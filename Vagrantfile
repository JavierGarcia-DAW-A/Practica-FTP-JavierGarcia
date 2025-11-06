# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Imagen base de Debian
  config.vm.box = "debian/bullseye64"

  # Nombre del host
  config.vm.hostname = "servidor-ftp"

  # Red privada (puedes cambiar la IP si tu red 20.x ya está usada)
  config.vm.network "private_network", ip: "192.168.56.101"

  # Redirección de puertos (FTP usa el 21)
  config.vm.network "forwarded_port", guest: 21, host: 2121

  # Carpeta compartida
  config.vm.synced_folder ".", "/vagrant"

  # Script de aprovisionamiento (opcional, lo crearemos después)
  config.vm.provision "shell", path: "bootstrap.sh"
end

