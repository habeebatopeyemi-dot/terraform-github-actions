terraform {
backend "s3" {
    bucket         = "harbybah-terraform-state-bucket" 
    key            = "terraform-cicd/state.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}
  
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "my bucket"
    Environment = "Dev"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Main_subnet1"
  }
}

resource "aws_security_group" "my_security_group" {
  name        = "allow_ssh_hhtp"
  description = "Allow SSH and HTTP traffic"
  vpc_id     = aws_vpc.main.id
  
  ingress {
    from_port =  22
    to_port   =  22
    protocol  =  "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "EC2Instance" {
  ami                    = "ami-051bfa33df3949860"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  tags = {
    Name = "my_terraform_ec2_instance"
  }
}