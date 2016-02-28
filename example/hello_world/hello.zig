export executable "hello";

use @import("std").io;

pub fn main(args: [][]u8) -> %void {
    %%stdout.printf("Hello, world!\n");
}
