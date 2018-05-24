This is test code for evaluating HMM support between the nvidia driver, nvidia-uvm kernel module, and device. 

Steps:
1. make

2. run hmm_supported. 
If hmm_supported is successful, then your device is support,the nvidia-uvm module is loaded, and hmm is enabled. Otherwise 
check error code printed against common/nvstatuscodes.h (assuming these do not change between version of uvm)

3. run hmmtest
if hmm test is unsuccesful it will print a generic error message. To find out the specific error message, you have to check
    the error code provided by XID in `dmesg` (https://docs.nvidia.com/deploy/xid-errors/index.html). Currently, w/
    cuda_9.2.88.1, driver version 396.26_linux, error message 31 (device page fault) is received. This implies that 
    the driver is receiving the hardware interrupt issued by the device but does not "know" how to handle it. If run 
    w/ `cuda-memcheck`, we get error message 43 (GPU stopped processing), which seems like a generic error. This indicates
    that cuda-memcheck either takes a different control path or clobbers the hardware error.
