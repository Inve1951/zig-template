const std = @import("std");

/// Special constant which `std.log` inspects to decide which messages to print and which to ignore (at compile-time).
pub const log_level: std.log.Level = if (@import("builtin").mode == .Debug)
    .debug
else
    .info;

/// Application entry point.
pub fn main() u8 {
    return run() catch |err| {
        switch (err) {
            error.OutOfMemory => std.log.err("Out of memory", .{}),
        }
        return @errorToInt(err);
    };
}

fn run() !u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const leaks = gpa.deinit();
        if (leaks) {
            std.log.warn("Detected memory leaks during shutdown", .{});
        }
    }
    const allocator = gpa.allocator();

    // TODO: Do something interesting.
    _ = allocator;
    std.log.info("Hello Template!", .{});

    return 0;
}

comptime {
    _ = @import("tests.zig");
}

test "main" {
    try std.testing.expectEqual(
        @as(u8, 0),
        main(),
    );
}
