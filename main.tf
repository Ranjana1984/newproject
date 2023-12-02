terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "Test-server" {
  ami           = "ami-0cbd40f694b804622" # us-west-2
  instance_type = "t2.micro"
  tags = {
      Name = "Test-Instance"
  }
}
resource "aws_instance" "Prod-server" {
  ami           = "ami-0cbd40f694b804622" # us-west-2
  instance_type = "t2.micro"
  tags = {
      Name = "Prod-Instance"
  }
}
output "test_server_ip" {
  value = aws_instance.Test-server.public_ip
}

output "prod_server_ip" {
  value = aws_instance.Prod-server.public_ip
}
