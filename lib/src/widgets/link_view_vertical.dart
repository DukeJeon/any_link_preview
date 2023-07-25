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
    this.titleMaxLines,
    this.bgColor,
    this.radius = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var layoutWidth = constraints.biggest.width;
      var layoutHeight = constraints.biggest.height;

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
          child: Column(
            children: <Widget>[
              showMultiMedia!
                  ? Expanded(
                      flex: 2,
                      child: imageProvider == null
                          ? Container(color: bgColor ?? Colors.grey)
                          : Container(
                              padding: EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
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
                  titleTS_, titleMaxLines),
              _buildBodyContainer(bodyTS_, bodyMaxLines),
            ],
          ));
    });
  }

  Widget _buildTitleContainer(TextStyle titleTS_, int? maxLines_) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 5, 1),
      child: Container(
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
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
        child: Container(
          alignment: Alignment(-1.0, -1.0),
          child: Text(
            description,
            style: bodyTS_,
            overflow: bodyTextOverflow ?? TextOverflow.ellipsis,
            maxLines: bodyMaxLines ?? maxLines_,
          ),
        ),
      ),
    );
  }
}
