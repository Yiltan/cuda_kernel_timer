# CUDA Kernel Timer

This header provides easily read a PTX special register to access a 64-bit global nanosecond timer.

The canonical way of measuring how a CUDA Kernel's execution time is to use CUDA Events.
That measures the execution time of the kernel on the steam boundries.
With this header library we can now measure the time spent within a kernel.
This contrasts with `clock64()` which provides the number of cycles,
as we are providing wall time.

## Requirements
- Requries PTX ISA version 3.1.
- Requires target sm_30 or higher.

## Building The Example

```
make
./example
```

### Expected Output
```
Requested 100.000000ms, Kernel Timer Measured 100.000771ms, CUDA Events Measured 105.527298ms
```

## Include In Your Project
```
#include "cuda_kernel_timer.cuh"
```
