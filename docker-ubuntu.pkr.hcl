# Configurar o Packer
packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

# Adicionar variável de imagem Docker
variable "docker_image" {
  type    = string
  default = "ubuntu:jammy"
}

# Configurar a primeira imagem de container a ser compilada
source "docker" "ubuntu" {
  image  = var.docker_image
  commit = true
}

# Configurar a segunda imagem de container a ser compilada
source "docker" "ubuntu-focal" {
  image  = "ubuntu:focal"
  commit = true
}

# Compilar imagens
build {
  name = "packer-docker"
  sources = [
    "source.docker.ubuntu",
    "source.docker.ubuntu-focal",
  ]

  # Primeiro provisionador do shell
  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }

  # Segundo provisionador do shell
  provisioner "shell" {
    inline = ["echo Running ${var.docker_image} Docker image"]
  }

  # Pós-Processador para a imagem ubuntu:jammy
  post-processor "docker-tag" {
    repository = "packer-docker"
    tags       = ["ubuntu-jammy", "packer-rocks"]
    only       = ["docker.ubuntu"]
  }

  # Pós-Processador para a imagem ubuntu:focal
  post-processor "docker-tag" {
    repository = "packer-docker"
    tags       = ["ubuntu-focal", "packer-rocks"]
    only       = ["docker.ubuntu-focal"]
  }
}
