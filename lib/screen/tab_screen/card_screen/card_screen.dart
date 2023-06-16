import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Card',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Admin')
                        .doc('allproducts')
                        .collection('cart')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == null) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData) {
                        return Text('No data available');
                      }

                      var doc = snapshot.data!.docs;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.80,
                        child: ListView.builder(
                            itemCount: doc.length,
                            itemBuilder: ((context, index) {
                              return ItemCard();
                            })),
                      );
                    }),
                SizedBox(height: 12),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5.2,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Your Total Cost',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      CalculateCost(
                        title: 'Subtotal',
                        price: '20 taka',
                      ),
                      SizedBox(height: 5),
                      CalculateCost(
                        title: 'Delivery charge',
                        price: '20 taka',
                      ),
                      SizedBox(height: 5),
                      CalculateCost(
                        title: 'Total',
                        price: '20 taka',
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 8),
                            child: Text(
                              'Pagar',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 184, 170, 79),
                  borderRadius: BorderRadius.circular(12)),
              child: Image.asset('lib/images/image 1.png'),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Name',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '1500 Taka',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.remove_circle)),
                Text(
                  '01',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.add_circle)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CalculateCost extends StatelessWidget {
  String title;
  String price;
  CalculateCost({
    required this.title,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            price,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
