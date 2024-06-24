import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mercado_na_nao/addCategoriaScreen.dart';
import 'package:mercado_na_nao/modelCategoria.dart';
import 'package:mercado_na_nao/produtoScreen.dart';
import 'package:mercado_na_nao/sharedPreferencesHelper.dart';

class CategoriaScreen extends StatefulWidget {
  @override
  _CategoriaScreenState createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();
  List<Categoria> _categorias = [];

  @override
  void initState() {
    super.initState();
    _refreshCategorias();
  }

  Future<void> _refreshCategorias() async {
    final categorias = await _prefsHelper.getCategorias();
    setState(() {
      _categorias = categorias;
    });
  }

  void _addCategoria() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddCategoriaScreen(onSave: _refreshCategorias),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        title: const Text('Todas as Categorias'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de colunas
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.8,
        ),
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          final categoria = _categorias[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProdutoScreen(
                    categoriaNome: categoria.nome,
                    categoriaId: categoria.id,
                  ),
                ),
              );
            },
            child: Container(
              child: Card(
                elevation: 2,
                surfaceTintColor: Colors.white,
                shadowColor: Colors.green,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: categoria.imagem.isNotEmpty
                            ? Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15),
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(File(categoria.imagem)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        categoria.nome.toUpperCase(),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
