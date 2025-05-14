#Définition du provider
provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "main" {
  id = "vpc-0dc6afcbf4b2ee09d"
}

# Instance EC2 dans le subnet public
resource "aws_instance" "EC2" {
  ami                         = "ami-0df368112825f8d8f"
  instance_type               = "t2.micro"
  key_name                    = "mp_key"
  tags = {
    Name = "mp_ec2_jenkins"
  }
}