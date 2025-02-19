import Logging
@preconcurrency import Sentry
import XCTest
import os

@testable import LoggingSentry

final class LoggingSentryTests: XCTestCase {
  func test_Integration() {
    nonisolated(unsafe) var breadcrumb: Breadcrumb?
    let mockClient = SentryClient { crumb in
      breadcrumb = crumb
    }

    LoggingSystem.bootstrap { label in
      SentryLogHandler(label: label, client: mockClient)
    }

    var logger = Logger(label: "Testing")
    logger[metadataKey: "test-key"] = "test-metadata"
    logger.info("Hello World!")


    XCTAssertEqual(logger[metadataKey: "test-key"], "test-metadata")
    
    XCTAssertEqual(breadcrumb?.level, .info)
    XCTAssertEqual(breadcrumb?.message, "Hello World!")
    XCTAssertEqual(breadcrumb?.category, "Testing")
    XCTAssertEqual(breadcrumb?.type, "log")
    XCTAssertNotNil(breadcrumb?.data?["test-key"])
    XCTAssertNotNil(breadcrumb?.data?["file"])
    XCTAssertNotNil(breadcrumb?.data?["function"])
    XCTAssertNotNil(breadcrumb?.data?["line"])
    XCTAssertNotNil(breadcrumb?.timestamp)
  }

  func test_Handler_Debug() {
    nonisolated(unsafe) var breadcrumb: Breadcrumb?
    let mockClient = SentryClient { crumb in
      breadcrumb = crumb
    }

    let handler = SentryLogHandler(label: "Testing", client: mockClient)
    handler.log(
      level: .debug, message: "testing", metadata: nil, source: "test_source",
      file: "test.swift", function: "test()", line: 1)

    XCTAssertEqual(breadcrumb?.level, .debug)
    XCTAssertEqual(breadcrumb?.message, "testing")
    XCTAssertEqual(breadcrumb?.category, "Testing")
    XCTAssertEqual(breadcrumb?.type, "log")
    XCTAssertNotNil(breadcrumb?.data?["source"])
    XCTAssertNotNil(breadcrumb?.data?["file"])
    XCTAssertNotNil(breadcrumb?.data?["function"])
    XCTAssertNotNil(breadcrumb?.data?["line"])
    XCTAssertNotNil(breadcrumb?.timestamp)
  }

  func test_Handler_Warning() {
    nonisolated(unsafe) var breadcrumb: Breadcrumb?
    let mockClient = SentryClient { crumb in
      breadcrumb = crumb
    }

    let handler = SentryLogHandler(label: "Testing", client: mockClient)
    handler.log(
      level: .warning, message: "testing", metadata: nil, source: "test_source",
      file: "test.swift", function: "test()", line: 1)

    XCTAssertEqual(breadcrumb?.level, .warning)
    XCTAssertEqual(breadcrumb?.message, "testing")
    XCTAssertEqual(breadcrumb?.category, "Testing")
    XCTAssertEqual(breadcrumb?.type, "log")
    XCTAssertNotNil(breadcrumb?.data?["file"])
    XCTAssertNotNil(breadcrumb?.data?["function"])
    XCTAssertNotNil(breadcrumb?.data?["line"])
    XCTAssertNotNil(breadcrumb?.timestamp)
  }

  func test_Handler_Error() {
    nonisolated(unsafe) var breadcrumb: Breadcrumb?
    let mockClient = SentryClient { crumb in
      breadcrumb = crumb
    }

    let handler = SentryLogHandler(label: "Testing", client: mockClient)
    handler.log(
      level: .error, message: "testing", metadata: nil, source: "test_source",
      file: "test.swift", function: "test()", line: 1)

    XCTAssertEqual(breadcrumb?.level, .error)
    XCTAssertEqual(breadcrumb?.message, "testing")
    XCTAssertEqual(breadcrumb?.category, "Testing")
    XCTAssertEqual(breadcrumb?.type, "log")
    XCTAssertNotNil(breadcrumb?.data?["file"])
    XCTAssertNotNil(breadcrumb?.data?["function"])
    XCTAssertNotNil(breadcrumb?.data?["line"])
    XCTAssertNotNil(breadcrumb?.timestamp)
  }

  func test_Handler_Notice() {
    nonisolated(unsafe) var breadcrumb: Breadcrumb?
    let mockClient = SentryClient { crumb in
      breadcrumb = crumb
    }

    let handler = SentryLogHandler(label: "Testing", client: mockClient)
    handler.log(
      level: .notice, message: "testing", metadata: nil, source: "test_source",
      file: "test.swift", function: "test()", line: 1)

    XCTAssertEqual(breadcrumb?.level, .warning)
    XCTAssertEqual(breadcrumb?.message, "testing")
    XCTAssertEqual(breadcrumb?.category, "Testing")
    XCTAssertEqual(breadcrumb?.type, "log")
    XCTAssertNotNil(breadcrumb?.data?["file"])
    XCTAssertNotNil(breadcrumb?.data?["function"])
    XCTAssertNotNil(breadcrumb?.data?["line"])
    XCTAssertNotNil(breadcrumb?.timestamp)
  }

  func test_Handler_Critical() {
    nonisolated(unsafe) var breadcrumb: Breadcrumb?
    let mockClient = SentryClient { crumb in
      breadcrumb = crumb
    }

    let handler = SentryLogHandler(label: "Testing", client: mockClient)
    handler.log(
      level: .critical, message: "testing", metadata: nil, source: "test_source",
      file: "test.swift", function: "test()", line: 1)

    XCTAssertEqual(breadcrumb?.level, .fatal)
    XCTAssertEqual(breadcrumb?.message, "testing")
    XCTAssertEqual(breadcrumb?.category, "Testing")
    XCTAssertEqual(breadcrumb?.type, "log")
    XCTAssertNotNil(breadcrumb?.data?["file"])
    XCTAssertNotNil(breadcrumb?.data?["function"])
    XCTAssertNotNil(breadcrumb?.data?["line"])
    XCTAssertNotNil(breadcrumb?.timestamp)
  }

  func test_Handler_Trace() {
    nonisolated(unsafe) var breadcrumb: Breadcrumb?
    let mockClient = SentryClient { crumb in
      breadcrumb = crumb
    }

    let handler = SentryLogHandler(label: "Testing", client: mockClient)
    handler.log(
      level: .trace, message: "testing", metadata: nil, source: "test_source",
      file: "test.swift", function: "test()", line: 1)

    XCTAssertEqual(breadcrumb?.level, .debug)
    XCTAssertEqual(breadcrumb?.message, "testing")
    XCTAssertEqual(breadcrumb?.category, "Testing")
    XCTAssertEqual(breadcrumb?.type, "log")
    XCTAssertNotNil(breadcrumb?.data?["file"])
    XCTAssertNotNil(breadcrumb?.data?["function"])
    XCTAssertNotNil(breadcrumb?.data?["line"])
    XCTAssertNotNil(breadcrumb?.timestamp)
  }

  func test_Live() {
    let handler = SentryLogHandler(label: "Testing")
    handler.log(
      level: .critical, message: "testing", metadata: nil, source: "test_source",
      file: "test.swift", function: "test()", line: 1)
  }
}
