use @import("syscall.zig");
use @import("errno.zig");

pub error SigInterrupt;
pub error Unexpected;

pub fn get_random_bytes(buf: []u8) -> %void {
    switch (@compile_var("os")) {
        linux => {
            const amt_got = getrandom(buf.ptr, buf.len, 0);
            if (amt_got < 0) {
                return switch (-amt_got) {
                    EINVAL => unreachable{},
                    EFAULT => unreachable{},
                    EINTR  => error.SigInterrupt,
                    else   => error.Unexpected,
                }
            }
        },
        windows => {
            // TODO
            for (buf) |_, i| {
                buf[i] = 4;
            }
        },
        else => unreachable{},
    }
}
