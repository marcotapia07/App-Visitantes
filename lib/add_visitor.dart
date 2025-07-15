import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddVisitorPage extends StatefulWidget{
  const AddVisitorPage({super.key});

  @override
  State<AddVisitorPage> createState() =>_AddVisitorPageState();
}

class _AddVisitorPageState extends State<AddVisitorPage> {
  final nombreController = TextEditingController();
  final motivoController = TextEditingController();
  File? imagen;
  DateTime hora = DateTime.now();
  bool cargando = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if(picked != null) setState(() => imagen = File(picked.path));
  }

  Future<void> guardar() async {
    setState(() => cargando = true);
    String? url;

    if(imagen != null){
      final nombreArchivo = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.ref().child('fotos').child('$nombreArchivo.jpg');
      await ref.putFile(imagen!);
      url = await ref.getDownloadURL();
    }

    await FirebaseFirestore.instance.collection('visitantes').add({
      'nombre': nombreController.text,
      'motivo': motivoController.text,
      'hora': Timestamp.fromDate(hora),
      'foto': url,
    });

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Visitante')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller:nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: motivoController, decoration: const InputDecoration(labelText: 'Motivo de visita')),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('Hora: ${hora.toLocal()}'),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: ()async{
                  final seleccion = await showDatePicker(
                    context: context,
                    initialDate: hora,
                    firstDate: DateTime(2026),
                    lastDate: DateTime(2028),
                  );
                  if(seleccion != null) {
                    setState(() => hora = seleccion);
                  }
                }, child: const Text('Cambiar Fecha'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            imagen != null
              ? Image.file(imagen!, width: 100, height: 100)
              : ElevatedButton(onPressed: pickImage, child: const Text('Tomar Foto')),
            const Spacer(),
            cargando
              ? const CircularProgressIndicator()
              : ElevatedButton(onPressed: guardar, child: const Text('Guardar')),
          ],
        ),
      ),
    );
  }
}