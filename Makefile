all: | output
	java -cp ./lib/antlr-3.4-complete.jar org.antlr.Tool -o output src/Expr.g
	gcc -o expr output/*.c  -I lib/libantlr3c-3.4/include/ lib/libantlr3c-3.4/.libs/libantlr3c.a

output:
	mkdir -p output
