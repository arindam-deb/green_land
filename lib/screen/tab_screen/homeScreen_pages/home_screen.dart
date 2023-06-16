import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_land/screen/tab_screen/homeScreen_pages/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String category_name = 'mango';
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 43,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search Your Plant',
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),

          //HOrizontal listview for item list
          SizedBox(
            height: 35,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Admin')
                    .doc('allproducts')
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

                  var category = snapshot.data!.data()!['category'];
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length ?? 0,
                      itemBuilder: ((context, index) {
                        
                        return InkWell(
                          onTap: () {
                            setState(() {
                              category_name = category[index]['category-name'];
                              print(category_name);
                            });
                            
                          },
                          child: HorizontalListGrid(
                            title: category[index]['category-name'],
                          ),
                        );
                      }));
                }),
          ),

          //Product for you
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Products For You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          //Products Item Gridview
          SizedBox(height: 25),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Admin')
                  .doc('allproducts')
                  .collection('products')
                  .where('category-name', isEqualTo: category_name)
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

                var data = snapshot.data!.docs;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                        itemCount: data.length ,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 255),
                        itemBuilder: ((context, index) {
                          print(category_name);
                          var product=data[index].data();
                          return InkWell(
                            onTap: (() {
                              Get.to(() => DetailsScreen(
                                data: product,
                              ));
                            }),
                            child: ProductGrid(
                              title: product['product-name'],
                            ),
                          );
                        })),
                  ),
                );
              })
        ],
      ),
    );
  }
}

class HorizontalListGrid extends StatelessWidget {
  String title;
  HorizontalListGrid({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Container(
        height: 24,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  String title;
  ProductGrid({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 196, 221, 199),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            height: 165,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset('lib/images/image 1.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Descripción Producto',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '20\$',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          size: 14,
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
