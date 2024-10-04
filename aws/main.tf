resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    CreatedBy = "terraform"
    Name      = "main"
  }

}

resource "aws_subnet" "public_main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    CreatedBy = "terraform"
    Name      = "public_main"
  }
}

resource "aws_subnet" "private_main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    CreatedBy = "terraform"
    Name      = "private_main"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    CreatedBy = "terraform"
    Name      = "main"
  }
}

resource "aws_route_table" "public_main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    CreatedBy = "terraform"
    Name      = "main"
  }
}

# public subnetをroute tableに関連付ける
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.public_main.id
  route_table_id = aws_route_table.public_main.id
}
