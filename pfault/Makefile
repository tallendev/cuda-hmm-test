all: pfault.cu
	nvcc -arch=sm_61 pfault.cu -o pfault -g
	nvcc -arch=sm_61 pfaultro.cu -o pfaultro -g

clean:
	rm -f pfault pfaultro
