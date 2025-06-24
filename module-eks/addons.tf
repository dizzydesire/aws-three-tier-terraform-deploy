provider "helm" {
    kubernetes {
        host                   = aws_eks_cluster.eks.endpoint
        cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
        token                  = data.aws_eks_cluster_auth.eks.token
    }
}

<<<<<<< HEAD
provider "kubernetes" {
  alias                  = "eks"
  host                   = aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

=======
>>>>>>> cf7fb3e (Completed the terraform script)
data "aws_eks_cluster_auth" "eks" {
    name = aws_eks_cluster.eks.name
}
resource "helm_release" "nginx_ingress" {
    name       = "nginx-ingress"
    repository = "https://kubernetes.github.io/ingress-nginx"
    chart      = "ingress-nginx"
    version    = "4.12.0"
    namespace  = "ingress-nginx"
    create_namespace = true

<<<<<<< HEAD
    values = [file("${path.module}/nginx-ingress-values.yaml")]
=======
    set {
        name  = "controller.service.type"
        value = "LoadBalancer"
    }

    # set {
    #     name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal"
    #     value = "0.0.0.0/0"
    # }

    set {
        name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
        value = "true"
    }

    set {
        name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
        value = "nlb"
    }

    timeout = 600

>>>>>>> cf7fb3e (Completed the terraform script)
    depends_on = [ aws_eks_node_group.eks_node_group ]
}

data "aws_lb" "nginx_ingress" {
  tags = {
    "kubernetes.io/service-name" = "ingress-nginx/nginx-ingress-ingress-nginx-controller"
  }

  depends_on = [helm_release.nginx_ingress]
}

<<<<<<< HEAD
resource "helm_release" "cert_manager" {
    name       = "cert-manager"
    repository = "https://charts.jetstack.io"
    chart      = "cert-manager"
    version    = "1.14.5"
    namespace  = "cert-manager"
    create_namespace = true
    set {
        name  = "installCRDs"
        value = "true"
    }
    depends_on = [ helm_release.nginx_ingress ]
}
#==================================================

resource "helm_release" "argocd" {
    name             = "argocd"
    repository       = "https://argoproj.github.io/argo-helm"
    chart            = "argo-cd"
    version          = "5.51.6"
    namespace        = "argocd"
    create_namespace = true
    values = [file("${path.module}/argocd-values.yaml")]
    depends_on = [ helm_release.nginx_ingress, helm_release.cert_manager]
}
=======

# resource "helm_release" "argocd" {
#     name       = "argocd"
#     repository = "https://argoproj.github.io/argo-helm"
#     chart      = "argo-cd"
#     version    = "5.51.6"
#     namespace  = "argocd"
#     create_namespace = true
# }

# resource "helm_release" "cert_manager" {
#     name       = "cert-manager"
#     repository = "https://charts.jetstack.io"
#     chart      = "cert-manager"
#     version    = "1.14.4"
#     namespace  = "cert-manager"
#     create_namespace = true
#     set {
#         name  = "installCRDs"
#         value = "true"
#     }
# }


# output "nginx_ingress_load_balancer_hostname" {
#     value       = data.kubernetes_service.nginx_ingress_lb.status[0].load_balancer[0].ingress[0].hostname
#     description = "The DNS hostname of the NGINX ingress LoadBalancer service"
# }
>>>>>>> cf7fb3e (Completed the terraform script)
