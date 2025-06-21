###### root/kubernetes.tf ######

resource "kubernetes_deployment" "ekscluster" {
  metadata {
    name = "terraform-ekscluster"
    labels = {
      app = "ekscluster"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "ekscluster"
      }
    }
    template {
      metadata {
        labels = {
          app = "ekscluster"
        }
      }
      spec {
        container {
          name  = "ekscluster"
          image = "nginx:1.23.4" # Updated to a more recent stable Nginx version

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "128Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "ekscluster" {
  metadata {
    name = "terraform-ekscluster"
  }

  spec {
    selector = {
      app = "ekscluster"
    }
    
    port {
      port        = 80
      target_port = 80
      node_port   = 30010
    }

    type = "LoadBalancer"
  }
}
