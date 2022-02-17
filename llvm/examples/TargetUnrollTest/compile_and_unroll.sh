#!/bin/bash

#currently trying to extract the features with no actual unrolling happening

#/project/accelmerger/ext/vitis_llvm/hls-build/bin/clang -S -Xclang -disable-O0-optnone -emit-llvm -c static_boundaries.c -o static_boundaries.ll
/project/accelmerger/ext/vitis_llvm/hls-build/bin/clang -S -O2 -mllvm -unroll-specific-loop=for.cond -emit-llvm -c static_boundaries.c -o static_boundaries.ll

#/project/accelmerger/ext/vitis_llvm/hls-build/bin/opt -loop-simplify -S static_boundaries.ll -o static_boundaries_opt.ll
#/project/accelmerger/ext/vitis_llvm/hls-build/bin/opt -mem2reg -lcssa -loop-simplify -loop-simplifycfg -indvars -S static_boundaries.ll -o static_boundaries_opt.ll
#/project/accelmerger/ext/vitis_llvm/hls-build/bin/opt -O2 -mem2reg -lcssa -loop-simplify -loop-simplifycfg -indvars -S static_boundaries.ll -o static_boundaries_opt.ll

/project/accelmerger/ext/vitis_llvm/hls-build/bin/opt -loop-unroll -unroll-specific-loop=for.body -S static_boundaries.ll -o static_boundaries_unrolled.ll
/project/accelmerger/ext/vitis_llvm/hls-build/bin/opt -loop-simplify -loop-simplifycfg -S static_boundaries_unrolled.ll -o static_boundaries_unrolled_cleanup.ll
#/project/accelmerger/ext/vitis_llvm/hls-build/bin/opt -loop-unroll -unroll-specific-loop=for.cond -S static_boundaries_opt.ll -o static_boundaries_unrolled.ll
