//
//  ContentView.swift
//  iExpense
//
//  Created by Corwin Rainier on 6/27/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddView = false
    
    @StateObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(item.color)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddView(expenses: expenses)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ExpenseItem {
    var color: Color {
        if self.amount <= 10 {
            return .green
        } else if self.amount <= 100 {
            return .primary
        } else if self.amount > 1000 {
            return .red
        } else {
            return .orange
        }
    }
}
