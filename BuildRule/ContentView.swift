//
//  ContentView.swift
//  BuildRule
//
//  Created by Damian Rzeszot on 11/12/2020.
//

import SwiftUI

struct Key: View {
  let text: String
  var body: some View {
    Text(text)
      .foregroundColor(.secondary)
      .font(.footnote)
  }
}

struct Value: View {
  let text: String
  var body: some View {
    Text(text)
      .foregroundColor(.primary)
      .font(.body)
  }
}

struct ContentView: View {
  var body: some View {
    VStack {
      Section {
        Key(text: "raw file content")
        Value(text: content ?? "...")
      }
      Section {
        Key(text: "base64 decoded")
        Value(text: content?.base64Decoded() ?? "...")
      }
    }
  }

  // MARK: -

  var data: Data? {
    Bundle
      .main
      .url(forResource: "file", withExtension: "json")
      .flatMap { try? Data(contentsOf: $0) }
  }

  var content: String? {
    data
      .flatMap { String(data: $0, encoding: .utf8) }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension String {
  func base64Encoded() -> String? {
    return data(using: .utf8)?.base64EncodedString()
  }

  func base64Decoded() -> String? {
    guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
    return String(data: data, encoding: .utf8)
  }
}
