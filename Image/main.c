#include "trap.h"
#include "print.h"

void KMain(void)
{
   char *string = "Hello and Welcome to Our Operating System";
   int64_t value = 0x123456789ABCD;
   int h = 9;
   
   init_idt();

   printk("%s\n", string);
   printk("This value is equal to %x\n", value);
   printk("New Value = %x", h);
}