import Sentry

public struct SentryClient: Sendable {
  public var addBreadcrumb: @Sendable (_ crumb: Breadcrumb) -> Void

  public init(addBreadcrumb: @Sendable @escaping (_ crumb: Breadcrumb) -> Void) {
    self.addBreadcrumb = addBreadcrumb
  }
}
