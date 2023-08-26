// import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foody/base/custom_loader.dart';
import 'package:foody/base/show_custom_snackbar.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/models/signup_body_model.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/app_text_field.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["t.png", "f.png", "g.png"];
    void _registration(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        // showCustomSnackBar("All went well ", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registation(signUpBody).then((status) {
          if (status.isSuccess) {
            print("success registration");
            Get.offNamed(RouteHelper.getIntitial());
          } else {
            print("failed registerarion");
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeigth * 0.1,
                      ),
                      //app logo
                      Container(
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage: AssetImage("assets/image/sp.jpeg"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      //your email
                      AppTextField(
                          hintText: "Email",
                          icon: Icons.email,
                          textController: emailController),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //your password
                      AppTextField(
                          hintText: "Password",
                          icon: Icons.password_sharp,
                          isObscure: true,
                          textController: passwordController),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //name
                      AppTextField(
                          hintText: "Name",
                          icon: Icons.person,
                          textController: nameController),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //phone
                      AppTextField(
                          hintText: "Phone",
                          icon: Icons.phone,
                          textController: phoneController),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //sign up button
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeigth / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: Colors.amber),
                          child: Center(
                              child: BigText(
                            text: "Sign up",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      //tagline
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Have an account already?",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20))),
                      SizedBox(
                        height: Dimensions.screenHeigth * 0.05,
                      ),
                      //sign up options
                      RichText(
                          text: TextSpan(
                              text: "Sign up using one of following methods",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16))),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius30,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                        "assets/image/" + signUpImages[index]),
                                  ),
                                )),
                      )
                    ],
                  ),
                )
              : CustomLoader();
        }));
  }
}