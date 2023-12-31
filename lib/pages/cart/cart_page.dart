import 'package:flutter/material.dart';
import 'package:foody/base/no_data_page.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/controllers/popular_product_controller.dart';
import 'package:foody/controllers/recommended_product_controller.dart';
// import 'package:foody/pages/home/main_food_page.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/utils/app_constants.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/app_icon.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getIntitial());
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: Colors.amber,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20 * 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getIntitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: Colors.amber,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: Colors.amber,
                    iconSize: Dimensions.iconSize24,
                  )
                ],
              )),
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                          margin: EdgeInsets.only(top: Dimensions.height20),
                          // color: Colors.red,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                                builder: (CartController) {
                              var _cartList = CartController.getItems;
                              return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      width: double.maxFinite,
                                      height: Dimensions.height20 * 5,
                                      child: Row(children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      popularIndex, "home"));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar("History product",
                                                    "Product review is not available for history product!",
                                                    backgroundColor:
                                                        Colors.amber,
                                                    colorText: Colors.white);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        "cartPage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10,
                                                right: Dimensions.width10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppConstants
                                                                .BASE_URL +
                                                            AppConstants
                                                                .UPLOAD_URL +
                                                            CartController
                                                                .getItems[index]
                                                                .img!))),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          width: Dimensions.width20,
                                          height: Dimensions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: CartController
                                                    .getItems[index].name!,
                                                color: Colors.grey[700],
                                              ),
                                              SmallText(text: "spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: "\$" +
                                                        CartController
                                                            .getItems[index]
                                                            .price
                                                            .toString(),
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            Dimensions.height10,
                                                        bottom:
                                                            Dimensions.height10,
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                    ),
                                                    child: Row(children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          CartController
                                                              .addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Dimensions.width10 /
                                                                2,
                                                      ),
                                                      BigText(
                                                          text: _cartList[index]
                                                              .quantity
                                                              .toString()),
                                                      SizedBox(
                                                        width:
                                                            Dimensions.width10 /
                                                                2,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          CartController
                                                              .addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                      ]),
                                    );
                                  });
                            }),
                          )))
                  : NoDataPage(text: "Your cart is Empty, Add First!");
            },
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.height20,
              right: Dimensions.height20),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 241, 241),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.height20 * 2),
                  topRight: Radius.circular(Dimensions.height20 * 2))),
          child: cartController.getItems.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height15,
                          bottom: Dimensions.height15,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Row(children: [
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        BigText(
                            text:
                                "\$ " + cartController.totalAmount.toString()),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userLoggedIn()) {
                          cartController.addToHistory();
                        } else {
                          Get.toNamed(RouteHelper.getSignInPage());
                        } //popularProduct.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height15,
                            bottom: Dimensions.height15,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: BigText(
                          text: "Check Out",
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.greenAccent),
                      ),
                    )
                  ],
                )
              : Container(),
        );
      }),
    );
  }
}
