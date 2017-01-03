# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

   config.vm.box = "rod86/ubuntu-16.04-lemp"

   config.vm.network "private_network", ip: "192.168.56.105"

   config.vm.provider "virtualbox" do |vb|
       vb.name = "ubuntu-16.04-lemp"
       vb.memory = "1024"
   end

   config.ssh.username = 'vagrant'
   config.ssh.password = 'vagrant'

   config.vm.synced_folder ".", "/vagrant", disabled: true

   config.vm.synced_folder "./www", "/var/www",
     :owner => 'vagrant',
     :group => 'www-data',
     :mount_options => ["dmode=775","fmode=666"]

    config.vm.synced_folder "./bin", "/home/vagrant/bin"

end
