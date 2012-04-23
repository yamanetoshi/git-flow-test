test:
	./gosh_test.sh 1.scm>test.log
	./gosh_test.sh 2.scm>>test.log
	./gosh_test.sh 3.scm>>test.log
	./gosh_test.sh 4.scm>>test.log
	./gosh_test.sh 5.scm>>test.log
	./gosh_test.sh 6.scm>>test.log
	./gosh_test.sh 7.scm>>test.log
	./gosh_test.sh 8.scm>>test.log
	./gosh_test.sh 9.scm>>test.log

clean:
	rm -f *~ test.log
