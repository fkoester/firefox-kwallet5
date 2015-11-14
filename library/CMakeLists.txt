cmake_minimum_required(VERSION 2.8.12)

project(firefox-kwallet5)

find_package(ECM REQUIRED NO_MODULE)

set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDEFrameworkCompilerSettings)
include(KDECMakeSettings)
include(ECMMarkAsTest)

include(FeatureSummary)

find_package(KF5Wallet 5.3 REQUIRED)

find_package(Qt5 5.2 CONFIG REQUIRED Core)

set(firefox-kwallet5_SRCS
    KWallet5.cpp
)

add_library(libkwallet5 MODULE ${firefox-kwallet5_SRCS})

target_link_libraries(libkwallet5
PUBLIC
    KF5::Wallet
    Qt5::Core
)

add_executable(testkwallet5 testKWallet5.c)
target_link_libraries(testkwallet5 KF5::Wallet ${CMAKE_DL_LIBS})
ecm_mark_as_test(testkwallet5)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
