// This makes it possible to write a kernel, i.e. we choose to drop support from the std.
#![no_std]
#![allow(ctypes)]

type Int = i32;

#[derive(Copy, Clone)]
enum Color {
    Black      = 0,
    Blue       = 1,
    Green      = 2,
    Cyan       = 3,
    Red        = 4,
    Pink       = 5,
    Brown      = 6,
    LightGray  = 7,
    DarkGray   = 8,
    LightBlue  = 9,
    LightGreen = 10,
    LightCyan  = 11,
    LightRed   = 12,
    LightPink  = 13,
    Yellow     = 14,
    White      = 15,
}

struct IntRange {
    cur: Int,
    max: Int
}

impl IntRange {
    fn next(&mut self) -> Option<Int> {
        if self.cur < self.max {
            self.cur += 1;
            Some(self.cur - 1)
        } else {
            None
        }
    }
}

fn range(lo: Int, hi: Int) -> IntRange {
    IntRange { cur: lo, max: hi }
}

fn clear_screen(background: &Color) {
    let mut r = 0..(80 * 25);
    loop{
        match r.next() {
            Some(x) => {
                unsafe {
                    *((0xb8000 + x * 2) as *mut u16) = (*background as u16) << 12;
                }
            },
            None =>{ break }
        }
    }
}

#[no_mangle]
// #[no_split_check] TODO: Find a replacement for this
pub fn main() {
    clear_screen(&Color::Blue);
}
