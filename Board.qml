import QtQuick 2.15

Item {
    Grid {
        columns: 7
        rows: 7
        anchors.fill: parent
        //            anchors.margins: 10
        //            anchors.bottomMargin: 10      почему-то не работает
        //            anchors.rightMargin: 10
        spacing: 2
        Repeater {
            model: {
                var v = new Array(49);
                for (var i = 0; i < v.length; i++) {
                }
                return v;
            }
            Rectangle {
                width: parent.width / 7.0
                height: parent.height / 7.0
                color: "blue"
                Text {
                    color: "white"
                    font.pixelSize: 48
                    anchors.centerIn: parent
                    text: index
                }
            }
        }
    }
}
