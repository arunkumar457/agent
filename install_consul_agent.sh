
echo " Installing Node_Exporter"
echo "============================="

cd ~
curl -LO https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-amd64.tar.gz
sha256sum node_exporter-0.17.0.linux-amd64.tar.gz
tar -xvf node_exporter-0.17.0.linux-amd64.tar.gz 
cp node_exporter-0.17.0.linux-amd64/node_exporter /usr/local/bin/node_exporter
useradd --no-create-home --shell /bin/false node_exporter
chown node_exporter:node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter*
cp -p /tmp/node_exporter.service /etc/systemd/system/node_exporter.service
chmod -x /etc/systemd/system/node_exporter.service
systemctl restart node_exporter.service


echo " Installing Consul Agent "
echo " ======================== "


cd ~
wget https://releases.hashicorp.com/consul/1.4.4/consul_1.4.4_linux_amd64.zip
unzip consul_1.4.4_linux_amd64.zip
mv consul /usr/bin/
mkdir -p /etc/consul.d
mkdir -p /etc/consul.d/client
cp -p /tmp/config.json /etc/consul.d/client/config.json
cp -p /tmp/consul.service /etc/systemd/system/consul.service
cp -p /tmp/node_exporter.json /etc/consul.d/client/node_exporter.json
chmod -x /etc/systemd/system/consul.service
systemctl restart consul.service
