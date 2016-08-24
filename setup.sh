#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get update -y
sudo apt-get install -y git
sudo apt-get install -y curl

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo npm install -g npm

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Make
sudo apt-get install -y gcc
sudo apt-get install -y make 
sudo apt-get install -y automake

# libcurl dev
sudo apt-get install -y libcurl4-openssl-dev

#libev
sudo apt-get install -y libev-dev

#fcgi
sudo apt-get install -y libfcgi-dev

#nginx
sudo apt-get install -y nginx-full

# roswel
git clone -b release https://github.com/roswell/roswell.git
cd roswell
sh bootstrap
./configure
make
sudo make install

# Install SBCL and clack
sudo ros install clack
export PATH=$PATH:/home/ubuntu/.roswell/bin

# Perl server starter
sudo apt-get install -y libserver-starter-perl

# Anaconda
wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda3-4.0.0-Linux-x86_64.sh
bash Anaconda3-4.0.0-Linux-x86_64.sh

source ~/.bashrc

# PostgreSQL
sudo apt-get install -y libpq-dev

conda install psycopg2
pip install python-telegram-bot
pip install SQLAlchemy
pip install Flask-SQLAlchemy
pip install gunicorn

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/pyankoff/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

# set path to clackup
echo "export PATH=$PATH:~/.roswell/bin" >> .bashrc_custom
echo "alias sudo='sudo env PATH=$PATH'" >> .bashrc_custom
source .bashrc
