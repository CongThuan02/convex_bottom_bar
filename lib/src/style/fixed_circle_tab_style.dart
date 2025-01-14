import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';

/// Convex shape is fixed center with circle.
class FixedCircleTabStyle extends InnerBuilder {
  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Index of the centered convex shape.
  final int convexIndex;

  /// Create style builder
  FixedCircleTabStyle(
      {required List<TabItem> items,
      required Color activeColor,
      required Color color,
      required this.backgroundColor,
      required this.convexIndex})
      : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var c;  
    if (index == convexIndex) {
      c = active ? activeColor : color; // Màu cho icon giữa
    } else {
      c = active ? Colors.blue : color; // Màu riêng cho các icon khác
    }
    var item = items[index];
    var style = ofStyle(context);
    var textStyle = style.textStyle(c, item.fontFamily);

    // Kiểm tra xem có phải là icon giữa không, nếu có thì tạo circle
    if (index == convexIndex) {
      final item = items[index];
      return Container(
        width: 220, // Tăng kích thước chiều rộng
        height: 220, // Tăng kích thước chiều cao
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xffA9C0FF), width: 5),
          color: Color(0xff006AF5),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlendImageIcon(
                active ? item.activeIcon ?? item.icon : item.icon,
                size: 24, // Tăng kích thước biểu tượng
                color: Colors.white,
              ),
              SizedBox(height: 0),
              Text(
                "Đăng tin",
                style: TextStyle(color: Colors.white, fontSize: 12), // Tăng font chữ
              ),
            ],
          ),
        ),
      );
    }

    // Tạo các icon khác với gạch trên đầu khi chọn
    var icon = BlendImageIcon(
      active ? item.activeIcon ?? item.icon : item.icon,
      color: item.blend ? (c) : null,
      size: style.iconSize,
    );

    var children = <Widget>[
      icon,
      Text(
        "${item.title}",
        style: textStyle,
      ),
    ];

    // Tạo hiệu ứng gạch ở trên biểu tượng khi chọn
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
    
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 2, // Độ dày của gạch
                width: 20, // Chiều dài của gạch
                color:active ==true? Colors.blue: Colors.white, // Màu gạch
              ),
            ),
        
            
          ...children,
        ],
      ),
    );
  }

  @override
  bool fixed() {
    return true;
  }
}