resource "kubernetes_ingress" "surfer_ingress" {
  metadata {
    name      = "surfer-ingress"
    namespace = "surfer-store"

    labels = {
      app = "surfer-store"
    }

    annotations = {
      # "alb.ingress.kubernetes.io/load-balancer-attributes" = "access_logs.s3.enabled=true,access_logs.s3.bucket=surfer-store-access-logs"

      "alb.ingress.kubernetes.io/scheme" = "internet-facing"

      # "alb.ingress.kubernetes.io/security-groups" = "HttpOnlyEks,eksctl-surfer-test-cluster-ControlPlaneSecurityGroup-ZMT7VWOSXV07"

      "kubernetes.io/ingress.class" = "alb"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/shop*"

          backend {
            service_name = "webfrontend"
            service_port = "8088"
          }
        }

        path {
          path = "/wstatic*"

          backend {
            service_name = "webfrontend"
            service_port = "8088"
          }
        }

        path {
          path = "/admin*"

          backend {
            service_name = "adminfrontend"
            service_port = "3000"
          }
        }

        path {
          path = "/astatic*"

          backend {
            service_name = "adminfrontend"
            service_port = "3000"
          }
        }

        path {
          path = "/cart*"

          backend {
            service_name = "cartservice"
            service_port = "4201"
          }
        }

        path {
          path = "/orders*"

          backend {
            service_name = "ordersservice"
            service_port = "4201"
          }
        }

        path {
          path = "/products*"

          backend {
            service_name = "productservice"
            service_port = "6767"
          }
        }

        path {
          path = "/*"

          backend {
            service_name = "webfrontend"
            service_port = "8088"
          }
        }
      }
    }
  }
}

output "lb_ip" {
  value = kubernetes_ingress.surfer_ingress.status.0.load_balancer.0.ingress.0.hostname
}
