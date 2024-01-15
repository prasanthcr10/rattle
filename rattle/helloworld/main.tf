terraform {
required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
}
}


# build docker image
resource "docker_image" "my-docker-image" {
  name = "registry-1.docker.io/prasanth10/helloworld:latest"
  build {
    context = "."
  }
  platform = "linux/arm64"
}

# configure docker provider
provider "docker" {
  registry_auth {
      address = "registry-1.docker.io"
      
      username = "prasanth10"
      password  = "loco@2024"
    }
}

resource "docker_registry_image" "push_to_dockerhub" {
  name          = docker_image.my-docker-image.name
  keep_remotely = true
  

}


