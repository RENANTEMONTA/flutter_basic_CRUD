import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> movieList = [
  'The Shawshank Redemption',
  'The Godfather',
  'The Dark Knight',
  'Pulp Fiction',
  'The Lord of the Rings: The Return of the King',
  'Forrest Gump',
  'Inception',
  'The Matrix',
  'Interstellar',
  'Spirited Away'
    ];
@override
void initState() {
  super.initState();
  movieList.sort(); //Sort the list once when the app starts
}

  TextEditingController movieController = TextEditingController();

  //add function
  void addMovie(BuildContext context) {
    String inputMovie = movieController.text.trim();

    setState(() {
      if (inputMovie.isEmpty || movieList.contains(inputMovie)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Input empty or already exist.'), duration: Duration(seconds: 2)));
      } else {
        movieList.add(inputMovie);
        movieList.sort();
        movieController.clear();
        //print(movieList);
      }
    });
  }

  //update function
  void updateMovie(BuildContext context, int index) {
    TextEditingController updateController = TextEditingController(text: movieList[index]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Movie'),
          content: TextField(controller: updateController, decoration: InputDecoration(hintText: 'Enter new name')),
          //buttons
          actions: [
            //cancel button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.red[600]),
              child: Text('Cancel'),
            ),
            //update button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String updatedMovie = updateController.text.trim();
                  if (updatedMovie.isNotEmpty && !movieList.contains(updatedMovie)) {
                    movieList[index] = updatedMovie;
                    movieList.sort();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Input empty or already exist.'), duration: Duration(seconds: 2)),
                    );
                  }
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.green[600]),
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  //delete function
  void deleteMovie(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Do you want to delete "${movieList[index]}"?'),
          //buttons
          actions: [
            //cancel button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.grey[300]),
              child: Text('Cancel'),
            ),
            //delete button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  movieList.removeAt(index);
                });
                 Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Movie Deleted'),
                    duration: Duration(seconds: 2),
                  )
                );
              },
              style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.red[600]),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Read Update Delete',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text('Movie List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: movieController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Type your movie',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => addMovie(context),
                      icon: Icon(Icons.add),
                      label: Text('Add'),
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.yellow),
                    ),
                    SizedBox(height: 12),
                    movieList.isEmpty
                        ? Text('The list is empty', style: TextStyle(color: Colors.white))
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: movieList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: Icon(Icons.movie_creation, color: Colors.blue[600]),
                                title: Text(movieList[index]),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => updateMovie(context, index),
                                      icon: Icon(Icons.edit, color: Colors.yellow[600]),
                                    ),
                                    IconButton(
                                      onPressed: () => deleteMovie(context, index),
                                      icon: Icon(Icons.delete, color: Colors.red[600]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
