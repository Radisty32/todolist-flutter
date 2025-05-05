import 'package:flutter/material.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ToDoHome(),
    );
  }
}

class ToDoItem {
  String title;
  bool isDone;

  ToDoItem({required this.title, this.isDone = false});
}

class ToDoHome extends StatefulWidget {
  const ToDoHome({super.key});
  @override
  ToDoHomeState createState() => ToDoHomeState();
}

class ToDoHomeState extends State<ToDoHome> {
  final List<ToDoItem> _items = [];
  final TextEditingController _controller = TextEditingController();

  void _addItem(String title) {
    if (title.isEmpty) return;
    setState(() {
      _items.add(ToDoItem(title: title));
    });
    _controller.clear();
  }

  void _toggleItem(int index) {
    setState(() {
      _items[index].isDone = !_items[index].isDone;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'New Task',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: _addItem,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _addItem(_controller.text),
                  child: Text('Add'),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  leading: Checkbox(
                    value: item.isDone,
                    onChanged: (_) => _toggleItem(index),
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      decoration: item.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeItem(index),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
