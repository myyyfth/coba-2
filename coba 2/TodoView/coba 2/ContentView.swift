//
//  ContentView.swift
//  coba 2
//
//  Created by Ahmad Miftah Syakir on 16/02/21.
// NSManagedObject = dia dapat mengikat object model kita ke bagian antar muka / UI / interface
// ManagedObjectContect = menyimpan konteks object  yg terkelola

// fetch request = tugas nya menampilkan hasil proses data  dari managedObjectContent untuk di tampilkan ke halaman interfface app
// ascanding = urutan dari yg terkecil ke yg terbesar
// descending = urutan dari yg terbesar ke yg terkecil

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var iconSettings: IconNames
    @FetchRequest(entity: Todo.entity(),sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name,ascending: true)]) var todos: FetchedResults<Todo>
    @State private var showingAddTodo: Bool = false
    @State private var showingSettingsView: Bool = false
    var body: some View {
        NavigationView{
         ZStack{
            List{
                ForEach(self.todos,id: \.self){todo in
                    HStack{
                        Text(todo.name ?? "Unknown")
                        
                        Spacer()
                        
                        Text(todo.priority ?? "Unknown")
                    }
                }
                .onDelete(perform: deleteTodo)
            }.navigationBarTitle("Todo",displayMode: .inline)
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action : {
                                        self.showingSettingsView.toggle() //true
                                    }){
                                        Image(systemName: "paintbrush")
                                    }
                .sheet(isPresented: $showingSettingsView){
                    SettingsView().environmentObject(self.iconSettings)
                }
            )
            if todos.count == 0{
               EmptyListView()
            }
        }
         .sheet(isPresented: $showingAddTodo){
             AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
         }
         .overlay(
            ZStack{
                Button(action: {
                    self.showingAddTodo.toggle()
                }){
                    Image(systemName: "plus.circel.fill")
                        .resizable()
                        .scaledToFit()
                        .background(Circle().fill(Color("ColorBase")))
                        .frame(width: 48,height: 48, alignment: .center)
                }
            }
            .padding(.bottom,15)
            .padding(.trailing,15)
            ,alignment: .bottomTrailing
         )
        }
    }
    
    private func deleteTodo(at offsets: IndexSet){ //komponen array = objek urutan array nama lain adalah index
        for index in offsets{
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do{
                try managedObjectContext.save()
            }catch{
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
    }
}
