provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "context"
}


module "namespace" {
 source     =  "./modules/namepsace"

 }

 module "app" {
  source = "./modules/app"
}
