if(NOT TARGET SimplexNoise)
    # Define ${Cinder-Notifications_PROJECT_ROOT}. ${CMAKE_CURRENT_LIST_DIR} is just the current directory.
    get_filename_component(SimplexNoise_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

    # Define ${CINDER_PATH} as usual.
    get_filename_component(CINDER_PATH "${SimplexNoise_PROJECT_ROOT}/../.." ABSOLUTE)

    # Create the library!
    add_library(SimplexNoise INTERFACE)

    # Add include directories.
    # Notice that `cinderblock.xml` has `<includePath>src</includePath>`.
    # So you need to set `../../src/` to include.
    target_include_directories(SimplexNoise INTERFACE "${SimplexNoise_PROJECT_ROOT}/include" )
    target_include_directories(SimplexNoise SYSTEM BEFORE INTERFACE "${CINDER_PATH}/include")


    # If your Cinder block has no source code but instead pre-build libraries,
    # you can specify all of them here (uncomment the below line and adjust to your needs).
    # Make sure to use the libraries for the right platform.
    if(NOT TARGET cinder)
        include("${CINDER_PATH}/proj/cmake/configure.cmake")
        find_package(cinder REQUIRED PATHS
                "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
                "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}")
    endif()
    target_link_libraries(SimplexNoise INTERFACE cinder)

endif()