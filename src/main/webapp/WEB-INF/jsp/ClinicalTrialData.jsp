<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<jsp:useBean id="trialID" scope="session" class="java.lang.String" />

<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1256">
<title>Clinical Trial Data</title>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">
	<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <link href="css/searchOverlay.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/bootstrap-datepicker.css">
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script src="js/jquery.ui.datepicker.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-multiselect.js" type="text/javascript"></script>
<link href="css/bootstrap-multiselect.css" rel="stylesheet"
	type="text/css" />
	

<style type="text/css">
.form-group-header {
	margin-left: auto;
	height: 30px;
}

.panel-heading {
	background-color: royalblue !important
}
.panel-body {
	background-color: steelblue !important
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
.scroller{margin:0 0 10px; z-index:100; background: #1f8dd6; height:50px; font-size:18px; font-weight:bold; text-align:center; width:960px;}
/*
 * -- SPLASH STYLES --
 * This is the blue top section that appears on the page.
 */

.splash-container {
    background: #1f8dd6;
    z-index: 1;
    overflow: hidden;
    /* The following styles are required for the "scroll-over" effect */
    width: 100%;
    height: 30%;
    top: 0;
    left: 0;
    position: fixed !important;
}

.splash {
    /* absolute center .splash within .splash-container */
    width: 80%;
    height: 60%;
    margin: auto;
    position: absolute;
    top: 15px; left: 0; bottom: 0; right: 0;
    text-align: center;
    text-transform: uppercase;
}

/* This is the main heading that appears on the blue section */
.splash-head {
    font-size: 10%;
    font-weight: bold;
	font-weight: xsmall;
    color: white;
    border: 3px solid white;
    padding: .5em .8em;
    font-weight: 25;
    border-radius: 2px;
    line-height: 1em;
}

/* This is the subheading that appears on the blue section */
.splash-subhead {
    color: white;
    letter-spacing: 0.05em;
    opacity: 0.8;
}

/*
 * -- CONTENT STYLES --
 * This represents the content area (everything below the blue section)
 */
 
.content-wrapper {
    /* These styles are required for the "scroll-over" effect */
    position: absolute;
    top: 30%; /*where the scroll over appears on the page */
    width: 100%;
    min-height: 12%;
    z-index: 2; /* The z-index property specifies the stack order of an element. If it had a z-index of -1, it will be placed behind the text.*/
    background: black;
	background: url(images/doctor-patient.jpg);
	background-image:url(images/doctor-patient.jpg);
background-repeat:no-repeat;
background-size:contain;
background-position:center;
}
.content-wrapper {
    /*These styles are required for the "scroll-over" effect */
    position: absolute;
    top: 30%;
    width: 100%;
    min-height: 12%;
    z-index: 2;
    background: white;

}
.content-wrapper::after{
  content: "";
  background-image: url(images/doctor-patient.jpg);
  background-size: cover; 
  background-repeat: no-repeat;
  opacity: 0.4;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  position: absolute;
  z-index: -1;   
  /*width:100%;
  height:auto;*/
  background-repeat:no-repeat;
background-size:contain;
background-position:center; /*must keep this*/
}

/* This is the class used for the main content headers (<h2>) */
.content-head {
    font-weight: 400;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    margin: 1em 0 1em;
}

/* This is a modifier class used when the content-head is inside a ribbon */
.content-head-ribbon {
    color: white;
}

/* This is the class used for the content sub-headers (<h3>) */
.content-subhead {
    color: #1f8dd6;
}
    .content-subhead i {
        margin-right: 7px;
    }

/* This is the class used for the dark-background areas. */
.ribbon {
    background: #2d3e50;
    color: #aaa;
}

/* This is the class used for the footer */
.footer {
    background: #111;
}


</style>
<script type="text/javascript">

	$(document).ready(function() {
		$('#startDateId').datepicker({
			format : "dd-M-yy"
		});
		$('#endDateId').datepicker({
			format : "dd-M-yy"
		});
		$('#studyCalId').datepicker({
			format : "dd-M-yy"
		});
	});
	$('inclusion').on('keydown', function(e){
	    if(e.which == 13) {e.preventDefault();}
	}).on('input', function(){
	    $(this).height(1);
	    var totalHeight = $(this).prop('scrollHeight') - parseInt($(this).css('padding-top')) - parseInt($(this).css('padding-bottom'));
	    $(this).height(totalHeight);
	});
	var enteredStr = '';
	var count = 1;
	var substring = '';
	var substr = '';
	var multiSubstring = '';
    function show (text){
    	if(text == '')
    		{
    	alert("Please enter text");
    		}else{
    	var str = '<ul>';
     if(enteredStr == ''){
             str += '<li id="liId">' + text +' '+'<input name="removeBtn" id="removeBtn" value="Remove" onclick="removeStr();" type="button"/>'+'</li>';
             document.clinicalTrialFrm.inclusion.value='';
 		         enteredStr = str;
              }else{
              enteredStr += '<li id='+count+' class="id-a">' + text +' '+'<input name="removeBtn" id="removeBtn" value="Remove" onclick="removeLine('+count+');" type="button"/>'+'</li>';
              document.clinicalTrialFrm.inclusion.value='';
              str += enteredStr;
              count += 1;
 		         }
              str += '</ul>';
              
	          document.getElementById("text").innerHTML = str;
	          var countSyn = count;
	          substring = str.substring(str.indexOf("Id")+4,str.indexOf("<input"));
	          if(countSyn > 1){
	        	  substring += ",";
	        	  if(countSyn > 2)
        		  {
        		  multiSubstring += ",";
        		  }
	        	  var x = document.getElementsByClassName("id-a");
	        	  var multiSubStr = x[countSyn-2].innerHTML;
	        	  multiSubstring += multiSubStr.substring(0,multiSubStr.indexOf("<"));
	        	  countSyn--;	
	          }
	          substring += multiSubstring;
	          substr = substring;
	          document.getElementById("hiddenInclusion").value = substr;
    		}//end-of if text is empty
                 }
                 function removeStr (){
                	 
				 var liIdentity = document.getElementById("liId");
				 var removeLi = '<li id="liId">'+liIdentity.innerHTML.replace(">","/>")+'</li>';
				 enteredStr = enteredStr.replace(removeLi, '');
				 var rmvLi = liIdentity.innerHTML;
				 var rmvStr = rmvLi.substring(0,rmvLi.indexOf("<"));
				 substr = substr.replace(rmvStr,'');
				 var c = substr.charAt(0);
					if (c == ','){
						substr = substr.replace(c,'');
					}
				 liIdentity.parentNode.removeChild(liIdentity);
				 document.getElementById("hiddenInclusion").value = substr;
				 }
                 function removeLine (cnt){
                	 
                	 var list = document.getElementsByClassName("id-a");
               	  for (var i = 1; i < list.length; i++) {
                	   var lineIdty = document.getElementById(cnt);
                	   var removeLine = '<li id='+cnt+' class="id-a">'+lineIdty.innerHTML.replace(">","/>")+'</li>';
      				 	enteredStr = enteredStr.replace(removeLine, '');
      				 	var rmvLine = lineIdty.innerHTML;
      					 var rmvString = rmvLine.substring(0,rmvLine.indexOf("<"));
      					 substr = substr.replace(rmvString+',','');
      					var c = substr.charAt(i);
    					if (c == ','){
    						substr = substr.replace(c,'');
    					}
                	   lineIdty.parentNode.removeChild(lineIdty);
                 	  document.getElementById("hiddenInclusion").value = substr;
               	  }
                	  str += enteredStr;
                	  
                	 }
                 
                 
                 $('exclusion').on('keydown', function(e){
             	    if(e.which == 13) {e.preventDefault();}
             	}).on('input', function(){
             	    $(this).height(1);
             	    var totalHeight = $(this).prop('scrollHeight') - parseInt($(this).css('padding-top')) - parseInt($(this).css('padding-bottom'));
             	    $(this).height(totalHeight);
             	});
             	var enteredString = '';
             	var idCount = 1;
             	var exSubstring = '';
            	var exSubstr = '';
            	var exMultiSubstring = '';
                 function showExclusion(extext){
                	 if(extext == '')
             		{
             		alert("Please enter text");
             		}else{
                	 var string = '<ul>';
                  if(enteredString == ''){
                	  string += '<li id="liFirstId">' + extext +' '+'<input name="rmvBtn" id="rmvBtn" value="Remove" onclick="removeString();" type="button"/>'+'</li>';
                          document.clinicalTrialFrm.exclusion.value='';
                          enteredString = string;
                           }else{
                        	   enteredString += '<li id=id'+idCount+' class="id-b">' + extext +' '+'<input name="rmvBtn" id="rmvBtn" value="Remove" onclick="removeSentence('+idCount+');" type="button"/>'+'</li>';
                           document.clinicalTrialFrm.exclusion.value='';
                           string += enteredString;
                           idCount += 1;
              		         }
                  			string += '</ul>';       
                  			
             	          document.getElementById("extext").innerHTML = string;
             	         var exCountSyn = idCount;
           	             exSubstring = string.substring(string.indexOf("Id")+4,string.indexOf("<input"));
           	             if(exCountSyn > 1){
           	        	  exSubstring += ",";
           	        	  if(exCountSyn > 2)
                   		  {
                   		  exMultiSubstring += ",";
                   		  }
           	        	  var x = document.getElementsByClassName("id-b");
           	        	  var multiSubStr = x[exCountSyn-2].innerHTML;
           	        	  exMultiSubstring += multiSubStr.substring(0,multiSubStr.indexOf("<"));
           	        	  exCountSyn--;	
           	          }
           	          exSubstring += exMultiSubstring;
           	          exSubstr = exSubstring;
           	          document.getElementById("hiddenExclusion").value = exSubstr;
             		}
                              }
                              function removeString (){
                            	  
             				 var liIdent = document.getElementById("liFirstId");
             				 var rmvLi = '<li id="liFirstId">'+liIdent.innerHTML.replace(">","/>")+'</li>';
             				 enteredString = enteredString.replace(rmvLi, '');
             				var rmvLi = liIdent.innerHTML;
           				   var rmvStr = rmvLi.substring(0,rmvLi.indexOf("<"));
           				exSubstr = exSubstr.replace(rmvStr,'');
           				 var c = exSubstr.charAt(0);
           					if (c == ','){
           						exSubstr = exSubstr.replace(c,'');
           					}
             				 liIdent.parentNode.removeChild(liIdent);
             				document.getElementById("hiddenExclusion").value = exSubstr;
             				 }
                              function removeSentence (idcnt){
                            	  
                             	 var listLines = document.getElementsByClassName("id-b");
                            	  for (var i = 1; i < listLines.length; i++) {
                             	   var lineIdenty = document.getElementById('id'+idcnt);
                             	   
                             	   var removeLn = '<li id=id'+idcnt+' class="id-b">'+lineIdenty.innerHTML.replace(">","/>")+'</li>';
                             	  
                             	   enteredString = enteredString.replace(removeLn, '');
                             	  var rmvLine = lineIdenty.innerHTML;
               					 var rmvString = rmvLine.substring(0,rmvLine.indexOf("<"));
               					exSubstr = exSubstr.replace(rmvString+',','');
               					var c = exSubstr.charAt(i);
             					if (c == ','){
             						exSubstr = exSubstr.replace(c,'');
             					}
                             	   lineIdenty.parentNode.removeChild(lineIdenty);
                             	  document.getElementById("hiddenExclusion").value = exSubstr;
                            	  }
                             	  string += enteredString;
                             	 }
                             
                              $(document).ready(function(){
                            	    var counter = 2;
                            	    $("#addButton").click(function () {
                            		if(counter>10){
                            	            alert("Only 10 textboxes allow");
                            	            return false;
                            		}   
                            		var newTextBox = $(document.createElement('tr'))
                            		.attr({id: 'coordinatorname' + counter, class: "form-group"});
                            		newTextBox.after().html('<td align="left" nowrap>'+'<b>'+'<font color="black" style="font-family: fantasy;">'+'Study Coordinator Name'+counter+''+': '+'</font>'+'</b>'+'</td>'+'<td class="col-sm-4" align="left">'+'<font size="4">'+'<b>'+
      										'<font color="blue">'+'<input type="text" class="form-control" name="SCName'+counter+'" id="SCName'+counter+'" size="40" height="10px" value=""/>'+' </font>'+'</font>'+'<br>'+'</td>');
                            		newTextBox.appendTo("#boxgroup");
                            		newTextBox.insertAfter( "#coordinatoraddress"+(counter-1) );
                            		
                            		var emailTextBox = $(document.createElement('tr'))
                            		.attr({id: 'coordinatoremail' + counter, class: "form-group"});
                            		emailTextBox.after().html('<td align="left" nowrap>'+'<b>'+'<font color="black" style="font-family: fantasy;">'+'Study Coordinator Email'+counter+''+': '+'</font>'+'</b>'+'</td>'+'<td class="col-sm-4" align="left">'+'<font size="4">'+'<b>'+
      										'<font color="blue">'+'<input type="text" class="form-control" name="SCEmail'+counter+'" id="SCEmail'+counter+'" size="40" height="10px" value=""/>'+' </font>'+'</font>'+'<br>'+'</td>');
                            		emailTextBox.appendTo("#boxgroup");
                            		emailTextBox.insertAfter( "#coordinatorname"+counter);
                            		
                            		var phoneTextBox = $(document.createElement('tr'))
                            		.attr({id: 'coordinatorphone' + counter, class: "form-group"});
                            		phoneTextBox.after().html('<td align="left" nowrap>'+'<b>'+'<font color="black" style="font-family: fantasy;">'+'Study Coordinator Phone'+counter+''+': '+'</font>'+'</b>'+'</td>'+'<td class="col-sm-4" align="left">'+'<font size="4">'+'<b>'+
      										'<font color="blue">'+'<input type="text" class="form-control" name="SCPhone'+counter+'" id="SCPhone'+counter+'" size="40" height="10px" value=""/>'+' </font>'+'</font>'+'<br>'+'</td>');
                            		phoneTextBox.appendTo("#boxgroup");
                            		phoneTextBox.insertAfter( "#coordinatoremail"+counter);
                            		
                            		var addrTextBox = $(document.createElement('tr'))
                            		.attr({id: 'coordinatoraddress' + counter, class: "form-group"});
                            		addrTextBox.after().html('<td align="left" nowrap>'+'<b>'+'<font color="black" style="font-family: fantasy;">'+'Study Coordinator Address'+counter+''+': '+'</font>'+'</b>'+'</td>'+'<td class="col-sm-4" align="left">'+'<font size="4">'+'<b>'+
      										'<font color="blue">'+'<input type="text" class="form-control" name="SCAddress'+counter+'" id="SCAddress'+counter+'" size="40" height="10px" value=""/>'+' </font>'+'</font>'+'<br>'+'</td>');
                            		addrTextBox.appendTo("#boxgroup");
                            		addrTextBox.insertAfter( "#coordinatorphone"+counter);
                            		document.getElementById("hiddenSC").value = counter;
                            		
                            		counter++;
                            	     });
                            	    
                            	    var locationcount = 2;
                            	    $("#addLocation").click(function () {
                            		if(locationcount>10){
                            	            alert("Only 10 textboxes allow");
                            	            return false;
                            		}   
                            		var locNameTextBox = $(document.createElement('tr'))
                            		.attr({id: 'locationName' + locationcount, class: "form-group"});
                            		locNameTextBox.after().html('<td align="left" nowrap>'+'<b>'+'<font color="black" style="font-family: fantasy;">'+'Location Name'+locationcount+''+': '+'</font>'+'</b>'+'</td>'+'<td class="col-sm-4" align="left">'+'<font size="4">'+'<b>'+
      										'<font color="blue">'+'<input type="text" class="form-control" name="locName'+locationcount+'" id="locName'+locationcount+'" size="40" height="10px" value=""/>'+' </font>'+'</font>'+'<br>'+'</td>');
                            		locNameTextBox.appendTo("#boxgroup");
                            		locNameTextBox.insertAfter( "#locationAddr"+(locationcount-1) );
                            		
                            		var locAddrTextBox = $(document.createElement('tr'))
                            		.attr({id: 'locationAddr' + locationcount, class: "form-group"});
                            		locAddrTextBox.after().html('<td align="left" nowrap>'+'<b>'+'<font color="black" style="font-family: fantasy;">'+'Location Address'+locationcount+''+': '+'</font>'+'</b>'+'</td>'+'<td class="col-sm-4" align="left">'+'<font size="4">'+'<b>'+
      										'<font color="blue">'+'<input type="text" class="form-control" name="locAddr'+locationcount+'" id="locAddr'+locationcount+'" size="40" height="10px" value=""/>'+' </font>'+'</font>'+'<br>'+'</td>');
                            		locAddrTextBox.appendTo("#boxgroup");
                            		locAddrTextBox.insertAfter( "#locationName"+locationcount);
                            		document.getElementById("hiddenLoc").value = locationcount;
                            		
                            		locationcount++;
                            	     });
                              });
                              
                              function inclusionFn(){
                            	  alert("inside inclusion function");
                            	  var inclusionTxt = document.getElementById("text").value;
                            	  alert("inclusionTxt:"+inclusionTxt);
                              }
                              function validate() 
                      	    {
                      		     if(clinicalTrialFrm.title.value=="")
                      	        {
                      		       document.getElementById('errAbst').innerHTML='';
                      	           document.getElementById("abst").style.borderColor = '';
                      	           document.getElementById('errStartDt').innerHTML='';
                      	           document.getElementById("startDateId").style.borderColor = '';
                      	           document.getElementById('errEndDt').innerHTML='';
                      	  	       document.getElementById("endDateId").style.borderColor = '';
                      	  	       document.getElementById('errButton').innerHTML='';
                      	     	   document.getElementById("button").style.borderColor = '';
                      	     	   document.getElementById('errBtn').innerHTML='';
                      	   		   document.getElementById("btn").style.borderColor = '';
                      	   		   document.getElementById('errMinage').innerHTML='';
			                       document.getElementById("minAge").style.borderColor = '';
			                       document.getElementById('errMaxage').innerHTML='';
			                       document.getElementById("maxAge").style.borderColor = '';
                      	  	       document.getElementById("phenogenderId").style.borderColor = '';
                      	     	   document.getElementById("genogenderId").style.borderColor = '';
	                      	       document.getElementById('errNoOfVisits').innerHTML='';
                      	   		   document.getElementById("noOfVisits").style.borderColor = '';
                      	   		   document.getElementById('errIntervalOfVisits').innerHTML='';
			                       document.getElementById("intervalOfVisits").style.borderColor = '';
			                       document.getElementById('errPIName').innerHTML='';
			                       document.getElementById("PIName").style.borderColor = '';
			                       document.getElementById('errPIEmail').innerHTML='';
                      	  	       document.getElementById("PIEmail").style.borderColor = '';
                      	  	   	   document.getElementById('errPIPhone').innerHTML='';
                      	     	   document.getElementById("PIPhone").style.borderColor = '';
                      	     	   document.getElementById('errPIAddress').innerHTML='';
                      	   		   document.getElementById("PIAddress").style.borderColor = '';
                      	   		   document.getElementById('errSCName1').innerHTML='';
			                       document.getElementById("SCName1").style.borderColor = '';
			                       document.getElementById('errSCEmail1').innerHTML='';
			                       document.getElementById("SCEmail1").style.borderColor = '';
			                       document.getElementById('errSCPhone1').innerHTML='';
                      	  	       document.getElementById("SCPhone1").style.borderColor = '';
                      	  	       document.getElementById('errSCAddress1').innerHTML='';
                      	     	   document.getElementById("SCAddress1").style.borderColor = '';
                      	     	   document.getElementById('errLocName1').innerHTML='';
                      	   		   document.getElementById("locName1").style.borderColor = '';
                      	   		   document.getElementById('errLocAddr1').innerHTML='';
			                       document.getElementById("locAddr1").style.borderColor = '';
			                       document.getElementById('errCost').innerHTML='';
			                       document.getElementById("cost").style.borderColor = '';
			                       document.getElementById('errPayment').innerHTML='';
			                       document.getElementById("payment").style.borderColor = '';
			                       document.getElementById('errTitle').innerHTML="Please enter Project Title";
                      	           document.getElementById('title').focus();
                      	           document.getElementById("title").style.borderColor = "red";
                      	           return false;
                      	        }else if(clinicalTrialFrm.abst.value=="")
                      	        {  
                      	           document.getElementById('errTitle').innerHTML='';
                      	           document.getElementById("title").style.borderColor = '';
                      	           document.getElementById('errStartDt').innerHTML='';
                       	           document.getElementById("startDateId").style.borderColor = '';
                       	           document.getElementById('errEndDt').innerHTML='';
                       	  	       document.getElementById("endDateId").style.borderColor = '';
                       	  	       document.getElementById('errButton').innerHTML='';
                       	     	   document.getElementById("button").style.borderColor = '';
                       	     	   document.getElementById('errBtn').innerHTML='';
                       	   		   document.getElementById("btn").style.borderColor = '';
                       	   		   document.getElementById('errMinage').innerHTML='';
 			                       document.getElementById("minAge").style.borderColor = '';
 			                       document.getElementById('errMaxage').innerHTML='';
 			                       document.getElementById("maxAge").style.borderColor = '';
                       	  	       document.getElementById("phenogenderId").style.borderColor = '';
                       	     	   document.getElementById("genogenderId").style.borderColor = '';
                         	       document.getElementById('errNoOfVisits').innerHTML='';
                       	   		   document.getElementById("noOfVisits").style.borderColor = '';
                       	   		   document.getElementById('errIntervalOfVisits').innerHTML='';
 			                       document.getElementById("intervalOfVisits").style.borderColor = '';
 			                       document.getElementById('errPIName').innerHTML='';
 			                       document.getElementById("PIName").style.borderColor = '';
 			                       document.getElementById('errPIEmail').innerHTML='';
                       	  	       document.getElementById("PIEmail").style.borderColor = '';
                       	  	       document.getElementById('errPIPhone').innerHTML='';
                       	     	   document.getElementById("PIPhone").style.borderColor = '';
                       	     	   document.getElementById('errPIAddress').innerHTML='';
                       	   		   document.getElementById("PIAddress").style.borderColor = '';
                       	   		   document.getElementById('errSCName1').innerHTML='';
 			                       document.getElementById("SCName1").style.borderColor = '';
 			                       document.getElementById('errSCEmail1').innerHTML='';
 			                       document.getElementById("SCEmail1").style.borderColor = '';
 			                       document.getElementById('errSCPhone1').innerHTML='';
                       	  	       document.getElementById("SCPhone1").style.borderColor = '';
                       	  	       document.getElementById('errSCAddress1').innerHTML='';
                       	     	   document.getElementById("SCAddress1").style.borderColor = '';
                       	     	   document.getElementById('errLocName1').innerHTML='';
                       	   		   document.getElementById("locName1").style.borderColor = '';
                       	   		   document.getElementById('errLocAddr1').innerHTML='';
 			                       document.getElementById("locAddr1").style.borderColor = '';
 			                       document.getElementById('errCost').innerHTML='';
 			                       document.getElementById("cost").style.borderColor = '';
 			                       document.getElementById('errPayment').innerHTML='';
 			                       document.getElementById("payment").style.borderColor = '';
 			                       document.getElementById('errAbst').innerHTML="Please enter Project Abstract";
                       	           document.getElementById('abst').focus();
                       	           document.getElementById("abst").style.borderColor = "red";
                      		           return false;
                      		        }
                      		     else if(clinicalTrialFrm.startDate.value=="")
                      	        {
                      		    	document.getElementById('errTitle').innerHTML=''; 
                      		    	document.getElementById("title").style.borderColor = '';
                      		    	document.getElementById('errAbst').innerHTML='';
                        	        document.getElementById("abst").style.borderColor = '';
                        	        document.getElementById('errEndDt').innerHTML='';
                        	  	    document.getElementById("endDateId").style.borderColor = '';
                        	  	  	document.getElementById('errButton').innerHTML='';
                        	     	document.getElementById("button").style.borderColor = '';
                        	     	document.getElementById('errBtn').innerHTML='';
                        	   		document.getElementById("btn").style.borderColor = '';
                        	   		document.getElementById('errMinage').innerHTML='';
  			                        document.getElementById("minAge").style.borderColor = '';
  			                        document.getElementById('errMaxage').innerHTML='';
  			                        document.getElementById("maxAge").style.borderColor = '';
                        	  	    document.getElementById("phenogenderId").style.borderColor = '';
                        	     	document.getElementById("genogenderId").style.borderColor = '';
                        	     	document.getElementById('errNoOfVisits').innerHTML='';
                        	   		document.getElementById("noOfVisits").style.borderColor = '';
                        	   		document.getElementById('errIntervalOfVisits').innerHTML='';
  			                        document.getElementById("intervalOfVisits").style.borderColor = '';
  			                        document.getElementById('errPIName').innerHTML='';
  			                        document.getElementById("PIName").style.borderColor = '';
  			                        document.getElementById('errPIEmail').innerHTML='';
                        	  	    document.getElementById("PIEmail").style.borderColor = '';
                        	  	    document.getElementById('errPIPhone').innerHTML='';
                        	     	document.getElementById("PIPhone").style.borderColor = '';
                        	     	document.getElementById('errPIAddress').innerHTML='';
                        	   		document.getElementById("PIAddress").style.borderColor = '';
                        	   		document.getElementById('errSCName1').innerHTML='';
  			                        document.getElementById("SCName1").style.borderColor = '';
  			                        document.getElementById('errSCEmail1').innerHTML='';
  			                        document.getElementById("SCEmail1").style.borderColor = '';
  			                        document.getElementById('errSCPhone1').innerHTML='';
                        	  	    document.getElementById("SCPhone1").style.borderColor = '';
                        	  	    document.getElementById('errSCAddress1').innerHTML='';
                        	     	document.getElementById("SCAddress1").style.borderColor = '';
                        	     	document.getElementById('errLocName1').innerHTML='';
                        	   		document.getElementById("locName1").style.borderColor = '';
                        	   		document.getElementById('errLocAddr1').innerHTML='';
  			                        document.getElementById("locAddr1").style.borderColor = '';
  			                        document.getElementById('errCost').innerHTML='';
  			                        document.getElementById("cost").style.borderColor = '';
  			                        document.getElementById('errPayment').innerHTML='';
  			                        document.getElementById("payment").style.borderColor = '';
  			                        document.getElementById('errStartDt').innerHTML="Please enter Start Date";
                        	        document.getElementById('startDateId').focus();
                        	        document.getElementById("startDateId").style.borderColor = "red";
                      		           return false;
                      		        }                            	  
                      		     else if(clinicalTrialFrm.endDate.value=="")
                      	        {
                      		    	document.getElementById('errTitle').innerHTML='';
                      		    	document.getElementById("title").style.borderColor = '';
                      		    	document.getElementById('errAbst').innerHTML='';
                        	        document.getElementById("abst").style.borderColor = '';
                        	        document.getElementById('errStartDt').innerHTML='';
                        	  	    document.getElementById("startDateId").style.borderColor = '';
                        	  	  	document.getElementById('errButton').innerHTML='';
                        	     	document.getElementById("button").style.borderColor = '';
                        	     	document.getElementById('errBtn').innerHTML='';
                        	   		document.getElementById("btn").style.borderColor = '';
                        	   		document.getElementById('errMinage').innerHTML='';
  			                        document.getElementById("minAge").style.borderColor = '';
  			                        document.getElementById('errMaxage').innerHTML='';
  			                        document.getElementById("maxAge").style.borderColor = '';
                        	  	    document.getElementById("phenogenderId").style.borderColor = '';
                        	     	document.getElementById("genogenderId").style.borderColor = '';
                        	     	document.getElementById('errNoOfVisits').innerHTML='';
                        	   		document.getElementById("noOfVisits").style.borderColor = '';
                        	   		document.getElementById('errIntervalOfVisits').innerHTML='';
  			                        document.getElementById("intervalOfVisits").style.borderColor = '';
  			                        document.getElementById('errPIName').innerHTML='';
  			                        document.getElementById("PIName").style.borderColor = '';
  			                        document.getElementById('errPIEmail').innerHTML='';
                        	  	    document.getElementById("PIEmail").style.borderColor = '';
                        	  	    document.getElementById('errPIPhone').innerHTML='';
                        	     	document.getElementById("PIPhone").style.borderColor = '';
                        	     	document.getElementById('errPIAddress').innerHTML='';
                        	   		document.getElementById("PIAddress").style.borderColor = '';
                        	   		document.getElementById('errSCName1').innerHTML='';
  			                        document.getElementById("SCName1").style.borderColor = '';
  			                        document.getElementById('errSCEmail1').innerHTML='';
  			                        document.getElementById("SCEmail1").style.borderColor = '';
  			                        document.getElementById('errSCPhone1').innerHTML='';
                        	  	    document.getElementById("SCPhone1").style.borderColor = '';
                        	  	    document.getElementById('errSCAddress1').innerHTML='';
                        	     	document.getElementById("SCAddress1").style.borderColor = '';
                        	     	document.getElementById('errLocName1').innerHTML='';
                        	   		document.getElementById("locName1").style.borderColor = '';
                        	   		document.getElementById('errLocAddr1').innerHTML='';
  			                        document.getElementById("locAddr1").style.borderColor = '';
  			                        document.getElementById('errCost').innerHTML='';
  			                        document.getElementById("cost").style.borderColor = '';
  			                        document.getElementById('errPayment').innerHTML='';
  			                        document.getElementById("payment").style.borderColor = '';
  			                        document.getElementById('errEndDt').innerHTML="Please enter End Date";
                        	        document.getElementById('endDateId').focus();
                        	        document.getElementById("endDateId").style.borderColor = "red";
                      		           return false;
                      		        }
                      		     else if(clinicalTrialFrm.hiddenInclusion.value=="")
                      	        {
                      		    	document.getElementById('errTitle').innerHTML='';
                      		    	document.getElementById("title").style.borderColor = '';
                      		    	document.getElementById('errAbst').innerHTML='';
                        	        document.getElementById("abst").style.borderColor = '';
                        	        document.getElementById('errStartDt').innerHTML='';
                        	  	    document.getElementById("startDateId").style.borderColor = '';
                        	  	    document.getElementById('errEndDt').innerHTML='';
                        	     	document.getElementById("endDateId").style.borderColor = '';
                        	     	document.getElementById('errBtn').innerHTML='';
                        	   		document.getElementById("btn").style.borderColor = '';
                        	   		document.getElementById('errMinage').innerHTML='';
  			                        document.getElementById("minAge").style.borderColor = '';
  			                      	document.getElementById('errMaxage').innerHTML='';
  			                        document.getElementById("maxAge").style.borderColor = '';
                        	  	    document.getElementById("phenogenderId").style.borderColor = '';
                        	     	document.getElementById("genogenderId").style.borderColor = '';
                        	     	document.getElementById('errNoOfVisits').innerHTML='';
                        	   		document.getElementById("noOfVisits").style.borderColor = '';
                        	   		document.getElementById('errIntervalOfVisits').innerHTML='';
  			                        document.getElementById("intervalOfVisits").style.borderColor = '';
  			                        document.getElementById('errPIName').innerHTML='';
  			                        document.getElementById("PIName").style.borderColor = '';
  			                        document.getElementById('errPIEmail').innerHTML='';
                        	  	    document.getElementById("PIEmail").style.borderColor = '';
                        	  	    document.getElementById('errPIPhone').innerHTML='';
                        	     	document.getElementById("PIPhone").style.borderColor = '';
                        	     	document.getElementById('errPIAddress').innerHTML='';
                        	   		document.getElementById("PIAddress").style.borderColor = '';
                        	   		document.getElementById('errSCName1').innerHTML='';
  			                        document.getElementById("SCName1").style.borderColor = '';
  			                        document.getElementById('errSCEmail1').innerHTML='';
  			                        document.getElementById("SCEmail1").style.borderColor = '';
  			                        document.getElementById('errSCPhone1').innerHTML='';
                        	  	    document.getElementById("SCPhone1").style.borderColor = '';
                        	  	    document.getElementById('errSCAddress1').innerHTML='';
                        	     	document.getElementById("SCAddress1").style.borderColor = '';
                        	     	document.getElementById('errLocName1').innerHTML='';
                        	   		document.getElementById("locName1").style.borderColor = '';
                        	   		document.getElementById('errLocAddr1').innerHTML='';
  			                        document.getElementById("locAddr1").style.borderColor = '';
  			                        document.getElementById('errCost').innerHTML='';
  			                        document.getElementById("cost").style.borderColor = '';
  			                        document.getElementById('errPayment').innerHTML='';
  			                        document.getElementById("payment").style.borderColor = '';
  			                      	document.getElementById('errButton').innerHTML="Please enter Inclusion Criteria";
                        	        document.getElementById('button').focus();
                        	        document.getElementById("button").style.borderColor = "red";
                      		           return false;
                      		        }
                      		     else if(clinicalTrialFrm.hiddenExclusion.value=="")
                      	        {
                      		    	
                      		    	document.getElementById('errTitle').innerHTML='';
                      		    	document.getElementById("title").style.borderColor = '';
                      		    	document.getElementById('errAbst').innerHTML='';
                        	        document.getElementById("abst").style.borderColor = '';
                        	        document.getElementById('errStartDt').innerHTML='';
                        	  	    document.getElementById("startDateId").style.borderColor = '';
                        	  	    document.getElementById('errEndDt').innerHTML='';
                        	     	document.getElementById("endDateId").style.borderColor = '';
                        	     	document.getElementById('errButton').innerHTML='';
                        	   		document.getElementById("button").style.borderColor = '';
                        	   		document.getElementById('errMinage').innerHTML='';
  			                        document.getElementById("minAge").style.borderColor = '';
  			                        document.getElementById('errMaxage').innerHTML='';
  			                        document.getElementById("maxAge").style.borderColor = '';
                        	  	    document.getElementById("phenogenderId").style.borderColor = '';
                        	     	document.getElementById("genogenderId").style.borderColor = '';
                        	     	document.getElementById('errNoOfVisits').innerHTML='';
                        	   		document.getElementById("noOfVisits").style.borderColor = '';
                        	   		document.getElementById('errIntervalOfVisits').innerHTML='';
  			                        document.getElementById("intervalOfVisits").style.borderColor = '';
  			                        document.getElementById('errPIName').innerHTML='';
  			                        document.getElementById("PIName").style.borderColor = '';
  			                        document.getElementById('errPIEmail').innerHTML='';
                        	  	    document.getElementById("PIEmail").style.borderColor = '';
                        	  	    document.getElementById('errPIPhone').innerHTML='';
                        	     	document.getElementById("PIPhone").style.borderColor = '';
                        	     	document.getElementById('errPIAddress').innerHTML='';
                        	   		document.getElementById("PIAddress").style.borderColor = '';
                        	   		document.getElementById('errSCName1').innerHTML='';
  			                        document.getElementById("SCName1").style.borderColor = '';
  			                        document.getElementById('errSCEmail1').innerHTML='';
  			                        document.getElementById("SCEmail1").style.borderColor = '';
  			                        document.getElementById('errSCPhone1').innerHTML='';
                        	  	    document.getElementById("SCPhone1").style.borderColor = '';
                        	  	    document.getElementById('errSCAddress1').innerHTML='';
                        	     	document.getElementById("SCAddress1").style.borderColor = '';
                        	     	document.getElementById('errLocName1').innerHTML='';
                        	   		document.getElementById("locName1").style.borderColor = '';
                        	   		document.getElementById('errLocAddr1').innerHTML='';
  			                        document.getElementById("locAddr1").style.borderColor = '';
  			                        document.getElementById('errCost').innerHTML='';
  			                        document.getElementById("cost").style.borderColor = '';
  			                        document.getElementById('errPayment').innerHTML='';
  			                        document.getElementById("payment").style.borderColor = '';
  			                        document.getElementById('errBtn').innerHTML="Please enter Exclusion Criteria";
                        	        document.getElementById('btn').focus();
                        	        document.getElementById("btn").style.borderColor = "red";
                      	           return false;
                      	        }
                      		     else if(clinicalTrialFrm.minAge.value=="")
                      	        {
                      		    	document.getElementById('errTitle').innerHTML='';
                      		    	document.getElementById("title").style.borderColor = '';
                      		    	document.getElementById('errAbst').innerHTML='';
                        	        document.getElementById("abst").style.borderColor = '';
                        	        document.getElementById('errStartDt').innerHTML='';
                        	  	    document.getElementById("startDateId").style.borderColor = '';
                        	  	    document.getElementById('errEndDt').innerHTML='';
                        	     	document.getElementById("endDateId").style.borderColor = '';
                        	     	document.getElementById('errButton').innerHTML='';
                        	   		document.getElementById("button").style.borderColor = '';
                        	   		document.getElementById('errBtn').innerHTML='';
  			                        document.getElementById("btn").style.borderColor = '';
  			                        document.getElementById('errMaxage').innerHTML='';
  			                        document.getElementById("maxAge").style.borderColor = '';
                        	  	    document.getElementById("phenogenderId").style.borderColor = '';
                        	     	document.getElementById("genogenderId").style.borderColor = '';
                        	     	document.getElementById('errNoOfVisits').innerHTML='';
                        	   		document.getElementById("noOfVisits").style.borderColor = '';
                        	   		document.getElementById('errIntervalOfVisits').innerHTML='';
  			                        document.getElementById("intervalOfVisits").style.borderColor = '';
  			                        document.getElementById('errPIName').innerHTML='';
  			                        document.getElementById("PIName").style.borderColor = '';
  			                        document.getElementById('errPIEmail').innerHTML='';
                        	  	    document.getElementById("PIEmail").style.borderColor = '';
                        	  	    document.getElementById('errPIPhone').innerHTML='';
                        	     	document.getElementById("PIPhone").style.borderColor = '';
                        	     	document.getElementById('errPIAddress').innerHTML='';
                        	   		document.getElementById("PIAddress").style.borderColor = '';
                        	   		document.getElementById('errSCName1').innerHTML='';
  			                        document.getElementById("SCName1").style.borderColor = '';
  			                        document.getElementById('errSCEmail1').innerHTML='';
  			                        document.getElementById("SCEmail1").style.borderColor = '';
  			                        document.getElementById('errSCPhone1').innerHTML='';
                        	  	    document.getElementById("SCPhone1").style.borderColor = '';
                        	  	    document.getElementById('errSCAddress1').innerHTML='';
                        	     	document.getElementById("SCAddress1").style.borderColor = '';
                        	     	document.getElementById('errLocName1').innerHTML='';
                        	   		document.getElementById("locName1").style.borderColor = '';
                        	   		document.getElementById('errLocAddr1').innerHTML='';
  			                        document.getElementById("locAddr1").style.borderColor = '';
  			                        document.getElementById('errCost').innerHTML='';
  			                        document.getElementById("cost").style.borderColor = '';
  			                        document.getElementById('errPayment').innerHTML='';
  			                        document.getElementById("payment").style.borderColor = '';
  			                        document.getElementById('errMinage').innerHTML="Please enter Minimum age";
                        	        document.getElementById('minAge').focus();
                        	        document.getElementById("minAge").style.borderColor = "red";
                      		           return false; 
                      		        }
                      		     else if(clinicalTrialFrm.maxAge.value=="")
                      		        {
                      		    	document.getElementById('errTitle').innerHTML='';
                      		    	document.getElementById("title").style.borderColor = '';
                      		    	document.getElementById('errAbst').innerHTML='';
                        	        document.getElementById("abst").style.borderColor = '';
                        	        document.getElementById('errStartDt').innerHTML='';
                        	  	    document.getElementById("startDateId").style.borderColor = '';
                        	  	    document.getElementById('errEndDt').innerHTML='';
                        	     	document.getElementById("endDateId").style.borderColor = '';
                        	     	document.getElementById('errButton').innerHTML='';
                        	   		document.getElementById("button").style.borderColor = '';
                        	   		document.getElementById('errBtn').innerHTML='';
  			                        document.getElementById("btn").style.borderColor = '';
  			                        document.getElementById('errMinage').innerHTML='';
  			                        document.getElementById("minAge").style.borderColor = '';
                        	  	    document.getElementById("phenogenderId").style.borderColor = '';
                        	     	document.getElementById("genogenderId").style.borderColor = '';
                        	     	document.getElementById('errNoOfVisits').innerHTML='';
                        	   		document.getElementById("noOfVisits").style.borderColor = '';
                        	   		document.getElementById('errIntervalOfVisits').innerHTML='';
  			                        document.getElementById("intervalOfVisits").style.borderColor = '';
  			                        document.getElementById('errPIName').innerHTML='';
  			                        document.getElementById("PIName").style.borderColor = '';
  			                        document.getElementById('errPIEmail').innerHTML='';
                        	  	    document.getElementById("PIEmail").style.borderColor = '';
                        	  	    document.getElementById('errPIPhone').innerHTML='';
                        	     	document.getElementById("PIPhone").style.borderColor = '';
                        	     	document.getElementById('errPIAddress').innerHTML='';
                        	   		document.getElementById("PIAddress").style.borderColor = '';
                        	   		document.getElementById('errSCName1').innerHTML='';
  			                        document.getElementById("SCName1").style.borderColor = '';
  			                        document.getElementById('errSCEmail1').innerHTML='';
  			                        document.getElementById("SCEmail1").style.borderColor = '';
  			                        document.getElementById('errSCPhone1').innerHTML='';
                        	  	    document.getElementById("SCPhone1").style.borderColor = '';
                        	  	    document.getElementById('errSCAddress1').innerHTML='';
                        	     	document.getElementById("SCAddress1").style.borderColor = '';
                        	     	document.getElementById('errLocName1').innerHTML='';
                        	   		document.getElementById("locName1").style.borderColor = '';
                        	   		document.getElementById('errLocAddr1').innerHTML='';
  			                        document.getElementById("locAddr1").style.borderColor = '';
  			                        document.getElementById('errCost').innerHTML='';
  			                        document.getElementById("cost").style.borderColor = '';
  			                        document.getElementById('errPayment').innerHTML='';
  			                        document.getElementById("payment").style.borderColor = '';
  			                        document.getElementById('errMaxage').innerHTML="Please enter Maximum age";
                        	        document.getElementById('maxAge').focus();
                        	        document.getElementById("maxAge").style.borderColor = "red";
                      			           return false;
                      			        }
                      		     else if(clinicalTrialFrm.phenogender.value=="")
                      			        {
                      		    	document.getElementById("title").style.borderColor = '';
                        	        document.getElementById("abst").style.borderColor = '';
                        	  	    document.getElementById("startDateId").style.borderColor = '';
                        	     	document.getElementById("endDateId").style.borderColor = '';
                        	   		document.getElementById("button").style.borderColor = '';
  			                        document.getElementById("btn").style.borderColor = '';
  			                        document.getElementById("minAge").style.borderColor = '';
                        	  	    document.getElementById("maxAge").style.borderColor = '';
                        	     	document.getElementById("genogenderId").style.borderColor = '';
                        	   		document.getElementById("noOfVisits").style.borderColor = '';
  			                        document.getElementById("intervalOfVisits").style.borderColor = '';
  			                        document.getElementById("PIName").style.borderColor = '';
                        	  	    document.getElementById("PIEmail").style.borderColor = '';
                        	     	document.getElementById("PIPhone").style.borderColor = '';
                        	   		document.getElementById("PIAddress").style.borderColor = '';
  			                        document.getElementById("SCName1").style.borderColor = '';
  			                        document.getElementById("SCEmail1").style.borderColor = '';
                        	  	    document.getElementById("SCPhone1").style.borderColor = '';
                        	     	document.getElementById("SCAddress1").style.borderColor = '';
                        	   		document.getElementById("locName1").style.borderColor = '';
  			                        document.getElementById("locAddr1").style.borderColor = '';
  			                        document.getElementById("cost").style.borderColor = '';
  			                        document.getElementById("payment").style.borderColor = '';
                        	        document.getElementById('phenogenderId').focus();
                        	        document.getElementById("phenogenderId").style.borderColor = "red";
                      				           return false;
                      				        }
                      		   else if(clinicalTrialFrm.genogender.value=="")
             			        {
                      			    document.getElementById("title").style.borderColor = '';
                     	        	document.getElementById("abst").style.borderColor = '';
                     	  	    	document.getElementById("startDateId").style.borderColor = '';
                     	     		document.getElementById("endDateId").style.borderColor = '';
                     	   			document.getElementById("button").style.borderColor = '';
			                        document.getElementById("btn").style.borderColor = '';
			                        document.getElementById("minAge").style.borderColor = '';
                     	  	    	document.getElementById("maxAge").style.borderColor = '';
                     	     		document.getElementById("phenogenderId").style.borderColor = '';
                     	   			document.getElementById("noOfVisits").style.borderColor = '';
			                        document.getElementById("intervalOfVisits").style.borderColor = '';
			                        document.getElementById("PIName").style.borderColor = '';
                     	  	    	document.getElementById("PIEmail").style.borderColor = '';
                     	     		document.getElementById("PIPhone").style.borderColor = '';
                     	   			document.getElementById("PIAddress").style.borderColor = '';
			                        document.getElementById("SCName1").style.borderColor = '';
			                        document.getElementById("SCEmail1").style.borderColor = '';
                     	  	    	document.getElementById("SCPhone1").style.borderColor = '';
                     	     		document.getElementById("SCAddress1").style.borderColor = '';
                     	   			document.getElementById("locName1").style.borderColor = '';
			                        document.getElementById("locAddr1").style.borderColor = '';
			                        document.getElementById("cost").style.borderColor = '';
			                        document.getElementById("payment").style.borderColor = '';
                     	        	document.getElementById('genogenderId').focus();
                     	        	document.getElementById("genogenderId").style.borderColor = "red";
             				           return false;
             				        }
                      		 else if(clinicalTrialFrm.noOfVisits.value=="")
          			        {
                      			    document.getElementById('errTitle').innerHTML='';
                      				document.getElementById("title").style.borderColor = '';
                      				document.getElementById('errAbst').innerHTML='';
                 	        		document.getElementById("abst").style.borderColor = '';
                 	        		document.getElementById('errStartDt').innerHTML='';
                 	  	    		document.getElementById("startDateId").style.borderColor = '';
                 	  	    		document.getElementById('errEndDt').innerHTML='';
                 	     			document.getElementById("endDateId").style.borderColor = '';
                 	     			document.getElementById('errButton').innerHTML='';
                 	   				document.getElementById("button").style.borderColor = '';
                 	   				document.getElementById('errBtn').innerHTML='';
		                        	document.getElementById("btn").style.borderColor = '';
		                        	document.getElementById('errMinage').innerHTML='';
			                        document.getElementById("minAge").style.borderColor = '';
			                        document.getElementById('errMaxage').innerHTML='';
    	             	  	    	document.getElementById("maxAge").style.borderColor = '';
        	         	     		document.getElementById("phenogenderId").style.borderColor = '';
            	     	   			document.getElementById("genogenderId").style.borderColor = '';
            	     	   			document.getElementById('errIntervalOfVisits').innerHTML='';
		        	                document.getElementById("intervalOfVisits").style.borderColor = '';
		        	                document.getElementById('errPIName').innerHTML='';
		            	            document.getElementById("PIName").style.borderColor = '';
		            	            document.getElementById('errPIEmail').innerHTML='';
                 	  		    	document.getElementById("PIEmail").style.borderColor = '';
                 	  		    	document.getElementById('errPIPhone').innerHTML='';
                 	     			document.getElementById("PIPhone").style.borderColor = '';
                 	     			document.getElementById('errPIAddress').innerHTML='';
                 	   				document.getElementById("PIAddress").style.borderColor = '';
                 	   				document.getElementById('errSCName1').innerHTML='';
		                        	document.getElementById("SCName1").style.borderColor = '';
		                        	document.getElementById('errSCEmail1').innerHTML='';
		                        	document.getElementById("SCEmail1").style.borderColor = '';
		                        	document.getElementById('errSCPhone1').innerHTML='';
	                 	  	    	document.getElementById("SCPhone1").style.borderColor = '';
	                 	  	    	document.getElementById('errSCAddress1').innerHTML='';
    	             	     		document.getElementById("SCAddress1").style.borderColor = '';
    	             	     		document.getElementById('errLocName1').innerHTML='';
        	         	   			document.getElementById("locName1").style.borderColor = '';
        	         	   			document.getElementById('errLocAddr1').innerHTML='';
		    	                    document.getElementById("locAddr1").style.borderColor = '';
		    	                    document.getElementById('errCost').innerHTML='';
		        	                document.getElementById("cost").style.borderColor = '';
		        	                document.getElementById('errPayment').innerHTML='';
		            	            document.getElementById("payment").style.borderColor = '';
		            	            document.getElementById('errNoOfVisits').innerHTML="Please enter Number of visits";
                 	    	    	document.getElementById('noOfVisits').focus();
                 	        		document.getElementById("noOfVisits").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.intervalOfVisits.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
                      				document.getElementById("title").style.borderColor = '';
                      				document.getElementById('errAbst').innerHTML='';
             	        			document.getElementById("abst").style.borderColor = '';
             	        			document.getElementById('errStartDt').innerHTML='';
             	  	    			document.getElementById("startDateId").style.borderColor = '';
             	  	    			document.getElementById('errEndDt').innerHTML='';
	             	     			document.getElementById("endDateId").style.borderColor = '';
	             	     			document.getElementById('errButton').innerHTML='';
    	         	   				document.getElementById("button").style.borderColor = '';
    	         	   				document.getElementById('errBtn').innerHTML='';
	    	                    	document.getElementById("btn").style.borderColor = '';
	    	                    	document.getElementById('errMinage').innerHTML='';
		    	                    document.getElementById("minAge").style.borderColor = '';
		    	                    document.getElementById('errMaxage').innerHTML='';
	            	 	  	    	document.getElementById("maxAge").style.borderColor = '';
    	         		     		document.getElementById("phenogenderId").style.borderColor = '';
        	     	   				document.getElementById("genogenderId").style.borderColor = '';
        	     	   				document.getElementById('errNoOfVisits').innerHTML='';
	        	            	    document.getElementById("noOfVisits").style.borderColor = '';
	        	            	    document.getElementById('errPIName').innerHTML='';
	            	            	document.getElementById("PIName").style.borderColor = '';
	            	            	document.getElementById('errPIEmail').innerHTML='';
	             	  		    	document.getElementById("PIEmail").style.borderColor = '';
	             	  		    	document.getElementById('errPIPhone').innerHTML='';
    	         	     			document.getElementById("PIPhone").style.borderColor = '';
    	         	     			document.getElementById('errPIAddress').innerHTML='';
        	     	   				document.getElementById("PIAddress").style.borderColor = '';
        	     	   				document.getElementById('errSCName1').innerHTML='';
	        	                	document.getElementById("SCName1").style.borderColor = '';
	        	                	document.getElementById('errSCEmail1').innerHTML='';
	            	            	document.getElementById("SCEmail1").style.borderColor = '';
	            	            	document.getElementById('errSCPhone1').innerHTML='';
                 		  	    	document.getElementById("SCPhone1").style.borderColor = '';
                 		  	    	document.getElementById('errSCAddress1').innerHTML='';
	             	    	 		document.getElementById("SCAddress1").style.borderColor = '';
	             	    	 		document.getElementById('errLocName1').innerHTML='';
    	         	   				document.getElementById("locName1").style.borderColor = '';
    	         	   				document.getElementById('errLocAddr1').innerHTML='';
	    	                    	document.getElementById("locAddr1").style.borderColor = '';
	    	                    	document.getElementById('errCost').innerHTML='';
		        	                document.getElementById("cost").style.borderColor = '';
		        	                document.getElementById('errPayment').innerHTML='';
		            	            document.getElementById("payment").style.borderColor = '';
		            	            document.getElementById('errIntervalOfVisits').innerHTML="Please enter Interval of visits";
        	     	    	    	document.getElementById('intervalOfVisits').focus();
            	 	        		document.getElementById("intervalOfVisits").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.PIName.value=="")
          			        {	
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
    	     	        			document.getElementById("abst").style.borderColor = '';
    	     	        			document.getElementById('errStartDt').innerHTML='';
        	 	  	    			document.getElementById("startDateId").style.borderColor = '';
        	 	  	    			document.getElementById('errEndDt').innerHTML='';
            	 	     			document.getElementById("endDateId").style.borderColor = '';
            	 	     			document.getElementById('errButton').innerHTML='';
	         		   				document.getElementById("button").style.borderColor = '';
	         		   				document.getElementById('errBtn').innerHTML='';
    	            	        	document.getElementById("btn").style.borderColor = '';
    	            	        	document.getElementById('errMinage').innerHTML='';
	    	            	        document.getElementById("minAge").style.borderColor = '';
	    	            	        document.getElementById('errMaxage').innerHTML='';
            	 	  	    		document.getElementById("maxAge").style.borderColor = '';
	         		     			document.getElementById("phenogenderId").style.borderColor = '';
	    	     	   				document.getElementById("genogenderId").style.borderColor = '';
	    	     	   				document.getElementById('errNoOfVisits').innerHTML='';
    	    	            	    document.getElementById("noOfVisits").style.borderColor = '';
    	    	            	    document.getElementById('errIntervalOfVisits').innerHTML='';
        	    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
        	    	            	document.getElementById('errPIEmail').innerHTML='';
            	 	  		    	document.getElementById("PIEmail").style.borderColor = '';
            	 	  		    	document.getElementById('errPIPhone').innerHTML='';
	         		     			document.getElementById("PIPhone").style.borderColor = '';
	         		     			document.getElementById('errPIAddress').innerHTML='';
    	     	   					document.getElementById("PIAddress").style.borderColor = '';
    	     	   					document.getElementById('errSCName1').innerHTML='';
        	            	    	document.getElementById("SCName1").style.borderColor = '';
        	            	    	document.getElementById('errSCEmail1').innerHTML='';
            	            		document.getElementById("SCEmail1").style.borderColor = '';
            	            		document.getElementById('errSCPhone1').innerHTML='';
             		  	    		document.getElementById("SCPhone1").style.borderColor = '';
             		  	    		document.getElementById('errSCAddress1').innerHTML='';
	             	    	 		document.getElementById("SCAddress1").style.borderColor = '';
	             	    	 		document.getElementById('errLocName1').innerHTML='';
		         	   				document.getElementById("locName1").style.borderColor = '';
		         	   				document.getElementById('errLocAddr1').innerHTML='';
    		                    	document.getElementById("locAddr1").style.borderColor = '';
    		                    	document.getElementById('errCost').innerHTML='';
	        		                document.getElementById("cost").style.borderColor = '';
	        		                document.getElementById('errPayment').innerHTML='';
	            		            document.getElementById("payment").style.borderColor = '';
	            		            document.getElementById('errPIName').innerHTML="Please enter Principal Investigator Name";
    	     	    		    	document.getElementById('PIName').focus();
        	 	        			document.getElementById("PIName").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.PIEmail.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
    		 	  	    			document.getElementById("startDateId").style.borderColor = '';
    		 	  	    			document.getElementById('errEndDt').innerHTML='';
        		 	     			document.getElementById("endDateId").style.borderColor = '';
        		 	     			document.getElementById('errButton').innerHTML='';
         			   				document.getElementById("button").style.borderColor = '';
         			   				document.getElementById('errBtn').innerHTML='';
	            		        	document.getElementById("btn").style.borderColor = '';
	            		        	document.getElementById('errMinage').innerHTML='';
    	            		        document.getElementById("minAge").style.borderColor = '';
    	            		        document.getElementById('errMaxage').innerHTML='';
        	 	  	    			document.getElementById("maxAge").style.borderColor = '';
         		     				document.getElementById("phenogenderId").style.borderColor = '';
	    	     	   				document.getElementById("genogenderId").style.borderColor = '';
	    	     	   				document.getElementById('errNoOfVisits').innerHTML='';
		    	            	    document.getElementById("noOfVisits").style.borderColor = '';
		    	            	    document.getElementById('errIntervalOfVisits').innerHTML='';
    		    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
    		    	            	document.getElementById('errPIName').innerHTML='';
        		 	  		    	document.getElementById("PIName").style.borderColor = '';
        		 	  		    	document.getElementById('errPIPhone').innerHTML='';
         			     			document.getElementById("PIPhone").style.borderColor = '';
         			     			document.getElementById('errPIAddress').innerHTML='';
	     	   						document.getElementById("PIAddress").style.borderColor = '';
	     	   						document.getElementById('errSCName1').innerHTML='';
    	            		    	document.getElementById("SCName1").style.borderColor = '';
    	            		    	document.getElementById('errSCEmail1').innerHTML='';
        	            			document.getElementById("SCEmail1").style.borderColor = '';
        	            			document.getElementById('errSCPhone1').innerHTML='';
         		  	    			document.getElementById("SCPhone1").style.borderColor = '';
         		  	    			document.getElementById('errSCAddress1').innerHTML='';
	             	    	 		document.getElementById("SCAddress1").style.borderColor = '';
	             	    	 		document.getElementById('errLocName1').innerHTML='';
		         	   				document.getElementById("locName1").style.borderColor = '';
		         	   				document.getElementById('errLocAddr1').innerHTML='';
			                    	document.getElementById("locAddr1").style.borderColor = '';
			                    	document.getElementById('errCost').innerHTML='';
        			                document.getElementById("cost").style.borderColor = '';
        			                document.getElementById('errPayment').innerHTML='';
            			            document.getElementById("payment").style.borderColor = '';
            			            document.getElementById('errPIEmail').innerHTML="Please enter Principal Investigator Email";
	     	    			    	document.getElementById('PIEmail').focus();
    	 	        				document.getElementById("PIEmail").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.PIPhone.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
    			 	     			document.getElementById("endDateId").style.borderColor = '';
    			 	     			document.getElementById('errButton').innerHTML='';
     				   				document.getElementById("button").style.borderColor = '';
     				   				document.getElementById('errBtn').innerHTML='';
            			        	document.getElementById("btn").style.borderColor = '';
            			        	document.getElementById('errMinage').innerHTML='';
	            			        document.getElementById("minAge").style.borderColor = '';
	            			        document.getElementById('errMaxage').innerHTML='';
    	 	  	    				document.getElementById("maxAge").style.borderColor = '';
     		     					document.getElementById("phenogenderId").style.borderColor = '';
	    	     	   				document.getElementById("genogenderId").style.borderColor = '';
	    	     	   				document.getElementById('errNoOfVisits').innerHTML='';
		    	            	    document.getElementById("noOfVisits").style.borderColor = '';
		    	            	    document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
    			 	  		    	document.getElementById("PIName").style.borderColor = '';
    			 	  		    	document.getElementById('errPIEmail').innerHTML='';
     				     			document.getElementById("PIEmail").style.borderColor = '';
     				     			document.getElementById('errPIAddress').innerHTML='';
     	   							document.getElementById("PIAddress").style.borderColor = '';
     	   							document.getElementById('errSCName1').innerHTML='';
	            			    	document.getElementById("SCName1").style.borderColor = '';
	            			    	document.getElementById('errSCEmail1').innerHTML='';
    	            				document.getElementById("SCEmail1").style.borderColor = '';
    	            				document.getElementById('errSCPhone1').innerHTML='';
     		  	    				document.getElementById("SCPhone1").style.borderColor = '';
     		  	    				document.getElementById('errSCAddress1').innerHTML='';
	             	    	 		document.getElementById("SCAddress1").style.borderColor = '';
	             	    	 		document.getElementById('errLocName1').innerHTML='';
		         	   				document.getElementById("locName1").style.borderColor = '';
		         	   				document.getElementById('errLocAddr1').innerHTML='';
			                    	document.getElementById("locAddr1").style.borderColor = '';
			                    	document.getElementById('errCost').innerHTML='';
    				                document.getElementById("cost").style.borderColor = '';
    				                document.getElementById('errPayment').innerHTML='';
        				            document.getElementById("payment").style.borderColor = '';
        				            document.getElementById('errPIPhone').innerHTML="Please enter Principal Investigator Phone";
     	    				    	document.getElementById('PIPhone').focus();
	 	        					document.getElementById("PIPhone").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.PIAddress.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
 					   				document.getElementById("button").style.borderColor = '';
 					   				document.getElementById('errBtn').innerHTML='';
        				        	document.getElementById("btn").style.borderColor = '';
        				        	document.getElementById('errMinage').innerHTML='';
            				        document.getElementById("minAge").style.borderColor = '';
            				        document.getElementById('errMaxage').innerHTML='';
	 	  	    					document.getElementById("maxAge").style.borderColor = '';
 		     						document.getElementById("phenogenderId").style.borderColor = '';
	    	     	   				document.getElementById("genogenderId").style.borderColor = '';
	    	     	   				document.getElementById('errNoOfVisits').innerHTML='';
		    	            	    document.getElementById("noOfVisits").style.borderColor = '';
		    	            	    document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
 					     			document.getElementById("PIEmail").style.borderColor = '';
 					     			document.getElementById('errPIPhone').innerHTML='';
 	   								document.getElementById("PIPhone").style.borderColor = '';
 	   								document.getElementById('errSCName1').innerHTML='';
            				    	document.getElementById("SCName1").style.borderColor = '';
            				    	document.getElementById('errSCEmail1').innerHTML='';
	            					document.getElementById("SCEmail1").style.borderColor = '';
	            					document.getElementById('errSCPhone1').innerHTML='';
 		  	    					document.getElementById("SCPhone1").style.borderColor = '';
 		  	    					document.getElementById('errSCAddress1').innerHTML='';
	             	    	 		document.getElementById("SCAddress1").style.borderColor = '';
	             	    	 		document.getElementById('errLocName1').innerHTML='';
		         	   				document.getElementById("locName1").style.borderColor = '';
		         	   				document.getElementById('errLocAddr1').innerHTML='';
			                    	document.getElementById("locAddr1").style.borderColor = '';
			                    	document.getElementById('errCost').innerHTML='';
					                document.getElementById("cost").style.borderColor = '';
					                document.getElementById('errPayment').innerHTML='';
    					            document.getElementById("payment").style.borderColor = '';
    					            document.getElementById('errPIAddress').innerHTML="Please enter Principal Investigator Address";
 	    					    	document.getElementById('PIAddress').focus();
 	        						document.getElementById("PIAddress").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.SCName1.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
					   				document.getElementById("button").style.borderColor = '';
					   				document.getElementById('errBtn').innerHTML='';
    					        	document.getElementById("btn").style.borderColor = '';
    					        	document.getElementById('errMinage').innerHTML='';
        					        document.getElementById("minAge").style.borderColor = '';
        					        document.getElementById('errMaxage').innerHTML='';
 	  	    						document.getElementById("maxAge").style.borderColor = '';
		     						document.getElementById("phenogenderId").style.borderColor = '';
    	     	   					document.getElementById("genogenderId").style.borderColor = '';
    	     	   					document.getElementById('errNoOfVisits').innerHTML='';
	    	            	    	document.getElementById("noOfVisits").style.borderColor = '';
	    	            	    	document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
					     			document.getElementById("PIEmail").style.borderColor = '';
					     			document.getElementById('errPIPhone').innerHTML='';
	   								document.getElementById("PIPhone").style.borderColor = '';
	   								document.getElementById('errPIAddress').innerHTML='';
        					    	document.getElementById("PIAddress").style.borderColor = '';
        					    	document.getElementById('errSCEmail1').innerHTML='';
            						document.getElementById("SCEmail1").style.borderColor = '';
            						document.getElementById('errSCPhone1').innerHTML='';
		  	    					document.getElementById("SCPhone1").style.borderColor = '';
		  	    					document.getElementById('errSCAddress1').innerHTML='';
             		    	 		document.getElementById("SCAddress1").style.borderColor = '';
             		    	 		document.getElementById('errLocName1').innerHTML='';
	         	   					document.getElementById("locName1").style.borderColor = '';
	         	   					document.getElementById('errLocAddr1').innerHTML='';
		                	    	document.getElementById("locAddr1").style.borderColor = '';
		                	    	document.getElementById('errCost').innerHTML='';
				            	    document.getElementById("cost").style.borderColor = '';
				            	    document.getElementById('errPayment').innerHTML='';
					            	document.getElementById("payment").style.borderColor = '';
					            	document.getElementById('errSCName1').innerHTML="Please enter Study Coordinator name";
	    					    	document.getElementById('SCName1').focus();
	        						document.getElementById("SCName1").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.SCEmail1.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
					   				document.getElementById("button").style.borderColor = '';
					   				document.getElementById('errBtn').innerHTML='';
						        	document.getElementById("btn").style.borderColor = '';
						        	document.getElementById('errMinage').innerHTML='';
    						        document.getElementById("minAge").style.borderColor = '';
    						        document.getElementById('errMaxage').innerHTML='';
	  	    						document.getElementById("maxAge").style.borderColor = '';
	     							document.getElementById("phenogenderId").style.borderColor = '';
	     	   						document.getElementById("genogenderId").style.borderColor = '';
	     	   						document.getElementById('errNoOfVisits').innerHTML='';
	    	            	    	document.getElementById("noOfVisits").style.borderColor = '';
	    	            	    	document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
					     			document.getElementById("PIEmail").style.borderColor = '';
					     			document.getElementById('errPIPhone').innerHTML='';
   									document.getElementById("PIPhone").style.borderColor = '';
   									document.getElementById('errPIAddress').innerHTML='';
    						    	document.getElementById("PIAddress").style.borderColor = '';
    						    	document.getElementById('errSCName1').innerHTML='';
        							document.getElementById("SCName1").style.borderColor = '';
        							document.getElementById('errSCPhone1').innerHTML='';
	  	    						document.getElementById("SCPhone1").style.borderColor = '';
	  	    						document.getElementById('errSCAddress1').innerHTML='';
         		    	 			document.getElementById("SCAddress1").style.borderColor = '';
         		    	 			document.getElementById('errLocName1').innerHTML='';
	         	   					document.getElementById("locName1").style.borderColor = '';
	         	   					document.getElementById('errLocAddr1').innerHTML='';
		                	    	document.getElementById("locAddr1").style.borderColor = '';
		                	    	document.getElementById('errCost').innerHTML='';
				            	    document.getElementById("cost").style.borderColor = '';
				            	    document.getElementById('errPayment').innerHTML='';
					            	document.getElementById("payment").style.borderColor = '';
					            	document.getElementById('errSCEmail1').innerHTML="Please enter Study Coordinator Email";
    						    	document.getElementById('SCEmail1').focus();
        							document.getElementById("SCEmail1").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.SCPhone1.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
					   				document.getElementById("button").style.borderColor = '';
					   				document.getElementById('errBtn').innerHTML='';
						        	document.getElementById("btn").style.borderColor = '';
						        	document.getElementById('errMinage').innerHTML='';
							        document.getElementById("minAge").style.borderColor = '';
							        document.getElementById('errMaxage').innerHTML='';
  	    							document.getElementById("maxAge").style.borderColor = '';
     								document.getElementById("phenogenderId").style.borderColor = '';
	     	   						document.getElementById("genogenderId").style.borderColor = '';
	     	   						document.getElementById('errNoOfVisits').innerHTML='';
    		            	    	document.getElementById("noOfVisits").style.borderColor = '';
    		            	    	document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
					     			document.getElementById("PIEmail").style.borderColor = '';
					     			document.getElementById('errPIPhone').innerHTML='';
									document.getElementById("PIPhone").style.borderColor = '';
									document.getElementById('errPIAddress').innerHTML='';
							    	document.getElementById("PIAddress").style.borderColor = '';
							    	document.getElementById('errSCName1').innerHTML='';
    								document.getElementById("SCName1").style.borderColor = '';
    								document.getElementById('errSCEmail1').innerHTML='';
  	    							document.getElementById("SCEmail1").style.borderColor = '';
  	    							document.getElementById('errSCAddress1').innerHTML='';
     		    	 				document.getElementById("SCAddress1").style.borderColor = '';
     		    	 				document.getElementById('errLocName1').innerHTML='';
	         	   					document.getElementById("locName1").style.borderColor = '';
	         	   					document.getElementById('errLocAddr1').innerHTML='';
		                	    	document.getElementById("locAddr1").style.borderColor = '';
		                	    	document.getElementById('errCost').innerHTML='';
				            	    document.getElementById("cost").style.borderColor = '';
				            	    document.getElementById('errPayment').innerHTML='';
					            	document.getElementById("payment").style.borderColor = '';
					            	document.getElementById('errSCPhone1').innerHTML="Please enter Study Coordinator Phone";
							    	document.getElementById('SCPhone1').focus();
    								document.getElementById("SCPhone1").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.SCAddress1.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
					   				document.getElementById("button").style.borderColor = '';
					   				document.getElementById('errBtn').innerHTML='';
						        	document.getElementById("btn").style.borderColor = '';
						        	document.getElementById('errMinage').innerHTML='';
							        document.getElementById("minAge").style.borderColor = '';
							        document.getElementById('errMaxage').innerHTML='';
	    							document.getElementById("maxAge").style.borderColor = '';
 									document.getElementById("phenogenderId").style.borderColor = '';
     	   							document.getElementById("genogenderId").style.borderColor = '';
     	   							document.getElementById('errNoOfVisits').innerHTML='';
			            	    	document.getElementById("noOfVisits").style.borderColor = '';
			            	    	document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
					     			document.getElementById("PIEmail").style.borderColor = '';
					     			document.getElementById('errPIPhone').innerHTML='';
									document.getElementById("PIPhone").style.borderColor = '';
									document.getElementById('errPIAddress').innerHTML='';
							    	document.getElementById("PIAddress").style.borderColor = '';
							    	document.getElementById('errSCName1').innerHTML='';
									document.getElementById("SCName1").style.borderColor = '';
									document.getElementById('errSCEmail1').innerHTML='';
	    							document.getElementById("SCEmail1").style.borderColor = '';
	    							document.getElementById('errSCPhone1').innerHTML='';
 		    	 					document.getElementById("SCPhone1").style.borderColor = '';
 		    	 					document.getElementById('errLocName1').innerHTML='';
         	   						document.getElementById("locName1").style.borderColor = '';
         	   						document.getElementById('errLocAddr1').innerHTML='';
		                	    	document.getElementById("locAddr1").style.borderColor = '';
		                	    	document.getElementById('errCost').innerHTML='';
				            	    document.getElementById("cost").style.borderColor = '';
				            	    document.getElementById('errPayment').innerHTML='';
					            	document.getElementById("payment").style.borderColor = '';
					            	document.getElementById('errSCAddress1').innerHTML="Please enter Study Coordinator Address";
							    	document.getElementById('SCAddress1').focus();
									document.getElementById("SCAddress1").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.locName1.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
                      			    document.getElementById("title").style.borderColor = '';
                      			  	document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
					   				document.getElementById("button").style.borderColor = '';
					   				document.getElementById('errBtn').innerHTML='';
						        	document.getElementById("btn").style.borderColor = '';
						        	document.getElementById('errMinage').innerHTML='';
							        document.getElementById("minAge").style.borderColor = '';
							        document.getElementById('errMaxage').innerHTML='';
    								document.getElementById("maxAge").style.borderColor = '';
									document.getElementById("phenogenderId").style.borderColor = '';
 	   								document.getElementById("genogenderId").style.borderColor = '';
 	   								document.getElementById('errNoOfVisits').innerHTML='';
			            	    	document.getElementById("noOfVisits").style.borderColor = '';
			            	    	document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
					     			document.getElementById("PIEmail").style.borderColor = '';
					     			document.getElementById('errPIPhone').innerHTML='';
									document.getElementById("PIPhone").style.borderColor = '';
									document.getElementById('errPIAddress').innerHTML='';
							    	document.getElementById("PIAddress").style.borderColor = '';
							    	document.getElementById('errSCName1').innerHTML='';
									document.getElementById("SCName1").style.borderColor = '';
									document.getElementById('errSCEmail1').innerHTML='';
    								document.getElementById("SCEmail1").style.borderColor = '';
    								document.getElementById('errSCPhone1').innerHTML='';
		    	 					document.getElementById("SCPhone1").style.borderColor = '';
		    	 					document.getElementById('errSCAddress1').innerHTML='';
	     	   						document.getElementById("SCAddress1").style.borderColor = '';
	     	   						document.getElementById('errLocAddr1').innerHTML='';
		                	    	document.getElementById("locAddr1").style.borderColor = '';
		                	    	document.getElementById('errCost').innerHTML='';
				            	    document.getElementById("cost").style.borderColor = '';
				            	    document.getElementById('errPayment').innerHTML='';
					            	document.getElementById("payment").style.borderColor = '';
					            	document.getElementById('errLocName1').innerHTML="Please enter Location Name";
							    	document.getElementById('locName1').focus();
									document.getElementById("locName1").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.locAddr1.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
                      				document.getElementById("title").style.borderColor = '';
                      				document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
					   				document.getElementById("button").style.borderColor = '';
					   				document.getElementById('errBtn').innerHTML='';
						        	document.getElementById("btn").style.borderColor = '';
						        	document.getElementById('errMinage').innerHTML='';
							        document.getElementById("minAge").style.borderColor = '';
							        document.getElementById('errMaxage').innerHTML='';
									document.getElementById("maxAge").style.borderColor = '';
									document.getElementById("phenogenderId").style.borderColor = '';
	   								document.getElementById("genogenderId").style.borderColor = '';
	   								document.getElementById('errNoOfVisits').innerHTML='';
		            	    		document.getElementById("noOfVisits").style.borderColor = '';
		            	    		document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
					     			document.getElementById("PIEmail").style.borderColor = '';
					     			document.getElementById('errPIPhone').innerHTML='';
									document.getElementById("PIPhone").style.borderColor = '';
									document.getElementById('errPIAddress').innerHTML='';
							    	document.getElementById("PIAddress").style.borderColor = '';
							    	document.getElementById('errSCName1').innerHTML='';
									document.getElementById("SCName1").style.borderColor = '';
									document.getElementById('errSCEmail1').innerHTML='';
									document.getElementById("SCEmail1").style.borderColor = '';
									document.getElementById('errSCPhone1').innerHTML='';
	    	 						document.getElementById("SCPhone1").style.borderColor = '';
     	   							document.getElementById("errSCAddress1").style.borderColor = '';
     	   							document.getElementById('errLocName1').innerHTML='';
		                	    	document.getElementById("locName1").style.borderColor = '';
		                	    	document.getElementById('errCost').innerHTML='';
				            	    document.getElementById("cost").style.borderColor = '';
				            	    document.getElementById('errPayment').innerHTML='';
					            	document.getElementById("payment").style.borderColor = '';
					            	document.getElementById('errLocAddr1').innerHTML="Please enter Location Address";
							    	document.getElementById('locAddr1').focus();
									document.getElementById("locAddr1").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.cost.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
					   				document.getElementById("button").style.borderColor = '';
					   				document.getElementById('errBtn').innerHTML='';
						        	document.getElementById("btn").style.borderColor = '';
						        	document.getElementById('errMinage').innerHTML='';
							        document.getElementById("minAge").style.borderColor = '';
							        document.getElementById('errMaxage').innerHTML='';
									document.getElementById("maxAge").style.borderColor = '';
									document.getElementById("phenogenderId").style.borderColor = '';
	   								document.getElementById("genogenderId").style.borderColor = '';
	   								document.getElementById('errNoOfVisits').innerHTML='';
		            	    		document.getElementById("noOfVisits").style.borderColor = '';
		            	    		document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
					     			document.getElementById("PIEmail").style.borderColor = '';
					     			document.getElementById('errPIPhone').innerHTML='';
									document.getElementById("PIPhone").style.borderColor = '';
									document.getElementById('errPIAddress').innerHTML='';
							    	document.getElementById("PIAddress").style.borderColor = '';
							    	document.getElementById('errSCName1').innerHTML='';
									document.getElementById("SCName1").style.borderColor = '';
									document.getElementById('errSCEmail1').innerHTML='';
									document.getElementById("SCEmail1").style.borderColor = '';
									document.getElementById('errSCPhone1').innerHTML='';
	    	 						document.getElementById("SCPhone1").style.borderColor = '';
	    	 						document.getElementById('errSCAddress1').innerHTML='';
 		   							document.getElementById("SCAddress1").style.borderColor = '';
 		   							document.getElementById('errLocName1').innerHTML='';
	    	            	    	document.getElementById("locName1").style.borderColor = '';
	    	            	    	document.getElementById('errLocAddr1').innerHTML='';
			    	        	    document.getElementById("locAddr1").style.borderColor = '';
			    	        	    document.getElementById('errPayment').innerHTML='';
					            	document.getElementById("payment").style.borderColor = '';
					            	document.getElementById('errCost').innerHTML="Please enter Cost";
							    	document.getElementById('cost').focus();
									document.getElementById("cost").style.borderColor = "red";
          				           return false;
          				        }
                      		else if(clinicalTrialFrm.payment.value=="")
          			        {
                      				document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
					   				document.getElementById("button").style.borderColor = '';
					   				document.getElementById('errBtn').innerHTML='';
						        	document.getElementById("btn").style.borderColor = '';
						        	document.getElementById('errMinage').innerHTML='';
							        document.getElementById("minAge").style.borderColor = '';
							        document.getElementById('errMaxage').innerHTML='';
									document.getElementById("maxAge").style.borderColor = '';
									document.getElementById("phenogenderId").style.borderColor = '';
	   								document.getElementById("genogenderId").style.borderColor = '';
	   								document.getElementById('errNoOfVisits').innerHTML='';
		            	    		document.getElementById("noOfVisits").style.borderColor = '';
		            	    		document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
					     			document.getElementById("PIEmail").style.borderColor = '';
					     			document.getElementById('errPIPhone').innerHTML='';
									document.getElementById("PIPhone").style.borderColor = '';
									document.getElementById('errPIAddress').innerHTML='';
							    	document.getElementById("PIAddress").style.borderColor = '';
							    	document.getElementById('errSCName1').innerHTML='';
									document.getElementById("SCName1").style.borderColor = '';
									document.getElementById('errSCEmail1').innerHTML='';
									document.getElementById("SCEmail1").style.borderColor = '';
									document.getElementById('errSCPhone1').innerHTML='';
	    	 						document.getElementById("SCPhone1").style.borderColor = '';
	    	 						document.getElementById('errSCAddress1').innerHTML='';
		   							document.getElementById("SCAddress1").style.borderColor = '';
		   							document.getElementById('errLocName1').innerHTML='';
    		            	    	document.getElementById("locName1").style.borderColor = '';
    		            	    	document.getElementById('errLocAddr1').innerHTML='';
		    		        	    document.getElementById("locAddr1").style.borderColor = '';
		    		        	    document.getElementById('errCost').innerHTML='';
					            	document.getElementById("cost").style.borderColor = '';
					            	document.getElementById('errPayment').innerHTML="Please enter Payment";
							    	document.getElementById('payment').focus();
									document.getElementById("payment").style.borderColor = "red";
          				           return false;
          				        }
                      	        else{
                      	        	document.getElementById('errTitle').innerHTML='';
	                      			document.getElementById("title").style.borderColor = '';
	                      			document.getElementById('errAbst').innerHTML='';
		     	        			document.getElementById("abst").style.borderColor = '';
		     	        			document.getElementById('errStartDt').innerHTML='';
			 	  	    			document.getElementById("startDateId").style.borderColor = '';
			 	  	    			document.getElementById('errEndDt').innerHTML='';
				 	     			document.getElementById("endDateId").style.borderColor = '';
				 	     			document.getElementById('errButton').innerHTML='';
					   				document.getElementById("button").style.borderColor = '';
					   				document.getElementById('errBtn').innerHTML='';
						        	document.getElementById("btn").style.borderColor = '';
						        	document.getElementById('errMinage').innerHTML='';
							        document.getElementById("minAge").style.borderColor = '';
							        document.getElementById('errMaxage').innerHTML='';
									document.getElementById("maxAge").style.borderColor = '';
									document.getElementById("phenogenderId").style.borderColor = '';
	   								document.getElementById("genogenderId").style.borderColor = '';
	   								document.getElementById('errNoOfVisits').innerHTML='';
		            	    		document.getElementById("noOfVisits").style.borderColor = '';
		            	    		document.getElementById('errIntervalOfVisits').innerHTML='';
			    	            	document.getElementById("intervalOfVisits").style.borderColor = '';
			    	            	document.getElementById('errPIName').innerHTML='';
				 	  		    	document.getElementById("PIName").style.borderColor = '';
				 	  		    	document.getElementById('errPIEmail').innerHTML='';
					     			document.getElementById("PIEmail").style.borderColor = '';
					     			document.getElementById('errPIPhone').innerHTML='';
									document.getElementById("PIPhone").style.borderColor = '';
									document.getElementById('errPIAddress').innerHTML='';
							    	document.getElementById("PIAddress").style.borderColor = '';
							    	document.getElementById('errSCName1').innerHTML='';
									document.getElementById("SCName1").style.borderColor = '';
									document.getElementById('errSCEmail1').innerHTML='';
									document.getElementById("SCEmail1").style.borderColor = '';
									document.getElementById('errSCPhone1').innerHTML='';
	    	 						document.getElementById("SCPhone1").style.borderColor = '';
	    	 						document.getElementById('errSCAddress1').innerHTML='';
		   							document.getElementById("SCAddress1").style.borderColor = '';
		   							document.getElementById('errLocName1').innerHTML='';
    		            	    	document.getElementById("locName1").style.borderColor = '';
    		            	    	document.getElementById('errLocAddr1').innerHTML='';
		    		        	    document.getElementById("locAddr1").style.borderColor = '';
		    		        	    document.getElementById('errCost').innerHTML='';
					            	document.getElementById("cost").style.borderColor = '';
					            	document.getElementById('errPayment').innerHTML='';
									document.getElementById("payment").style.borderColor = '';
                      	        	return true;
                      	        }
                      	    }
                             
</script>
 </head>
<body>
			<%
			String trialId= (String)session.getAttribute("trialID");
			%>
<div class="header">
    <div class="home-menu pure-menu pure-menu-horizontal pure-menu-fixed">
    <% if (trialId != null && !trialId.isEmpty()) {
    	session.setAttribute("trialId", trialId);
    %>
						<div style="color: white" align="left" style="padding-top: 2px; font-size:50%; font-family: fantasy;">Please note your trialID number is:<%=trialId%></div>
						<%} %>
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
		       <h3 class="splash-head" style="font-size:200%; font-weight:normal" >WNY Clinical Trials</h3>
		    </div>
		    </div>
		</div>
		</div>
		<div class="panel-body" align="center">
			<div class="content-wrapper">
				<form name="clinicalTrialFrm" id="clinicalTrialId" method="post" action="ClinicalTrialServlet"
					class="form-horizontal" role="form">
					
					<table
						style="height: 550px; align: center; border-collapse: collapse;"
						width="95%" cellpadding="0" cellspacing="0" id="boxgroup">

						<tr class="form-group">
							<td align="left" width="300px" style="padding-top: 10px;" nowrap><b><font color="black"
									style="font-family: fantasy;">Title: </font></b>
							</td>
							<td class="col-sm-4" style="padding-top: 10px;" align="left"><font size="4"><b>
										<font color="blue"> 
										<input type="text" class="form-control"
																			name="title" id="title" size="40" height="10px"/><span id="errTitle" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font
									color="black" style="font-family: fantasy;">Abstract: </font></b>
							</td>
							<td class="col-sm-4" align="left">
								<font size="2"><b> <font color="black">
								<textarea class="form-control" name="abst" id="abst" cols="50" rows="10"></textarea><span id="errAbst" style='color:red;font-size: small;'></span>
								</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Recruitment Start date:(DD-MON-YY) </font></b></td>
							<td class="col-sm-4"><font size="4"><b> <font
										color="blue"> 
									 <input type="text" id="startDateId"
																			placeholder="click to select date" class="form-control"
																			class="hero-unit" name="startDate" size="40"
																			height="10px" /> <span id="errStartDt" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Recruitment End date:(DD-MON-YY) </font></b></td>
							<td class="col-sm-4"><font size="4"><b> <font
										color="blue"> 
									 <input type="text" id="endDateId"
																			placeholder="click to select date" class="form-control"
																			class="hero-unit" name="endDate" size="40"
																			height="10px" /><span id="errEndDt" style='color:red;font-size: small;'></span> 
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Inclusion Criteria: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="black">									 
										<textarea class="form-control" name=inclusion id=inclusion value="Insert text" data-autosize-input='{ "space": 40 }'></textarea></font>
                                        <input type=button name=button id=button value="OK" style="width: 10%; font-size: 0.7em;"
										onclick="show(document.getElementById('inclusion').value)"/>
										<div id="text" name="textName" style="font-size: 0.7em;"></div>	
										<input type="hidden" name="hiddenInclusion" id="hiddenInclusion" /><span id="errButton" style='color:red;font-size: small;'></span>						
									</font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" wrap><b><font color="black"
									style="font-family: fantasy;">Exclusion Criteria: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="black">
										<textarea class="form-control" name=exclusion id=exclusion value="Insert text" data-autosize-input='{ "space": 40 }'></textarea></font>
                                        <input type=button name=btn id=btn value="OK" style="width: 10%; font-size: 0.7em;"
										onclick="showExclusion(document.getElementById('exclusion').value)"/>
										<div id="extext" style="font-size: 0.7em;"></div>
										<input type="hidden" name="hiddenExclusion" id="hiddenExclusion" /><span id="errBtn" style='color:red;font-size: small;'></span>
									</font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Minimum Age: </font></b>
							</td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue"> 
										<input type="text" class="form-control"
																			name="minAge" id="minAge" size="40" height="10px"/><span id="errMinage" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Maximum Age: </font></b>
							</td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue"> 
										<input type="text" class="form-control"
																			name="maxAge" id="maxAge" size="40" height="10px"/><span id="errMaxage" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Phenotypic Gender: </font></b></td>
							<td class="col-sm-4" align="left"><select id="phenogenderId"
								name="phenogender" class="form-control" style="width: 400px;">
									<%
										List phenogenderList = new ArrayList();
									    phenogenderList.add("Male");
									    phenogenderList.add("Female");
											for (int k = 0; k < phenogenderList.size(); k++) {
									%>
									<option value="<%=phenogenderList.get(k)%>"><%=phenogenderList.get(k)%></option>
									<%
										}
									%>
							</select>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Genotypic Gender: </font></b></td>
							<td class="col-sm-4" align="left"><select id="genogenderId"
								name="genogender" class="form-control" style="width: 400px;">
									<%
										List genogenderList = new ArrayList();
									    genogenderList.add("Male");
									    genogenderList.add("Female");
											for (int k = 0; k < genogenderList.size(); k++) {
									%>
									<option value="<%=genogenderList.get(k)%>"><%=genogenderList.get(k)%></option>
									<%
										}
									%>
							</select></td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Number of Visits: </font></b>
							</td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue"> 
										<input type="text" class="form-control"
																			name="noOfVisits" id="noOfVisits" size="40" height="10px"/><span id="errNoOfVisits" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Interval of visits: </font></b>
							</td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue"> 
										<input type="text" class="form-control"
																			name="intervalOfVisits" id="intervalOfVisits" size="40" height="10px"/><span id="errIntervalOfVisits" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Principal Investigator Name: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="PIName" id="PIName" size="40" height="10px"/><span id="errPIName" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Principal Investigator Email: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="PIEmail" id="PIEmail" size="40" height="10px"/><span id="errPIEmail" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Principal Investigator Phone: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="PIPhone" id="PIPhone" size="40" height="10px"/><span id="errPIPhone" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Principal Investigator Address: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="PIAddress" id="PIAddress" size="40" height="10px"/><span id="errPIAddress" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr id="coordinatorname1" class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Study Coordinator Name1: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="SCName1" id="SCName1" size="40" height="10px"/><span id="errSCName1" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr id="coordinatoremail1" class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Study Coordinator Email1: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="SCEmail1" id="SCEmail1" size="40" height="10px"/><span id="errSCEmail1" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr id="coordinatorphone1" class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Study Coordinator Phone1: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="SCPhone1" id="SCPhone1" size="40" height="10px"/><span id="errSCPhone1" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr id="coordinatoraddress1" class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Study Coordinator Address1: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="SCAddress1" id="SCAddress1" size="40" height="10px"/><span id="errSCAddress1" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
							<td>
							<input type='button' name="addButton" value='Add Study Coordinator' id='addButton'/>
							<input type="hidden" name="hiddenSC" id="hiddenSC" >
							</td>
						</tr>
						<tr id="locationName1" class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Location Name1: </font></b></td>
							<td class="col-sm-4" align="left">
							<font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="locName1" id="locName1" size="40" height="10px"/><span id="errLocName1" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr id="locationAddr1" class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Location Address1: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="locAddr1" id="locAddr1" size="40" height="10px"/><span id="errLocAddr1" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
							<td>
							<input type='button' name="addLocation" value='Add Location' id='addLocation'/>
							<input type="hidden" name="hiddenLoc" id="hiddenLoc" >
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Cost Reimbursement for Patient: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="cost" id="cost" size="40" height="10px"/><span id="errCost" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group">
							<td align="left" nowrap><b><font color="black"
									style="font-family: fantasy;">Payment for Patient: </font></b></td>
							<td class="col-sm-4" align="left"><font size="4"><b>
										<font color="blue">
								  <input type="text" class="form-control"
																			name="payment" id="payment" size="40" height="10px"/><span id="errPayment" style='color:red;font-size: small;'></span>
									</font></font><br>
							</td>
						</tr>
						<tr class="form-group" style="padding-top: 10px;">
						<td align="right" style="padding-left: 60px; padding-top: 10px;"
								valign="top"><input name="editTrial" type="submit"
								value="Edit a Trial"
								style="width: 50%; font-size: 1.0em;"
								class="btn btn-large btn btn-success btn-lg btn-block" /></td>
							<td align="left" style="padding-left: 20px; padding-top: 10px;"
								valign="top"><input name="submitTrial" type="submit"
								value="Submit" style="width: 30%; font-size: 1.0em;"
								class="btn btn-large btn btn-success btn-lg btn-block" onclick="{return validate();document.clinicalTrialFrm.submit();}"/></td>
						</tr>
					</table>
				</form>
				</div>
			</div>
		</div>
</body>

</html>