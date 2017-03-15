#lang racket

(require plot)

(plot-file (parametric (λ (t) (vector (* 3 (cos (* 3 t))) (sin (* 2 t)))) 0 (* 2 pi)) #:title "Lissajous Curve" "Lissajous" 'png)

(plot-file (list (axes)
            (function sin (- pi) pi #:label "y = sin(x)" #:color 3 #:style 'dot)
             (function (lambda (x) (+ x 3)) #:label "y = x + 3" #:color 12 #:style 'solid)) #:title "Just Some Equations" "2d" 'png)

(plot3d-file (discrete-histogram3d '(#(1 1 1) #(1 2 3) #(2 2 2)) #:label "steps" #:line-color 56) #:title "3D Histogram" "3d" 'png) 

; creates blank hash table
(define ht (make-hash))

; convers list of pairs into list of vectors
(define (plistToVector lst)
  (map (λ (x) (vector (car x) (cdr x))) lst))

; adds new hash key and value to hash table
(define (addNewHash hasht lst)
  (hash-set! hasht (car lst) 1)
  (hashList hasht (cdr lst)))

; increments hash key already in hash table
(define (incHash hasht lst)
  (hash-set! hasht (car lst) (add1 (hash-ref hasht (car lst))))
                                   (hashList hasht (cdr lst)))

; creates hash table from list of strings
(define (hashList hasht lst)
    (cond [(null? lst) hasht]
        [(hash-has-key? hasht (car lst)) (incHash hasht lst)]
        [else (addNewHash hasht lst)]))

; uses above functions to create a histogram of word count in a file
(define storyString (file->string "sidewalksong.txt"))
(define stringList (string-split storyString))
(define storyHash (hashList ht stringList))
(define hashedList (hash->list storyHash))
(define vList (plistToVector hashedList))

(plot-width 1920)
(plot-height 1080)
(plot-x-tick-label-anchor 'top-right)
(plot-x-tick-label-angle 90)
(plot-file (discrete-histogram vList) #:x-label "Word" #:y-label "Number of Occurrences" #:title "Word Count" "WordCount" 'png)
