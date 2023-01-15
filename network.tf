terraform {
  backend "s3" {
    bucket = "yotam-halperin"
    key    = "tf-conf/terraform.tfstate"
    region = "eu-west-2"
  }
}


// the provider
provider "aws" {
    region = var.region
}

// VPC 
resource "aws_vpc" "yh-tf" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "yh-tf"
        owner = "yotam_halperin"
        bootcamp = "17"
        expiration_date = "23-02-23"
    }
}

// first subnet
resource "aws_subnet" "yh-s1" {
    vpc_id = aws_vpc.yh-tf.id
    cidr_block = var.first_subnet_cidr
    availability_zone = "${var.region}a"

    tags = {
        Name = "yh-s1"
        owner = "yotam_halperin"
        bootcamp = "17"
        expiration_date = "23-02-23"
    }
}

// second subnet
resource "aws_subnet" "yh-s2" {
    vpc_id = aws_vpc.yh-tf.id
    cidr_block = var.second_subnet_cidr
    availability_zone = "${var.region}b"

    tags = {
        Name = "yh-s2"
        owner = "yotam_halperin"
        bootcamp = "17"
        expiration_date = "23-02-23"
    }
}

// IGW
resource "aws_internet_gateway" "yh-tf-igw" {
    vpc_id = aws_vpc.yh-tf.id

    tags = {
        Name = "yh-tf-igw"
        owner = "yotam_halperin"
        bootcamp = "17"
        expiration_date = "23-02-23"
    }
}

// Routing Table
resource "aws_route_table" "yh-tf-pub1" {
    vpc_id = aws_vpc.yh-tf.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.yh-tf-igw.id
    }
}

resource "aws_main_route_table_association" "main" {
  vpc_id = aws_vpc.yh-tf.id
  route_table_id = aws_route_table.yh-tf-pub1.id
}