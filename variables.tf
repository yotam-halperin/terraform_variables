variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "the default region for the IaC"
}

variable "instance_ami" {
  type        = string
  default     = "ami-01b8d743224353ffe"
  description = "ami for the instances"
}

variable "instance_type" {
  type        = string
  default     = "t3a.micro"
  description = "instance type"
}

variable "instance_port" {
  type        = number
  default     = 80
  description = "the port on the instance that open to the internet"
}

variable "alb_port" {
  type        = string
  default     = 80
  description = "the port on the alb that open to the internet"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.10.0.0/16"
  description = "vpc cidr"
}

variable "first_subnet_cidr" {
  type        = string
  default     = "10.10.10.0/24"
}

variable "second_subnet_cidr" {
  type        = string
  default     = "10.10.20.0/24"
}
