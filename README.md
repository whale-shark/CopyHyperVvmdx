# Copy Hyper-V vmdx and create new vm

Hyper-V on Windows 10 can not duplicate the second generation virtual machine.

So create a new virtual machine by copying the disk of the virtual machine that already exists on Hyper-V.

After that, manually execute the command to complete the initial setting.

**These scripts and commands should be executed by the administrator.**

# Restriction

* You already have a copy source virtual machine.
* No checkpoint exists in the virtual machine as the copy source.
* We do not guarantee OS other than CentOS.

# Configuration

Open the CopyHyperVvm.ps1 file and change the variables according to your environment.

# After script

After this script completes, connect to the virtual machine and execute the following command in rescue mode.

## 1st: Check mount points.

```
sh-4.2# fdisk -l | less
```

The following commands indicate that the mount point is /dev/sda1.

## 2nd: Add settings required for startup.

```
sh-4.2# /sbin/efibootmgr --create --label CentOS --disk /dev/sda1 --loader "\EFI\centos\shimx64.efi"
``` 

## 3rd: Shutdown vm.

```
sh-4.2# /sbin/shutdown -h now
```

## 4th: Take out ISO image form the DVD drive.

After the execution of the command is completed, take out the ISO image from the DVD drive.

This concludes the replication of the virtual machine.

# Execute manually using the GUI

Please refer to the following site when working this script manually using Hyper-V manager.

https://qiita.com/whale_shark/items/11a2b0a36c5dfe27e9f0

*Sorry, japanese only.*