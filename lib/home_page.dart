import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_visitor.dart';

class HomePage extends StatelessWidget {
  const HomePage ({super.key});

  void logout() => FirebaseAuth.instance.signOut();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitantes'),
        actions: [IconButton( icon: const Icon(Icons.logout), onPressed: logout)],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('visitantes').orderBy('hora', descending: true).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i){
              final data = docs[i].data() as Map<String, dynamic>;
              return ListTile(
                leading: data['foto'] != null ? Image.network(data['foto'], width: 50, height: 50, fit: BoxFit.cover): const Icon(Icons.person),
                title: Text(data['nombre'] ?? 'Sin nombre'),
                subtitle: Text('Motivo ${data['motivo']} - ${(data['hora'] as Timestamp).toDate()}'),
              );
            },
          );
        }, 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddVisitorPage())),
        child: const Icon(Icons.add),
    ),
  );
  }
}