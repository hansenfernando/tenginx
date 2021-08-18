output "ssh_key_name" {
  description = "ssh key for instance login"
  value       = alicloud_ecs_key_pair.tenginx_ssh_keypair.key_file
}

output "user_login" {
  description = "user login name to instance"
  value       = "root"
}

output "public_ip" {
  description = "IP public"
  value       = alicloud_instance.instance.public_ip
}