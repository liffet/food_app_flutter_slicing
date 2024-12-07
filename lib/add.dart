import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker
import 'package:supabase_flutter/supabase_flutter.dart';
import 'list.dart'; // Import halaman ListPage setelah produk ditambahkan

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController imageController = TextEditingController();

    // Variabel untuk menyimpan path gambar yang dipilih
    String? imagePath;

    // Instance ImagePicker
    final ImagePicker _picker = ImagePicker();

    // Fungsi untuk memilih gambar dari galeri
    Future<void> _pickImage() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath = image.path; // Simpan path gambar yang dipilih
        imageController.text = imagePath!; // Tampilkan path di TextField
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.red),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Tambah Produk',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Produk",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Masukkan nama produk",
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Harga",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Masukkan Harga",
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kategori Produk",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: categoryController,
                        decoration: InputDecoration(
                          hintText: "Makanan",
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Image",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: _pickImage,
                        child: AbsorbPointer(
                          child: TextField(
                            controller: imageController,
                            decoration: InputDecoration(
                              hintText: imagePath ?? "Choose file",
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final productName = nameController.text;
                final productPrice = double.tryParse(priceController.text) ?? 0;
                final productCategory = categoryController.text;
                final productImage = imageController.text;

                // Validasi input
                if (productName.isEmpty ||
                    productPrice <= 0 ||
                    productCategory.isEmpty ||
                    productImage.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Harap lengkapi semua data produk')),
                  );
                  return;
                }

                // Insert data ke Supabase
                final response = await Supabase.instance.client
                    .from('products') // Ganti dengan nama tabel Anda
                    .insert([
                  {
                    'name': productName,
                    'price': productPrice,
                    'category': productCategory,
                    'image': productImage,
                  }
                ]);

                if (response.error == null) {
                  // Berhasil menambahkan data
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Produk berhasil ditambahkan!')));

                  // Debugging: Print response untuk memastikan data berhasil masuk
                  debugPrint('Produk berhasil ditambahkan: ${response.data}');
  
                  // Navigasi ke halaman ListPage setelah data berhasil ditambahkan
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ListPage()),
                  );
                } else {
                  // Menampilkan pesan kesalahan jika ada error
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Gagal menambahkan produk: ${response.error!.message}')));
                  // Debugging: Menampilkan error
                  debugPrint('Error: ${response.error!.message}');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


