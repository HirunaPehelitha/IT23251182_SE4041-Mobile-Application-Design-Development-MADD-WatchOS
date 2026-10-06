import SwiftUI

struct ContentView: View {

    @State private var tasks = [
        TaskItem(title: "Morning Walk", completed: true),
        TaskItem(title: "Drink Water", completed: false),
        TaskItem(title: "Read Notes", completed: false),
        TaskItem(title: "Call Home", completed: true)
    ]

    private var completedCount: Int {
        tasks.filter { $0.completed }.count
    }

    var body: some View {

        NavigationStack {

            List {

                Text("\(completedCount) / \(tasks.count) Completed")
                    .font(.caption)
                    .listRowBackground(Color.clear)

                ForEach(tasks.indices, id: \.self) { index in

                    // Tap the row to toggle completion
                    Button {
                        tasks[index].completed.toggle()
                    } label: {
                        HStack {
                            Image(
                                systemName:
                                    tasks[index].completed
                                    ? "checkmark.circle.fill"
                                    : "circle"
                            )
                            .foregroundStyle(tasks[index].completed ? .green : .gray)

                            Text(tasks[index].title)

                            Spacer()
                        }
                    }

                    // Separate row to open details
                    NavigationLink {
                        TaskDetailView(task: tasks[index])
                    } label: {
                        Label("Details", systemImage: "info.circle")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }

                // Additional feature (Option A): Reset Tasks
                Button(role: .destructive) {
                    for index in tasks.indices {
                        tasks[index].completed = false
                    }
                } label: {
                    Label("Reset Tasks", systemImage: "arrow.counterclockwise")
                }
            }
            .navigationTitle("Quick Tasks")
        }
    }
}

#Preview {
    ContentView()
}
