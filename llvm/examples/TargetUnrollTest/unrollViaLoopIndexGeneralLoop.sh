#!/bin/bash

loop_name=loop
file_prefix=test
loop_name=loopi
file_prefix=gemm

unroll_factor=2


rm -f /tmp/position_preorder${loop_name}.txt

#$LLVM7/clang test.c -g -Xclang -disable-llvm-passes -O2 -S -o test.noopt.ll -emit-llvm
$LLVM7/clang ${file_prefix}.c -S  -fno-discard-value-names -Xclang -disable-O0-optnone -o ${file_prefix}.noopt.ll -emit-llvm
#the result of the following command will be produced in an intermediate file called
#position_preorder_<loop_to_unroll>.txt
$LLVM7/opt -get-loop-id-preorder -unroll-specific-loop=${loop_name} ${file_prefix}.noopt.ll -o /dev/null

cp /tmp/position_preorder${loop_name}.txt ./

$vitis_llvm/../hls-build/bin/clang ${file_prefix}.c -S -Xclang -disable-O0-optnone -S -o ${file_prefix}.noopt.ll -emit-llvm

echo "before"

/project/accelmerger/ext/vitis_llvm/hls-build/bin/opt -S -mem2reg -simplifycfg -reassociate -domtree -loops -loop-simplify -lcssa -basicaa -aa -scalar-evolution -loop-rotate -memoryssa -licm -simplifycfg -simplifycfg -loops -instcombine -loop-simplify -lcssa -scalar-evolution -loop-idiom -indvars -loop-unroll -unroll-allow-remainder=true -unroll-runtime=true -param-unroll-factor=${unroll_factor} -unroll-specific-loop=${loop_name} ${file_prefix}.noopt.ll -o ${file_prefix}.opt.ll
