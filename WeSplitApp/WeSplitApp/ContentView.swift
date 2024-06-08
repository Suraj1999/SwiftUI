//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Suraj Gupta on 16/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var totalAmt = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercent = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10,15,20,5,0]
    
    var totalPerPerson : Double {
        let peopleCount = Double(numOfPeople + 2)
        let tipSelection = Double(tipPercent)
        let tipValue = totalAmt / 100 * tipSelection
        let grandTotal = totalAmt + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Amount", value: $totalAmt , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach(tipPercentages,id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
