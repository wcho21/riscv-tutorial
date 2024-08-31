# Hello World

We'll compile and run a simple program that writes "Hello World!".

## Writing a Hello World Program

Let's write some RISC-V assembly codes.
Make a file named `HelloWorld.S` and start with the following lines.

```asm
.global _start 
```

`_start` is declared as a starting point.

We'll call the `write()` system call to write a string (see `man 2 write`).
The system call takes three arguments through `a0` to `a2` registers in RISC-V.
Let's set the arguments as follows.

```asm
.data
msg: .ascii "Hello World!\n"

.text
_start:
  addi a0, x0, 1  # 1 is stdout
  la   a1, msg    # address of the string to write
  addi a2, x0, 13 # length of the msg
```

The `x0` register is always zero, so `a0` is set to `1`.
The `write()` system call takes a file descriptor as the first argument, and `1` means the standard output.

Since we've set the arguments for the `write()` system call, let's call it.

```asm
  addi a7, x0, 64 # 64 means write() system call
  ecall
```

To terminate the program, we need to call the `exit()` system call.
It takes one argument, which is the exit code.
Let's give the normal exit code `0` to `exit()`.

```asm
  addi a0, x0, 0  # 0 means normal exit

  addi a7, x0, 93 # 93 means exit() system call
  ecall
```

## Compiling and Running

Time to compile.
We're going to use the assembler `as` and the linker `ld`.
Specifically, they're tools provided by GNU Binutils.

```
$ as --version
GNU assembler (GNU Binutils for Ubuntu) 2.38
Copyright (C) 2022 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `riscv64-linux-gnu'.
$ ld --version
GNU ld (GNU Binutils for Ubuntu) 2.38
Copyright (C) 2022 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later version.
This program has absolutely no warranty.
```

As we can see, the target of the assembler is RISC-V machines.

Let's build the first executable file as follows.

```
$ as HelloWorld.S -o HelloWorld.o
$ ld HelloWorld.o -o HelloWorld
```

The last command generates `HelloWorld` file, and it writes "Hello World!".

```
$ ./HelloWorld
Hello World!
```
