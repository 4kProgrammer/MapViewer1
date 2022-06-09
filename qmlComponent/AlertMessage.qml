import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
Item {
    id:root
    function alertOpen(){
        popup.open();
    }
    property string alertMessage: ""
    property int alertType: 0
    property bool alertCloseAfterFewSec: true
    property color alertColor: {
        switch (alertType){
        case 1:
            return "green";
        case 2:
            return "red";
        default:
            return "yellow";
        }
    }


    //Popup to show messages or warnings on the bottom postion of the screen
    Popup {
        id: popup
        background: Rectangle {
            implicitWidth: rootWindow.width
            implicitHeight: 60
            color: alertColor
        }
        y: (rootWindow.height - 60)
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        Text {
            id: message
            anchors.centerIn: parent
            font.pointSize: 12
            color: popupTextCOlor
            text: alertMessage
        }
        onOpened: popupClose.start()
    }
    // Popup will be closed automatically in 2 seconds after its opened
    Timer {
        id: popupClose
        interval: 3000
        onTriggered: {
            if(alertCloseAfterFewSec){
                popup.close();
            }
        }
    }
}
