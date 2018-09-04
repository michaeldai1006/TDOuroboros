![TDOuroboros](./README/Images/READMELogo.png)

[![CI Status](https://img.shields.io/travis/michaeldai1006/TDOuroboros.svg?style=flat)](https://travis-ci.org/michaeldai1006/TDOuroboros)
[![Version](https://img.shields.io/cocoapods/v/TDOuroboros.svg?style=flat)](https://cocoapods.org/pods/TDOuroboros)
[![License](https://img.shields.io/cocoapods/l/TDOuroboros.svg?style=flat)](https://cocoapods.org/pods/TDOuroboros)
[![Platform](https://img.shields.io/cocoapods/p/TDOuroboros.svg?style=flat)](https://cocoapods.org/pods/TDOuroboros)

TDOuroboros is an async task chaining library written in Swift.

- [Why TDOuroboros](why-tdouroboros)
- [Installation](installation)
- [Usage](usage)
  - [Use shared task queue instance](use-shared-task-queue-instance)
  - [Create your own task queue](create-your-own-task-queue)
- [About](about)
- [License](license)

## Why TDOuroboros
TDOuroboros is an iOS library written in Swift which provides the ability to chain async tasks, such as animation tasks, HTTP request tasks, etc.
Traditionally, connects async tasks can be done by nesting completion handlers, such as:
```swift
import UIKit

UIView.animate(withDuration: 1.0, animations: {
    // Perform animation 1
}) { (result1) in
    UIView.animate(withDuration: 1.0, animations: {
        // Perform animation 2
    }, completion: { (result2) in
        UIView.animate(withDuration: 1.0, animations: {
            // Perform animation 3
        }, completion: { (result3) in
            UIView.animate(withDuration: 1.0, animations: {
                // Perform animation 4
            }, completion: { (result4) in
                print('Animation 1-4 executed');
            })
        })
    })
}
```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TDOuroboros is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TDOuroboros'
```

## Author

michaeldai1006, dtc74110@gmail.com

## License

TDOuroboros is available under the MIT license. See the LICENSE file for more info.
