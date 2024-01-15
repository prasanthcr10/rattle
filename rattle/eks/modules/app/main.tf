resource "kubernetes_deployment" "app" {
  metadata {
    name = "helloworld app example"
    namespace = "exercise"
    labels = {
      App = "helloworld"
    }
  }


 spec {
    replicas = 2
    selector {
      match_labels = {
        App = "helloworld"
      }


    template {
      metadata {
        labels = {
          App = "helloworld"
        }
      }


      spec {
        container {
          image = "prasanth10/helloworld:latest"
          name  = "exercise"

          port {
            container_port = 80
          }

resource "kubernetes_service" "app" {
  metadata {
    name = "helloworld app example"
    namespace = "exercise"
  }
  spec {
    selector = {
      App = kubernetes_deployment.app.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
