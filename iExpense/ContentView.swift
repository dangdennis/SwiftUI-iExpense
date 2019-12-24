//
//  ContentView.swift
//  iExpense
//
//  Created by Dennis Dang on 12/17/19.
//  Copyright © 2019 DLab. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            if (item.amount > 100) {
                                Text("$\(item.amount)")
                                    .foregroundColor(.red)
                            } else if (item.amount > 10) {
                                Text("$\(item.amount)")
                                    .foregroundColor(.blue)
                            } else {
                                Text("$\(item.amount)")
                            }
                        }
                    }
                    .onDelete(perform: removeRows)
                    .onMove(perform: move)
                }
            }
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        self.expenses.items.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to dest: Int) {
        self.expenses.items.move(fromOffsets: source, toOffset: dest)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var name: String

    var body: some View {
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
