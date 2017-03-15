## My Library: plot
My name: Van Ha

I played around with the plot library from racket. I wanted to use data as well but could
not figure out the error about installation and user scope. Nonetheless, I mainly used the
plotted things in 2D and 3D. Used different colors and line types as well as domains to see
what the plotting functions would produce. Used various built in functions to produce
the graphs. Created my own data to use since I couldn't think of anything else.
The program reads a text file into a string which is then split into a list of
strings. Then that list is hashed to a hash table with the word as the key and the
number of occurrences of that word as its value. If the word doesn't exist, it is
added to the hash table and if it does exist, the value is incremented. Then that
hash table is converted to a list of cons cells which in turn is turned into a list of
vectors. Finally that list of vectors is plotted into a histogram with the word on
the x-axis and the number of occurrences of that word on the y-axis. Had to resize
the window otherwise all the data would overlap on one another. All plots
are sent to a file rather than a window on the screen. Text in the file
was from the URL below.

http://www.brightlightmultimedia.com/blcafe/ShrtStories-SidewalkSong.htm

```
#lang racket

(require plot)

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



```


![Word Count](/WordCount.png?raw=true "WordCount")
![Lissajous Curve](/Lissajous.png?raw=true "Lissajous")
![3D Histogram](/3d.png?raw=true "3D")
![2D Plot](/2d.png?raw=true "2D")
