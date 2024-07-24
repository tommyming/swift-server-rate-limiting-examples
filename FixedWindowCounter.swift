// Fixed Window Counter

import Foundation

class FixedWindowCounter {
    let windowSizeInSeconds: Int
    let maxRequestPerWindow: Int
    var currentWindowStart: Int
    var requestCount: Int

    init(windowSizeInSeconds: Int, maxRequestPerWindow: Int) {
        self.windowSizeInSeconds = windowSizeInSeconds
        self.maxRequestPerWindow = maxRequestPerWindow
        self.currentWindowStart = Int(Date().timeIntervalSince1970)
        self.requestCount = 0
    }

    func allowRequest() -> Bool {
        let currentTime = Int(Date().timeIntervalSince1970)
        if currentTime >= currentWindowStart + windowSizeInSeconds {
            currentWindowStart = currentTime
            requestCount = 0
        }

        if requestCount < maxRequestPerWindow {
            requestCount += 1
            return true
        }

        return false
    }
}