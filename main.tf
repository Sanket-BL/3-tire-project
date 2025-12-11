terraform {
  backend "s3" {
    bucket = "terraform-backend-c56-bucket"
    key = "terraform.tfstate"
    region = "us-east-1" #remote backend
  }
}
provider "aws" {
  region = var.region
}
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "${var.project_name}-vpc"
    }
}
# Create a privete subnet
resource "aws_subnet" "privete_subnet"{
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_cidr
  availability_zone = var.az1
    tags = {
        Name = "${var.project_name}-private-subnet"
    }
}
#create a public subnet
resource "aws_subnet" "public_subnet"{
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_cidr
  availability_zone = var.az2
    tags = {
        Name = "${var.project_name}-public-subnet"
    }
}
# Create an internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.project_name}-IGW"
  }
}
# create a default Route table
resource "aws_default_route_table" "main_RT" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id
  tags = {
    Name = "${var.project_name}-main-RT"
  }
}
# add a route in main route table
resource "aws_route" "aws-route" {
  route_table_id = aws_default_route_table.main_RT.id
  destination_cidr_block = var.igw_cidr
  gateway_id = aws_internet_gateway.my_igw.id
}
# create a security group
# create a security group
resource "aws_security_group" "my-sg" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "${var.project_name}-SG"
  description = "allow ssh, http, mysql traffic"

  # ✅ Ingress rules (use block syntax, not =)
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ✅ Egress rules
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#create a publice server
resource "aws_instance" "public_server" {
  subnet_id = aws_subnet.public_subnet.id
  ami = var.ami
  instance_type = var.instance_type
  key_name = "sanket1"
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  tags = {
    Name = "${var.project_name}-public-server"
  }
  depends_on = [ aws_security_group.my-sg ]
}

# create a private server
resource "aws_instance" "name" {
  subnet_id =aws_subnet.privete_subnet.id
  ami = var.ami
  instance_type = var.instance_type
  key_name = "sanket1"  
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  tags = {
    Name = "${var.project_name}-db-server"



  }
  depends_on = [ aws_security_group.my-sg ]
}