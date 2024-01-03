vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  cython/cython
    REF ${VERSION}
    SHA512 585d3fe810ace55278fcc6ea4508b3b5259320f92998cd688da787cd5f88ac5fc2467025f20da6d968969eb3296ae9c517136d24a4dbb475441271227968f6be
    HEAD_REF main
)

vcpkg_python_build_and_install_wheel(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
