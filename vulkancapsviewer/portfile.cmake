vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SaschaWillems/VulkanCapsViewer
    REF "${VERSION}"
    SHA512 5e453fb77f730ae7e3a203451c9323d58894b208b114c87f75a59ffa600b98bd2d26802e4266f990e8c4568a440bb79f2c2f1f0f4e8cad40bf385a535c9f727c
    HEAD_REF main
)

set(VCPKG_BUILD_TYPE release) # only builds tools

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DVULKAN_HEADERS_INSTALL_DIR=${CURRENT_INSTALLED_DIR}
  OPTIONS_RELEASE
    -DVULKAN_LOADER_INSTALL_DIR=${CURRENT_INSTALLED_DIR}
    -DVULKAN_UTILITY_LIBRARIES_INSTALL_DIR=${CURRENT_INSTALLED_DIR}
  OPTIONS_DEBUG
    -DVULKAN_LOADER_INSTALL_DIR=${CURRENT_INSTALLED_DIR}/debug
    -DVULKAN_UTILITY_LIBRARIES_INSTALL_DIR=${CURRENT_INSTALLED_DIR}/debug
)
vcpkg_cmake_install()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

vcpkg_copy_tools(TOOL_NAMES vulkanCapsViewer AUTO_CLEAN )

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
