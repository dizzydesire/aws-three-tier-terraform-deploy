resource "aws_ecr_repository" "foo" {
<<<<<<< HEAD
  name                 = "bank-backendapi"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "foo1" {
  name                 = "bank-frontend"
=======
  name                 = "${var.environment}repository-${var.repository_name}"
>>>>>>> cf7fb3e (Completed the terraform script)
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}