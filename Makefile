all: lib/libantlr3c-3.4.a | output
	java -cp ./lib/antlr-3.4-complete.jar org.antlr.Tool -o output Expr.g
	gcc -g -o expr output/*.c  -I lib/include/ lib/libantlr3c.a

output:
	mkdir -p output


lib/libantlr3c-3.4.a:
	cd lib; zcat libantlr3c-3.4.tar.gz | tar -xvpf -
	cd lib/libantlr3c-3.4; ./configure --enable-64bit && make
	rm -rf lib/include
	cp -r lib/libantlr3c-3.4/include lib/include
	cp lib/libantlr3c-3.4/.libs/libantlr3c.a lib/

clean:
	rm -rf build-antlr output/ lib/libantlr3c-3.4/

test:
	./expr 1+1
