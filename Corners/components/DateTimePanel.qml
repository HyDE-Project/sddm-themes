import QtQuick 2.12
import QtQuick.Controls 2.12

Column {
    spacing: 0
    
    Text {
        id: dateLabel

        anchors.right: parent.right
        opacity: config.DateOpacity

        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.DateSize
        font.bold: config.DateIsBold == "true" ? true : false
        color: config.DateColor
                
        // A blank DateFormat/TimeFormat in theme.conf means "follow the system
        // locale"; Qt would render a blank format as an empty string.
        function updateDate() {
            text = new Date().toLocaleDateString(Qt.locale(), config.DateFormat ? config.DateFormat : Locale.LongFormat)
        }
    }

    Text {
        id: timeLabel

        anchors.right: parent.right
        opacity: config.TimeOpacity

        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.TimeSize
        font.bold: config.TimeIsBold == "true" ? true : false
        color: config.TimeColor

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(), config.TimeFormat ? config.TimeFormat : Locale.ShortFormat)
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            timeLabel.updateTime()
            dateLabel.updateDate()
        }
    }

    Component.onCompleted: {
        timeLabel.updateTime()
        dateLabel.updateDate()
    }
}
