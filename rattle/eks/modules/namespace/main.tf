

resource "kubernetes_namespace" "example" {
  metadata {
    name = "exercise" # Naming the namespace "example"
  }
}

output "namespace_id" {
  value = kubernetes_namespace.example.id
  description = "The ID of the created namespace"
}

output "namespace_name" {
  value = kubernetes_namespace.example.metadata.0.name
  description = "The name of the created namespace"
}
