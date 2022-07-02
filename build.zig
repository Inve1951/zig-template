const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("zig-template", "src/main.zig");
    const install = b.addInstallArtifact(exe);
    { // >>> EXE - BUILD ONLY >>>
        exe.setTarget(target);
        exe.setBuildMode(mode);

        const install_step = b.getInstallStep();
        install_step.dependOn(&install.step);
    } // <<< EXE - BUILD ONLY <<<

    { // >>> EXE - BUILD AND RUN >>>
        const run_cmd = exe.run();
        run_cmd.step.dependOn(&install.step);

        // Forward CLI arguments passed after "--".
        if (b.args) |args| run_cmd.addArgs(args);

        const run_step = b.step("run", "Run the app");
        run_step.dependOn(&run_cmd.step);
    } // <<< EXE - BUILD AND RUN <<<

    const test_exe = b.addTestExe("test", "src/main.zig");
    const install_test = b.addInstallArtifact(test_exe);
    { // >>> TEST - BUILD ONLY >>>
        test_exe.setTarget(target);
        test_exe.setBuildMode(mode);

        const install_test_step = b.step("build-test", "Build unit tests");
        install_test_step.dependOn(&install_test.step);
    } // <<< TEST - BUILD ONLY <<<

    { // >>> TEST - BUILD AND RUN >>>
        const run_test_cmd = test_exe.run();
        run_test_cmd.step.dependOn(&install_test.step);

        // Test executables need the zig command/path as the first argument.
        // Not passing it here because it's done implicitely.
        // run_test_cmd.addArg("zig");

        const run_test_step = b.step("test", "Run unit tests");
        run_test_step.dependOn(&run_test_cmd.step);
    } // <<< TEST - BUILD AND RUN <<<
}
