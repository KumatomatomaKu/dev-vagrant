#!/bin/sh

sudo apt-get --yes update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

echo "Asia/Tokyo" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata
sudo aptitude install -y language-pack-ja
sudo dpkg-reconfigure locales

sudo apt-get install --yes git
sudo apt-get install --yes make

sudo apt-get install --yes redis-server
sed -e 's/^port 6379$/port 11222/' /etc/redis/redis.conf > /tmp/redis.conf
sudo mv /tmp/redis.conf /etc/redis/redis.conf
sudo chmod 644 /etc/redis/redis.conf
sudo service redis-server force-reload

sudo apt-get install --yes memcached


sudo mkdir -p /etc/mysql/conf.d
cat <<__EOF__ | sudo tee /etc/mysql/conf.d/character_set.cnf
[client]
default-character-set = utf8

[mysqld]
character-set-server = utf8
skip-character-set-client-handshake

[mysqldump]
default-character-set=utf8

[mysql]
default-character-set=utf8
__EOF__

sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes mysql-server
sudo apt-get install --yes libmysqlclient-dev


##
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
echo 'export LC_CTYPE=en_US.UTF-8' >> ~/.bash_profile
echo 'export LC_ALL=en_US.UTF-8"' >> ~/.bash_profile
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
