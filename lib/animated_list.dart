import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State<AnimatedListScreen> createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  final List<String> items = [];
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Animated List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 65,
                height: 62,
                decoration: BoxDecoration(
                    //shape:BoxShape.circle ,
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15.r)),
                child: Center(
                  child: TextButton(
                      onPressed: insertItem,
                      child: const Text(
                        'add',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )),
                )),
          ),
          Expanded(
            child: AnimatedList(
              controller: scrollController,
              key: listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) => SizeTransition(
               
                sizeFactor: animation,
                child: SizedBox(
                  height: 65,
                  child: Card(
                    elevation: 10,
                    color: Colors.deepPurple,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                            child: Text(
                          "   ${items[index]}",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        )),
                        IconButton(
                          onPressed: () => deleteItem(index),
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void insertItem() {
    var index = items.length;
    items.add('item${index + 1}');
    Future.delayed(const Duration(milliseconds: 200), () {
      listKey.currentState!.insertItem(index);
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  void deleteItem(int index) {
    var removeI = items.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => SlideTransition(
          position: animation.drive(Tween<Offset>(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          )),
              child: SizedBox(
                height: 65,
                child: Card(
                  elevation: 10,
                  color: Colors.deepPurple,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                          child: Text(
                        removeI,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      )),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
            ),
        duration: const Duration(milliseconds: 500));
  }
}
