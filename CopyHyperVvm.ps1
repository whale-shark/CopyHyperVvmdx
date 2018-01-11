### Replace your environment from here ###

# Set create clone vm name
$VMName = "CentOS_1"

# Copy vhdx file path
$Src = "D:\Data\Hyper-V\SourceVM\Virtual Hard Disks\SourceVM.vhdx"
# Hyper-V VM contains directory
$VMCollectionsPath = "D:\Data\Hyper-V"

# Rescue disk file path
$DiskImagePath = "D:\Data\Hyper-VTemplate\CentOS-7-x86_64-DVD-1708.iso"
# CPU processer count
$CpuCount = 2
# Default memory size
$MemorySize = 4GB
# Default connect switch name
$SwitchName = "Direct"

# Contains cloning vm path
$DstVMPath = $VMCollectionsPath + "\" + $VMName
$DstVMDiskPath = $DstVMPath + "\Virtual Hard Disks"
$Dst = $DstVMDiskPath + "\" + $VMName + ".vhdx"

### So far ###

# Create Directory
New-Item $DstVMDiskPath -ItemType Directory
# Convert(Clone) vm disk image
Convert-VHD $Src $Dst

# Configure creation vm setting
$VMConf = @{
    Name = $VMName
    MemoryStartupBytes = $MemorySize
    SwitchName = $SwitchName
    Path = $VMCollectionsPath
    Generation = 2
}

# Create vm
New-VM @VMConf

# Setting vm
Add-VMHardDiskDrive $VMName -Path $Dst
Add-VMDvdDrive $VMName -Path $DiskImagePath
Set-VMProcessor $VMName -Count $CpuCount

$BootOrder = @(
    Get-VMDvdDrive $VMName
    Get-VMHardDiskDrive $VMName
    Get-VMNetworkAdapter $VMName
)

# If you are on Windows on vm please set SecureBootTemplate to "MicrosoftWindows"
Set-VMFirmware $VMName -BootOrder $BootOrder -SecureBootTemplate "MicrosoftUEFICertificateAuthority"

# Start vm
Start-VM $VMName
