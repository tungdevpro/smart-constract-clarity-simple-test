
(define-map ListingData principal
    {
        neededAmount: uint,
        description: (string-ascii 100),
        contact: (string-ascii 100)
    }
)

(define-read-only (get-listing (needer principal))
    (begin
        (map-get? ListingData needer)
    )
)

(define-public (list-needer (needer principal) (neededAmount uint) (description (string-ascii 100)) (contact (string-ascii 100))) 
    (begin 
        (map-insert ListingData needer {neededAmount: neededAmount, description: description, contact: contact})
        (ok needer)
    )
)



(define-public (say-hello) 
    (ok "Hello world")
)