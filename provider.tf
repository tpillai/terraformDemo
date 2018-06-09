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

resource "aws_subnet" "subnets" {
  count = "${length(var.azs)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"

  tags {
    Name = "subnet1"
  }
}
