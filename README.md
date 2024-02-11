#CUDA Kernel Timer

We provide a easy access PTX special register for a 64-bit global nanosecond timer.

The canonical way of measuring how long a CUDA kernel takes to execute is using CUDA Events.
That measures the execution time of the kernel boundries.
With this header library we can now measure the time spent within a kernel.
This contrasts with `clock64()` which provides the number of cycles,
as we are providing wall time.

##Requirements
- Requries PTX ISA version 3.1.
- Requires target sm_30 or higher.

##Building The Example

```
make
./example
```

### Expected Output
```
Requested 100.000000ms, Kernel Timer Measured 100.000771ms, CUDA Events Measured 105.527298ms
```
