<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1256">
<title>CTSA</title>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">
	<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
      <!--   <link href="css/searchOverlay.css" rel="stylesheet" type="text/css" /> -->
<link href="css/ctsaSearch.css" rel="stylesheet" type="text/css" />

 </head>
<body>
<div class="header">
    <div class="home-menu pure-menu pure-menu-horizontal pure-menu-fixed">
	
    <a href="/GME/LogoutServlet" style="padding-left: 1400px;"><font
				size="2" color="white">Logout</font></a>
    </div>
</div>

	<div class="panel panel-success">
	<div class="panel-heading" align="center">
	<img src="//www.buffalo.edu/static.1465393709/etc/designs/ubcms/images/ubheader/ub-logo.png"
				width="322" height="35" align="left" style="color: white" 
				alt="University at Buffalo, The State University of New York" />
				<div class="scroller">
		<div class="splash-container">
		    <div class="splash">
		       <h3 class="splash-head" style="font-size:200%; font-weight:normal" >CTSA</h3>
		    </div>
		    </div>
		</div>
		</div>
		<div class="panel-body" align="center">
			<div class="content-wrapper">
			<form class="form-wrapper"  method="post" action="ctsaSearchServlet">
    <font color="white"><input type="text" id="search" placeholder="Enter Search Query" required></font>
    <input type="submit" value="go" id="submit">
</form>
				</div>
			</div>
		</div>
</body>

</html>