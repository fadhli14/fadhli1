bucket_name = "dev-proj-1-remote-state-bucket-fadhli"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-eu-west-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["eu-west-1a", "eu-west-1b"]

public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB48AFiOyCEe/D5SPwLndrCFHy0J9gr+TDvXrv07tDuo ff14@DESKTOP-H31LDDN"
ec2_ami_id     = "ami-01f23391a59163da9"

ec2_user_data_install_apache = ""

domain_name = "fadhli.site"
