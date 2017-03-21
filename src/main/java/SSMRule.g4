grammar SSMRule;

ssmrule
    : object ':' (trigger '|')? conditions '|' commands
    | Linecomment+
    ;

object
    : ID
    ;

trigger
    : AT timepointexpr
    | EVERY timeintvalexpr duringexpr?
    | ON ID duringexpr?
    ;

duringexpr : FROM timepointexpr (TO timepointexpr)?;


conditions
    : boolvalue
    ;

boolvalue
    : '(' boolvalue ')'
    | compareexpr
    | NOT boolvalue
    | boolvalue AND boolvalue
    | boolvalue OR boolvalue
    | TRUE
    | FALSE
    ;

compareexpr
    : ID oPCMP ID
    | (ID | INT) oPCMP (ID | INT)
    | (ID | STRING) ('==' | '!=') (ID | STRING)
    | (ID | STRING) MATCHES (ID | STRING)
    | timeintvalexpr oPCMP timeintvalexpr
    | timepointexpr oPCMP timepointexpr
    ;

timeintvalexpr
    : TIMEINTVALCONST
    | timepointexpr '-' timepointexpr
    | timeintvalexpr ('-' | '+') timeintvalexpr
    ;


timepointexpr
    : NOW
    | TIMEPOINTCONST
    | timepointexpr ('+' | '-') timeintvalexpr
    ;

commands
    : command (';' command)*
    ;

command
    : ID (ID | OPTION | STRING)*
    ;

OPTION: '-' [a-zA-Z0-9]+ ;

Linecomment : '#' .*? '\r'? '\n' -> skip ;


oPCMP
    : '=='
    | '>'
    | '<'
    | '>='
    | '<='
    | '!='
    ;

opr
   : '*'
   | '/'
   | '+'
   | '-'
   | '%'
   ;

oprexpr
   : INT opr INT
   | STRING '+' STRING
   ;


AT : 'at' ;
AND : 'and' ;
EVERY : 'every' ;
FROM : 'from' ;
ON : 'on' ;
OR : 'or' ;
NOW : 'now' ;
NOT : 'not' ;
TO : 'to' ;
TRUE : 'true' ;
FALSE : 'false' ;
MATCHES : 'matches' ;


TIMEINTVALCONST
    : [1-9] [0-9]* ('s' | 'm' | 'h' | 'd' | 'mon' | 'y') ;

TIMEPOINTCONST
    : '"' [1-9][0-9][0-9][0-9] '-' [0-9][0-9] '-' [0-9][0-9] ' '+ [0-9][0-9] ':' [0-9][0-9] ':' [0-9][0-9] '"'
    ;

ID
    : PARTID
    | PARTID '.' PARTID
    | PARTID '.' PARTID '(' ')'
    ;

fragment PARTID : [a-zA-Z_] [a-zA-Z0-9_]* ;

WS : [ \t\r\n]+ -> skip ;

STRING
    : '"' (ESCAPE | ~["\\])* '"';
fragment ESCAPE : '\\' (["\\/bfnrt] | UNICODE) ;
fragment UNICODE : 'u' HEX HEX HEX HEX ;
fragment HEX : [0-9a-fA-F] ;

INT
    : '0'
    | [1-9] [0-9]*
    | ('0' | [1-9] [0-9]*) ('PB' | 'TB' | 'GB' | 'MB' | 'KB' | 'B')
    ;

CONST
    : INT
    | STRING
    | TIMEINTVALCONST
    | TIMEPOINTCONST
    ;

NEWLINE : '\r'? '\n' ;


