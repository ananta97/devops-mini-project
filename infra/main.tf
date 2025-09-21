provider "aws" {
  region     = "ap-south-1"          # Mumbai region
  access_key = "YOUR_ACCESS_KEY"     # Replace with your AWS IAM user key
  secret_key = "YOUR_SECRET_KEY"     # Replace with your AWS IAM user secret
}

# Security Group
resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH and App port"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "devops_ec2" {
  ami           = "ami-08e5424edfe926b43" # Ubuntu 22.04 LTS (Mumbai)
  instance_type = "t2.micro"              # Free Tier
  key_name      = "YOUR_KEY_PAIR_NAME"     # Replace with your AWS key pair name

  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "DevOps-EC2"
  }
}

