import 'package:flutter/material.dart';

class LinkViewVertical extends StatelessWidget {
  final String url;
  final String title;
  final String description;
  final ImageProvider? imageProvider;
  final Function() onTap;
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;
  final bool? showMultiMedia;
  final TextOverflow? bodyTextOverflow;
  final int? bodyMaxLines;
  final int? titleMaxLines;
  final double radius;
  final Color? bgColor;
  final EdgeInsets? imagePadding;
  final EdgeInsets? titlePadding;
  final EdgeInsets? bodyPadding;
  final BoxConstraints? imageConstraints;

  LinkViewVertical({
    Key? key,
    required this.url,
    required this.title,
    required this.description,
    required this.imageProvider,
    required this.onTap,
    this.imagePadding = const EdgeInsets.only(bottom: 15),
    this.titlePadding = const EdgeInsets.fromLTRB(10, 5, 5, 1),
    this.bodyPadding = const EdgeInsets.fromLTRB(10, 0, 5, 5),
    this.titleTextStyle,
    this.bodyTextStyle,
    this.showMultiMedia,
    this.bodyTextOverflow,
    this.bodyMaxLines,
    this.titleMaxLines,
    this.bgColor,
    this.radius = 0, this.imageConstraints
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleTS_ = titleTextStyle ??
        TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        );
    var bodyTS_ = bodyTextStyle ??
        TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        );

    return InkWell(
        onTap: () => onTap(),
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              showMultiMedia!
                  ? Expanded(
                      child: imageProvider == null
                          ? Container(color: bgColor ?? Colors.grey)
                          : Container(
                              padding: imagePadding,
                              constraints: imageConstraints,
                              decoration: BoxDecoration(
                                borderRadius: radius == 0
                                  ? BorderRadius.zero
                                  : BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      topRight: Radius.circular(radius),
                                    ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radius),
                                  topRight: Radius.circular(radius),
                                ),
                                child: Image(
                                  image: imageProvider!,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            )
                    )
                  : SizedBox(height: 5),
              _buildTitleContainer(
                  titleTS_, titleMaxLines),
              _buildBodyContainer(bodyTS_, bodyMaxLines),
            ],
          ),
        ));
  }

  Widget _buildTitleContainer(TextStyle titleTS_, int? maxLines_) {
    return Visibility(
      visible: title.isNotEmpty,
      child: Container(
        padding: titlePadding,
        alignment: Alignment(-1.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: titleTS_,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines_,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContainer(TextStyle bodyTS_, int? maxLines_) {
    return Visibility(
      visible: description.isNotEmpty,
      child: Container(
        padding: bodyPadding,
        alignment: Alignment(-1.0, -1.0),
        child: Text(
          description,
          style: bodyTS_,
          overflow: bodyTextOverflow ?? TextOverflow.ellipsis,
          maxLines: bodyMaxLines ?? maxLines_,
        ),
      ),
    );
  }
}
