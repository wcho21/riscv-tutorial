.global _start 

.data
msg: .ascii "Hello World!\n"

.text
_start:
  addi a0, x0, 1  # 1 is stdout
  la   a1, msg    # address of the string to write
  addi a2, x0, 13 # length of the msg

  addi a7, x0, 64 # 64 means write() system call
  ecall

  addi a0, x0, 0  # 0 means normal exit

  addi a7, x0, 93 # 93 means exit() system call
  ecall
