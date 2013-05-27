#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "kernel.h"
 
uint8_t make_color(enum vga_color fg, enum vga_color bg) {
  return fg | bg << 4;
}
 
uint16_t make_vgaentry(char c, uint8_t color) {
  uint16_t c16 = c;
  uint16_t color16 = color;
  return c16 | color16 << 8;
}
 
size_t strlen(const char* str) {
  size_t ret = 0;
  while ( str[ret] != 0 )
    ret++;
  return ret;
}

void kernel_main() {
  terminal_initialize();
  terminal_writestring("Hello, James Rose!\nWhat's up?");  
}