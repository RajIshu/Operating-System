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
11.	Open Bosch.
12.	Edit CPUID:
	* X86-64 and long mode [enable]
	* 1G pages support in long mode [enable]
13.	Edit Memory:
	* Memory size [1024]
	* Host allocated memory size [1024]
14.	Edit Disk & Boot:
	* ATA channel 0:
		- First HD/CD on channel 0
			+ Type of ATA device [disk]
			+ Path or physical device name [boot.img]
			+ Cylinders [20]
			+ Heads [16]
			+ Sectors per track [63]

	* Boot Options
		- Boot drive #1 [disk]
15.	Save the configuration file.
16.	Open VS Code.
17.	Install C/C++ and x8664assembly (by fredhappyface) extensions in vs code.
18.	Install Rufus which is used to create bootable usb flash drive: https://rufus.ie/en/
19.	Write assembly code (boot.asm) and build script file (build.sh)
20.	After writing codes, open Ubuntu Windows Sub-system and go to the folder where these files are located use ```cd /mnt/[Local drive]``` command as it will basically mount our local drive to ubuntu. (Keep these files in the same directory where boot.img file is located.)

## NOTE:
- Mounting the drive and moving to the where it is located is very time-consuming task. So, we can take help of aliases. 
- Aliases are like custom shortcuts used to represent a command (or set of commands) executed.
- We can make aliases using this command: ```alias [shortName]="[Your custom command]"```
	+ Example:
		I have made an alias for myself like this: ```alias cdmos="cd /mnt/d/PROJECT/Operating\ System/"```
Remember, these aliases will be temporary. But we can make them permanent if we add this alias in ahell configuration profile file. 
We can run vim ~/.bashrc for Bash shell or terminal.
It will open the file and then we have to add the alias at the last of the file and save and close.
It will start working from next ubuntu session.

If we want to use the alias from this current session then we have to run source ~/.bashrc command in the terminal.

We can even list all the alias using alias command.

20.	Now it’s time to build the project. Run the build script using ./build.sh
21.	We would be able to see the generated binary file using hexdump command
Example: ```hexdump -c boot.bin```
22.	Now open bochs configuration file and change the boot.img directory path at line 13
It must look like this: ```ata0-master: type=disk, path="D:\PROJECT\Operating System\Image\boot.img"```
23.	Now start bochs configuration file by double clicking on it.
