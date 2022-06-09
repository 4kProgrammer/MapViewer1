import QtQuick 2.14
import QtQuick.Controls 2.14
import "qmlComponent/"

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Stack")

    property color backGroundColor : "#394454"
    property color mainAppColor: "#6fda9c"
    property color mainTextCOlor: "#f0f0f0"
    property color popupBackGroundColor: "#b44"
    property color popupTextCOlor: "#ffffff"

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: rootWindow.width * 0.66
        height: rootWindow.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1")
                width: parent.width
                onClicked: {
                    stackView.push("Page1.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2")
                width: parent.width
                onClicked: {
                    stackView.push("Page2.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomePage.qml"
        anchors.fill: parent
    }
    AlertMessage{
        id:messageDisplay
        signal showAlert(message: string, closeAfterFewSec: bool, type: int);

        Connections {
            target: messageDisplay
            function onShowAlert(message,closeAfterFewSec,type) {
                messageDisplay.alertType=type;
                messageDisplay.alertMessage=message;
                messageDisplay.alertCloseAfterFewSec=true;
                messageDisplay.alertOpen();
                console.log("showMessage");

            }
        }
    }

}
