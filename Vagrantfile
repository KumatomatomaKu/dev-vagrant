VAGRANTFILE_API_VERSION = "2"

Vagrant::DEFAULT_SERVER_URL.replace('https://vagrantcloud.com')
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :shell, :privileged => false, :path => ".bootstrap.sh"

  config.ssh.forward_agent = true
  config.vm.network :forwarded_port, host: 3000, guest: 3000

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus   = 2
    vb.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 0]
  end
end
