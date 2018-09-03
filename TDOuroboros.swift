//
//  TDOuroboros.swift
//  Pods-TDOuroboros_Example
//
//  Created by Michael Open Source on 9/3/18.
//

public class TDTaskQueueManager {
    static let shared = TDTaskQueueManager()
    public typealias task = () -> ()
    private var taskQueue: TDQueue<task>
    
    init() { taskQueue = TDQueue<task>() }
    
    func enqueue(_ operation: @escaping task) {
        if (taskQueue.size() == 0) {
            taskQueue.enqueue(operation)
            operation()
        } else {
            taskQueue.enqueue(operation)
        }
    }
    
    func taskCompleted() {
        _ = taskQueue.dequeue()
        taskQueue.next()?()
    }
}

// Queue implementation
fileprivate class TDQueue<T> {
    
    var storage: [T]
    
    init() { storage = [] }
    
    func enqueue(_ element: T) { storage.append(element) }
    
    func dequeue() -> T? {
        if (size() > 0) {
            return storage.removeFirst()
        } else {
            return nil
        }
    }
    
    func next() -> T? {
        if (size() > 0) {
            return storage.first!
        } else {
            return nil
        }
    }
    
    func size() -> Int { return storage.count }
}
