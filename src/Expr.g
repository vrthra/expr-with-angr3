grammar Expr;

options
{
  language=C;
}

@members
{
 #include "antlr3defs.h"
 #include "ExprLexer.h"

 int main(int argc, char * argv[]) {

    pANTLR3_INPUT_STREAM input;
    pExprLexer  lex;
    pANTLR3_COMMON_TOKEN_STREAM tokens;
    pExprParser  parser;

    input  = antlr3StringStreamNew((pANTLR3_UINT8)argv[1], ANTLR3_ENC_8BIT, strlen(argv[1]), "_x_");
    //input  = antlr3FileStreamNew((pANTLR3_UINT8)argv[1], ANTLR3_ENC_8BIT);
    lex    = ExprLexerNew(input);
    tokens = antlr3CommonTokenStreamSourceNew(ANTLR3_SIZE_HINT, TOKENSOURCE(lex));
    parser = ExprParserNew(tokens);

    parser->program(parser);

    parser->free(parser);
    tokens->free(tokens);
    lex->free(lex);
    input->close(input);

    return 0;
 }
}

program: expr EOF;
expr: term  ( (PLUS|MINUS) term)*;
term: factor ( (MULT|DIV) factor)*;
factor: INT
    | OP expr CP;
INT  : (DIGIT)+;
OP: '(';
CP: ')';
PLUS: '+';
MINUS: '-';
MULT: '*';
DIV: '/';

WHITESPACE  : ( '\t' | ' ' | '\r' | '\n'| '\u000C' )+
{
    $channel = HIDDEN;
};

fragment
DIGIT: '0'..'9';
