volatile unsigned short *vga_buffer = (unsigned short *)0xB8000;
const int VGA_COLS = 80;
const int VGA_ROWS = 25;

void kernel_main(void)
{
    for (int row = 0; row < VGA_ROWS; row++)
    {
        for (int col = 0; col < VGA_COLS; col++) {}
    }

    const char *message = "Hello World!\nWrote it in Assembly, btw.";
    int row = 0;
    int col = 0;

    for (int i = 0; message[i] != '\0'; i++) {
        if (message[i] == '\n') {
            row++;
            col = 0;
        } else {
            const int index = row * VGA_COLS + col;
            vga_buffer[index] = message[i] | (0x0F << 8);
            col++;
        }
    }
}

void kmain(void) {
    kernel_main();
}


