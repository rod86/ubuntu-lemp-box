# Ubuntu 16.04 LEMP box

A basic vagrant box for development

## Server setup

- Ubuntu Server 16.04 LTS Xenial Xerus
- Nginx
- PHP 7 FPM
- MySQL


## Install

- You must have installed vagrant and Virtualbox.
- Clone this repo
- Go to the directory and do vagrant up.


## logins

### SSH
host: 192.168.56.105
user: vagrant
password: vagrant

### MySQL
connect to mysql via ssh using the previous ssh details
host: 127.0.0.1
user: vagrantdb
password: vagrantdb

## Scripts

### Host Generator

This script generates a host file
