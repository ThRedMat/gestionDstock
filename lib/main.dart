import 'package:flutter/material.dart';

void main() {
  runApp(GestionDesStocksApp());
}

class GestionDesStocksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Stocks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestionDesStocksPage(),
    );
  }
}

class GestionDesStocksPage extends StatefulWidget {
  @override
  _GestionDesStocksPageState createState() => _GestionDesStocksPageState();
}

class _GestionDesStocksPageState extends State<GestionDesStocksPage> {
  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Stocks'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(articles[index].nom),
            onDismissed: (direction) {
              setState(() {
                articles.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ListTile(
              title: Text(articles[index].nom),
              subtitle: Text('Quantité: ${articles[index].quantite}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String nom = '';
              int quantite = 0;

              return AlertDialog(
                title: Text('Ajouter un Article'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        nom = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Nom de l\'article',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        quantite = int.tryParse(value) ?? 0;
                      },
                      decoration: InputDecoration(
                        labelText: 'Quantité',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        articles.add(Article(nom: nom, quantite: quantite));
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Ajouter'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Article {
  final String nom;
  final int quantite;

  Article({required this.nom, required this.quantite});
}
