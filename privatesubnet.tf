# private subnet
resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc_test.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Isolated Private Subnet"
  }
}
# route table
resource "aws_route_table" "my_vpc_private" {
    vpc_id = aws_vpc.vpc_test.id

    tags = {
        Name = "Local Route Table for Isolated Private Subnet"
    }
}

resource "aws_route_table_association" "my_vpc_us_east_1a_private" {
    subnet_id = aws_subnet.subnet_private.id
    route_table_id = aws_route_table.my_vpc_private.id
}