#lang racket/base

(require (prefix-in log: web-server/dispatchers/dispatch-log)
         (prefix-in sequencer: web-server/dispatchers/dispatch-sequencer)
         web-server/http
         web-server/servlet-dispatch
         web-server/web-server)

(define (app _req)
  (response/full
   200 #"OK" (current-seconds) #"text/plain"
   (list (make-header #"Content-length" #"5"))
   (list #"hello")))

(define stop
  (serve
   #:port 8000
   #:dispatch (sequencer:make
               (log:make #:format log:extended-format)
               (dispatch/servlet app))))

(with-handlers ([exn:break? (λ (_) (stop))])
  (sync never-evt))
