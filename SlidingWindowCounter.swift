// Sliding Window Counter

import Foundation

class SlidingWindowCounter {
    private let windowSize: TimeInterval
    private let maxRequests: Int
    private var currentWindow: Int
    private var requestCount: Int
    private var previousCount: Int


    init(windowSize: TimeInterval, maxRequests: Int) {
        self.windowSize = windowSize
        self.maxRequests = maxRequests
        self.currentWindow = Int(Date().timeIntervalSince1970 / windowSize)
        self.requestCount = 0
        self.previousCount = 0
    }

    func allowRequest() -> Bool {
        let now = Int(Date().timeIntervalSince1970)
        let window = now / Int(windowSize)

        if window != currentWindow {
            currentWindow = window
            previousCount = requestCount
            requestCount = 0
        }

        let windowElasped = (now.truncatingRemainder(dividingBy: windowSize)) / windowSize
        let threshold = Double(previousCount) * (1 - windowElasped) + Double(requestCount)

        if threshold < Double(maxRequests) {
            requestCount += 1
            return true
        }

        return false
    }
}

// Usage
let limiter = SlidingWindowCounter(windowSize: 60, maxRequests: 5)

for _ in 0..<10 {
    Thread.sleep(forTimeInterval: 0.1)
}

Thread.sleep(forTimeInterval: 30)
print(limiter.allowRequest())