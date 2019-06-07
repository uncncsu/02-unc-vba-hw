Attribute VB_Name = "Module1"


Sub StockData()

    ' LOOP THROUGH ALL SHEETS

Dim WS As Worksheet

    For Each WS In ActiveWorkbook.Worksheets

    WS.Activate

        '  Last Row

        LastRow = WS.Cells(Rows.Count, 1).End(xlUp).Row



       '  Addition Heading for summary

        Cells(1, "I").Value = "Ticker"

        Cells(1, "J").Value = "Yearly Change"

        Cells(1, "K").Value = "Percent Change"

        Cells(1, "L").Value = "Total Stock Volume"

        'Create Variable to hold Value

  

        Dim Close_Price As Double
        
        Dim Open_price As Double
        
        Dim Percent_Change As Double


        Dim Volume As Double

        Volume = 0

        Dim Row As Double

        Row = 2


        Dim Yearly_Change As Double

        Dim Ticker_Name As String

        Dim Column As Integer

        Column = 1

        Dim i As Long

        

        'Set Initial Open Price

        Open_price = Cells(2, Column + 2).Value

         ' Loop through all ticker symbol

        

        For i = 2 To LastRow

         ' Check if we are still within the same ticker symbol, if it is not...

            If Cells(i + 1, Column).Value <> Cells(i, Column).Value Then

                ' Set Ticker name

                Ticker_Name = Cells(i, Column).Value

                Cells(Row, Column + 8).Value = Ticker_Name

                ' Set Close Price

                Close_Price = Cells(i, Column + 5).Value

                ' Add Yearly Change

                Yearly_Change = Close_Price - Open_price

                Cells(Row, Column + 9).Value = Yearly_Change

                ' Add Percent Change

                If (Open_price = 0 And Close_Price = 0) Then

                    Percent_Change = 0

                ElseIf (Open_price = 0 And Close_Price <> 0) Then

                    Percent_Change = 1

                Else

                    Percent_Change = Yearly_Change / Open_price

                    Cells(Row, Column + 10).Value = Percent_Change

                    Cells(Row, Column + 10).NumberFormat = "0.00%"

                End If

                ' Add Total Volumn

                Volume = Volume + Cells(i, Column + 6).Value

                Cells(Row, Column + 11).Value = Volume

                ' Add one to the summary table row

                Row = Row + 1

                ' reset the Open Price

                Open_price = Cells(i + 1, Column + 2)

                ' reset the Volumn Total

                Volume = 0

            'if cells are the same ticker

            Else

                Volume = Volume + Cells(i, Column + 6).Value

            End If

        Next i

        

        ' Determine the Last Row of Yearly Change per WS

        YCLastRow = WS.Cells(Rows.Count, Column + 8).End(xlUp).Row

        ' Set the Cell Colors

        For j = 2 To YCLastRow

            If (Cells(j, Column + 9).Value > 0 Or Cells(j, Column + 9).Value = 0) Then

                Cells(j, Column + 9).Interior.ColorIndex = 10

            ElseIf Cells(j, Column + 9).Value < 0 Then

                Cells(j, Column + 9).Interior.ColorIndex = 3

            End If

        Next j

        

        ' Set  the column for Greatest % Increase, % Decrease, and Total Volume

        Cells(2, Column + 14).Value = "Greatest % Increase"

        Cells(3, Column + 14).Value = "Greatest % Decrease"

        Cells(4, Column + 14).Value = "Greatest Total Volume"

        Cells(1, Column + 15).Value = "Ticker"

        Cells(1, Column + 16).Value = "Value"
        

    Next WS

        

End Sub
