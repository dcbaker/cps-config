set(PKGCONF_VERSION ${CMAKE_PROJECT_VERSION})
configure_file(builtins.toml.in builtins.toml)

set(pkgconf_tests
  "${CMAKE_CURRENT_SOURCE_DIR}/basic.toml"
  "${CMAKE_CURRENT_SOURCE_DIR}/conflicts.toml"
  "${CMAKE_CURRENT_SOURCE_DIR}/framework.toml"
  "${CMAKE_CURRENT_SOURCE_DIR}/parser.toml"
  "${CMAKE_CURRENT_SOURCE_DIR}/provides.toml"
  #"${CMAKE_CURRENT_SOURCE_DIR}/regress.toml"
  #"${CMAKE_CURRENT_SOURCE_DIR}/requires.toml"
  #"${CMAKE_CURRENT_SOURCE_DIR}/symlink.toml"
  "${CMAKE_CURRENT_SOURCE_DIR}/sysroot.toml"
  "${CMAKE_CURRENT_SOURCE_DIR}/version.toml"
  "${CMAKE_CURRENT_BINARY_DIR}/builtins.toml" # Note that this configured file is in the binary dir
)

add_test(
  NAME "pkgconf tests"
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  COMMAND
  ${CMAKE_COMMAND} -E env CPS_PREFIX_PATH=${CMAKE_CURRENT_BINARY_DIR}/cps-files
  ${Python_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/runner.py
  $<TARGET_FILE:cps-config> ${pkgconf_tests}
)
