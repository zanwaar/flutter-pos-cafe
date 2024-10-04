import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_app/core/constants/variables.dart';
import 'package:flutter_pos_app/core/extensions/int_ext.dart';
import 'package:flutter_pos_app/data/models/response/product_response_model.dart';
import 'package:flutter_pos_app/presentation/home/bloc/checkout/checkout_bloc.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  final VoidCallback onCartButton;

  const ProductCard({
    super.key,
    required this.data,
    required this.onCartButton,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1, color: Color.fromARGB(255, 29, 12, 12)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                // padding: const EdgeInsets.all(0.0),
                // decoration: BoxDecoration(
                //   // shape: BoxShape.circle,
                //   borderRadius: BorderRadius.circular(8),
                //   color: AppColors.disabled.withOpacity(0.4),
                // ),
                child: ClipRRect(
                  // borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                  child: CachedNetworkImage(
                    // width: double.infinity,
                    // height: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: '${Variables.imageBaseUrl}${data.image}',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.food_bank_outlined,
                      size: 80,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                data.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1, // Menentukan maksimal dua baris teks
                overflow: TextOverflow
                    .ellipsis, // Menampilkan tanda elipsis (...) jika teks melebihi dua baris
              ),
              const SpaceHeight(8.0),
              Text(
                data.category,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                ),
              ),
              const SpaceHeight(8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      data.price.currencyFormatRp,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<CheckoutBloc>()
                          .add(CheckoutEvent.addCheckout(data));
                    },
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            color: Colors.black),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14.0,
                        ) //Assets.icons.orders.svg(),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox(),
              success: (products, qty, price) {
                if (qty == 0) {
                  return const SizedBox();
                }
                return products.any((element) => element.product == data)
                    ? products
                                .firstWhere(
                                    (element) => element.product == data)
                                .quantity >
                            0
                        ? Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              backgroundColor: AppColors.primary,
                              child: Text(
                                products
                                    .firstWhere(
                                        (element) => element.product == data)
                                    .quantity
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : const SizedBox()
                    : const SizedBox();
              },
            );
          },
        ),
      ],
    );
  }
}
