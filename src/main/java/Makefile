v ?= test_1.rule

compile:
	rm -f *.class
	antlr4 -visitor SSMRule.g4
	javac *.java
	java org.antlr.v4.runtime.misc.TestRig SSMRule ssmrule -gui ${v}

clean:
	rm -f *.class
