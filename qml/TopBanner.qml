import QtQuick 2.0

Rectangle
{
    property alias text : titleText.text
    width : parent.width
    height : 55
    color : "#e5e5e5"
    Rectangle
    {
        anchors
        {
            top : parent.bottom
            left : parent.left
            right : parent.right
            topMargin : 0
        }
        height : 5
        gradient : Gradient {
            GradientStop {position : 0.0; color : "#aa000000"}
            GradientStop {position : 1.0; color : "#00000000"}
        }
    }

    Text
    {
        id : titleText
        anchors.centerIn: parent
        color : "#101010"
    }
}