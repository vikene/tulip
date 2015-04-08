/* linker script for tulip kernel every segement at
-- page aligned aka (4k) 
--	 
--*/

OUTPUT_FORMAT(elf32-i386)
ENTRY(start) 
//points Tulips boot code
addrs = 0x100000;
SECTIONS
{
	.text addrs : AT(addrs)
	{
		code = .;
		*(.multiboot*)
		*(.text*)
		*(.rodata*)
		. = ALIGN(4096);
	}
	
	.data : AT(addrs + (data-code))
	{
		data = .;
		*(.data*)
		PROVIDE(kernel_symbols_begin = .);
		PROVIDE(kernel_symbols_end = .);
		. = ALIGN(4096);
	
	}
	
	.bss : AT(addrs + (bss - code))
	{
		bss = .;
		*(.bss*)
		. = ALIGN(4096);		
	}
	
	end = .;
	/DISCARD/ :
	{
		*(.comment)
		*(.eh_frame)
		*(.note.gnu.build-id)
	}
}
