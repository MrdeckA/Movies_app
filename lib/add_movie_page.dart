import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _posterController = TextEditingController();
  List<String> _categories = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: ('Nom *'),
                    labelText: ('Nom du film'),
                  ),
                  validator: (String? value) {
                    return (value == null || value == '')
                        ? "Ce champ est obligatoire"
                        : null;
                  },
                ),
                TextFormField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: ('Annés *'),
                    labelText: ('Année de sortie du film'),
                  ),
                  validator: (String? value) {
                    return (value == null || value == '')
                        ? "Ce champ est obligatoire"
                        : null;
                  },
                ),
                TextFormField(
                  controller: _posterController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: ('Poster *'),
                    labelText: ('Lien vers poster'),
                  ),
                  validator: (String? value) {
                    return (value == null || value == '')
                        ? "Ce champ est obligatoire"
                        : null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropDownMultiSelect(
                  onChanged: (List<String> x) {
                    setState(() {
                      _categories = x;
                    });
                  },
                  options: ['Action', 'Science-fiction', 'Avanture', 'Comédie'],
                  selectedValues: _categories,
                  whenEmpty: 'Catégorie',
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    FirebaseFirestore.instance.collection('Movies').add({
                      'name' : _nameController.text,
                      'year': _yearController.text,
                      'poster': _posterController.text,
                      'categories': _categories,
                      'likes': 0
                    });
                    Navigator.pop(context);
                  }
                }, child: Text('Ajouter'),)

              ],
            ),
          )),
    );
  }
}
