# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = "XXXXXXXXX"
  secret_key = "XXXXXXXXX"
  region = "us-east-1"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  ami = "ami-0c6b1d09930fac512"
  instance_type = "t2.micro"
  count = "4"
}
# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  ami = "ami-0c6b1d09930fac512"
  instance_type = "m4.large"
  count = "2"
}