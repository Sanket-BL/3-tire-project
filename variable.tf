variable "region" {
  default = "us-east-1"
}
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "FCT-vpc"
  }
}
variable "az1" {
  default = "us-east-1a"
  
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "private_cidr" {
  default = "10.0.16.0/20"
}
variable "public" {
  default = "10.0.32.0/20"
}
variable "project_name" {
  default = "FCT"
}
variable "igw_cidr" {
  default = "0.0.0.0/0"
}
variable "ami" {
  default = "ami-068c0051b15cdb816"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "az2" {
  default = "us-east-1b"
}
variable "public_cidr" {
  default = "10.0.48.0/20"
}
variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
} 
variable "db_username" {
  description = "The username for the database"
  type        = string
}
variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "mydatabase"
}
