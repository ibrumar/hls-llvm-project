#!/bin/bash

/project/accelmerger/ext/vitis_llvm/hls-build/bin/clang -S -emit-llvm -c static_boundaries.c -o static_boundaries.ll

/project/accelmerger/ext/vitis_llvm/hls-build/bin/opt -loop-unroll -unroll-specific-loop=loop -S static_boundaries.ll -o static_boundaries_unrolled.ll
