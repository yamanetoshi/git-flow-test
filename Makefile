test:
	./gosh_test.sh 1.scm
	./gosh_test.sh 2.scm
	./gosh_test.sh 3.scm

clean:
	rm -f *~ test.log
