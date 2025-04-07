module "ec2_instance" {
  source = "./modules/ec2_instance"


  instance_name               = var.instance_name
  instance_type               = var.instance_type
  ami_id                      = var.ami_id
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
}
