vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO numpy/numpy
    REF 7b27c3ebe7f35684aeb2dfa2fd3125b2a69aed49
    SHA512 fe7004a5c588cc2f1bc08896cf11dc1029cbdda347ad0ed63481aedcb7d2276b1a75d5baa0e614e599341e9e41c778b5ded5f2ae7a6d1fa5b6b915ba21045932
    HEAD_REF main
    PATCHES fix-build.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH_SIMD
    REPO intel/x86-simd-sort
    REF aeab737f5b27796f627148a33e0fa8d3aa8eb282
    SHA512 cf7542d76da503128589763464fccab83790c1de8f50a2e015263951dc8b1fbd68e5d65700e96318583ea30b66fd3d0f6e33b09ce808e0960d9b6b3717cf36c0
    HEAD_REF main
)

file(COPY "${SOURCE_PATH_SIMD}/" DESTINATION "${SOURCE_PATH}/numpy/core/src/npysort/x86-simd-sort")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH_SVML
    REPO numpy/SVML
    REF 86f9647f9b445c5dc42820ebf17d6a49b2b157ed
    SHA512 94e910626f5ecb97d028475e7a28004a9e9adc73b6feeff15344bb7a953ec204b9969889929755127c1efd2224369aeb85cc757a03a05de9f35ad38cf985ec25
    HEAD_REF main
)

file(COPY "${SOURCE_PATH_SVML}/" DESTINATION "${SOURCE_PATH}/numpy/core/src/umath/svml")

x_vcpkg_get_python_packages(PYTHON_VERSION "3" OUT_PYTHON_VAR "PYTHON3" PACKAGES cython)
set(CYTHON "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-venv/Scripts/cython${VCPKG_HOST_EXECUTABLE_SUFFIX}")

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
        -Dblas=blas
        -Dlapack=lapack
    ADDITIONAL_BINARIES
      cython=['${CYTHON}']
    )
vcpkg_install_meson()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")