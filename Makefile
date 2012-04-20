test:
	echo "" > test.log
	gosh 1.scm >>test.log
	gosh 2.scm >>test.log
	gosh 3.scm >>test.log

clean:
	rm -f *~ test.log
