# VPC Creation
resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}
resource "aws_subnet" "pubsub" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-north-1a" # Choose an availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub"
  }
}

# Private Subnet Creation
resource "aws_subnet" "privsub" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-north-1a"

  tags = {
    Name = "privsub"
  }
}

# Internet Gateway to allow Internet access
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }
}

# Route Table for Public Subnet      
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "pub_rt"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "pubsub_rt_assoc" {
  subnet_id      = aws_subnet.pubsub.id
  route_table_id = aws_route_table.pub_rt.id

}

# Security Group 
resource "aws_security_group" "my-sg" {
  vpc_id      = aws_vpc.my-vpc.id
  name        = "ng-server-sg"
  description = "Allow access to the server"

  dynamic "ingress" {
    for_each = toset([22, 80])
    iterator = port
    content {
      description = "Allow access to port ${port.value}"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
    env  = "dev"
  }
}
