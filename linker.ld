/* 
This is a linker script:
https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html

SECTIONS is the output layout.

MEMORY complements SECTIONS by describing the available memory in the target architecture.

. is the current output location.

The special secname `/DISCARD/' may be used to discard input sections. Any sections which are assigned to an output section named `/DISCARD/' are not included in the final link output.

'>region' (i.e. '>ram') directs the linker to place specific output sections into that memory region.

*/
ENTRY(main)
OUTPUT_FORMAT(binary)

MEMORY {
    ram : org = 0x7e00, l = 12K
}

SECTIONS {
    . = 0x7e00;

    .text : {
        *(.text)
    } >ram

    /DISCARD/ : {
        *(.comment)
        *(.eh_frame)
        *(.rel.eh_frame)
    }
}
