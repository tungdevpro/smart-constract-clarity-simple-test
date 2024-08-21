
(define-constant LISTING_NOT_FOUND u101)

(define-data-var total_listing uint u0)

(define-read-only (get_total_listing)
    (var-get total_listing)
)

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
            contact: contact
        })
        (var-set total_listing (+ u1 (var-get total_listing)))
        (ok needer)
    )
)

(define-public (donate-stx (needer principal) (amount uint))
    (let 
        (
            (listing (unwrap! (map-get? ListingData needer) (err LISTING_NOT_FOUND)))
            (neededAmountValue (get neededAmount listing))
            (recivedAmountValue (get receivedAmount listing))
            (contact (get contact listing))
            (description (get description listing))
        )
        (try! (stx-transfer? neededAmountValue tx-sender needer))
        (map-set ListingData needer (
            merge listing {receivedAmount: (+ amount recivedAmountValue)}
        ))

        ;; (map-set ListingData needer {
        ;;     neededAmount: neededAmountValue,
        ;;     receivedAmount: (+ amount recivedAmountValue),
        ;;     description: description,
        ;;     contact: contact
        ;; })
        (ok contact)
    )
)

(define-public (say-hello) 
    (ok "Hello world")
)
