variable "instance_name" {
  type        = string
  description = "Name tag for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the instance"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security groups"
}

variable "key_name" {
  type        = string
  description = "SSH key name"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Assign public IP?"
}
