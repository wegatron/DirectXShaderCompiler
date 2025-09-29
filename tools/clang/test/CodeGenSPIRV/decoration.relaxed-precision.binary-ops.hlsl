// RUN: %dxc -T ps_6_0 -E main -fcgl  %s -spirv | FileCheck %s

// Test that binary operations with min16float operands get RelaxedPrecision decoration
// even when one operand is a regular float constant.

struct Input {
    min16float3 normal : NORMAL;
};

// CHECK: OpDecorate [[normal_offset1:%[0-9]+]] RelaxedPrecision
// CHECK: OpDecorate [[mul_result:%[0-9]+]] RelaxedPrecision
// CHECK: OpDecorate [[sub_result:%[0-9]+]] RelaxedPrecision

float4 main(Input input) : SV_Target {
    // This should have RelaxedPrecision decoration on the intermediate operations
    // and the final result because the target variable is min16float3
    min16float3 normal_offset1 = (input.normal * 2.0f) - 1.0f;
    
    return float4(normal_offset1, 1.0);
}