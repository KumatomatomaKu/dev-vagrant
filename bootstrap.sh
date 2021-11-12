#!/bin/sh -xe

sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get update

# Set timezone
sudo timedatectl set-timezone Asia/Tokyo

# Setup git enviroment
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

read -p "git username:" git_username
read -p "git email:" git_email
git config --global user.name "$git_username"
git config --global user.email $git_email
git config --global push.default tracking
git config --global color.ui auto
git config --global core.precomposeunicode true
git config --global core.editor vim

# Apply dot files
cp ./dotfiles/.bash_profile ~/
cp ./dotfiles/.vimrc ~/
cp ./dotfiles/.screenrc ~/
mkdir $HOME/.screen

# Install rbenv
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev libdb-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

# Install default ruby
rbenv install 2.5.9

# Install mysql
sudo mkdir -p /etc/mysql/conf.d
cat <<__EOF__ | sudo tee /etc/mysql/conf.d/dev.cnf
[client]
default-character-set = utf8

[mysqld]
character-set-server = utf8
skip-character-set-client-handshake
transaction-isolation = READ-COMMITTED
skip-grant-tables

[mysqldump]
default-character-set = utf8

[mysql]
default-character-set = utf8
__EOF__

sudo apt-get install -y mariadb-server=1:10.1.48-0ubuntu0.18.04.1
sudo apt-get install -y libmariadbclient-dev

# Install redis
sudo apt-get install -y redis-server=5:4.0.9-1ubuntu0.2
sudo sed -i -e 's/^port 6379$/port 11222/' /etc/redis/redis.conf
sudo service redis-server force-reload

# Install memcached
sudo apt-get install -y memcached
