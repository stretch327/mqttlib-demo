#tag Window
Begin Window Window1
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   422
   ImplicitInstance=   True
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   687433727
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   True
   Width           =   600
   Begin MQTTLib.ClientConnection MQTTClient
      Connected       =   False
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   1
      TabPanelIndex   =   0
   End
   Begin TextArea LogArea
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   350
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "Courier"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   False
      UnicodeMode     =   0
      UseFocusRing    =   False
      Visible         =   True
      Width           =   560
   End
   Begin PushButton DisconnectButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Disconnect"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   475
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   382
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin PushButton SendButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Publish"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   382
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  // set the verbose mode
		  MQTTLib.VerboseMode = True
		  
		  // Setup the socket
		  Dim theSocket As New TCPSocket
		  theSocket.Address = "test.mosquitto.org"
		  theSocket.Port = MQTTLib.kDefaultPort
		  
		  // Setup the connection options
		  Dim theConnectOptions As New MQTTLib.OptionsCONNECT
		  
		  theConnectOptions.KeepAlive = 30
		  theConnectOptions.ClientID = "zdEdLRXojoTest"
		  theConnectOptions.PasswordFlag = False
		  theConnectOptions.CleanSessionFlag = True
		  theConnectOptions.UsernameFlag = False
		  
		  theConnectOptions.WillFlag = True
		  theConnectOptions.WillTopic = "test/zd/world"
		  theConnectOptions.WillMessage = "MQTTLib was here!"
		  theConnectOptions.WillQoS = MQTTLib.QoS.AtLeastOnceDelivery
		  
		  Me.MQTTClient.Setup New MQTTLib.TCPSocketAdapter( theSocket ), theConnectOptions
		  Me.MQTTClient.Connect
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Log(inLogMessage As String = "")
		  Self.LogArea.AppendText DateTime.Now.SQLDateTime + " - " + inLogMessage + EndOfLine
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SubscribeTopics()
		  Dim theOptions As New MQTTLib.OptionsSUBSCRIBE
		  
		  theOptions.AddTopic "$SYS/broker/messages/#", MQTTLib.QoS.ExactlyOnceDelivery
		  theOptions.AddTopic "test/#", MQTTLib.QoS.ExactlyOnceDelivery
		  theOptions.AddTopic "test/zd/world", MQTTLib.QoS.ExactlyOnceDelivery
		  
		  Self.MQTTClient.Subscribe theOptions
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Licensing
		MIT License
		
		Copyright (c) 2017 Za'atar Digital
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
	#tag EndNote


#tag EndWindowCode

#tag Events MQTTClient
	#tag Event
		Sub BrokerConnected(inSessionPresentFlag As Boolean)
		  Self.Log "Connected to Broker. Session Present flag is " + If( inSessionPresentFlag, "True", "False" )
		  
		  Timer.CallLater 1000, AddressOf Self.SubscribeTopics
		End Sub
	#tag EndEvent
	#tag Event
		Sub BrokerConnectionRejected(inErrorCode As Integer)
		  Self.Log "Connection Rejected - " + Str( Integer( inErrorCode ) )
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(inMessage As String, inError As MQTTLib.Error)
		  Self.Log inMessage + " !!! Connection closed !!!"
		End Sub
	#tag EndEvent
	#tag Event
		Sub ReceivedPINGRESP()
		  Self.Log "PINGRESP received"
		End Sub
	#tag EndEvent
	#tag Event
		Sub ReceivedPUBACK(inPacketID As UInt16)
		  Self.Log "PUBACK received with packet id #" + Str( inPacketID )
		End Sub
	#tag EndEvent
	#tag Event
		Sub ReceivedPUBCOMP(inPacketID As UInt16)
		  Self.Log "PUBCOMP received with packet id #" + Str( inPacketID )
		End Sub
	#tag EndEvent
	#tag Event
		Function ReceivedPUBLISH(inPublish As MQTTLib.OptionsPUBLISH) As Boolean
		  Self.Log "PUBLISH received #" + Str( inPublish.PacketID ) + " & QoS:" + MQTTLib.QoSToString( inPublish.QoSLevel ) + EndOfLine _
		  + "Topic: " + inPublish.TopicName + EndOfLine + "Message: " + inPublish.Message + EndOfLine
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ReceivedPUBREC(inPacketID As UInt16) As Boolean
		  Self.Log "PUBREC received with packet id #" + Str( inPacketID )
		End Function
	#tag EndEvent
	#tag Event
		Function ReceivedPUBREL(inPacketID As UInt16) As Boolean
		  Self.Log "PUBREL received with packet id #" + Str( inPacketID )
		End Function
	#tag EndEvent
	#tag Event
		Sub ReceivedSUBACK(inSUBACKData As MQTTLib.OptionsSUBACK)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DisconnectButton
	#tag Event
		Sub Action()
		  Self.MQTTClient.Disconnect
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SendButton
	#tag Event
		Sub Action()
		  // Send a hello world message
		  
		  Dim thePacket As New MQTTLib.OptionsPUBLISH
		  
		  thePacket.TopicName = "test/zd/world"
		  thePacket.QoSLevel = MQTTLib.QoS.AtLeastOnceDelivery
		  thePacket.Message = "Hello World! " + DateTime.Now.SQLDateTime + " - " + MQTTLib.QoSToString( thePacket.QoSLevel )
		  thePacket.RETAINFlag = True
		  
		  Self.MQTTClient.Publish( thePacket )
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
