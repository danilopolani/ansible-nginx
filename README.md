# Ansible NGINX
Manage NGINX configuration with Ansible Playbooks. **Vagrant** and **index.php** are here only for testing purposes.

> Ansible is an IT automation tool (like Puppet or Chef). It can configure systems, deploy software, and orchestrate more advanced IT tasks such as continuous deployments or zero downtime rolling updates.
> 
> Ansible’s main goals are simplicity and ease-of-use. It also has a strong focus on security and reliability, featuring a minimum of moving parts, usage of OpenSSH for transport (with an accelerated socket mode and pull modes as alternatives), and a language that is designed around auditability by humans–even those not familiar with the program.

## Installation of Ansible

### Ubuntu

Execute these codes in your terminal:


1. `$ sudo apt-get install software-properties-common`
1. `$ sudo apt-add-repository ppa:ansible/ansible`
1. `$ sudo apt-get update`
1. `$ sudo apt-get install ansible`

### Mac OSX

1. Install Python pip: `sudo easy_install pip`
1. Install Ansible: `sudo pip install ansible`

## Edit NGINX configuration

You just have to edit `nginx.tpl` file. Then, when you're done, execute from the directory `ansible-playbook nginx.yml`.

### Warning: edit these lines

- **hosts**: hosts under `app`
- **nginx.tpl**:
  - On line **18** replace `project` with your project root. `root /var/www/project;`
- **nginx.yml**:
  - On line **10** replace `yoursite.com` with your site domain. `dest={{ nginx_sites }}/yoursite.com.conf`
- **nginx_install.yml** (optional):
  - On line **6** replace `project` with your project root. `doc_root: /var/www/project` 
  - On line **7** replace `yoursite.com` with your site domain. `conf_file: yoursite.com`
- **nginx_vagrant.yml** (optional):
  - On line **6** replace `yoursite.com` with your site domain. `dest={{ nginx_sites }}/yoursite.com.conf` 

## Testing your NGINX configuration before the production

If you want to test your configuration, you can do it with a **Vagrant** machine. 

### First time installation

If you don't have the machine running or you destroyed it, you have to rerun and reinstall it. So this step is only for the first time.

#### What will be installed on the machine

1. Python (for Ansible)
1. NGINX
1. PHP
1. Your SSH key

### Use Vagrant

You can run the machine with `vagrant up`, which will grab the configuration from `Vagrantfile`, so you will not have to change anything. It will run on your private address **192.168.33.10**.  
Once the machine is running (in background), you can login in it with `vagrant ssh` or `ssh ubuntu@192.168.33.10`.

Now (**only the first time you start the machine or after a destroy**) run `ansible-playbook nginx_install.yml` to install NGINX with PHP7.0. The configuration from `nginx.tpl` will be automatically copied to the machine.

### Update NGINX configuration

If you have to update the nginx configuration because you changed the file, just run `ansible-playbook nginx_vagrant.yml`. 

## Ansible files and terms

- **Inventory** is the file with the hosts. By default is `/etc/ansible/hosts`, but in this case we said Ansible to use the `hosts` file in the project directory (through `ansible.cfg` file).
- **Tasks** are a set of operations to execute. For example, in `nginx_install.yml` the tasks are the installation of nginx and php, the copy of files and so on.
- **hosts** file is where machine hosts are listed. You can group them putting a `[group-name]` header before. In our case, there are two groups: `vagrant` and `app`.
- **ansible.cfg** file is the ansible configuration for this project. It's optional, we created it just to set our hosts file.
