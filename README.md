# SwiftLogSentry

[![Build & Test](https://github.com/laosb/swift-log-sentry/actions/workflows/ci.yml/badge.svg)](https://github.com/laosb/swift-log-sentry/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flaosb%2Fswift-log-sentry%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/laosb/swift-log-sentry)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flaosb%2Fswift-log-sentry%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/laosb/swift-log-sentry)

A [Sentry](https://sentry.com) logging backend for [SwiftLog](https://github.com/apple/swift-log), 
it works by creating and adding a [Breadcrumb](https://docs.sentry.io/platforms/apple/guides/ios/enriching-events/breadcrumbs/) for log events.

> **This is a maintained fork of [ericlewis/swift-log-sentry](https://github.com/ericlewis/swift-log-sentry).**
>
> This fork bumped up `sentry-cocoa` to 8.x, targets latest SwiftLog interface and is now fully compatible with Swift 6 Language Mode. Library name is also updated to `LoggingSentry` to be more in-line with other SwiftLog backends.

## Features

- Supports [metadata](https://github.com/apple/swift-log#logging-metadata) by inserting the key value pairs in the data property on a Breadcrumb. 
- Log levels roughly map with minor differences.
- Supports line, file, and function reporting via the data property.
- 100% test coverage.

## Getting started

Before using the logger you need to initialize the Sentry SDK.

#### Adding the dependency

`SwiftLogSentry` is fully Swift 6 compatible and is also available for Swift 5. To use the handler, you need to declare your dependency in your `Package.swift`:

```swift
.package(url: "https://github.com/laosb/swift-log-sentry.git", from: "1.0.0"),
```

and to your application/library target, add `"LoggingSentry"` to your `dependencies`, e.g. like this:

```swift
.target(name: "BestExampleApp", dependencies: [
    .product(name: "LoggingSentry", package: "swift-log-sentry")
],
```

## License

This library is released under the MIT license. See [LICENSE](LICENSE.md) for details.
