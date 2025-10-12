ASM = nasm
CC = i686-elf-gcc
LD = i686-elf-ld
GRUB_MKRESCUE = i686-elf-grub-mkrescue

ASMFLAGS = -f elf32
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T

SRCDIR = src
BUILDDIR = build
TARGET_ISO = snake_os.iso

ASM_SOURCES = $(SRCDIR)/boot/boot.asm
C_SOURCES = $(SRCDIR)/kernel/kernel.c

ASM_OBJS = $(patsubst $(SRCDIR)/%.asm, $(BUILDDIR)/%.o, $(ASM_SOURCES))
C_OBJS = $(patsubst $(SRCDIR)/%.c, $(BUILDDIR)/%.o, $(C_SOURCES))

.PHONY: clean all iso

all: $(TARGET_ISO)

clean:
	@rm -rf $(BUILDDIR) $(TARGET_ISO)

iso: $(TARGET_ISO)

$(TARGET_ISO): $(BUILDDIR)/kernel.bin
	@mkdir -p $(BUILDDIR)/iso/boot/grub
	@cp $(BUILDDIR)/kernel.bin $(BUILDDIR)/iso/boot/kernel.bin
	@echo 'set_timeout=0\nset_default=0\nmenuentry "snake_os" {\n\tmultiboot /boot/kernel.bin\n}' > $(BUILDDIR)/iso/boot/grub/grub.cfg
		@$(GRUB_MKRESCUE) -o $(TARGET_ISO) $(BUILDDIR)/iso

$(BUILDDIR)/kernel.bin: $(ASM_OBJS) $(C_OBJS) $(SRCDIR)/linker.ld
	@$(LD) $(LDFLAGS) $(SRCDIR)/linker.ld -o $@ $(ASM_OBJS) $(C_OBJS)

$(BUILDDIR)/%.o: $(SRCDIR)/%.asm
	@mkdir -p $(dir $@)
	@$(ASM) $(ASMFLAGS) $< -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@

run: $(TARGET_ISO)
	@qemu-system-i386 -cdrom $(TARGET_ISO)

