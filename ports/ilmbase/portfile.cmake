# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/ilmbase-2.2.0)
vcpkg_download_distfile(ARCHIVE
    URLS "http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz"
    FILENAME "ilmbase-2.2.0.tar.gz"
    SHA512 0bbad14ed2bd286dff3987b16ef8631470211da54f822cb3e29b7931807216845ded81c9bf41fd2d22a8b362e8b9904a5450f61f5a242e460083e86b846513f1
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

# Installation
message(STATUS "Installing")

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
  file(COPY
    ${CURRENT_PACKAGES_DIR}/lib/Half.dll
    ${CURRENT_PACKAGES_DIR}/lib/Iex-2_2.dll
    ${CURRENT_PACKAGES_DIR}/lib/IexMath-2_2.dll
    ${CURRENT_PACKAGES_DIR}/lib/IlmThread-2_2.dll
    ${CURRENT_PACKAGES_DIR}/lib/Imath-2_2.dll
    DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
  file(COPY
    ${CURRENT_PACKAGES_DIR}/debug/lib/Half.dll
    ${CURRENT_PACKAGES_DIR}/debug/lib/Iex-2_2.dll
    ${CURRENT_PACKAGES_DIR}/debug/lib/IexMath-2_2.dll
    ${CURRENT_PACKAGES_DIR}/debug/lib/IlmThread-2_2.dll
    ${CURRENT_PACKAGES_DIR}/debug/lib/Imath-2_2.dll
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
  file(REMOVE
    ${CURRENT_PACKAGES_DIR}/lib/Half.dll
    ${CURRENT_PACKAGES_DIR}/lib/Iex-2_2.dll
    ${CURRENT_PACKAGES_DIR}/lib/IexMath-2_2.dll
    ${CURRENT_PACKAGES_DIR}/lib/IlmThread-2_2.dll
    ${CURRENT_PACKAGES_DIR}/lib/Imath-2_2.dll
    ${CURRENT_PACKAGES_DIR}/debug/lib/Half.dll
    ${CURRENT_PACKAGES_DIR}/debug/lib/Iex-2_2.dll
    ${CURRENT_PACKAGES_DIR}/debug/lib/IexMath-2_2.dll
    ${CURRENT_PACKAGES_DIR}/debug/lib/IlmThread-2_2.dll
    ${CURRENT_PACKAGES_DIR}/debug/lib/Imath-2_2.dll)
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

message(STATUS "Installing done")

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/ilmbase)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/ilmbase/LICENSE ${CURRENT_PACKAGES_DIR}/share/ilmbase/copyright)
