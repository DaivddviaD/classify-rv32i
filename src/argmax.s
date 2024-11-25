.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)

    li t1, 0
    li t2, 1
    addi sp, sp, -4
    sw a0 0(sp)
loop_start:
    # TODO: Add your own implementation
    bge t1, a1, loop_end
    addi t1, t1, 1

    addi a0, a0, 4
    lw t2, 0(a0)

    bge t0, t2, loop_start
    
    add t0, t2, x0
    
    j loop_start
loop_end:
    lw a0, 0(sp)
    addi sp, sp, 4
    sw t0, 0(a0)
    j exit

handle_error:
    li a0, 36
    j exit
