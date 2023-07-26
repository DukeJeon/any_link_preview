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
  final double radius;
  final Color? bgColor;
  final EdgeInsets? imagePadding;
  final EdgeInsets? titlePadding;
  final EdgeInsets? bodyPadding;
  final Border? border;
  final Gradient? gradient;

  LinkViewVertical({
    Key? key,
    required this.url,
    required this.title,
    required this.description,
    required this.imageProvider,
    required this.onTap,
    this.titleTextStyle,
    this.bodyTextStyle,
    this.showMultiMedia,
    this.bodyTextOverflow,
    this.bodyMaxLines,
    this.bgColor,
    this.radius = 0,
    this.imagePadding = const EdgeInsets.only(bottom: 15),
    this.titlePadding = const EdgeInsets.fromLTRB(10, 5, 5, 1),
    this.bodyPadding = const EdgeInsets.fromLTRB(10, 0, 5, 5),
    this.border,
    this.gradient,
  }) : super(key: key);

  double computeTitleFontSize(double height) {
    var size = height * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  int computeTitleLines(layoutHeight, layoutWidth) {
    return layoutHeight - layoutWidth < 50 ? 1 : 2;
  }

  int? computeBodyLines(layoutHeight) {
    return layoutHeight ~/ 60 == 0 ? 1 : layoutHeight ~/ 60;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var layoutWidth = constraints.biggest.width;
      var layoutHeight = constraints.biggest.height;

      var titleTS_ = titleTextStyle ??
          TextStyle(
            fontSize: computeTitleFontSize(layoutHeight),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          );
      var bodyTS_ = bodyTextStyle ??
          TextStyle(
            fontSize: computeTitleFontSize(layoutHeight) - 1,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          );

      return InkWell(
          onTap: () => onTap(),
          child: Column(
            children: <Widget>[
              showMultiMedia!
                  ? Expanded(
                      child: imageProvider == null
                        ? Container(color: bgColor ?? Colors.grey)
                        : Container(
                            padding: imagePadding,
                            decoration: BoxDecoration(
                              border: border,
                              gradient: gradient,
                              borderRadius: radius == 0
                                  ? BorderRadius.zero
                                  : BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      topRight: Radius.circular(radius),
                                    ),
                              image: DecorationImage(
                                image: imageProvider!,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                    )
                  : SizedBox(height: 5),
              _buildTitleContainer(
                  titleTS_, computeTitleLines(layoutHeight, layoutWidth)),
              _buildBodyContainer(bodyTS_, computeBodyLines(layoutHeight)),
            ],
          ));
    });
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
