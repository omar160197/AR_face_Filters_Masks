import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'package:avatar_view/avatar_view.dart';
import 'dart:io' as platform;

class CameraWithMaskFiltersScreen extends StatefulWidget {
  @override
  _CameraWithMaskFiltersScreenState createState() =>
      _CameraWithMaskFiltersScreenState();
}

class _CameraWithMaskFiltersScreenState
    extends State<CameraWithMaskFiltersScreen> {
  late CameraDeepArController cameraDeepArController;

  String platformVision = "UnKnown";
  int CurrentPage = 0;
  final vp = PageController(viewportFraction: 0.24);
  Effects currentEffects = Effects.none;
  Filters currentFilters = Filters.none;
  Masks currentMask = Masks.none;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            //Deep Ar Camera
            CameraDeepAr(
              onCameraReady: (isReady) {
                platformVision = "Camera Status $isReady";
                print(platformVision);
                setState(() {});
              },
              onImageCaptured: (path) {
                platformVision = "Image saved at $path";
                print(platformVision);
                setState(() {});
              },
              androidLicenceKey:
                  "1bde0e46df918c64ed72791c881a31c60e9f98835faa067ba7b018e3cb73b1b65423237eb5b3d40c",
              cameraDeepArCallback: (c) async {
                cameraDeepArController = c;
                setState(() {});
              },
            ),
            //Face mask Filters && Image Buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 28.0),
                      child: FlatButton(
                        child: Icon(Icons.camera_enhance),
                        color: Colors.white54,
                        padding: EdgeInsets.all(15.0),
                        onPressed: () {
                          if (null == cameraDeepArController)
                          {
                            return;
                          }
                          cameraDeepArController.snapPhoto();
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        //page = index
                        children: List.generate(8, (page) {
                          bool active = CurrentPage == page;
                          return platform.Platform.isIOS
                              ? GestureDetector(
                                  onTap: () {
                                    CurrentPage = page;
                                    cameraDeepArController.changeMask(page);
                                    setState(() {});
                                  },
                                  child: AvatarView(
                                    radius: active ? 65 : 30,
                                    borderColor: Colors.yellow,
                                    borderWidth: 2,
                                    isOnlyText: false,
                                    avatarType: AvatarType.CIRCLE,
                                    backgroundColor: Colors.red,
                                    imagePath:
                                        "assets/ios/${page.toString()}.jpg",
                                    placeHolder: Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    errorWidget: Container(
                                      child: Icon(
                                        Icons.error,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    CurrentPage = page;
                                    cameraDeepArController.changeMask(page);
                                    setState(() {});
                                  },
                                  child: AvatarView(
                                    radius: active ? 45 : 20,
                                    borderColor: Colors.yellow,
                                    borderWidth: 2,
                                    isOnlyText: false,
                                    avatarType: AvatarType.CIRCLE,
                                    backgroundColor: Colors.red,
                                    imagePath:
                                        "assets/android/${page.toString()}.jpg",
                                    placeHolder: Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    errorWidget: Container(
                                      child: Icon(
                                        Icons.error,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
