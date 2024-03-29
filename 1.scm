(use gauche.test)
(add-load-path ".")
(load "func")

(test-start "chapter 1")

(test-section "atom?")
(test* "(atom? 'atom)" #t (atom? 'atom))
(test* "(atom? 'turkey)" #t (atom? 'turkey))
(test* "(atom? 1942)" #t (atom? 1942))
(test* "(atom? 'u)" #t (atom? 'u))
(test* "(atom? '*abc$)" #t (atom? '*abc$))

(test-section "list?")
(test* "(list? '(atom))" #t (list? '(atom)))
(test* "(list? '(atom turkey or))" #t (list? '(atom turkey or)))
(test* "(list? '(atom turkey) 'or))" (test-error) (list? '(atom turkey) 'or))
(test* "(list? '((atom turkey) or))" #t (list? '((atom turkey) or)))

(test-section "sexp")
(test* "(let1 sexp 'xyz (or (list? sexp) (atom? sexp)))" #t (let1 sexp 'xyz (or (list? sexp) (atom? sexp))))
(test* "(let1 sexp '(x y z) (or (list? sexp) (atom? sexp)))" #t (let1 sexp '(x y z) (or (list? sexp) (atom? sexp))))
(test* "(let1 sexp '((x y) z) (or (list? sexp) (atom? sexp)))" #t (let1 sexp '((x y) z) (or (list? sexp) (atom? sexp))))
(test* "(list? '(how are you doing so far))" #t (list? '(how are you doing so far)))
(test* "(length '(how are you doing so far))" 6 (length '(how are you doing so far)))
(test* "(list? '(((how) are) ((you) (doing so)) far))" #t (list? '(((how) are) ((you) (doing so)) far)))
(test* "(length '(((how) are) ((you) (doing so)) far))" 3 (length '(((how) are) ((you) (doing so)) far)))

(test-section "empty list")
(test* "(list? '())" #t (list? '()))
(test* "(atom? '())" #f (atom? '()))
(test* "(list? '(() () () ()))" #t (list? '(() () () ())))

(test-section "car")
(test* "(car '(a b c))" 'a (car '(a b c)))
(test* "(car '((a b c) x y z))" '(a b c) (car '((a b c) x y z)))
(test* "(car 'hotdog)" (test-error) (car 'hotdog))
(test* "(car '())" (test-error) (car '()))
(test* "(car '(((hotdogs)) (and) (pickle) relish))" '((hotdogs)) (car '(((hotdogs)) (and) (pickle) relish)))
(test* "(car (car '(((hotdogs)) (and))))" '(hotdogs) (car (car '(((hotdogs)) (and)))))

(test-section "cdr")
(test* "(cdr '(a b c))" '(b c) (cdr '(a b c)))
(test* "(cdr '((a b c) x y z))" '(x y z) (cdr '((a b c) x y z)))
(test* "(cdr '(hamburger))" '() (cdr '(hamburger)))
(test* "(cdr '((x) t r))" '(t r) (cdr '((x) t r)))
(test* "(cdr 'hotdogs)" (test-error) (cdr 'hotdogs))
(test* "(cdr '())" (test-error) (cdr '()))
(test* "(car (cdr '((b) (x y) ((c)))))" '(x y) (car (cdr '((b) (x y) ((c))))))
(test* "(cdr (cdr '((b) (x y) ((c)))))" '(((c))) (cdr (cdr '((b) (x y) ((c))))))
(test* "(cdr (car '(a (b (c)) d)))" (test-error) (cdr (car '(a (b (c)) d))))

(test-section "cons")
(test* "(cons 'peanut '(butter and jelly))" '(peanut butter and jelly) (cons 'peanut '(butter and jelly)))
(test* "(cons '(banana and) '(peanut butter and jelly))" '((banana and) peanut butter and jelly) (cons '(banana and) '(peanut butter and jelly)))
(test* "(cons '((help) this) '(is very ((hard) to lean)))" '(((help) this) is very ((hard) to lean)) (cons '((help) this) '(is very ((hard) to lean))))
(test* "(cons '(a b (c)) '())" '((a b (c))) (cons '(a b (c)) '()))
(test* "(cons 'a '())" '(a) (cons 'a '()))
(test* "(let* ((s '(a b c)) (l 'b) (result (cons s l))) (and (equal? (car result) s) (equal? (cdr result) l)))"
       #t
       (let* ((s '(a b c))
              (l 'b)
              (result (cons s l)))
         (and (equal? (car result) s)
              (equal? (cdr result) l))))
;; In practice, (cons a b) works for all values a and b.
(test* "(let1 result (cons 'a 'b) (and (eq? (car result) 'a) (eq? (cdr result) 'b)))"
       #t
       (let1 result (cons 'a 'b) (and (eq? (car result) 'a) (eq? (cdr result) 'b))))
(test* "(cons 'a (car '((b) c d)))" '(a b) (cons 'a (car '((b) c d))))
(test* "(cons 'a (cdr '((b) c d)))" '(a c d) (cons 'a (cdr '((b) c d))))

(test-section "null?")
(test* "(null? '())" #t (null? '()))
(test* "(null? '(a b c))" #f (null? '(a b c)))
;; In practice, (null? a) is false for everything, except the empty list.
(test* "(null? 'spaghetti)" #f (null? 'spaghetti))

(test-section "confirm")
(test* "(atom? 'Harry)" #t (atom? 'Harry))
(test* "(atom? '(Harry had a heap of apples))" #f (atom? '(Harry had a heap of apples)))
(test* "(atom? (car '(Harry had a heap of apples)))" #t (atom? (car '(Harry had a heap of apples))))
(test* "(atom? (cdr '(Harry had a heap of apples)))" #f (atom? (cdr '(Harry had a heap of apples))))
(test* "(atom? (cdr '(Harry)))" #f (atom? (cdr '(Harry))))
(test* "(atom? (car (cdr '(swing low sweet cherry oat))))" #t (atom? (car (cdr '(swing low sweet cherry oat)))))
(test* "(atom? (car (cdr '(swing (low sweet) cherry oat))))" #f (atom? (car (cdr '(swing (low sweet) cherry oat)))))

(test-section "eq?")
(test* "(eq? 'Harry 'Harry)" #t (eq? 'Harry 'Harry))
(test* "(eq? 'margarine 'butter)" #f (eq? 'margarine 'butter))
;; In practice, lists may be arguments of eq?. Two lists are eq? if they are the same list.
(test* "(eq? '() '(strawberry))" #f (eq? '() '(strawberry)))
;; In practice, some numbers may be arguments of eq?
(test* "(eq? 6 7)" #f (eq? 6 7))
(test* "(eq? (car '(Mary had a little lamb lamb)) 'Mary)" #t (eq? (car '(Mary had a little lamb lamb)) 'Mary))
(test* "(eq? (cdr '(soured milk)) 'milk)" #f (eq? (cdr '(soured milk)) 'milk))
(test* "(let1 l '(beans beans we need jelly beans) (eq? (car l) (car (cdr l))))"
       #t
       (let1 l '(beans beans we need jelly beans) (eq? (car l) (car (cdr l)))))

;; (test-section "fail")
;; (test* "fail" #t #f)

(test-end)
