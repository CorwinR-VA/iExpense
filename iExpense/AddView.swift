//
//  AddView.swift
//  iExpense
//
//  Created by Corwin Rainier on 6/27/22.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = ""
    @State private var amount = 0.0
    @State private var footer = false
    
    @ObservedObject var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                } footer: {
                    if footer == true {
                        Text("CANNOT SAVE WHILE ANY FIELD IS LEFT EMPTY")
                            .foregroundColor(Color.red)
                    }
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("SAVE") {
                    if name != "" || type != "" || amount != 0.0 {
                        footer = false
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    } else {
                        footer = true
                    }
                }
                .font(.title3.bold())
                .buttonStyle(.plain)
                .foregroundColor(name == "" || type == "" || amount == 0.0 ? .secondary : .primary)
                    
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
