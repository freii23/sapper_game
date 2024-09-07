import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Item {
        anchors.fill: parent
        anchors.centerIn: parent
        Grid {
            columns: 7
            rows: 7
            anchors.fill: parent
            //            anchors.margins: 10
            //            anchors.bottomMargin: 10      почему-то не работает
            //            anchors.rightMargin: 10
            spacing: 2
            Repeater

                {
                model: { // пусть будет 7 бомб
                    var s = new Set;
                    while (s.size < 7) {
                        s.add(Math.floor(Math.random() * 49));
                    }

                    var v = new Array(49);
                    for (var i = 0; i < v.length; i++) {
                        if (s.has(i))
                            v[i] = "red"; // if bomb then true
                        else
                            v[i] = "green";
                    }

                    var w = new Array(7);
                    for (var i = 0; i < 7; i++) {
                        w[i] = new Array(7);
                    }
                    for (var i = 0; i < 7; i++) {
                        for (var j = 0; j < 7; j++) {
                            if (v[i + 7*j] === "red")
                                w[i][j] = -1;
                            else {
                                w[i][j] = 0;
                                if (1 <= i && i <= 5 && j === 0) {
                                    for (var k = i - 1; k <= i + 1; k++) {
                                        if (v[k + 7*j] === "red")
                                            w[i][j]++;
                                        if (v[k + 7*j + 7] === "red")
                                            w[i][j]++;
                                    }
                                }
                                else if (i === 0 && 1 <= j && j <= 5) {
                                    for (k = j - 1; k <= j + 1; k++) {
                                        if (v[i + 7*k] === "red")
                                            w[i][j]++;
                                        if (v[i + 7*k + 1] === "red")
                                            w[i][j]++;
                                    }
                                }
                                else if (i === 6 && 1 <= j && j <= 5) {
                                    for (k = j - 1; k <= j + 1; k++) {
                                        if (v[i + 7*k] === "red")
                                            w[i][j]++;
                                        if (v[i + 7*k - 1] === "red")
                                            w[i][j]++;
                                    }
                                }
                                else if (j === 6 && 1 <= i && i <= 5) {
                                    for (k = i - 1; k <= i + 1; k++) {
                                        if (v[k + 7*j] === "red")
                                            w[i][j]++;
                                        if (v[k + 7*j - 7] === "red")
                                            w[i][j]++;
                                    }
                                }




                                else if (i === 0 && j === 0) {
                                    for (k = i; k <= i + 1; k++) {
                                        if (v[k + 7*j] === "red")
                                            w[i][j]++;
                                        if (v[k + 7*j + 7] === "red")
                                            w[i][j]++;
                                    }
                                }
                                else if (i === 6 && j === 0) {
                                    for (k = i - 1; k <= i; k++) {
                                        if (v[k + 7*j] === "red")
                                            w[i][j]++;
                                        if (v[k + 7*j + 7] === "red")
                                            w[i][j]++;
                                    }
                                }
                                else if (i === 0 && j === 6) {
                                    for (k = i; k <= i + 1; k++) {
                                        if (v[k + 7*j] === "red")
                                            w[i][j]++;
                                        if (v[k + 7*j - 7] === "red")
                                            w[i][j]++;
                                    }
                                }
                                else if (i === 6 && j === 6) {
                                    for (k = i - 1; k <= i; k++) {
                                        if (v[k + 7*j] === "red")
                                            w[i][j]++;
                                        if (v[k + 7*j - 7] === "red")
                                            w[i][j]++;
                                    }
                                }




                                else {
                                    for (k = i - 1; k <= i + 1; k++) {
                                        for (var l = j - 1; l <= j + 1; l++) {
                                        if (v[k + 7*l] === "red")
                                            w[i][j]++;
                                        }
                                    }
                                }
                            }
                        }
                    }

                    var a = new Array(49);
                    for (i = 0; i <= 6; i++) {
                        for (j = 0; j <= 6; j++) {
                            a[i + 7*j] = w[i][j];
                        }
                    }

                    return a;
                }

                Rectangle {
                    property bool isBomb: modelData === -1
                    id: rect
                    width: parent.width / 7.0
                    height: parent.height / 7.0
//                    color: modelData > -1 ? "green" : "red"
                    color: "green"
                    Text {
                        id: txt
                        color: "white"
                        font.pixelSize: 48
                        anchors.centerIn: parent
                        text: modelData
                        visible: false
                    }
                    MouseArea {
                        acceptedButtons: Qt.LeftButton |Qt.RightButton
                        anchors.fill: parent
                        onPressed: {
                            if (mouse.button === Qt.RightButton) {
                                if (parent.color == "green")
                                    parent.color = "yellow"
                                else
                                    parent.color = "green"
                            }
                            else if (mouse.button === Qt.LeftButton && parent.color != "yellow") {
                                if (parent.isBomb) {
                                    parent.color = "red"
                                }
                                else {
                                    txt.visible = true

                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
