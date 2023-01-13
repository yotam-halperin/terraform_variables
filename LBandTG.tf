// ALB
resource "aws_lb" "yh-tf-alb" {
  name = "yh-tf-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.yh-tf-sg-alb.id]
  subnets = [aws_subnet.yh-s1.id, aws_subnet.yh-s2.id]


  tags = {
        Name = "yh-tf-alb"
        owner = "yotam_halperin"
        bootcamp = "17"
        expiration_date = "23-02-23"
    }
}

// add a Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.yh-tf-alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.yh-tf-tg.arn
  }
}

// create a target group for the ALB
resource "aws_lb_target_group" "yh-tf-tg" {
  name     = "yh-tf-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.yh-tf.id

  health_check {
    enabled = true
    interval = 15
    matcher = 200
    path = "/"
    protocol = "HTTP"
    timeout = 10
    healthy_threshold = 5
    unhealthy_threshold = 2 
  }
}


// create the security group for the Load Balancer
resource "aws_security_group" "yh-tf-sg-alb" {
  name        = "yh-tf-sg-alb"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.yh-tf.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}