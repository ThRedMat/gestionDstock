import 'package:flutter/material.dart';
import 'camera.dart';
import 'modificationarticle.dart';

void main() {
  runApp(const GestionDesStocksApp());
}

class GestionDesStocksApp extends StatelessWidget {
  const GestionDesStocksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Stocks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GestionDesStocksPage(),
    );
  }
}

class GestionDesStocksPage extends StatefulWidget {
  const GestionDesStocksPage({Key? key}) : super(key: key);

  @override
  _GestionDesStocksPageState createState() => _GestionDesStocksPageState();
}

class _GestionDesStocksPageState extends State<GestionDesStocksPage> {
  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Stocks'),
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
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: _buildArticleItem(articles[index], context),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  String nom = '';
                  int quantite = 0;

                  return AlertDialog(
                    title: const Text('Ajouter un Article'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onChanged: (value) {
                            nom = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Nom de l\'article',
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            quantite = int.tryParse(value) ?? 0;
                          },
                          decoration: const InputDecoration(
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
                        child: const Text('Ajouter'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CameraPage()),
              );
            },
            child: const Icon(Icons.camera),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleItem(Article article, BuildContext context) {
    return ListTile(
      title: Text(article.nom),
      subtitle: Text('Quantité: ${article.quantite}'),
      onLongPress: () => _onArticleLongPress(article, context),
    );
  }

  void _onArticleLongPress(Article article, BuildContext context) async {
    Article? nouvelArticle = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModificationArticlePage(article: article),
      ),
    );

    if (nouvelArticle != null) {
      int index = articles.indexOf(article);
      setState(() {
        articles[index] = nouvelArticle;
      });
    }
  }
}

class Article {
  final String nom;
  final int quantite;

  Article({required this.nom, required this.quantite});
}
