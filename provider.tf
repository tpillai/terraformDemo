provider "aws" {
  region     = "${var.region}"
}
resource "aws_vpc" "main"{
  cidr_block ="${var.vpc_cidr}"
  instance_tenancy = "default"

  tags{
    Name = "main"
    Location = "Utrecht"
   }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_cidr}"

  tags {
    Name = "subnet1"
  }
}
