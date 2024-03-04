load(
    "@arm_gnu_toolchain//:deps.bzl",
    "arm_none_eabi_deps",
    "arm_none_linux_gnueabihf_deps",
)

def _arm_toolchain_impl(ctx):
    for mod in ctx.modules:
        if mod.name == "arm_gnu_toolchain":
            for attr in mod.tags.arm_none_eabi:
                arm_none_eabi_deps(attr.version)
            for attr in mod.tags.arm_none_linux_gnueabihf:
                arm_none_linux_gnueabihf_deps(attr.version)

_toolchain = tag_class(attrs = {
    "version": attr.string(),
})

arm_toolchain = module_extension(
    implementation = _arm_toolchain_impl,
    tag_classes = {
        "arm_none_eabi": _toolchain,
        "arm_none_linux_gnueabihf": _toolchain,
    },
)
