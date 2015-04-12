<%
' Create the connection object to the Excel workbook defined in the current_inc.asp file.

	Set xConn = server.CreateObject("ADODB.Connection")
	xConn.Open "Driver={Microsoft Excel Driver (*.xls)};" & _
           "Dbq="  & gWebRoot & "\data\" & gBalanceSheet & ";" & _
           "DefaultDir=" & gWebRoot 
%>
<%
'Create a recordset from the named range for the "BalanceDate" created in the workbook, then move to the first record.
   strSELECT = "SELECT * from `balanceDate`"  
   Set dateRS = Server.CreateObject("ADODB.Recordset")  
   dateRS.Open strSELECT, xConn
   dateRS.MoveFirst

%>
<!-- Put the revised date on the page, then close the recordset -->
<html>
<div class="infobox">
	<h2 class="title">Balance Sheet <%= dateRS(0) %></h2>
<% 
   dateRS.Close
%>


<table class="datatable" style="margin-left:10px">
<tr class="titleRow">

<%
'<th rowspan="3">Player</th>
'<th rowspan="3">Amount Paid</th>
'<th rowspan="2">Dues</th>
'<th>4/18/10</th>
'<th>5/1/10</th>
'<th>5/15/10</th>
'<th>5/22/10</th>
'<th>6/6/10</th>
'<th>6/27/10</th>
'<th>7/10/10</th>
'<th>7/18/10</th>
'<th>8/1/10</th>
'<th>8/22/10</th>
'<th>9/11/10</th>
'<th>9/25/10</th>
'<th rowspan="2">Balance</th>
'</tr>
'<tr class="titleRow">
'<th>Brookdale</th>
'<th>Meadowpark</th>
'<th>Elk Run</th>
'<th>Fort Lewis</th>
'<th>Capitol City</th>
'<th>Auburn</th>
'<th>Battle Creek</th>
'<th>Harbor Pointe</th>
'<th>Mt Si</th>
'<th>Elk Run</th>
'<th>High Cedars</th>
'<th>Hawks Prairie, The Links</th>
'</tr>
'<tr class="titleRow">
'<th>$125</th>
'<th>$32</th>
'<th>$35</th>
'<th>$42</th>
'<th>$32</th>
'<th>$34</th>
'<th>$39</th>
'<th>$38</th>
'<th>$72</th>
'<th>$49</th>
'<th>$42</th>
'<th>$43</th>
'<th>$53</th>
'<th>$636</th>
'</tr>
%>


<%
'Create a recordset from the named range for the "BalanceHeader" created in the workbook, then move to the first record.
   strSELECT = "SELECT * from `BalanceHeader`"  
   Set dateRS = Server.CreateObject("ADODB.Recordset")  
   dateRS.Open strSELECT, xConn
   dateRS.MoveFirst

' Loop through rows of the recordset
   hasOne = false
   While Not dateRS.EOF 
      if (hasOne) then
         Response.Write "</tr>"
         hasOne = true
      end if
      Response.Write "</tr><tr class=""TitleRow"">"  
     
' Loop through columnus in the current row.
     For i = 0 to (dateRS.Fields.Count - 1)  
       if (isNull(dateRS(i))) then
          Response.Write "<td>" & "&nbsp;" &"</td>" 
       else
          If i = 0 then 
             Response.Write "<td>" & dateRS(i) &"</td>" 
          else
             Response.Write "<td style=""white-space: nowrap"" align=""center"">" & dateRS(i) &"</td>" 
          end if
        end if
     Next  

'Move to the next row.  
     dateRS.MoveNext 

   Wend  

'   Response.Write "</tr></table>" 
%>

<%
'Create a recordset from the named range for the "balanceInfo" created in the workbook, then move to the first record.
   strSELECT = "SELECT * from `balanceInfo`"  
   Set objRS = Server.CreateObject("ADODB.Recordset")  
   objRS.Open strSELECT, xConn  
%>


<%
   objRS.MoveFirst  
   
   'Print out the field names using some of the methods and properties  
   ' of the Recordset object.  
   hasOne = false
   light = false
   'While not at the end of the records in the set... 
   While Not objRS.EOF 
	if (hasOne) then
		Response.Write "</tr>"
		hasOne = true
	end if
		
     
     Response.Write "</tr><tr class=""" & GetRowStyle(light) &""">"  

     'For each column in the current row...  
     For i = 0 to (objRS.Fields.Count - 1)  
       ' write out the data in the field. 
       if (isNull(objRS(i))) then
          Response.Write "<td>" & "&nbsp;" &"</td>" 
       else
          If i = 0 then 
             Response.Write "<td>" & objRS(i) &"</td>" 
          else
             Response.Write "<td style=""white-space: nowrap"" align=""center"">$" & objRS(i) &"</td>" 
          end if
        end if
     Next  

     'Move to the next row.  
     light = not light
     objRS.MoveNext  

   Wend  

   Response.Write "</tr></table>" 
%>
</div>
</html>
<% xConn.close %>
