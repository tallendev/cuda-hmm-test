#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#define __KERNEL__
#include "uvm_ioctl.h"
#include "uvm8_test_ioctl.h"

int main(void)
{
    int fd = open("/dev/nvidia-uvm", O_RDWR);
    printf ("fd: %d\n", fd);
    int result = ioctl(fd, UVM_PAGEABLE_MEM_ACCESS_ON_GPU);
    printf("result (0 is success): %d\n", result);
    return 0;
}
