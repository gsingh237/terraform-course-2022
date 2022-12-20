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

resource "aws_instance" "web" {
	ami           = "ami-085a8ae1aaa4f6e2a"
	instance_type = "t2.micro"
	key_name      = "mumbai-key"

	tags = {
		Name = "Tuts test"
	}

	connection {
		type        = "ssh"
		host        = self.public_ip
		user        = "ubuntu"
		private_key = file("mumbai-key.pem")
		# Default timeout is 5 minutes
		timeout     = "4m"
	}

	provisioner "file" {
		content     = "Hello there"
		#source = "somefile.txt"
		destination = "/home/ubuntu/tuts.txt"
	}

	provisioner "local-exec" {
		command = "echo ${self.public_ip} > instance-ip.txt"
	}

	provisioner "remote-exec" {
		#on_failure = "fail" OR "continue"
		inline = [
			"touch /home/ubuntu/tuts-remote-exec.txt"
		]
	}
}
output "ip" { 
	value = aws_instance.web.public_ip
}

