# Setup

In this chapter, we'll install the QEMU on Linux to set up the RISC-V system.
You can skip this guide and move to the next chapter if you have a real RISC-V machine or a virtual machine that is already set up for you.

## Installing the QEMU on Linux

To compile and run RISC-V assembly codes, we need to have a RISC-V machine.
Here we'll emulate a RISC-V machine using the [QEMU][1] emulator.

We'll use the Ubuntu Server 22.04.4 as a host machine.
You can get the version as follows.

```
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.4 LTS
Release:        22.04
Codename:       jammy
```

Install the QEMU emulator as follows.

```
$ sudo apt install qemu-system-riscv64
$ qemu-system-riscv64 --version
QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.22)
Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers
```

Download the Ubuntu Server (22.04.4) image from [the image list][2].
We'll use the preinstalled image of SiFive HiFive Unmatched on the QEMU.
We can download and unzip the file in a terminal as follows.

```
$ curl -O https://cdimage.ubuntu.com/releases/22.04.4/release/ubuntu-22.04.4-preinstalled-server-riscv64+unmatched.img.xz
$ xz -dk ubuntu-22.04.4-preinstalled-server-riscv64+unmatched.img.xz
```

You can get the checksum as follows.

```
$ md5sum ubuntu-22.04.4-preinstalled-server-riscv64+unmatched.img.xz
c1150e6c9c8e1ab5c5ba168d94736d09  ubuntu-22.04.4-preinstalled-server-riscv64+unmatched.img.xz
```

## Booting the QEMU

The RISC-V boot process requires the following two packages.

```
$ sudo apt install u-boot-qemu opensbi
```

Turn on the RISC-V emulator as follows. (See [Ubuntu Wiki][3].)

```
$ qemu-system-riscv64 \
-machine virt -nographic -m 1024 -smp 2 \
-bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.bin \
-kernel /usr/lib/u-boot/qemu-riscv64_smode/uboot.elf \
-device virtio-net-device,netdev=eth0 -netdev user,id=eth0 \
-device virtio-rng-pci \
-drive file=ubuntu-22.04.4-preinstalled-server-riscv64+unmatched.img,format=raw,if=virtio
```

It will take some time to initialize the system, and eventually the login prompt will appear. The initial id and password are both `ubuntu`.

## Installing Packages in QEMU

To set up the RISC-V assembly programming environment, install a package in the QEMU as follows.

```
$ sudo apt install build-essential
```

[1]: https://www.qemu.org/
[2]: https://cdimage.ubuntu.com/releases/22.04.4/release/
[3]: https://wiki.ubuntu.com/RISC-V/QEMU
