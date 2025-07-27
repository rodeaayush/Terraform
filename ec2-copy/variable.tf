variable "region" {
  description = "AWS region to launch resources in"
  type        = string
  default     = "ap-south-1"
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "instance_name" {
  description = "Tag name for the EC2 instance"
  type        = string
}
