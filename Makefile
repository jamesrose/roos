default: clean all run

all: build/kernel

kernel/boot.o: kernel/boot.asm
	nasm -felf kernel/boot.asm -o build/boot.o

kernel/kernel.o: kernel/kernel.c
	i586-elf-gcc -c kernel/kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

build/kernel: kernel/boot.o kernel/kernel.o
	i586-elf-gcc -T kernel/linker.ld -o build/kernel -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o

clean:
	rm -f -v *.o *.bin

run:
	qemu-system-i386 -kernel build/kernel