import QtQuick 2.2

Item
{
    anchors.fill: parent

    ListModel
    {
        id : remote_model
        ListElement
        {
            tabName : "Remote"
            delegateComponent : "RemoteControls.qml"
        }
        ListElement
        {
            tabName : "Playlist"
            delegateComponent : "PlaylistsScreen.qml"
        }
        ListElement
        {
            tabName : "Player"
            delegateComponent : "Player.qml"
        }
    }

    ListView
    {
        id : section_switcher_listview
        height : (mainScreen.mediaPlaying) ? 0 : 50 * mainScreen.dpiMultiplier
        model : remote_model
        orientation : ListView.Horizontal
        interactive: false
        anchors
        {
            left : parent.left
            right : parent.right
            bottom : parent.bottom
        }
        delegate: Component {
            Rectangle
            {
                width : ListView.view.width / 3
                height : ListView.view.height
                visible : height > 0
                color : "#202020"
                Text
                {
                    anchors.centerIn: parent
                    text : model.tabName
                    style: Text.Sunken
                    styleColor: "#ff2200"
                    color : "white"
                    font.family : "Helvetica";
                    font.bold: true
                    font.italic: true
                    font.pointSize: 15 * mainScreen.dpiMultiplier
                }
                Rectangle
                {
                    anchors
                    {
                        left : parent.left
                        right : parent.right
                        bottom : bottom_border.top
                    }
                    height : 2
                    color : "#ff3300"
                    visible: index === remote_listview.currentIndex
                }
                Rectangle
                {
                    id : bottom_border
                    anchors
                    {
                        left : parent.left
                        right : parent.right
                        bottom : parent.bottom
                    }
                    height : 1
                    color : "#040404"
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: remote_listview.positionViewAtIndex(index, ListView.Center)
                }
            }
        }

        Rectangle
        {
            anchors
            {
                bottom : parent.top
                left : parent.left
                right : parent.right
            }
            height : 5
            gradient : Gradient {
                GradientStop {position : 0.0; color : "#aa000000"}
                GradientStop {position : 1.0; color : "#00000000"}
            }
        }
    }

    ListView
    {
        id : remote_listview
        interactive: false
        anchors
        {
            left : parent.left
            right : parent.right
            top : parent.top
            bottom : section_switcher_listview.top
        }
        maximumFlickVelocity: 500
        boundsBehavior: ListView.StopAtBounds
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        model : remote_model
        orientation : ListView.Horizontal
        Component.onCompleted:
        {
            if (mainView.movieToPlay)
                positionViewAtEnd();
        }

        delegate : Component {
            Loader
            {
                width : ListView.view.width
                height : ListView.view.height - 5
                clip : true
                source: model.delegateComponent
            }
        }
    }
}
