# Rust Compiler
RUSTC=rustc

# Linker: Combine objects, resolve links and output executable. Usually last step (after compiled)
LD=i686-unknown-linux-gnu-ld

# Assembler for Intel x86: Turn Assembly code into machine (binary) code for that processor
NASM=nasm

# Simulator of OS
QEMU=qemu-system-x86_64

all: floppy.img

.SUFFIXES: .o .rs .asm

.PHONY: clean run

.rs.o:
	@echo "\n-> RUSTC: Compile main.rs into main.o...\n"
	$(RUSTC) -O --target i686-unknown-linux-gnu --crate-type lib -o $@ --emit obj $< -A warnings

loader.bin: loader.asm
	@echo "\n-> NASM: Assemble loader.asm into loader.bin...\n"
	$(NASM) -o $@ -f bin $<

main.bin: linker.ld main.o
	@echo "\n-> Linker: Link main.o into main.bin using linker.ld...\n"
	$(LD) -o $@ -T $^

floppy.img: loader.bin main.bin
	@echo "\n-> Make floppy.img from loader.bin and main.bin (by directly concat?)...\n"
	cat $^ | dd if=/dev/stdin of=$@ conv=notrunc &>/dev/null

run: floppy.img
	$(QEMU) -fda $<

clean:
	rm -f *.bin *.o *.img
