provider "alicloud" {
  access_key = var.access_key
  secret_key = var.access_key_secret
  region     = var.region
}

data "alicloud_zones" "zones_ds" {}

data "alicloud_instance_types" "core1mem1g" {
  cpu_core_count    = 1
  memory_size       = 1
  availability_zone = data.alicloud_zones.zones_ds.zones.0.id
}

resource "alicloud_vpc" "tenginx_vpc" {
  vpc_name   = "tenginx_vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "tenginx_vswitch" {
  vswitch_name = "tenginx_vswitch"
  vpc_id       = alicloud_vpc.tenginx_vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.zones_ds.zones.0.id
}

resource "alicloud_security_group" "tenginx_sg" {
  name        = "tenginx_sg"
  vpc_id      = alicloud_vpc.tenginx_vpc.id
  description = "Webserver Security Group"
}

resource "alicloud_security_group_rule" "ssh_in" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  security_group_id = alicloud_security_group.tenginx_sg.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "http_in" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "80/80"
  security_group_id = alicloud_security_group.tenginx_sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_ecs_key_pair" "tenginx_ssh_keypair" {
  key_pair_name = "tenginx-ssh-keypair"
  key_file      = "tenginx-ssh-keypair.pem"
}

resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.zones_ds.zones.0.id
  security_groups            = ["${alicloud_security_group.tenginx_sg.id}"]
  instance_type              = "ecs.xn4.small"
  system_disk_category       = "cloud_efficiency"
  image_id                   = "ubuntu_20_04_x64_20G_alibase_20210623.vhd"
  instance_name              = "tenginx_webserver"
  vswitch_id                 = alicloud_vswitch.tenginx_vswitch.id
  internet_max_bandwidth_out = 10
  key_name                   = alicloud_ecs_key_pair.tenginx_ssh_keypair.key_pair_name
  user_data                  = file("install_tools.sh")
}