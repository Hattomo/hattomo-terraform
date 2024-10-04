resource "aws_s3_bucket" "main" {
  bucket = "hattomo-main"

  tags = {
    Name      = "main"
    CreatedBy = "terraform"
  }
}
