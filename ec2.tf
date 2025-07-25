provider "aws" {
  region = "ap-south-1"  # Change to your desired AWS region
}

resource "aws_instance" "Terra-instance" {
  ami           = "ami-0d0ad8bb301edb745" # Replace with a valid AMI for your region
  instance_type = "t2.micro"

  key_name      = "ubuntukey"  # Replace with your key pair name

  tags = {
    Name = "Ec2-terraform-Instance"
  }

}

