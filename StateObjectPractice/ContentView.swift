//
//  ContentView.swift
//  StateObjectPractice
//
//  Created by Francisco Jean on 06/03/25.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [String] = []
    
    func addTask(_ task: String) {
        tasks.append(task)
    }
    
    func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
}

struct ContentView: View {
    var body: some View {
        TaskListView()
    }
}

struct TaskListView : View {
    
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTask: String = ""
    @State private var isStrikethrough: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add task", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                
                Button(action: {
                    if !newTask.isEmpty {
                        viewModel.addTask(newTask)
                        newTask = ""
                        print(viewModel.tasks)
                    }
                }) {
                    Image(systemName: "plus")   
                }
            }
            
            VStack() {
                ForEach(0..<viewModel.tasks.count, id: \.self) { index in
                    HStack {
                        Text(self.viewModel.tasks[index])
                        Button(action: {
                            self.viewModel.removeTask(at: index)
                            print(viewModel.tasks)
                        }) {
                            Image(systemName: "xmark")
                        }
                    }
                                        }
            }
        }
    }
}

#Preview {
    ContentView()
}
