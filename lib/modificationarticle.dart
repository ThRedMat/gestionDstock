import 'package:flutter/material.dart';
import 'package:gestiondesstocks/main.dart';

class ModificationArticlePage extends StatefulWidget {
  final Article article;

  const ModificationArticlePage({Key? key, required this.article})
      : super(key: key);

  @override
  _ModificationArticlePageState createState() =>
      _ModificationArticlePageState();
}

class _ModificationArticlePageState extends State<ModificationArticlePage> {
  late TextEditingController _nomController;
  late TextEditingController _quantiteController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.article.nom);
    _quantiteController =
        TextEditingController(text: widget.article.quantite.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modification d\'Article'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom de l\'article'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _quantiteController,
              decoration: const InputDecoration(labelText: 'Quantité'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            // Centrer le bouton en utilisant le widget Center
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String nom = _nomController.text;
                  int quantite = int.tryParse(_quantiteController.text) ?? 0;

                  Article nouvelArticle = Article(nom: nom, quantite: quantite);
                  Navigator.pop(context, nouvelArticle);
                },
                child: const Text('Enregistrer les modifications'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
