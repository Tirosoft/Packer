# create a Vagrant box files (ovf+vmdk) for Oracle VirtualBox using Centos9 Install ISO file (minimal installation)

packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-iso" "c9" {
  guest_os_type = "RedHat9_64"
  iso_url = "centos.iso"
  iso_checksum = "md5:59169a0e00f67ac490d7fc2b667564e9"
  shutdown_command = "shutdown -h now"
  hard_drive_interface = "sata"
  disk_size = 50000
  vm_name = "CentOS9"
  cpus = 2
  memory = 4096
  ssh_username = "admin"
  ssh_password = "Qwerty)!."
  boot_command = [
	"<tab><spacebar>inst.text<enter><wait1m><esc><wait2m>2<enter><wait10>",
	"2<enter>1<enter>1<enter>7<enter><wait10>",
	"5<enter>c<enter>c<enter>c<enter><wait10>",
	"8<enter><wait5>Qwerty)!.<enter><wait5>Qwerty)!.<enter><wait10>",
	"9<enter>1<enter>2<enter>admin<enter>5<enter><wait5>Qwerty)!.<enter><wait5>Qwerty)!.<enter>6<enter>c<enter><wait10>",
	"7<enter>1<enter><wait10>{{ .Name }}<enter>c<enter><wait10>",
	"4<enter>3<enter>c<enter>2<enter>c<enter>",
    "<wait2m>",
	"b<enter>",
    "<wait7m>",
	"<enter>",
    "<wait2m>"
  ]
}

build {
  sources = ["sources.virtualbox-iso.c9"]
}
