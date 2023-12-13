import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late Future<void> _cameraInitializationFuture;
  late CameraController _controller;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    _cameraInitializationFuture = initializeCamera();
  }

  // Initialiser la caméra
  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCaptureButtonPressed() async {
    try {
      final XFile file = await _controller.takePicture();

      // Faites quelque chose avec le fichier, par exemple l'afficher dans une nouvelle page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CapturedImagePreview(imagePath: file.path),
        ),
      );
    } catch (e) {
      // Gérer les erreurs liées à la capture d'image
      print('Erreur lors de la capture d\'image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner QR Code'),
      ),
      body: FutureBuilder(
        future: _cameraInitializationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // La caméra est initialisée, afficher la prévisualisation
            return CameraPreview(_controller);
          } else {
            // Afficher un indicateur de chargement pendant l'initialisation
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onCaptureButtonPressed,
        child: const Icon(Icons.camera),
      ),
    );
  }
}

class CapturedImagePreview extends StatelessWidget {
  final String imagePath;

  const CapturedImagePreview({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Capturée'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
