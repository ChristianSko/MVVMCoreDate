//
//  ContentView.swift
//  MVVMCoreDate
//
//  Created by Christian Skorobogatow on 6/7/22.
//

import SwiftUI
import CoreData

struct FruitCoreDateListView: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textfieldText: String  = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Add Fruit here", text: $textfieldText)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
            
            Button {
                guard !textfieldText.isEmpty else { return }
                vm.addFruit(text: textfieldText)
                textfieldText = ""
            } label: {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.orange)
                    .cornerRadius(10)
                    .padding()
            }
            
            List {
                ForEach(vm.savedEntities) { entity in
                    Text(entity.name ?? "NO NAME")
                        .onTapGesture {
                            vm.updateFruit(entity: entity)
                        }
                }
                .onDelete(perform: vm.deleteFruit)
            }
            .listStyle(PlainListStyle())
        }
        .onAppear{
            vm.fetchFruits()
        }
        .navigationTitle("Fruits")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FruitCoreDateListView()
    }
}
