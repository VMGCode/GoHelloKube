resource "kubernetes_namespace" "hello_world" {
  metadata {
    name = "hello-world-namespace"
  }
}

resource "kubernetes_deployment" "hello_world" {
  metadata {
    name = "hello-world-go-deployment"
    namespace = kubernetes_namespace.hello_world.metadata[0].name
    labels = {
      app = "hello-world-go"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "hello-world-go"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world-go"
        }
      }

      spec {
        container {
          name  = "hello-world-go"
          image = "your-docker-username/gohellokube:latest"
          ports {
            container_port = 8080
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds = 10
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 15
            period_seconds = 20
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello_world" {
  metadata {
    name = "hello-world-go-service"
    namespace = kubernetes_namespace.hello_world.metadata[0].name
  }

  spec {
    selector = {
      app = "hello-world-go"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
