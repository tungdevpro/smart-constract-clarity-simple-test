
(define-map ListingData principal
    {
        neededAmount: uint,
        receivedAmount: uint,
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
        (map-insert ListingData needer {
            neededAmount: neededAmount,
            receivedAmount: u0,
            description: description,
            contact: contact})
        (ok needer)
    )
)

(define-public (donate-stx (needer principal) (amount uint))
    (let 
        (
            (listing (map-get? ListingData needer))
        )
        (ok (get neededAmount listing))
    )
)

(define-public (say-hello) 
    (ok "Hello world")
)