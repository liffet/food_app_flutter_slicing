import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Page',
      home: const ShoppingPage(),
    );
  }
}

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topButton(
              Icons.arrow_back_ios_outlined,
              () {
                Navigator.pop(context);
              },
              iconColor: Colors.red,
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Card',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            topButton(Icons.person, () {}),
          ],
        ),
      ),
      body: const ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductItem(
          image: "assets/burger.jpg",
          name: "Burger King Medium",
          price: "Rp.50.000,00",
        ),
        ProductItem(
          image: "assets/teh.jpg",
          name: "Teh Botol",
          price: "Rp.4.000,00",
        ),
        ProductItem(
          image: "assets/burger.jpg",
          name: "Burger King Medium",
          price: "Rp.50.000,00",
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Ringkasan Belanja",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "PPN 11%",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              "Rp. 10.000,00",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Belanja",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              "Rp. 94.000,00",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Pembayaran",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Rp. 104.000,00",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 98, 176),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Checkout",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductItem extends StatefulWidget {
  final String image;
  final String name;
  final String price;

  const ProductItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void removeItem() {
    setState(() {
      quantity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return quantity > 0
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 380,
              height: 120,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        widget.image,
                        height: 110,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(  // Wrap the product details with Expanded to make room for the trash icon
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.name,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // No longer causes overflow because it's placed in the Expanded widget
                          ],
                        ),
                        Text(
                          widget.price,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  CupertinoIcons.minus,
                                  size: 18,
                                ),
                                onPressed: decrementQuantity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "$quantity",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  CupertinoIcons.plus,
                                  size: 18,
                                ),
                                onPressed: incrementQuantity,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(  // Moved the trash icon to the far right
                    icon: const Icon(
                      CupertinoIcons.trash,
                      color: Colors.red,
                      size: 18,
                    ),
                    onPressed: removeItem,
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink(); // Empty space when the item is removed
  }
}

Widget topButton(IconData icon, VoidCallback onPressed, {Color iconColor = Colors.black}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    ),
    child: IconButton(
      icon: Icon(icon, color: iconColor),
      onPressed: onPressed,
    ),
  );
}