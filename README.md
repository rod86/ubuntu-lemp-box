# Ubuntu 16.04 LEMP box

A basic LEMP vagrant box for development

## Server specs

- Ubuntu Server 16.04 LTS Xenial Xerus
- Nginx
- PHP 7 FPM
- MySQL 5.7
- Composer
- Xdebug

## Install

- You must have installed vagrant and Virtualbox.
- Run
```
$ git clone https://github.com/rod86/ubuntu-lemp-box.git
$ cd ubuntu-lemp-box
$ vagrant up
```

## Users

### SSH
|         |                |
| ------- | -------------- |
| **Host**| 192.168.56.105 |
| **User**| vagrant |
| **Password**| vagrant |

### MySQL
|         |                |
| ------- | -------------- |
| **Host**| 127.0.0.1 |
| **User**| vagrantdb |
| **Password**| vagrantdb |

If you are using a mysql client like sequel pro or navicat, connect to mysql via ssh

## SSH authentication via private key

The default SSH auth method is via password. If you want to use a private SSH key instead of a password, follow these steps:
- You need a public and private SSH key. If you don't have them, generate them using the *ssh-keygen* command. Leave the passphrase empty.
- Connect to the VM via SSH.
- Connect via SSH to the virtual machine and append the public key (*id_rsa.pub* file) in the file *~/.ssh/authorized_keys*.
- In *Vagrantfile*, remove the SSH username and password config lines and add *config.ssh.private_key_path* with the absolute path to the private key (*id_rsa* file).
- Reload the virtual machine with the provision flag

## Scripts

### Host Generator

This script generates a host file. It must be run as a root user.

```
$ cd /home/vagrant
$ sudo bin/generatehost.sh -h myapp.dev -n myapp -t symfony
```

Parameters

| Option | Description | Example |
| ------ | ----------- | ------- |
| **-d** | Project domain | *myapp.dev* |
| **-n** *(Optional)* | Project folder name. If not provided, the project domain will be used as a name | *myapp* |
| **-t** *(Optional)* | Template host file to use. If not provided, the template *default* will be used | *symfony* |

#### How to create a custom host template

- In *bin/templates*, create the template host file.
- Put the placeholders
    - *{{PROJECT_NAME}}* for the project name      
    - *{{PROJECT_DOMAIN}}* for the project domain


## FAQ

### When I start the virtual machine, I see *"Warning: Connection timeout. Retrying..."* when it connects via SSH with a private key

You have to add your private key to the virtual machine *authorized_keys* file.

- You need a public and private SSH key. If you don't have them, generate them using the *ssh-keygen* command. Leave the passphrase empty.

- Edit the Vagrantfile and update the setting *config.ssh.private_key_path* with the absolute path to the id_rsa file.

- Start the virtual machine.

- Copy the contents of .

- Connect via SSH to the virtual machine and add the key from the file *id_rsa.pub* in *~/.ssh/authorized_keys*.

- Restart the virtual machine and the SSH connection should work.
