/**
 * Structal Script Grammar
 *
 * This grammar is in from of peg, specifically parseable by pegjs (https://pegjs.org)
 *
 * Jian Li
 */

// start
Start
  = _0 Declarations? {}

// all allowed declarations
Declarations
  = (ImportDeclaration _1)* (ExtendsDeclaration _1)? (ConstructorDeclaration _1)? (Function _1)*

// import declaration
ImportDeclaration
  = "import" _ (NameSpaceIdentifier ".")* TypeIdentifier 

// extends declaration
ExtendsDeclaration
  = "extends" _ TypeIdentifier

// constructor
ConstructorDeclaration
  = "constructor" FunctionPart

// function
Function
  = FunctionDeclaration
  / StaticFunctionDeclaration

// identifier used for namespace
NameSpaceIdentifier
  = LowerLetter+

// type identifier used for type
TypeIdentifier
  = UpperLetter IdentifierPart*

// regular identifier, which is used as name of constructor, function, parameter, etc.
Identifier
  = LowerLetter IdentifierPart*

// non-start of identifier
IdentifierPart
  = Letter
  / Digit

// function declaration
FunctionDeclaration
  =  "function" FunctionPart

// static function declaration
StaticFunctionDeclaration
  =  "static" _ FunctionDeclaration

// function part starting with name followed by parameter list and body
FunctionPart
  = _ Identifier _ "(" _ ParameterList? _ ")" _ EOL? FunctionBody

// function body staring with "{" and ending with "}"
FunctionBody
  = "{" _1 (SourceLine / EOL)* "}"  

// parameter list for constructor or function
ParameterList
  = Identifier (_ "," __ Identifier)*

// any white space
_
  = WhiteSpace*

// any white space, comment, with end of line
_0
  = ((WhiteSpace / Comment)* EOL)*

// at least one end of line with optional white space or comment preceeding it
_1
  = ((WhiteSpace / Comment)* EOL)+

// any white space, end of line, or comment
__
  = (WhiteSpace / EOL / Comment)*

// white spaces
WhiteSpace
  = "\t"
  / "\v"
  / "\f"
  / " "
  / "\u00A0"
  / "\uFEFF"
  / Zs

// end of line
EOL
  = "\n"
  / "\r\n"
  / "\r"

// Separator, Space
Zs = [\u0020\u00A0]

SourceLineCharacter
  = !EOL .

SourceLine
  = WhiteSpace+ SourceLineCharacter* EOL

Comment
  = MultiLineComment
  / SingleLineComment

// single line comment
SingleLineComment
  = "//" SourceLineCharacter*

// multi-line comment
MultiLineComment
  = "/*" (!"*/" .)* "*/"

// Ascii upper or lower letter
Letter
  = UpperLetter
  / LowerLetter

// Ascii Lowercase Letter
LowerLetter = [\u0061-\u007A]

// Ascii Uppercase Letter
UpperLetter = [\u0041-\u005A]

// Ascii Decimal Digit
Digit = [\u0030-\u0039]
