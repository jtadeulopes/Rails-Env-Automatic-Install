#!/bin/bash

if [ "$(whoami)" != "root" ]; then
echo "You need to be root to run this!"
  exit 2
fi

echo ""
echo "================================================================"
echo "\tBASIC RAILS DEVELOPMENT SETUP"
echo "\tAuthor: Junio Vitorino"
echo "\tEmail: jgvitorino@gmail.com"
echo "\tBlog: http://www.lamiscela.net"
echo "\tDescription: Basic setup of a Rails development environment using Ubuntu 9.10"
echo "================================================================"
echo ""
echo ""
echo ""

echo "Do you'd like continue the installation? (y) for condinue or (q) to quit:"
read START
if [ $START == "q" ]; then
	echo "Installation not started"
	exit 2
fi

echo ""
echo ""
echo " Starting..."
echo ""
echo ""

echo ""
echo "================================================================"
echo "\tInstalling compilers"
echo "================================================================"
echo ""

apt-get -y install build-essential libssl-dev libreadline6-dev zlib1g zlib1g-dev


echo ""
echo "================================================================"
echo "\tInstalling required libraries and packages"
echo "================================================================"
echo ""

apt-get -y install tcl-dev libexpat-dev libcurl4-openssl-dev apg geoip-bin libgeoip1 libgeoip-dev libsqlite3-dev libpcre3 libpcre3-dev libyaml-dev libmysqlclient15-dev libonig-dev libopenssl-ruby libdbd-mysql-ruby libmysql-ruby  libmagick++-dev zip unzip libxml2-dev libxslt1-dev libxslt-ruby libxslt-ruby1.8 libxslt1.1 libxslt1-dev libxslt1-dbg libapr1-dev libaprutil1-dev memcached 

echo ""
echo "================================================================"
echo "\tRuby 1.8.7 Patch Level 72"
echo "================================================================"
echo ""

if [ -d /src ] 
then
   cd /src
else
  mkdir /src
  cd /src
fi

wget ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p72.tar.gz
tar -xzvf ruby-1.8.7-p72.tar.gz >> /dev/null
cd ruby-1.8.7-p72
./configure --prefix=/usr/local --with-openssl-dir=/usr --with-readline-dir=/usr --with-zlib-dir=/usr
make
make install
ln -s /usr/local/bin/ruby /usr/bin/ruby
/usr/local/bin/ruby -ropenssl -rzlib -rreadline -e "puts :success"
cd /
rm /src/ruby-1.8.7-p72.tar.gz
rm -rf /src/ruby-1.8.7-p72


echo ""
echo "================================================================"
echo "\tRubyGems 1.3.5" 
echo "================================================================"
echo ""

cd /src
wget http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz
tar xzvf rubygems-1.3.5.tgz
cd rubygems-1.3.5/
ruby setup.rb
cd /
rm /src/rubygems-1.3.5.tgz
rm /src/-rf rubygems-1.3.5

echo ""
echo "================================================================"
echo "\tApache2, SQLite3, MySQL5.1, ImageMagick e PHP5"
echo "================================================================"
echo ""

apt-get -y install mysql-server-5.1 mysql-client-5.1 apache2 php5 php5-mysql sqlite3 php5-sqlite imagemagick libfcgi-dev

echo ""
echo "================================================================"
echo "\tGIT"
echo "================================================================"
echo ""

cd /src
wget http://kernel.org/pub/software/scm/git/git-1.6.5.2.tar.gz
tar -xzvf git-1.6.5.2.tar.gz
cd git-1.6.5.2/
./configure
make
make install
ln -s /usr/local/bin/git /usr/bin/git
cd /
rm /src/git-1.6.5.2.tar.gz
rm /src/-rf git-1.6.5.2

gem sources -a http://gemcutter.org
gem sources -a http://gems.github.com

gem install --no-rdoc --no-ri rails

