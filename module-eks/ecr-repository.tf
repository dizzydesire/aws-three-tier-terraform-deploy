resource "aws_ecr_repository" "foo" {
  name                 = "bank-backendapi"
  image_tag_mutability = "MUTABLE"
  force_delete         = true  # 👈 Add this line

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "foo1" {
  name                 = "bank-frontend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true  # 👈 Add this line

  image_scanning_configuration {
    scan_on_push = true
  }
}
