terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 3.74"
		}
	}
}

provider "aws" {
	region = "ap-south-1"
}



resource "aws_vpc" "main" {
	cidr_block = "10.5.0.0/16"

	tags = var.vpc_tags
}

resource "aws_subnet" "main" {
	vpc_id     = aws_vpc.main.id
	cidr_block = "10.5.0.0/25"

	tags = {
		Name = "tuts-subnet"
	}
}

resource "aws_instance" "web" {
	ami           = var.ami
	instance_type = "t2.micro"
	subnet_id     = aws_subnet.main.id

	tags = {
		Name = var.ec2_name
	}
}
