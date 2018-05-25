#include <stdio.h>
#include "nvml.h"

// Device error checking function
#define devErrChk(ans) { devAssert((ans), __FILE__, __LINE__); }
inline void devAssert(cudaError_t code, const char *file, int line, bool abort=true){
	if(code != cudaSuccess){
		fprintf(stderr, "Device assert: %s in file \"%s\" line %d\n", cudaGetErrorString(code), file, line);
		if(abort) exit(code);
	}
}

// nvml error checking function
#define nvmlErrChk(ans) { nvmlAssert((ans), __FILE__, __LINE__); }
inline void nvmlAssert(nvmlReturn_t code, const char *file, int line, bool abort=true){
	if(code != NVML_SUCCESS){
		fprintf(stderr, "nvml assert: %s in file \"%s\" line %d\n", nvmlErrorString(code), file, line);
		if(abort) exit(code);
	}
}

__global__ void
compute_this(int *pDataFromCpu)
{
    printf ("start\n");
    *pDataFromCpu += 7;
    printf ("yay\n");
}

int main(void)
{
    int devID = 0;
	cudaDeviceProp devProp;
	devErrChk( cudaSetDevice(devID) );
	devErrChk( cudaGetDeviceProperties(&devProp, devID) );
	printf("Device name: %s  ID: %d\n", devProp.name, devID);

    //int *pData = (int*)malloc(sizeof(int));
    //if (pData == NULL) { printf("Malloc failed!\n"); exit(1); }
    int *pData = NULL;
    cudaMallocManaged(&pData, sizeof(int));
    *pData = 1;

    compute_this<<<1,1>>>(pData);
    if (cudaDeviceSynchronize() != cudaSuccess)
        printf("Error \n");

    printf("Results: %d\n", *pData);
    cudaFree(pData);
    return 0;
}
