# a 3 node web platform.
1 gateway + 2 app nodes

# Prepping the environment

you will need to have done the following:

1. Download and Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Download and Install [Vagrant](https://www.vagrantup.com/downloads.html)
3. Install [Ansible](http://ansibleworks.com/) ([guide for installing Ansible](http://docs.ansible.com/intro_installation.html))
4. Open a shell prompt (Terminal app on a Mac) and cd into the folder containing the `Vagrantfile`
5. Run the following command to install the necessary Ansible roles for this profile:

        $ ansible-galaxy install -r requirements.ansible.yml -p provisioning/front/roles

## Using virtualenv

Alternatively you can use virtualenv:

        virtualenv ENV
        source ENV/bin/activate
        pip install -r requirements.python.txt

and you will have the same python versions and ansible environment used to develop this repo
