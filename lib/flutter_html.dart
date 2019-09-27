library flutter_html;

import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:html/dom.dart';

import 'image_properties.dart';

typedef TextStyle LinkStyleGetter(Node link);
typedef String LinkSuffixGetter(String url);

const DEFAULT_LINK_STYLE = const TextStyle(
  decoration: TextDecoration.underline,
  color: Colors.blueAccent,
  decorationColor: Colors.blueAccent,
);

class Html extends StatelessWidget {
  Html({
    Key key,
    @required this.data,
    this.padding,
    this.backgroundColor,
    this.defaultTextStyle,
    this.onLinkTap,
    this.renderNewlines = false,
    this.customRender,
    this.customEdgeInsets,
    this.customTextStyle,
    this.customTextAlign,
    this.blockSpacing = 14.0,
    this.useRichText = true,
    this.onImageError,
    this.getLinkStyle,
    this.shrinkToFit = false,
    this.imageProperties,
    this.onImageTap,
    this.showImages = true,
    this.getLinkSuffix,
  }) : super(key: key);

  final String data;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final TextStyle defaultTextStyle;
  final OnLinkTap onLinkTap;
  final bool renderNewlines;
  final double blockSpacing;
  final bool useRichText;
  final ImageErrorListener onImageError;
  final LinkStyleGetter getLinkStyle;
  final LinkSuffixGetter getLinkSuffix;
  final bool shrinkToFit;

  /// Properties for the Image widget that gets rendered by the rich text parser
  final ImageProperties imageProperties;
  final OnImageTap onImageTap;
  final bool showImages;

  /// Either return a custom widget for specific node types or return null to
  /// fallback to the default rendering.
  final CustomRender customRender;
  final CustomEdgeInsets customEdgeInsets;
  final CustomTextStyle customTextStyle;
  final CustomTextAlign customTextAlign;

  @override
  Widget build(BuildContext context) {
    final double width = shrinkToFit ? null : MediaQuery.of(context).size.width;

    return Container(
      padding: padding,
      color: backgroundColor,
      width: width,
      child: DefaultTextStyle.merge(
        style: defaultTextStyle ?? DefaultTextStyle.of(context).style,
        child: (useRichText)
            ? HtmlRichTextParser(
                shrinkToFit: shrinkToFit,
                onLinkTap: onLinkTap,
                renderNewlines: renderNewlines,
                customEdgeInsets: customEdgeInsets,
                customTextStyle: customTextStyle,
                customTextAlign: customTextAlign,
                html: data,
                onImageError: onImageError,
                getLinkStyle: getLinkStyle,
                getLinkSuffix: getLinkSuffix,
                imageProperties: imageProperties,
                onImageTap: onImageTap,
                showImages: showImages,
              )
            : HtmlOldParser(
                width: width,
                onLinkTap: onLinkTap,
                renderNewlines: renderNewlines,
                customRender: customRender,
                html: data,
                blockSpacing: blockSpacing,
                onImageError: onImageError,
                getLinkStyle: getLinkStyle,
                showImages: showImages,
              ),
      ),
    );
  }
}
