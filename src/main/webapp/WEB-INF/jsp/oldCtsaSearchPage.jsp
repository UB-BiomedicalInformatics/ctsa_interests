<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="java.util.Map.Entry"%>
<%@ page import="java.util.StringTokenizer"%>

<jsp:useBean id="ResearcherListMap" scope="request"
	class="java.util.HashMap" />	
<jsp:useBean id="SnomedInfoListMap" scope="request"
	class="java.util.HashMap" />
	

<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1256">
<title>CTSA</title>
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<link href="css/interesttooltip.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.form-group-header {
	margin-left: auto;
	height: 30px;
}

.panel-heading {
	background-color: royalblue !important
}

.panel-heading1 {
	background-color: white !important
}

.panel-body {
	background-color: steelblue !important
}

.panel-body1 {
	background-color: white !important;
	height: 570px;
}

.col-sm-2,.control-label {
	margin-left: 30%;
}

.col-sm-4 {
	margin-right: 30%;
}

td {
	max-height: 150px;
	overflow-y: auto
}

.btn,.btn-large,.btn,.btn-success,.btn-lg,.btn-block {
	margin-left: 25%;
}

.form-group label,.form-group input {
	display: inline-block;
}
#tfheader{
		background-color:#c3dfef;
	}
	#tfnewsearch{
		float: right;
		padding:20px;
	}
	.tftextinput{
		margin: 0;
		padding: 5px 15px;
		font-family: Arial, Helvetica, sans-serif;
		font-size:14px;
		border:1px solid #0076a3; border-right:0px;
		border-top-left-radius: 5px 5px;
		border-bottom-left-radius: 5px 5px;
	}
	.tfbutton {
		margin: 0;
		padding: 5px 15px;
		font-family: Arial, Helvetica, sans-serif;
		font-size:14px;
		outline: none;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		color: #ffffff;
		border: solid 1px #0076a3; border-right:0px;
		background: #0095cd;
		background: -webkit-gradient(linear, left top, left bottom, from(#00adee), to(#0078a5));
		background: -moz-linear-gradient(top,  #00adee,  #0078a5);
		border-top-right-radius: 5px 5px;
		border-bottom-right-radius: 5px 5px;
	}
	.tfbutton:hover {
		text-decoration: none;
		background: #007ead;
		background: -webkit-gradient(linear, left top, left bottom, from(#0095cc), to(#00678e));
		background: -moz-linear-gradient(top,  #0095cc,  #00678e);
	}
	/* Fixes submit button height problem in Firefox */
	.tfbutton::-moz-focus-inner {
	  border: 0;
	}
	.tfclear{
		clear:both;
	}
	/**
 * Tooltip Styles
 */

/* Base styles for the element that has a tooltip */
[data-tooltip],
.tooltip {
  position: relative;
  cursor: pointer;
}

/* Base styles for the entire tooltip */
[data-tooltip]:before,
[data-tooltip]:after,
.tooltip:before,
.tooltip:after {
  position: absolute;
  visibility: hidden;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
  filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
  opacity: 0;
  -webkit-transition: 
      opacity 0.2s ease-in-out,
        visibility 0.2s ease-in-out,
        -webkit-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
    -moz-transition:    
        opacity 0.2s ease-in-out,
        visibility 0.2s ease-in-out,
        -moz-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
    transition:         
        opacity 0.2s ease-in-out,
        visibility 0.2s ease-in-out,
        transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
  -webkit-transform: translate3d(0, 0, 0);
  -moz-transform:    translate3d(0, 0, 0);
  transform:         translate3d(0, 0, 0);
  pointer-events: none;
}

/* Show the entire tooltip on hover and focus */
[data-tooltip]:hover:before,
[data-tooltip]:hover:after,
[data-tooltip]:focus:before,
[data-tooltip]:focus:after,
.tooltip:hover:before,
.tooltip:hover:after,
.tooltip:focus:before,
.tooltip:focus:after {
  visibility: visible;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
  filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=100);
  opacity: 1;
}

/* Base styles for the tooltip's directional arrow */
.tooltip:before,
[data-tooltip]:before {
  z-index: 1001;
  border: 6px solid transparent;
  background: transparent;
  content: "";
}

/* Base styles for the tooltip's content area */
.tooltip:after,
[data-tooltip]:after {
  z-index: 1000;
  padding: 8px;
  width: 160px;
  background-color: #000;
  background-color: hsla(0, 0%, 20%, 0.9);
  color: #fff;
  content: attr(data-tooltip);
  font-size: 14px;
  line-height: 1.2;
}

/* Directions */

/* Top (default) */
[data-tooltip]:before,
[data-tooltip]:after,
.tooltip:before,
.tooltip:after,
.tooltip-top:before,
.tooltip-top:after {
  bottom: 100%;
  left: 50%;
}

[data-tooltip]:before,
.tooltip:before,
.tooltip-top:before {
  margin-left: -6px;
  margin-bottom: -12px;
  border-top-color: #000;
  border-top-color: hsla(0, 0%, 20%, 0.9);
}

/* Horizontally align top/bottom tooltips */
[data-tooltip]:after,
.tooltip:after,
.tooltip-top:after {
  margin-left: -80px;
}

[data-tooltip]:hover:before,
[data-tooltip]:hover:after,
[data-tooltip]:focus:before,
[data-tooltip]:focus:after,
.tooltip:hover:before,
.tooltip:hover:after,
.tooltip:focus:before,
.tooltip:focus:after,
.tooltip-top:hover:before,
.tooltip-top:hover:after,
.tooltip-top:focus:before,
.tooltip-top:focus:after {
  -webkit-transform: translateY(-12px);
  -moz-transform:    translateY(-12px);
  transform:         translateY(-12px); 
}

/* Left */
.tooltip-left:before,
.tooltip-left:after {
  right: 100%;
  bottom: 50%;
  left: auto;
}

.tooltip-left:before {
  margin-left: 0;
  margin-right: -12px;
  margin-bottom: 0;
  border-top-color: transparent;
  border-left-color: #000;
  border-left-color: hsla(0, 0%, 20%, 0.9);
}

.tooltip-left:hover:before,
.tooltip-left:hover:after,
.tooltip-left:focus:before,
.tooltip-left:focus:after {
  -webkit-transform: translateX(-12px);
  -moz-transform:    translateX(-12px);
  transform:         translateX(-12px); 
}

/* Bottom */
.tooltip-bottom:before,
.tooltip-bottom:after {
  top: 100%;
  bottom: auto;
  left: 50%;
}

.tooltip-bottom:before {
  margin-top: -12px;
  margin-bottom: 0;
  border-top-color: transparent;
  border-bottom-color: #000;
  border-bottom-color: hsla(0, 0%, 20%, 0.9);
}

.tooltip-bottom:hover:before,
.tooltip-bottom:hover:after,
.tooltip-bottom:focus:before,
.tooltip-bottom:focus:after {
  -webkit-transform: translateY(12px);
  -moz-transform:    translateY(12px);
  transform:         translateY(12px); 
}

/* Right */
.tooltip-right:before,
.tooltip-right:after {
  bottom: 50%;
  left: 100%;
}

.tooltip-right:before {
  margin-bottom: 0;
  margin-left: -12px;
  border-top-color: transparent;
  border-right-color: #000;
  border-right-color: hsla(0, 0%, 20%, 0.9);
}

.tooltip-right:hover:before,
.tooltip-right:hover:after,
.tooltip-right:focus:before,
.tooltip-right:focus:after {
  -webkit-transform: translateX(12px);
  -moz-transform:    translateX(12px);
  transform:         translateX(12px); 
}

/* Move directional arrows down a bit for left/right tooltips */
.tooltip-left:before,
.tooltip-right:before {
  top: 3px;
}

/* Vertically center tooltip content for left/right tooltips */
.tooltip-left:after,
.tooltip-right:after {
  margin-left: 0;
  margin-bottom: -16px;
}
	</style>
</head>
<body>
<%
							 
							Map<Integer, List> ResearcherDtlsListMap = new HashMap<Integer, List>();
							ResearcherDtlsListMap = (HashMap<Integer, List>) request.getAttribute("ResearcherListMap");
							
							Map<List, List> SnomedInfoDtlsListMap =  new HashMap<List, List>();
							SnomedInfoDtlsListMap = (HashMap<List, List>) request.getAttribute("SnomedInfoListMap");
							
							
						%>
	<div class="panel panel-success">
	
		<div class="panel-heading" align="center">
			<a class="ublogo" href="http://www.buffalo.edu/"><img
				src="//www.buffalo.edu/static.1465393709/etc/designs/ubcms/images/ubheader/ub-logo.png"
				width="322" height="35" align="left"
				alt="University at Buffalo, The State University of New York" /></a>
			
			<h4>
				<b><font color="white"
					style="padding-right: 300px; font-family: fantasy;">CTSA Investigator Interests</font> </b>
			</h4>
						<a href="/BMI/LogoutServlet" style="padding-left: 1400px;"><font
				size="2" color="black">Logout</font></a>
		</div>
		
		<div class="panel-heading1" align="center"></div>

		<div class="panel-body" align="center">
			<div class="panel-body1" align="center">
				<form name="ctsaSearch" id="ctsaSearchId" method="POST" action="ctsaSearchServlet"
					class="form-horizontal" role="form">
					<br>
					Search for collaborators by interest: <input type="text" class="tftextinput" id="searchStringID" name="searchString" size="21" maxlength="120"><input type="submit" id="submitSearchID" name="submitSearch" value="search" class="tfbutton">
					<br>
					<br>
					<table class="table" width="95%" cellpadding="0" cellspacing="0" border=1>
					<thead>
					<tr>
					<th>Department</th>
					<th>Last Name</th>
					<th>First Name</th>
					<th>Email</th>
					<th>Faculty Profile</th>
					<th>Speciality</th>
					</tr>
					</thead>
					<tbody>
						<%
						
						String searchQuery = request.getParameter("searchString");
						if (searchQuery == null) {
						// searchQuery is null when the page is first requested, 
						// so do nothing
						} else { 
						if (searchQuery.length() == 0) {
						// There was a querystring like ?searchQuery=
						// but no text, so searchQuery is not null, but 
						// a zero length string instead.
						%>
						<b>Search Query is empty</b>
						<% } else { %>
						<b>Search Results for Query: <%= searchQuery %></b>
						<%
						}
						}
						
						List researchList = new ArrayList();
						List snomedCodesList = new ArrayList();
						List snomedNamesList = new ArrayList();
						if(SnomedInfoDtlsListMap.size() != 0){
							for(Entry<List, List> entry: SnomedInfoDtlsListMap.entrySet()) {
								snomedCodesList = entry.getKey();
								snomedNamesList = entry.getValue();
							}
						}
						
						if(!ResearcherDtlsListMap.isEmpty()){
							for(Entry<Integer, List> entry: ResearcherDtlsListMap.entrySet()) {
								researchList = entry.getValue();
							%>
							<tr class="info">
							<% if(researchList.get(0) != null){
									%>
							<td><%=researchList.get(0).toString()%></td>
							<%}else{ %>
							<td></td>
							<%} %>
							<td><%=researchList.get(1).toString()%></td>
							<td><%=researchList.get(2).toString()%></td>
							<% if(researchList.get(3) != null && researchList.get(3).toString().contains("@")){ %>
							<td><%=researchList.get(3).toString()%></td>
							<% String emailId = researchList.get(3).toString();
	                    	   String[] userId;
							   String delimiter = "@";
							   userId = emailId.split(delimiter);
							   %>
							<td><a href="http://medicine.buffalo.edu/content/medicine/faculty/profile.html?ubit=<%=userId[0]%>">http://medicine.buffalo.edu/content/medicine/faculty/profile.html?ubit=<%=userId[0]%></a></td>
							<%}else{ %>
							<td></td>
							<td></td>
							<% }
							if(researchList.get(4) != null){ 
								String specialityName = researchList.get(4).toString();
							if(specialityName.contains("(")){
								specialityName = specialityName.replace("(", "");
								}
								if(specialityName.contains(")")){
								specialityName = specialityName.replace(")", "");	
								}
								%>
								<td><%=specialityName.trim()%></td>
									</tr>
							<%}else{
								%>
							<td></td>
							</tr>
							<% }}}else{
							%>
							<tr class="info">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							</tr>
							<%} %>
						
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>

</html>