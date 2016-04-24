help:
	@echo "setup-local - Build environment"
	@echo "run-deploy - Run container for in production mode"
	@echo "syntax - Ansible syntax checking"

setup-local: 
	ansible-galaxy install -r requirements.ansible.yml -p provisioning/front/roles; pip install -r requirements.python.txt

run-deploy:
	vagrant up; vagrant provision; curl http://localhost:8088

syntax:
	ansible-playbook --syntax-check --list-tasks provisioning/front/playbook.yml -i provisioning/hosts
