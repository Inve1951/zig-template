//! References all tests in the project.

const std = @import("std");

test {
    // Mirror the source file tree here.
    std.testing.refAllDecls(@import("main.zig"));
    std.testing.refAllDecls(@import("tests.zig"));
    std.testing.refAllDecls(@import("utils.zig"));
}
