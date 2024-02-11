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
#ifndef __CUDA_KERNEL_TIMER_CUH__
#define __CUDA_KERNEL_TIMER_CUH__

#include "cuda_runtime.h"

/* RETURNS: Globaltimer value in nanoseconds */
__device__ inline long long int get_globaltimer()
{
  long long int t;
  asm volatile("mov.u64  %0, %globaltimer;" : "=l"(t));
  return t;
}

#endif /* __CUDA_KERNEL_TIMER_CUH__ */
