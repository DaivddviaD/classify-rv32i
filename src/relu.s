.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1             
    blt a1, t0, error     
    li t1, 0   
    lt t3, 0          

loop_start:
    # TODO: Add your own implementation
    bge t1, a1, loop_end
    addi t1, t1, 1
    addi t3, t3, 4
    lw t2, 0(a0)
    addi a0, a0, 4
    bge t2, x0, loop_start

    sw x0, 0(a0)
    j loop_start
loop_end:
    sub a0, a0, t3
    j exit

error:
    li a0, 36          
    j exit          
