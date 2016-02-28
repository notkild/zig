export executable "guess_number";

use @import("std");
use io;

pub fn main(args: [][]u8) -> %void {
    %%stdout.printf("Welcome to the Guess Number Game in Zig.\n");

    var seed : u32 = undefined;
    const seed_bytes = (&u8)(&seed)[0...4];
    %%os.get_random_bytes(seed_bytes);

    var rand = Rand.init(seed);

    const answer = rand.range_u64(0, 100) + 1;

    while (true) {
        %%stdout.printf("\nGuess a number between 1 and 100: ");
        var line_buf : [20]u8 = undefined;

        const line_len = stdin.read(line_buf) %% |err| {
            %%stdout.printf("Unable to read from stdin.\n");
            return err;
        };

        const guess = parse_u64(line_buf[0...line_len - 1], 10) %% {
            %%stdout.printf("Invalid number.\n");
            continue;
        };
        if (guess > answer) {
            %%stdout.printf("Guess lower.\n");
        } else if (guess < answer) {
            %%stdout.printf("Guess higher.\n");
        } else {
            %%stdout.printf("You win!\n");
            return;
        }
    }
}
