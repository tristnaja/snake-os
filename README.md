# snake_os

A tiny 32-bit operating system for the x86 architecture, built from scratch to run a simple Snake game. This project is a learning exercise in OS development.

## Project Milestones

This project is divided into three main milestones:

1.  **Hello World Kernel:** A bootable kernel that prints a "Hello, World" message to the VGA text buffer.
2.  **Interactive Console:** An interactive shell with basic commands, including keyboard input handling.
3.  **Snake Game:** A classic Snake game running on top of our custom OS.

## Getting Started

### Prerequisites

-   `nasm`
-   `i686-elf-gcc` (or a compatible 32-bit cross-compiler)
-   `make`
-   `qemu`

Please refer to `.docs/hello_world.md` for detailed setup instructions.

### Building and Running

To build the OS and run it in QEMU:

```bash
make run
```

To clean the build artifacts:

```bash
make clean
```

## Project Structure

The project is organized as follows:

```
.
├── .docs/              # Project documentation and milestone guides
├── src/                # Source code
│   ├── boot/           # Assembly bootloader code
│   ├── kernel/         # C kernel code
│   └── linker.ld       # Linker script
├── Makefile            # Build automation script
└── README.md           # This file
```
