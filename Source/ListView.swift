import Foundation
import SwiftUI

struct ListView: View {
    @State private var items: [String]
    @State private var newItem: String = ""

    init(existingItems: [String] = []) {
        self.items = existingItems
    }

    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .listRowSeparator(.visible) // Add separator to each row
            }
            .listStyle(PlainListStyle())
            .onTapGesture {
                self.hideKeyboard()
            }

            HStack {
                TextField("Enter new item", text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    let trimmedItem = newItem.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmedItem.isEmpty {
                        items.append(trimmedItem)
                        newItem = ""
                    }
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(.trailing)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(existingItems: ["foo"])
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
