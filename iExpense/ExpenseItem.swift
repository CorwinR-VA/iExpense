//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Corwin Rainier on 6/27/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
