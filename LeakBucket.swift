// Leak Bucket

import Foundation

class LeakyBucket {
    private let capacity: int_fast64_t  // Maximum number of requests the bucket can hold
    private let leakRate: Double        // Rate at which requests leak out of the bucket (requests per second)
    private var bucket: [Date]          // Array to hold timestamps of requests
    private var lastLeakTimestamp: Date // Last time we leaked from the bucket
    
    init(capacity: Int64, leakRate: Double) {
        self.capacity = capacity
        self.leakRate = leakRate
        self.bucket = []
        self.lastLeakTimestamp = Date()
    }
    
    func allowRequest() -> Bool {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        leak()  // First, leak out any requests based on elapsed time
        
        if bucket.count < capacity {
            bucket.append(Date())  // Add the new request to the bucket
            return true  // Allow the request
        }
        return false  // Bucket is full, deny the request
    }
    
    private func leak() {
        let now = Date()
        let elapsedSeconds = now.timeIntervalSince(lastLeakTimestamp)
        let leakedItems = Int(elapsedSeconds * leakRate)  // Calculate how many items should have leaked
        
        // Remove the leaked items from the bucket
        bucket = Array(bucket.dropFirst(min(leakedItems, bucket.count)))
        
        lastLeakTimestamp = now
    }
}