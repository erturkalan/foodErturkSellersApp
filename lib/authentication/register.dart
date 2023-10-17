import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fooderturk_sellers_app/widgets/custom_text_field.dart';
import 'package:fooderturk_sellers_app/widgets/error_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Position? position;
  List<Placemark>? placeMarks;

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position newPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        position = newPosition;
        placeMarks = await placemarkFromCoordinates(
            position!.latitude, position!.longitude);

        Placemark pMark = placeMarks![0];

        String completeAddress =
            "${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}";

        locationController.text = completeAddress;
      } else {
        _showMyDialog("Location is not available");
      }
    }
  }

  Future<void> _showMyDialog(String alertText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ErrorDialog(errorMessage: alertText);
      },
    );
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      _showMyDialog("Please select an image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile == null
                    ? null
                    : FileImage(File(imageXFile!.path)),
                child: imageXFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: nameController,
                        iconData: Icons.person,
                        hintText: "Name",
                        isObscure: false),
                    CustomTextField(
                        controller: emailController,
                        iconData: Icons.email,
                        hintText: "Email",
                        isObscure: false),
                    CustomTextField(
                        controller: passwordController,
                        iconData: Icons.lock,
                        hintText: "Password",
                        isObscure: false),
                    CustomTextField(
                        controller: confirmPasswordController,
                        iconData: Icons.lock,
                        hintText: "Confirm Password",
                        isObscure: false),
                    CustomTextField(
                        controller: phoneController,
                        iconData: Icons.phone,
                        hintText: "Phone",
                        isObscure: false),
                    CustomTextField(
                      controller: locationController,
                      iconData: Icons.my_location,
                      hintText: "Cafe/Restaurant Address",
                      isObscure: false,
                      enabled: false,
                    ),
                    SizedBox(
                        width: 320,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            getCurrentLocation();
                          },
                          icon: const Icon(Icons.location_on,
                              color: Colors.white),
                          label: const Text(
                            "Get my Current Location",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ))
                  ],
                )),
            const SizedBox(
              height: 26,
            ),
            ElevatedButton(
              onPressed: () {
                formValidation();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 12)),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