echo "Do you would like install a set of gems than in my opinion is very important for a Rails development server? (y/n)"
read WANTS_GEMS_PACK

if [ $WANTS_GEMS_PACK == "y" ]; then
	
	echo ""
	echo "================================================================"
	echo "\tInstalling GEMS"
	echo "================================================================"
	echo ""	

	gem install --no-rdoc --no-ri authlogic
	gem install --no-rdoc --no-ri paperclip
	gem install --no-rdoc --no-ri mysql
	gem install --no-ri --no-rdoc rmagick 
	gem install --no-ri --no-rdoc chronic 
	gem install --no-ri --no-rdoc geoip 
	gem install --no-ri --no-rdoc daemons 
	gem install --no-ri --no-rdoc hoe 
	gem install --no-ri --no-rdoc echoe 
	gem install --no-ri --no-rdoc ruby-yadis 
	gem install --no-ri --no-rdoc ruby-openid
	gem install --no-ri --no-rdoc mime-types 
	gem install --no-ri --no-rdoc diff-lcs 
	gem install --no-ri --no-rdoc json 
	gem install --no-ri --no-rdoc rack 
	gem install --no-ri --no-rdoc ruby-hmac 
	gem install --no-ri --no-rdoc rake 
	gem install --no-ri --no-rdoc stompserver 
	gem install --no-ri --no-rdoc passenger
	gem install --no-ri --no-rdoc hpricot
	gem install --no-ri --no-rdoc ruby-debug
	gem install --no-ri --no-rdoc capistrano
	gem install --no-ri --no-rdoc rspec
	gem install --no-ri --no-rdoc ZenTest
	gem install --no-ri --no-rdoc webrat
	gem install --no-ri --no-rdoc image_science
	gem install --no-ri --no-rdoc mini_magick
	gem install --no-ri --no-rdoc mechanize
	gem install --no-ri --no-rdoc RedCloth
	gem install --no-ri --no-rdoc fastercsv
	gem install --no-ri --no-rdoc piston
	gem install --no-ri --no-rdoc sashimi
	gem install --no-ri --no-rdoc ruport
	gem install --no-ri --no-rdoc open4
	gem install --no-ri --no-rdoc rubigen
	gem install --no-ri --no-rdoc sqlite3-ruby
	gem install --no-ri --no-rdoc mongrel
	gem install --no-ri --no-rdoc mongrel_service
	gem install --no-ri --no-rdoc oniguruma
	gem install --no-ri --no-rdoc ultraviolet
	gem install --no-ri --no-rdoc libxml-ruby
fi

echo "Do you'd like install GMATE set of plugins for GEdit editor? (y/n)"
read WANTS_GMATE

if [ $WANTS_GMATE == 'y' ]; then
	echo ""
	echo "================================================================"
	echo "\tInstalling GMATE Plugins"
	echo "================================================================"
	echo ""	
	cd /srv
	git clone git://github.com/lexrupy/gmate.git
	cd gmate
	sh install.sh
	cd /
	rm -rf /src/gmate
fi

echo "Do you'd like setup Apache to works with Passenger? (y/n)"
read WANTS_PASSENGER

if [ $WANTS_PASSENGER == 'y' ]; then
	
	echo ""
	echo "================================================================"
	echo "\tEnable Passenger"
	echo "================================================================"
	echo ""	
	
	gem install --no-ri --no-rdoc passenger
	passenger-install-apache2-module
	echo "LoadModule passenger_module /usr/local/lib/ruby/gems/1.8/gems/passenger-2.2.5/ext/apache2/mod_passenger.so
  	PassengerRoot /usr/local/lib/ruby/gems/1.8/gems/passenger-2.2.5
   	PassengerRuby /usr/local/bin/ruby" >> /etc/apache2/mods-available/passenger.load
	a2enmod passenger
 	a2enmod rewrite
	/etc/init.d/apache2 restart
fi

echo ""	
echo ""
echo "=================================================="
echo "\tServer installation finished"
echo "=================================================="