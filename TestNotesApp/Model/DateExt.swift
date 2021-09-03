//
//  DateExt.swift
//  TestNotesApp
//
//  Created by Cyril on 5.08.21.
//

import Foundation

extension Date {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
}
