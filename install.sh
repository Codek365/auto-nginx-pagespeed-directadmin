cd /usr/local/directadmin/custombuild
./build set php1_mode php-fpm
./build set php2_mode php-fpm
./build set php1_release 7.0
./build set php2_release 5.6
./build set webserver nginx_apache
./build update

./build all d
./build rewrite_confs


[check the release notes for the latest version]
NPS_VERSION=1.13.35.1-beta
cd
wget https://github.com/apache/incubator-pagespeed-ngx/archive/v${NPS_VERSION}.zip
unzip v${NPS_VERSION}.zip
nps_dir=$(find . -name "*pagespeed-ngx-${NPS_VERSION}" -type d)
cd "$nps_dir"
NPS_RELEASE_NUMBER=${NPS_VERSION/beta/}
NPS_RELEASE_NUMBER=${NPS_VERSION/stable/}
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_RELEASE_NUMBER}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url}) 


cd /usr/local/directadmin/custombuild
mkdir -p custom/nginx
cp -fp configure/nginx/configure.nginx custom/nginx/configure.nginx

vi /usr/local/directadmin/custombuild/custom/nginx/configure.nginx

./build used_configs
./build nginx
 nginx -V
