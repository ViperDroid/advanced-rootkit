# 🛠️ Advanced Rootkit (Educational Only)

This is an **advanced rootkit** written in **x86 assembly language**. It hooks system calls (`sys_write`, `sys_read`, and `sys_open`) to hide a file named `secret.txt` from being written, read, or opened. This project is for **educational purposes only** and should only be used in a controlled environment.

---

## 📋 Table of Contents
1. [Overview](#-overview)
2. [Features](#-features)
3. [Prerequisites](#-prerequisites)
4. [Installation](#-installation)
5. [Usage](#-usage)
6. [Ethical Use Warning](#-ethical-use-warning)
7. [License](#-license)

---

## 🌟 Overview
The rootkit consists of the following components:
1. **System Call Hooks**: Hooks `sys_write`, `sys_read`, and `sys_open` to intercept file operations.
2. **File Hiding**: Hides the file `secret.txt` from being written, read, or opened.
3. **Stealth Mechanisms**: Operates at the kernel level to avoid detection.

---

## 🚀 Features
- **Multiple Hooks**: Hooks `sys_write`, `sys_read`, and `sys_open`.
- **File Hiding**: Prevents access to `secret.txt`.
- **Stealth**: Avoids detection by intercepting system calls.
- **Educational**: Designed for learning and research purposes.

---

## 📦 Prerequisites
Before using this tool, ensure you have the following installed:
- **NASM**: Netwide Assembler (to assemble the code). 🔧
- **ld**: GNU linker (to link the object file). 🔗
- **QEMU**: For testing in a virtual machine. 🖥️

---

## 🛠️ Installation
1. **Install NASM and ld**:
   - On Linux:
     ```bash
     sudo apt update
     sudo apt install nasm binutils
     ```

2. **Clone the Repository**:
   - Clone your GitHub repository:
     ```bash
     git clone https://github.com/ViperDroid/advanced-rootkit.git
     cd advanced-rootkit
     ```

---

## 🚀 Usage
### Step 1: Assemble the Rootkit
1. Assemble the rootkit code using NASM:
   ```bash
   nasm -f elf32 rootkit.asm -o rootkit.o
