# Installing Dependencies
apt install git curl python-pip python3-pip vim nginx
export PATH=/usr/sbin/:$PATH > ~/.bashrc

# Installing virtualenv
pip install virtualenvwrapper
echo "export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh" > ~/.bashrc
source ~/.bashrc

# Downloading project
mkdir /usr/local/project/ && cd $_
git clone https://github.com/thiagoferreiraw/django-todo-list.git
git clone https://github.com/thiagoferreiraw/devops-experiments.git

# Installing django-todo-list
mkvirtualenv django-todo-list --python=python3
cd /usr/local/project/django-todo-list
cd /usr/local/project/django-todo-list
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic --noinput
# gunicorn app.wsgi -w 1 --bind=0.0.0.0:8000
# curl http://127.0.0.1:8000/tasks/


# Installing a gunicorn service 
cp /usr/local/project/devops-experiments/gunicorn.service /etc/systemd/system/gunicorn.service
systemctl daemon-reload
systemctl enable gunicorn # enable to start at boot
systemctl start gunicorn

# Checking service status and logs
systemctl status gunicorn 
journalctl -u gunicorn


# Installing nginx
cp /usr/local/project/devops-experiments/nginx-django-todo-list /etc/nginx/sites-available/django-todo-list
ln -s /etc/nginx/sites-available/django-todo-list /etc/nginx/sites-enabled 
rm /etc/nginx/sites-enabled/default # remove default site
nginx -t # Check for syntax
systemctl enable nginx
systemctl restart nginx journalctl -u gunicorn


# Checking nginx logs
journalctl -u nginx
less /var/log/nginx/access.log
less /var/log/nginx/error.log