#lang racket/base

(require pollen/core
         racket/function
         racket/string
         string-interpolation)

(define raisin-black "#1F2030")
(define celadon "#A7D995")
; (define celadon-light "#97b6f0")
(define jordy "#8AADF4")
(define jordy-light "#8AADF4")

(provide (all-defined-out))

(define (badge topic)
  `(div ([class "mr-1.5 mb-2"])
		(div ([class ,"flex items-center rounded-full bg-[@{celadon}]/10 px-3 lg:px-4 py-1 lg:py-2 text-xs lg:text-sm font-medium leading-5 text-[@{celadon}]"]) ,topic)))

; (->badges "Haskell, Nix, Racket")
(define (->badges topics)
  (let ([top-list (map (curry string-trim #:left? #t) 
  					   (string-split topics ","))])
    `(div ([class "flex flex-wrap justify-center"] [aria-label "Tools/Techniques used"])
         ,(for/splice ([topic top-list]) (badge topic)))))

(define (link url . body)
  `(a ([class ,"text-[@{jordy}] hover:underline decoration-2 underline-offset-2 decoration-[@{jordy}] hover:text-[@{jordy}]"] [rel "noreferrer noopener"] [target "_blank"] [href ,url])
    ,@body))

(define (par . body)
  `(p ([class "my-4 sm:text-lg leading-relaxed"]) ,@body))

(define (id-ify text)
  (string-replace (string-downcase text) " " "-"))

(define (heading text)
  `(h1 ([id ,(id-ify text)] [class ,"text-3xl font-fira-code text-[@{jordy}] tracking-tighter leading-snug"])
       ,text))

(define (meetup #:title title #:img [img ""] . body)
  `(div ([class "overflow-hidden my-4 snap-center flex w-[90%] shrink-0 mx-8 sm:mx-16 shadow-lg rounded-lg"])
      ,(if (string=? img "")
           ""
           `(img ([class "w-full"] [src ,img])))
      (div ([class "px-6 py-4"])
        ,(heading title)
        ,@body)))

(define (meetups . body)
  `(div ([class "scroll-container mb-4 -mx-6 md:-mx-12 lg:-mx-24 md:gap-4 lg:gap-8"])
    (div ([class "flex justify-between"])
      (button ([id "meetups-scroll-left"] [class "text-zinc-500 hover:cursor-pointer hover:scale-125 duration-200 ease-out transition"])
        (svg ([xmlns "http://www.w3.org/2000/svg"] [fill "none"] [viewBox "0 0 24 24"] [stroke-width "1.5"] [stroke "currentColor"] [class "size-10"])
            (path ([stroke-linecap "round"] [stroke-linejoin "round"] [d "M15.75 19.5 8.25 12l7.5-7.5"]))
        )
      )
      (div ([id "meetups-container"] [class "relative flex items-center flex-grow snap-x overflow-x-auto"])
        ,@body
      )
      (button ([id "meetups-scroll-right"] [class "text-zinc-500 hover:cursor-pointer hover:scale-125 duration-200 ease-out transition"]) 
        (svg ([xmlns "http://www.w3.org/2000/svg"] [fill "none"] [viewBox "0 0 24 24"] [stroke-width "1.5"] [stroke "currentColor"] [class "size-10"])
            (path ([stroke-linecap "round"] [stroke-linejoin "round"] [d "m8.25 4.5 7.5 7.5-7.5 7.5"]))
        )
      )
    )
  )
)
