//
//  ContentView.swift
//  ListViewApp
//
//  Created by 米倉謙 on 2020/09/06.
//  Copyright © 2020 kenyonekura.com. All rights reserved.
//

import SwiftUI
import Combine


//構造体

struct ContentView: View {
    
//    インスンタンス？
    @ObservedObject var nList = namesList()
    
    @ObservedObject var tList = TaskList()
    
    @State var newTask : String = ""
    
//    ボタンのアクション
    var addTaskBar : some View{
        HStack{
            TextField("追加して下さい",text:self.$newTask)
            Button(action: self.addNewTask, label: {Text("add")})
        }
    }
//     ボタンを押された時に発動する関数
    func addNewTask() {
        tList.tasks.append(Task(id: String(tList.tasks.count + 1), taskItem:newTask))
        self.newTask = ""
    }
//    削除機能
    func rowRemove(offsets: IndexSet) {
        self.tList.tasks.remove(atOffsets: offsets)
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                addTaskBar.padding()
                List {
                    ForEach(self.tList.tasks){
                        Index in Text(Index.taskItem)
                    }.onDelete(perform: rowRemove)
                }.navigationBarTitle("Taskリスト")
            }.navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
