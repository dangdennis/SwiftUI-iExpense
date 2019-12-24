//
//  AddView.swift
//  iExpense
//
//  Created by Dennis Dang on 12/18/19.
//  Copyright © 2019 DLab. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var isInvalid = false
    @Environment(\.presentationMode) var presentationMode

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                    return
                }
                
                self.isInvalid = true
            })
                .alert(isPresented: $isInvalid) {
                    Alert(title: Text("U messed up"), message: Text("That \(self.amount) aint right"), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func resetForm() {
        self.name = ""
        self.amount = ""
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
