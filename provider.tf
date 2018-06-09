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
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone="${element(data.aws_availability_zones.azs.names,count.index)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"

  tags {
    Name = "subnet-${count.index+1}"
  }
}

resource "aws_instance" "web" {
  ami           = "${lookup(var.ec2_ami,var.region)}"
  instance_type = "t2.micro"

  tags {
    Name = "HelloTerraForm"
  }
}
output "address" {
  value = "${aws_instance.web.private_ip}"
}

output "eip" {
  value = "${aws_instance.web.*.public_ip}"
}
