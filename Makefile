default: clean all run

all: build/kernel

kernel/boot.o: kernel/boot.asm; nasm -felf boot.asm -o boot.o

kernel/kernel.o: kernel/kernel.c; i586-elf-gcc -c kernel/kernel.c -o kernel/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

build/kernel: kernel/boot.o kernel/kernel.o; i586-elf-gcc -T kernel/linker.ld -o build/kernel -ffreestanding -O2 -nostdlib kernel/boot.o kernel/kernel.o

clean:; rm -f -v *.o *.bin

run:; qemu-system-i386 -kernel build/kernel