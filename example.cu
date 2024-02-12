/*******************************************************************************
 * CUDA Kernel Timer
 * Copyright (C) 2024 Yiltan Hassan Temucin
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *******************************************************************************/
#include "cuda_kernel_timer.cuh"
#include "stdio.h" // For printf

__global__ void example_kernel(long long int  requested_time_ns,
                               long long int *measured_time_ns)
{
  long long int start;
  long long int stop;

  start = read_globaltimer();

  do {
    stop = read_globaltimer();
  } while ((stop - start) < requested_time_ns);
  *measured_time_ns = (stop - start);
}


static float to_ms(long long int time_ns)
{
    return ((float) time_ns / (1000.0 * 1000.0));
}

int main()
{
  cudaEvent_t start, stop;
  long long int requested_time_ns;
  long long int *measured_time_ns;
  float milliseconds;

  cudaEventCreate(&start);
  cudaEventCreate(&stop);
  cudaMallocManaged(&measured_time_ns, sizeof(long long int));

  requested_time_ns = 100 * 1000 * 1000; // 1ms

  cudaEventRecord(start);
  example_kernel<<<1,1>>>(requested_time_ns, measured_time_ns);
  cudaEventRecord(stop);

  cudaEventSynchronize(stop);
  cudaEventElapsedTime(&milliseconds, start, stop);

  printf("Requested %.6fms, Kernel Timer Measured %.6fms, CUDA Events Measured %.3fms\n",
         to_ms(requested_time_ns), /* 6DP for 1ns resolution (did not account for float rounding) */
         to_ms(*measured_time_ns), /* 6DP for 1ns resolution (did not account for float rounding) */
         milliseconds              /* 3DP for 0.5us resolution */
        );
  fflush(stdout);

  return 0;
}
