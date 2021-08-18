# Tenginx

Build and provision ECS instance on Alicloud using IaaC tool.

## Description

Build ECS Instance  and provision instance with Nginx (webserver that can be accessed from internet) and timedate using Asia/Jakarta time on Alicloud Infrastructure.
All build and provision activities is using terraform which is one of IaaC tools.

## Getting Started

### Installing

Terraform version 1.0.3,

### Executing program

There are 2 ways to add access key and access key secret:
* Add terraform.tfvars file, and then add this script to that file :
```
access_key ="<your access key>"
access_key_secret = "<your access key secret>"
```

* Or, on your terminal:

```
$ export ALICLOUD_ACCESS_KEY="anaccesskey"
$ export ALICLOUD_SECRET_KEY="asecretkey"
```
