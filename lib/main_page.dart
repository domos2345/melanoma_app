import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:melanoma_app/main.dart';
import 'package:path/path.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

const listData = ["0. textik", "first textiček", "second index"];

class _HomePageState extends State<HomePage> {
  final ImagePicker _imagePicker = ImagePicker();

  bool isTakingPhoto = false;
  int _selectedIndex = 0;
  int _articeId = -1;
  File? _image;

  Future getImage() async {
    print(_image == null ? " it IS null image" : "\n image is NOT null ");
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final tempImage = File(image.path);
    stderr.writeln(image.path);
    setState(() {
      isTakingPhoto = true;
    });
    setState(() {
      _image = tempImage;
    });

    print(_image == null ? " _image IS null image" : "\n _image is NOT null ");
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late Completer<GoogleMapController> _controller;

  // ignore: prefer_const_constructors
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: const LatLng(48.71, 21.26),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(48.71, 21.26),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void onArticleTappedFun(int index) {
    setState(() {
      _articeId = index;
    });
  }

  void _onArticleTapped(int index) {
    setState(() {
      _articeId = index;
    });
  }

  getImmage(ImageSource source) async {
    final XFile? image = _imagePicker.pickImage(source: source) as XFile?;
    File cropped = (await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxWidth: 700,
      maxHeight: 700,
      compressFormat: ImageCompressFormat.jpg,
    )) as File;
  }

  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[];

  @override
  void initState() {
    super.initState();
    //_image = File("assets/main_page_pic1.png");
    _widgetOptions = <Widget>[
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Column(
                  children: const [
                    Text(
                      "Keep yourself safe",
                      style: TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 96,
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        "Early detection is vital as, if caught early, 90% of melanomas can be cured with surgery.",
                        style: TextStyle(
                            fontFamily: 'Metropolis',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const Image(image: AssetImage("assets/main_page_pic1.png")),
              const SizedBox(height: 50),
              const Center(
                child: Text(
                  "3 IMPORTANT THINGS",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/newsletter-dev.svg",
                      semanticsLabel: "Icon 1",
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 75.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.arrow_back),
                    ),
                    const Spacer(),
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 250),
                      child: const Flexible(
                        flex: 1,
                        child: Text(
                          "Intresting about melanoma",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.info_outline))
                  ],
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        child: Card(
                            elevation: 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 17.0, top: 10),
                                child: Text(
                                  listData[index],
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              subtitle: const SizedBox(
                                height: 76,
                                child: Text(
                                  "some subtitle",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              enabled: true,
                              onTap: () {
                                _onArticleTapped(index);
                                print("onTap");
                              },
                            )),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      Text("unused page"),
      Padding(
        padding: EdgeInsets.only(left: 17.0, top: 128),
        child: Column(
          children: [
            _image != null ? Image.file(_image!) : Text("image from photo")
          ],
        ),
      ),
    ];
  }

  Widget loadMaps() {
    _controller = Completer();
    return GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: false,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: false,
        rotateGesturesEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        });
  }

  Widget loadImage() {
    return Padding(
        padding: const EdgeInsets.only(left: 23.0, top: 88, right: 23.0),
        child: Column(children: [
          const Text(
            "Is it your photo?",
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                fontFamily: "Metropolis"),
          ),
          const SizedBox(
            height: 29,
          ),
          _image != null
              ? DecoratedBox(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF1E0E0),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(width: 10, color: Color(0xFFF1E0E0))),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        _image!,
                      ),
                    ),
                  ))
              : const Text("image from photo"),
          const SizedBox(
            height: 44,
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 5,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              side: const BorderSide(color: Colors.red)))),
                  onPressed: () {
                    print("NO");
                    getImage();
                  },
                  child: const SizedBox(
                      height: 45, child: Center(child: Text("No"))),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Flexible(
                flex: 5,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              side: const BorderSide(color: Colors.blue)))),
                  onPressed: () {
                    print("yes");
                    setState(() {
                      isTakingPhoto = false;
                    });
                  },
                  child: const SizedBox(
                      height: 45, child: Center(child: Text("Yes"))),
                ),
              ),
            ],
          ),
        ]));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    setState(() {
      _articeId = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isTakingPhoto
          ? loadImage()
          : _selectedIndex == 2
              ? loadMaps()
              : _selectedIndex == 1 && _articeId != -1
                  ? loadArticle(_articeId)
                  : _widgetOptions.elementAt(_selectedIndex),
      //_widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("button click");
          getImage();

          /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TakePictureScreen( key:super.key , camera: firstCamera )
          );*/
          print("TakePictureScreen should load");
        },
        splashColor: Colors.blueAccent,
        backgroundColor: Color(0xFF4ECED7),
        child: Icon(Icons.camera_alt_outlined),
      ),
      bottomNavigationBar: isTakingPhoto
          ? null
          : BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_outlined),
                  label: 'Articles',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined),
                  label: 'Map',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
    );
  }

  loadArticle(int articeId) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      _articeId = -1;
                    });
                  },
                ),
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

  final List _articles = [
    {
      "title": "TITLE 1",
      "subtitle": "subtitle 1",
      "body": [
        "paragraph 1 and random text. random text. random text. random text. random text. random text. random text. random text. "
      ]
    },
    {
      "title": "TITLE 2",
      "subtitle": "subtitle 2",
      "body": [
        "paragraph 1 and random text. random text. random text. random text. random text. random text. random text. random text. ",
        "paragraph 1 and random text. random text. random text. random text. random text. random text. random text. random text. "
      ]
    },
    {
      "title": "TITLE 2",
      "subtitle": "subtitle 2",
      "body": [
        "paragraph 1 and random text. random text. random text. random text. random text. random text. random text. random text. ",
        "paragraph 1 and random text. random text. random text. random text. random text. random text. random text. random text. ",
        "paragraph 1 and random text. random text. random text. random text. random text. random text. random text. random text. "
      ]
    }
  ];
}
