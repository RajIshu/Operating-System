; Directives
[BITS 16]   ; This directive tells the assembler that our boot code is running on the 16-bit mode. For more refer this link https://en.wikibooks.org/wiki/X86_Assembly/16,_32,_and_64_Bits
[ORG 0x7c00]    ; This directive indicates that the code is supposed to be running at memory address 0x7c00

; Start is used as label to mark the starting point of our assembly code
start:
    xor ax,ax   ; xor'ing a value with itself produces 0. So, XOR AX,AX is equivalent to "AX = 0". It's a common trick in assembly code because it's faster than MOV AX,0. So, it is the Fastest way to zero a register.
    mov ds,ax   ; copies the value of ax i.e., 0 to ds.
    mov es,ax   ; copies the value of ax i.e., 0 to es.
    mov ss,ax   ; copies the value of ax i.e., 0 to ss.
    mov sp,0x7c00

PrintMessage:
    mov ah,0x13 ; register ah holds the function code and 0x13 means print string
    mov al,1    ; register al specifies the write mode and setting it to '1' place the cursor at the end of the string
    mov bx,0xa  ; 0xa is saved to bx. 0xa means the character is printed in bright green. Bh which is the higher part of bx register represents page number and BL, the lower part of bx holds the information of character attributes.
    xor dx,dx   ; equivalent to dx = 0. Dh which is higher part of dx register represents rows and dL represents columns. Since we want to print message at the beginning of the screen, we set them (dh and dL) to 0.
    mov bp,Message  ; bp holds the address of the string we want to print. If we want to copy the data in the variable message to bp, we need to add square brackets to do that, like this ==> mov bp,[Message]
    mov cx,MessageLen   ; cx specifies the number of characters to print. 
    int 0x10

End:
    hlt         ; 'hlt' halts the central processing unit (CPU) until the next external interrupt is fired.
    jmp End     ; 'jmp' is an interrupt which as a result, execution will jump back to label end and execute halt instruction again.
; End block is an infinite loop and code ends here.
     
Message:    db "Hello"
MessageLen: equ $-Message   ; The dollar sign means the current assembly position (which is the end of the message in this case) minus the address of message, the result is the size of string or the number of characters. The 'equ' is directive which is used to define a constant message length.

times (0x1be-($-$$)) db 0   ; 'times' is a directive which repeats command specific times. The double dollar sign means the beginning of the current section. The dollar sign minus double dollar sign represents the size from the start of the code to the end of the message. Then we subtract it from 1be. The result of this expression is repeat db command so that the space from the end of the message to the offset 1be are filled with 0s. 1be is nothing but called as a "partition enteries". The information about disk partitions starts from the predefined offset '1BE' from the beginning of the first sector. There are four partition table entries at this offset, each taking up 16 bytes in size.

    db 80h              ; Boot Indicator - here 80h means a bootable partition. If it is 0 instead of 80 then it would be otehr valid partition. If it is neither 80h nor zero, the corresponding partition should be considered invalid. Invalid partitions are silently ignored by most of the systems. For the disk to be bootable, exactly one entry must contain 80h in this field.
    db 0,2,0            ; Starting CHS - C stands for cylinder, H for head and S for sector
    db 0f0h             ; Partition Type
    db 0ffh,0ffh,0ffh   ; Ending CHS
    dd 1                ; starting sector
    dd (20*16*63-1)     ; size
    ; If you don’t fully understand the meaning of each field of the entry, no worries. Because the value in the partition entry does not reflect the real partition.
    ; The reason we define this entry is that some BIOS will try to find the valid looking partition entries. If it is not found, the BIOS will treat usb flash drive as, for example, floppy disk.
    ; We want BIOS to boot the usb flash drive as hard disk. So we add the partition entry to construct a seemingly valid entries.
	
    times (16*3) db 0

    ; These last two lines are signature
    db 0x55
    db 0xaa

	
