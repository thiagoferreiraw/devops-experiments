# Devops Experiments

## Introduction

I'll be using this repo to keep track of my devops studies, save code snippets, helpful links and documentations and everything that come to be helpful in my journey :)

## Main Goals

- Improve my skills with linux, network, containers and devops.
- Share my findings with whoever is interested

## Related repos

- [django-todo-list](https://github.com/thiagoferreiraw/django-todo-list)
- [locust-stress-test](https://github.com/thiagoferreiraw/locust-stress-test)

## Tasks

### Deploy a django application in a debian distro

- [x] Install Oracle VMBox (Downloaded from https://www.virtualbox.org/wiki/Downloads)
- [x] Install Debian (Dowloaded image from https://www.debian.org/distrib/netinst)
- - hostname: debian_devops
- - user: tferreira / abcd0987
- [x] Setup a django project: [django-todo-list](https://github.com/thiagoferreiraw/django-todo-list)
- [x] Configure vm network and ssh access
- - apt-install net-tools (to enable ifconfig)
- - Configure SSH and network [setting-ssh-connection-to-ubuntu-on-virtualbox](https://medium.com/@pierangelo1982/setting-ssh-connection-to-ubuntu-on-virtualbox-af243f737b8b)
- - ssh - run `ssh tferreira@127.0.0.1 -p 2222` and type password to login
- - Copy my ssh public key to the server: `brew install ssh-copy-id` and `ssh-copy-id tferreira@127.0.0.1 -p 2222`
- - ssh tferreira@127.0.0.1 -p 2222 (should not ask for password)
- [x] Install required packages to run the project on the debian instance
- - `apt install git curl python-pip python3-pip`
- - `curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py`
- - `pip install virtualenvwrapper` (remember to add shell [startup files](https://virtualenvwrapper.readthedocs.io/en/latest/install.html#shell-startup-file))
* [x] Deploy the django project on the debian machine
- - `mkvirtualenv django-todo-list --python=python3`
- - `mkdir /usr/local/project/` and `cd $_`
- - `git clone https://github.com/thiagoferreiraw/django-todo-list.git`
- - `workon django-todo-list`
- - `pip install -r requirements.txt`
- - `python manage.py migrate`
- - `gunicorn app.wsgi -w 1 --bind=0.0.0.0:8000`
- - `curl http://127.0.0.1:8000/tasks/` 
* [x] Setup my local network to access the application
- - Question: why 127.0.0.1 wont't work and 0.0.0.0 works?
- - [forward ports](https://www.howtogeek.com/122641/how-to-forward-ports-to-a-virtual-machine-and-use-it-as-a-server/) 
- [x] Fine tuning
- - Create a gunicorn/nginx service
- - Install a [self signed ssl certificate](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04)
- - Create a domain
- - Automate deploy with a provision tool
- - https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-16-04
- - apt instal nginx
### Install postgres in a separated machine

Continuing from the task above...

- [ ] Create a new VM and install postgres on it
- [ ] Update django project to use postgres
- [ ] Configure network to have connection between the two machines (app/db)

### Create a worker machine

- [ ] Setup a celery project
- [ ] Create a new machine for the workers
- [ ] Install redis
- [ ] Deploy workers
