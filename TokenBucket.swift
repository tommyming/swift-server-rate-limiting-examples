// Token Bucket

import Foundation

// Bucket Structure
struct TokenBucket {
    let capacity: Int
    let fillRate: Int
    var tokens: Int
    var lastRefillTimeStamp: Date = Date.now

    func allowRequest(incoming: Int) -> Bool {
        refill()

        guard tokens > incoming else { return false }

        tokens -= incoming
        return true
    }

    private mutating func refill() {
        let currentTime = Date.now
        let tokensToAdd = (currentTime.timeIntervalSince1970 - lastRefillTimeStamp.timeIntervalSince1970) * fillRate / 1000
        tokens = min(capacity, tokens + tokensToAdd)
        lastRefillTimeStamp = currentTime
    }
}

// MARK: You might need a timer to keep the fill rate as constant.
