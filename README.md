# rustboot

A tiny 32 bit kernel written in Rust.

This is a fork that fixes [rustboot](https://github.com/charliesome/rustboot) to run on my macOS. It adds some comments for my own learning.

## Setup

You need a few things to run rustboot:

1. `qemu`
2. a cross-compiler for i386
3. `nasm`
4. Rust >= 0.7 release.

### macOS

To set things up on macOS, do this:

Install `nasm` and `qemu` from homebrew:

```bash
$ brew install nasm
$ brew install qemu
```

Make sure the brew version of `nasm` is being used:

```bash
$ nasm -v
NASM version 2.11.02 compiled on Apr 14 2014
```

Install binutils from source.

I personally keep things I manually compile limited to my home directory, so
I use the `--prefix=/Users/aunn` option. Put this wherever you want, of
course.

```bash
$ wget http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz
$ tar xf binutils-2.24.tar.gz
$ cd binutils-2.24
$ ./configure --target=i686-unknown-linux-gnu --disable-werror --prefix=/Users/aunn
$ make && make install
```

Then, make sure that `~/bin` is in your `PATH`, if you're using a prefix:
```bash
export PATH=$PATH:~/bin
```

## Running it

To compile, simply

```bash
$ make
```

To run,

```bash
$ make run
```
