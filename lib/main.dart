import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget { // widget yang digunakan untuk menampilkan tampilan atau komponen yang tidak perlu mengubah keadaan atau state-nya selama aplikasi berjalan
  @override
  Widget build(BuildContext context) {  //metode yang digunakan mengembalikan widget atau tampilan yang akan ditampilkan pada layar aplikasi
    return MaterialApp(
      title: 'Baca Buku', //parameter yang digunakan pada widget 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Baca Buku'),
    );
  }
}

class MyHomePage extends StatefulWidget { //widget yang digunakan untuk menampilkan tampilan atau komponen yang tidak perlu mengubah keadaan atau state-nya selama aplikasi berjalan
  MyHomePage({Key? key, required this.title}) : super(key: key); //konstruktor dari MyHomePage yang digunakan membuat objek dari kelas myHomePage

  final String title; // deklarasi variable title

  @override
  _MyHomePageState createState() => _MyHomePageState(); //method yang digunakan untuk membuat objek dari kelas _MyHomePageState
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> books = [ //list judul buku yang akan ditampilkan pada aplikasi
    'Buku Filosofi Teras',
    'Buku Atomic Habits',
    'Buku Nanti Kita Cerita Tentang Hari ini',
    'Buku Kamu Gak Sendiri',
    'Buku Sebuah Seni Untuk Bersikap Bodoamat',
    'Buku I Want To Die But I Want To Eat',
  ];

  bool isReading = false;
  String bookContent = '';
  List<String> readBooks = [];

  void readBook(String title) { //method yang didefinisikan di dalam kelas (widget) yang digunakan untuk mengeksekusi suatu aksi atau tindakan ketika method tersebut dipanggil atau dijalankan.
    setState(() {
      isReading = true;
      bookContent = 'Novel yang berjudul Sebuah Seni Untuk Bersikap Bodo Amat bercerita tentang seseorang yang bernama Charles Bukowski yang mempunyai masa lalu yang kelam, suka mabuk-mabukan, berjudi, mempermainkan wanita, kasar, tukang utang dan seorang penyair. Dia bercita-cita menjadi seorang penulis terkenal namun karya-karyanya selalu ditolak oleh hampir disetiap majalah, jurnal-jurnal, surat kabar dan penerbit lainnya. Semua penerbit tersebut tidak mau menerbitkan karyanya dengan alasan tulisannya yang kasar, menjijikkan dan tidak bermoral. Berpuluh tahun Bukowski hidup sebagai penyair dan kehidupan yang buruk, sampai pada akhirnya ada seorang editor yang tertarik akan karya Bukowski sehingga editor tersebut mau membantu untuk menerbitkan karya Bukowski. Mulai dari situlah Bukowski menulis karya-karya dan menjadi sukses. Novel ini merupakan cerita dibalik kesuksesan Bukowski yang sesungguhnya. Dia merasa “nyaman” dengan dirinya yang dianggap sebagai sebuah kegagalan. $title';
    });
  }

  void markAsRead(String title) { //Method ini digunakan untuk melakukan aksi menandai sebuah buku dengan judul yang diberikan pada parameter title sebagai sudah dibaca.
    setState(() {
      isReading = false;
      readBooks.add(title);
    });
  }

  bool isBookRead(String title) {
    return readBooks.contains(title);
  }

  @override
  Widget build(BuildContext context) { //method yang didefinisikan di dalam sebuah kelas (widget) dan digunakan untuk mengembalikan tampilan (widget) dari kelas tersebut.
    if (isReading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  bookContent,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    markAsRead(books
                        .firstWhere((element) => element.startsWith('Buku')));
                  },
                  child: Text('Sudah Dibaca'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isReading = false;
                    });
                  },
                  child: Text('Kembali'),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.network(
                'https://images.pexels.com/photos/2741079/pexels-photo-2741079.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                height: 100.0,
                width: 75.0,
                fit: BoxFit.cover,
              ),
              title: Text(
                books[index],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Buku Non Fiksi ${index + 1}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: isBookRead(books[index]) & !isReading
                  ? Icon(Icons.check_box)
                  : ElevatedButton(
                      onPressed: () {
                        readBook(books[index]);
                      },
                      child: Text('Baca'),
                    ),
            );
          },
        ),
        floatingActionButton: readBooks.isEmpty
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController controller =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Buku Sudah Dibaca'),
                        content: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Masukkan judul buku yang sudah dibaca',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                readBooks.add(controller.text);
                                Navigator.pop(context);
                              });
                            },
                            child: Text('Simpan'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Batal'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.check),
              ),
      );
    }
  }
}