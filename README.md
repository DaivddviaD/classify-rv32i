# Assignment 2: Classify

## Part A: Mathematical Functions

### relu.s

The relu function iterates through each element of the array. 
If the value is >= 0, it skips to the next element.
Otherwise, it replaces the element with zero.
#### Error Condition: 
If the array length is less than 1, return 36.



### argmax.s

The argmax function iterates through the array to find the index of the maximum value.
If an element is greater than the current maximum, it updates the current maximum and index.
Otherwise, it continues iterating.
#### Error Condition: 
If the array length is less than 1, return 36.


### dot.s

First, we implement our own multiplication operation using the shift-and-add algorithm.
The algorithm:
1. Check if the least significant bit (LSB) of the multiplier is 1.
2. If it is, add the current multiplicand to the result.
3. Then shift the multiplicand left by 1 bit and the multiplier right by 1 bit.
The loop continues until the multiplier becomes zero.
```
mul:
    xor t6, t2, t1
    srli t6, t6, 31
    li t4, 0

    bge t2, x0, Pos1
    sub t2, x0, t2
Pos1:
    bge t1, x0, mloop_start
    sub t1, x0, t1

mloop_start:
    beq x0, t2, mloop_end
    andi t5, t2, 1

    beq t5, x0, mExit
    add t4, t4, t1
mExit:
    slli t1, t1, 1
    srli t2, t2, 1
    j mloop_start

mloop_end:
    beq t6, x0, end_mul
    sub t4, x0, t4
end_mul:
    jr ra
```
The dot function calculates the dot product of two arrays with strides.
It returns the result of the dot product.



### matmul.s

The matmul function includes an outer and inner loop.
The outer loop iterates through each row of the M0 matrix.
's0' keeps track of the current row in M0.
's1' starts at zero and tracks the current column in M1.
's4' points to the first column of M1.
If 's0' is less than 'a1', the inner loop is called to perform matrix multiplication.
Otherwise, the matmul function finishes.

```
inner_loop_end:
    # TODO: Add your own implementation
    slli t0, a2, 2
    add s3, s3, t0
    addi s0, s0, 1
    j outer_loop_start

outer_loop_end:
    # Prologue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28
    jr ra
    ret
```

The inner loop calls the dot function to calculate the dot product of the M0 row and M1 column.
It then stores the result into the target address of the result matrix D.
If 's1' equals 'a5', it finishes the inner loop and moves to the next row of M0.

#### Error Conditions
 1. Validates M0: Ensures positive dimensions.
 2. Validates M1: Ensures positive dimensions.
3. Validates multiplication compatibility: M0_cols = M1_rows.
All failures should trigger program exit with code 38.

## Part B: File Operations and Main

### read_matrix.s

The read_matrix function includes:
1. Open the file using fopen.
2. Read the matrix dimensions (#rows and #cols) using fread (8 bytes).
3. Calculate the matrix size (#matrix elements * 4 bytes).
    * matrix elements = rows * cols (using the custom mul operation).
    * Convert to bytes by shifting left by 2.
4. Allocate memory using malloc based on the calculated byte size.
5. Read matrix data into memory using fread.
6. Close the file using fclose.



### write_matrix.s

The write_matrix function includes:
1. Open the file using fopen.
2. Write matrix dimensions (#rows and #cols) using fwrite.
3. Calculate matrix size (#matrix elements * 4 bytes).
   * matrix elements = rows * cols (using the custom mul operation).
4. Write the matrix data using fwrite.
5. Close the file using fclose.



### classify.s

 The classify function includes:
1. Read two weight matrices (M0, M1) and the input matrix using read_matrix.
2. Compute intermediate matrix h = matmul(m0, input) using matmul.
3. Compute ReLU(h) using relu.
4. Compute output matrix o = matmul(m1, h) using matmul.
5. Save the output matrix o to a file using write_matrix.
6. Find the index of the largest element in output matrix o using argmax.



#### Error Conditions
 31 - Invalid argument count
 
 26 - Memory allocation failure
