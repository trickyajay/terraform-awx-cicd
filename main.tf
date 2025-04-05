provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "linux_vm" {
  ami           = "ami-00a929b66ed6e0de6" # Amazon Linux 2 AMI (update for your region)
  instance_type = "t2.micro"
  key_name      = "aj-key-us-east-1" # Replace with your key pair name
  tags = {
    Name = "Linux-VM-CICD"
  }

  # Allow SSH access
  vpc_security_group_ids = [aws_security_group.vm_sg.id]
}

resource "aws_security_group" "vm_sg" {
  name        = "vm_sg"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
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

output "vm_public_ip" {
  value = aws_instance.linux_vm.public_ip
}
