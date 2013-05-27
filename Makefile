OBJECTS = build/boot.o build/kernel.o build/terminal.o

default: clean all run

all: build/kernel

build/boot.o: kernel/boot.asm
	nasm -felf kernel/boot.asm -o build/boot.o

build/%.o: kernel/%.c
	i586-elf-gcc -c $< -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

build/kernel: $(OBJECTS)
	i586-elf-gcc -T kernel/linker.ld -o build/kernel -ffreestanding -O2 -nostdlib $(OBJECTS)

clean:
	rm -f -v build/*

run:
	qemu-system-i386 -kernel build/kernel