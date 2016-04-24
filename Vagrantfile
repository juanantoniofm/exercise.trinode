# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Create a forwarded port mapping which allows access to a specific port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #

  config.vm.provider :virtualbox do |v|
    v.memory = 256
    v.cpus = 1
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define :front do |front|
    front.vm.hostname = "front"
    front.vm.network "forwarded_port", guest: 8080, host: 8088
    front.vm.network "forwarded_port", guest: 22, host: 2201
    front.vm.network "private_network", ip: "192.168.33.254"
    front.vm.provision "ansible" do |ansible| 
      ansible.playbook = "provisioning/front/playbook.yml"
      ansible.inventory_path == "provisioning/hosts"
      ansible.sudo = true
    end
  end

    N = 2
    (1..N).each do |machine_id|
      config.vm.define "back#{machine_id}" do |machine|
        machine.vm.hostname = "back#{machine_id}"
        machine.vm.network "forwarded_port", guest: 22, host: 2201+machine_id
        machine.vm.network "forwarded_port", guest: 8484, host: 8080+machine_id
        machine.vm.network "private_network", ip: "192.168.33.#{10+machine_id}"
 
        # Only execute once the Ansible provisioner,
        # when all the machines are up and ready.
        if machine_id == N
          machine.vm.provision :ansible do |ansible|
            # Disable default limit to connect to all the machines
            ansible.limit = "all"
            ansible.playbook = "provisioning/back/playbook.yml"
            ansible.inventory_path == "provisioning/hosts"
            ansible.sudo = true
          end
        end
      end
    end


  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
end
