import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("To-Do List"),
        ),
        body: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map<String, dynamic>> _todoItems = [];
  TextEditingController _controller = TextEditingController();

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add({'task': task, 'completed': false});
      });
      _controller.clear();
    }
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index]['completed'] = !_todoItems[index]['completed'];
    });
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter a task',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _addTodoItem(_controller.text),
            child: Text('Add Task'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                final todoItem = _todoItems[index];
                return ListTile(
                  title: Text(
                    todoItem['task'],
                    style: TextStyle(
                      decoration: todoItem['completed']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todoItem['completed'],
                    onChanged: (value) => _toggleTodoItem(index),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTodoItem(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
