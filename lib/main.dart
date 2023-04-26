import 'package:flutter/material.dart';

void main() {
  runApp(const RockInRio());
}

class RockInRio extends StatelessWidget { 
  const RockInRio({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock in Rio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(
        title: '',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Atracao> _listaFavoritos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atrações'),
      ),
      body: ListView.builder(
        itemCount: listaAtracoes.length,
        itemBuilder: (context, index) {
          final isFavorito = _listaFavoritos.contains(listaAtracoes[index]);
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AtracaoPage(atracao: listaAtracoes[index])));
            },
            title: Text(listaAtracoes[index].nome),
            subtitle: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: listaAtracoes[index]
                  .tags
                  .map((tag) => Chip(label: Text('#$tag')))
                  .toList(),
            ),
            leading: CircleAvatar(
              child: Text('${listaAtracoes[index].dia}'),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  if (isFavorito) {
                    _listaFavoritos.remove(listaAtracoes[index]);
                  } else {
                    _listaFavoritos.add(listaAtracoes[index]);
                  }
                });
              },
              icon: isFavorito
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border),
            ),
          );
        },
      ),
    );
  }
}

class AtracaoPage extends StatelessWidget {
  const AtracaoPage({super.key, required this.atracao});
  final Atracao atracao;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(atracao.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var tag in atracao.tags) Chip(label: Text('#$tag')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}

class Atracao {
  final String nome;
  final int dia;
  final List<String> tags;
  const Atracao(this.nome, this.dia, this.tags);
}

const listaAtracoes = [
  Atracao('Iron Maiden', 2, ['Espetaculo', 'Fas', 'NovoAlbum']),
  Atracao('Alok', 3, ['Influente', 'Top', 'Show']),
  Atracao('Just Bieber', 4, ['TopCharts', 'Hits', 'PríncipeDoPOP']),
  Atracao('Guns N\' Roses', 8, ['Sucesso', 'Espetaculo', 'Fas']),
  Atracao('Capital Inicial', 9, ['2019', 'Novo Album', 'Fas']),
  Atracao('Green Day', 9, ['Sucesso', 'Reconhecimento', 'Show']),
  Atracao('Cold Play', 9, ['Novo Album', 'Sucesso', '2011']),
  Atracao('Avril Lavigne', 10, ['Representatividade', 'Sucesso', 'parcerias']),
];
