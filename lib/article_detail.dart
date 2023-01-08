import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({super.key, required Article article});
    @override
  
@override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.arrow_back_ios),
                Text(_articles[articeId]["title"])
              ],
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _articles[articeId]["body"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(_articles[articeId]["body"][index]),
                  );
                })
          ],
        ),
      ),
    );
  }
}
 {