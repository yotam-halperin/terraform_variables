// first instance
resource "aws_instance" "yh-tf1" {
  ami = "ami-01b8d743224353ffe"
  instance_type = "t3a.small"

  vpc_security_group_ids = [aws_security_group.yh-tf-sg-i.id]
  subnet_id = aws_subnet.yh-s1.id

  associate_public_ip_address = true
  
  tags = {
        Name = "yh-tf1"
        owner = "yotam_halperin"
        bootcamp = "17"
        expiration_date = "23-02-23"
    }
}

// second instance
resource "aws_instance" "yh-tf2" {
  ami = "ami-01b8d743224353ffe"
  instance_type = "t3a.small"

  vpc_security_group_ids = [aws_security_group.yh-tf-sg-i.id]
  subnet_id = aws_subnet.yh-s2.id

  associate_public_ip_address = true
  
  tags = {
        Name = "yh-tf2"
        owner = "yotam_halperin"
        bootcamp = "17"
        expiration_date = "23-02-23"
    }
}

// create the security group for the instances
resource "aws_security_group" "yh-tf-sg-i" {
  name        = "yh-tf-sg-i"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.yh-tf.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.yh-tf-sg-alb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

// create the target group attachment
resource "aws_lb_target_group_attachment" "first_attachment" {
  target_group_arn = aws_lb_target_group.yh-tf-tg.arn
  target_id        = aws_instance.yh-tf1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "second_attachment" {
  target_group_arn = aws_lb_target_group.yh-tf-tg.arn
  target_id        = aws_instance.yh-tf2.id
  port             = 80
}