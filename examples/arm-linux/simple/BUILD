# project/BUILD.bazel

load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")
load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_library(
    name = "arm_library",
    srcs = ["source/library.cpp"],
    hdrs = ["includes/library.h"],
    copts = [
        "-mcpu=cortex-a5",
        "-mthumb",
    ],
    includes = ["includes"],
    target_compatible_with = [
        "@platforms//cpu:arm",
        "@platforms//os:linux",
    ],
)

cc_binary(
    name = "arm_elf",
    srcs = ["source/main.cpp"],
    copts = [
        "-mcpu=cortex-a5",
        "-mthumb",
    ],
    deps = [":arm_library"],
)

platform_transition_filegroup(
    name = "elf",
    srcs = [":arm_elf"],
    target_platform = "//platforms:arm_linux",
)

genrule(
    name = "bin",
    srcs = [":elf"],
    outs = ["mock.bin"],
    cmd = "$(execpath @arm_none_linux_gnueabihf//:objcopy) -O binary $< $@",
    tools = ["@arm_none_linux_gnueabihf//:objcopy"],
)

genrule(
    name = "hex",
    srcs = [":elf"],
    outs = ["mock.hex"],
    cmd = "$(execpath @arm_none_linux_gnueabihf//:objcopy) -O ihex $< $@",
    tools = ["@arm_none_linux_gnueabihf//:objcopy"],
)
