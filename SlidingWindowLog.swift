// Sliding Window Log

import Foundation

class SlidingWindowLog {
    private let windowSize: TimeInterval
    private let maxRequests: Int
    private var requestLog: [TimeInterval]

    init(windowSize: TimeInterval, maxRequests: Int) {
        self.windowSize = windowSize
        self.maxRequests = maxRequests
        self.requestLog = []
    }

    func allowRequest() -> Bool {
        let now = Date().timeIntervalSince1970

        // Remove timestamps that are outside the current window.
        requestLog = requestLog.filter { now - $0 < windowSize }

        if requestLog.count < maxRequests {
            requestLog.append(now)
            return true
        }

        return false
    }
}

// Usage
let limiter = SlidingWindowLog(windowSize: 60, maxRequests: 5)

for _ in 0..<10 {
    print(limiter.allowRequest())
    Thread.sleep(forTimeInterval: 0.1)
}

Thread.sleep(forTimeInterval: 60)
print(limiter.allowRequest())