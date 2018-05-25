all: hmmtest.cu
	nvcc -arch=sm_61 hmmtest.cu -o hmmtest -g
	gcc -Wall -Wextra hmm_supported.c -o hmm_supported -I common/

clean:
	rm -f hmmtest hmm_supported
