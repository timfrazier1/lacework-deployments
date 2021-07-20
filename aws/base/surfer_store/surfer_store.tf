resource "kubernetes_namespace" "surfer_store" {
  metadata {
    name = "surfer-store"
  }
}

resource "kubernetes_service" "cartservice" {
  metadata {
    name      = "cartservice"
    namespace = "surfer-store"

    labels = {
      app = "surfer-store"

      tier = "middleware"
    }
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 4201
      target_port = "4201"
    }

    selector = {
      name = "cartservice"
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "ordersdb" {
  metadata {
    name      = "ordersdb"
    namespace = "surfer-store"

    labels = {
      name = "ordersdb"
    }
  }

  spec {
    port {
      port        = 3306
      target_port = "3306"
    }

    selector = {
      name = "ordersdb"
    }
  }
}

resource "kubernetes_service" "cartdb" {
  metadata {
    name      = "cartdb"
    namespace = "surfer-store"

    labels = {
      name = "cartdb"
    }
  }

  spec {
    port {
      port        = 3306
      target_port = "3306"
    }

    selector = {
      name = "cartdb"
    }
  }
}

resource "kubernetes_service" "webfrontend" {
  metadata {
    name      = "webfrontend"
    namespace = "surfer-store"

    labels = {
      app = "surfer-store"

      tier = "frontend"
    }
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 8088
      target_port = "8088"
    }

    selector = {
      name = "webfrontend"
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "ordersservice" {
  metadata {
    name      = "ordersservice"
    namespace = "surfer-store"

    labels = {
      app = "surfer-store"

      tier = "middleware"
    }
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 4201
      target_port = "4201"
    }

    selector = {
      name = "ordersservice"
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment" "productservice" {
  metadata {
    name      = "productservice"
    namespace = "surfer-store"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "productservice"
      }
    }

    template {
      metadata {
        labels = {
          app = "surfer-store"

          "app.kubernetes.io/name" = "productservice"

          name = "productservice"

          role = "productservice"

          tier = "middleware"
        }
      }

      spec {
        container {
          name  = "productservice"
          image = "k8tan/product_microservice"

          port {
            name           = "productservice"
            container_port = 6767
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_deployment" "cartservice" {
  metadata {
    name      = "cartservice"
    namespace = "surfer-store"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "cartservice"
      }
    }

    template {
      metadata {
        labels = {
          app = "surfer-store"

          "app.kubernetes.io/name" = "cartservice"

          name = "cartservice"

          role = "cartservice"

          tier = "middleware"
        }
      }

      spec {
        container {
          name  = "cartservice"
          image = "k8tan/cart_microservice"

          port {
            name           = "cartservice"
            container_port = 4201
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_deployment" "ordersservice" {
  metadata {
    name      = "ordersservice"
    namespace = "surfer-store"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "ordersservice"
      }
    }

    template {
      metadata {
        labels = {
          app = "surfer-store"

          "app.kubernetes.io/name" = "ordersservice"

          name = "ordersservice"

          role = "ordersservice"

          tier = "middleware"
        }
      }

      spec {
        container {
          name  = "ordersservice"
          image = "k8tan/orders_microservice"

          port {
            name           = "ordersservice"
            container_port = 4201
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_deployment" "cartdb" {
  metadata {
    name      = "cartdb"
    namespace = "surfer-store"

    labels = {
      name = "cartdb"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "cartdb"
      }
    }

    template {
      metadata {
        labels = {
          app = "surfer-store"

          "app.kubernetes.io/name" = "cartdb"

          name = "cartdb"

          role = "mysql"

          tier = "db"
        }
      }

      spec {
        container {
          name  = "cartdb"
          image = "k8tan/cart_db"

          port {
            name           = "mysql"
            container_port = 3306
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_service" "adminfrontend" {
  metadata {
    name      = "adminfrontend"
    namespace = "surfer-store"

    labels = {
      app = "surfer-store"

      tier = "frontend"
    }
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 3000
      target_port = "3000"
    }

    selector = {
      name = "adminfrontend"
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "productdb" {
  metadata {
    name      = "productdb"
    namespace = "surfer-store"

    labels = {
      name = "productdb"
    }
  }

  spec {
    port {
      port        = 3306
      target_port = "3306"
    }

    selector = {
      name = "productdb"
    }
  }
}

resource "kubernetes_deployment" "adminfrontend" {
  metadata {
    name      = "adminfrontend"
    namespace = "surfer-store"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "admin_frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "surfer-store"

          "app.kubernetes.io/name" = "admin_frontend"

          name = "adminfrontend"

          role = "adminfrontend"

          tier = "client"
        }
      }

      spec {
        container {
          name  = "adminfrontend"
          image = "k8tan/admin_frontend"

          port {
            name           = "adminfrontend"
            container_port = 3000
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_deployment" "ordersdb" {
  metadata {
    name      = "ordersdb"
    namespace = "surfer-store"

    labels = {
      name = "ordersdb"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "ordersdb"
      }
    }

    template {
      metadata {
        labels = {
          app = "surfer-store"

          "app.kubernetes.io/name" = "ordersdb"

          name = "ordersdb"

          role = "mysql"

          tier = "db"
        }
      }

      spec {
        container {
          name  = "ordersdb"
          image = "k8tan/orders_db"

          port {
            name           = "mysql"
            container_port = 3306
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_deployment" "webfrontend" {
  metadata {
    name      = "webfrontend"
    namespace = "surfer-store"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "webfrontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "surfer-store"

          "app.kubernetes.io/name" = "webfrontend"

          name = "webfrontend"

          role = "webfrontend"

          tier = "client"
        }
      }

      spec {
        container {
          name  = "webfrontend"
          image = "k8tan/web_frontend"

          port {
            name           = "webfrontend"
            container_port = 8088
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_service" "productservice" {
  metadata {
    name      = "productservice"
    namespace = "surfer-store"

    labels = {
      app = "surfer-store"

      tier = "middleware"
    }
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 6767
      target_port = "6767"
    }

    selector = {
      name = "productservice"
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment" "productdb" {
  metadata {
    name      = "productdb"
    namespace = "surfer-store"

    labels = {
      name = "productdb"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "productdb"
      }
    }

    template {
      metadata {
        labels = {
          app = "surfer-store"

          "app.kubernetes.io/name" = "productdb"

          name = "productdb"

          role = "mysql"

          tier = "db"
        }
      }

      spec {
        container {
          name  = "productdb"
          image = "k8tan/product_db:latest"

          port {
            name           = "mysql"
            container_port = 3306
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_cluster_role" "surfer_read_only_role" {
  metadata {
    name = "surfer-read-only-role"
  }

  rule {
    verbs      = ["get", "watch", "list"]
    api_groups = [""]
    resources  = ["secrets", "services"]
  }
}

resource "kubernetes_cluster_role_binding" "surfer_default_read_only" {
  metadata {
    name = "surfer-default-read-only"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "surfer-store"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "surfer-read-only-role"
  }
}

