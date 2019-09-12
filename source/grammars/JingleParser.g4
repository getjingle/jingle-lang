parser grammar JingleParser;

options { tokenVocab=JingleLexer; }

jingleFile : lines=line+ ;

line      : statement (ENDSTATEMENT | EOF) ;

statement : varDeclaration # varDeclarationStatement
          | assignment     # assignmentStatement
          | display          # displayStatement ;

display : DISPLAY LBRACKET expression RBRACKET ;

varDeclaration : VAR assignment ;

assignment : ID ASSIGN expression ;

expression : left=expression operator=(DIVIDE|MULTIPLY) right=expression # binaryOperation
           | left=expression operator=(PLUS|MINUS) right=expression        # binaryOperation
           | value=expression AS targetType=dataType                           # typeConversion
           | LBRACKET expression RBRACKET                                      # parenExpression
           | ID                                                            # varReference
           | MINUS expression                                              # minusExpression
           | INT                                                        # intLiteral
           | FLOAT                                                        # decimalLiteral ;

dataType : INT     # integer
     | FLOAT # decimal ;