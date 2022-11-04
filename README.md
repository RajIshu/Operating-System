# Operating-System
1.	Install and setup WSL: https://docs.microsoft.com/en-us/windows/wsl/install-manual
2.	Update Ubuntu first: ```sudo apt-get update```
3.	Install GCC: ```sudo apt install gcc```
4.	Check GCC installation status: ```gcc -v```
5.	Install Nasm assembler (Used for assembly code): ```sudo apt install nasm```
6.	Check Nasm installation: ```nasm -v```
7.	Install Bosch Emulator 2.6.11 (64-bit) (It is a virtual machine): https://bochs.sourceforge.io/
8.	Edit environment variable.
9.	Open powershell and run ‘bximage’ to create image file.
11.	Open Bosch
12.	Edit CPUID:
12.1. X86-64 and long mode [enable]
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b. 1G pages support in long mode [enable]
13.	Edit Memory:
a.	Memory size [1024]
b.	Host allocated memory size [1024]
14.	Edit Disk & Boot:
a.	ATA channel 0:
i.	First HD/CD on channel 0
1.	Type of ATA device [disk]
2.	Path or physical device name [boot.img]
3.	Cylinders [20]
4.	Heads [16]
5.	Sectors per track [63]

b.	Boot Options
i.	Boot drive #1 [disk]
15.	Save the configuration file and open the file in VS Code
16.	Install C/C++ and x8664assembly (by fredhappyface) extensions in vs code.
17.	Install Rufus which is used to create bootable usb flash drive: https://rufus.ie/en/
18.	Write assembly code (boot.asm) and build script file (build.sh)
19.	After writing codes, open Ubuntu Windows Sub-system and go to the folder where these files are located use cd /mnt/<the local drive>/ command as it will basically mount our local drive to ubuntu. (Keep these files in the same directory where boot.img file is located.)

NOTE:
Mounting the drive and moving to the where it is located is very time-consuming task. So, we can take help of aliases. 
Aliases are like custom shortcuts used to represent a command (or set of commands) executed.
We can make aliases using this command: alias [shortName]="[Your custom command]"
Example:
	I have made an alias for myself like this:
	alias cdmos="cd /mnt/d/PROJECT/Operating\ System/"
Remember, these aliases will be temporary. But we can make them permanent if we add this alias in ahell configuration profile file. 
We can run vim ~/.bashrc for Bash shell or terminal.
It will open the file and then we have to add the alias at the last of the file and save and close.
It will start working from next ubuntu session.

If we want to use the alias from this current session then we have to run source ~/.bashrc command in the terminal.

We can even list all the alias using alias command.

20.	Now it’s time to build the project. Run the build script using ./build.sh
21.	We would be able to see the generated binary file using hexdump command
Example: hexdump -c boot.bin
22.	Now open bochs configuration file and change the boot.img directory path at line 13
It must look like this: ata0-master: type=disk, path="D:\COURSES\BTECH\PROJECT\Operating System\Image\boot.img"
23.	Now start bochs configuration file by double clicking on it.
24.	[OPTIONAL] Now we will write the boot file into USB drive. Open Rufus. Select boot image. Select USB Drive. Click Start.
Now we want to configure our Test System. Open BIOS Interface. Go to BIOS Option. Enable CSM Support.
25.	Testing Disk Extension Service:
a.	What is Disk Extension Service and why we need it?
ANS: Disk extension service is just service or function bios provides to help us load the programs from the disk. In the boot up process, we need to load the loader and kernel from the disk to the memory using disk extension service.
b.	We use BIOS disk services to load our file from disk in boot process and when we read file from disk, we should provide CHS value in order to locate the sector we want to read.
NOTE: CHS stands for Cylinder Head Sector.

Using CHS value requires extra calculation. So, to make our boot file simple, we choose logical block address which disk extension service use to access the disk.

NOTE: A logical block address is a 28-bit value that maps to a specific cylinder-head-sector address on the disk. It is a common scheme used for specifying the location of blocks of data stored on computer storage devices, generally secondary storage systems such as hard disk drives.
c.	Modern Computer should support Disk Extension but for that we have to check or test the system for Disk Extension Service. We will add some code in assembly file (.asm).
d.	After adding codes in Assembly file, we can build the image file by running /.build.sh command. After build is complete, we can open bochsrc.bxrc by double clicking it.
It will show this:
  
  ![image](https://user-images.githubusercontent.com/86165115/199981382-07c3aaf6-cbd6-43b8-af57-4d04da001e22.png)

 

26.	After disk extension check is passed, we need to load a new file called loader in the memory.
The reason we need a loader file is that the MBR (MBR is explained in NOTES word file) is fixed size which is 512 bytes. There are spaces reserved for other use such as partition entries, which leaves us less than 512 bytes for the boot code.
Boot code is a set of "instructions" that are run by a computer when it is starting up.

The tasks that we should do in the boot process includes load kernel file, get memory map, switch to protected mode and then jump to long mode.
Doing all these tasks requires the boot code larger than 512 bytes.

So here we introduce a new file called loader file to do all these things.

27.	Loader:
a.	The loader file has no 512 bytes limits.
b.	Loader retrieves information about hardware
c.	Prepare for 64-bit mode and switch to it
d.	Loader loads kernel in main memory and Jump to kernel
This is the memory map when we load the loader file:
![image](https://user-images.githubusercontent.com/86165115/199981603-1d5e9014-efab-4b20-8cca-779ed7f514d2.png)

 
	The boot code or MBR code is loaded by BIOS in the memory address 7c00. 
The size of the boot code is 512 bytes which is 200 in hexadecimal.
So, here we simply load the loader file into the location right after the boot code which is at the location 7e00.
28.	Load a Kernel File:
![image](https://user-images.githubusercontent.com/86165115/199981687-e13255be-f693-4323-bc78-cdd1e22128b2.png)

 
	The kernel file can be loaded above loader file as there is very large space is free.
The boot file resides in first sector. The loader file occupies the next five sectors. So, we write kernel from seventh sector. 
29.	



