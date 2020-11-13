<%@page import="com.ecommerce.models.User"%>
<%@page import="java.util.List"%>
<%@page import="com.ecommerce.utility.UtilCls"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%
//redirects to index page if you try to access page w/o logging in
if(session.getAttribute("uname")==null){
	response.sendRedirect("login");
}

UtilCls util = new UtilCls();
if(session.getAttribute("uname")!=null){
	String loggedInUser = (String)session.getAttribute("uname");
	if(util.checkRoleSession(loggedInUser).equals("admin")){
		
	}
	else{
		response.sendRedirect("http://localhost:8080/eCommerceProject/home");
	}
}

%>
<%
session.setAttribute("idToChange", null);
%>
<head>
<meta charset="ISO-8859-1">
<title>Customer Management</title>
</head>
<body>
<h1>Customer Management Page</h1>
<p>This is the customer management page</p>
<form method="post" >
<table border=1>
<tr><th>Name</th><th>Email</th><th>Phone</th><th>Username</th><th>Edit</th><th>Delete</th></tr>
<%
			List<User> userList = util.retLogins();
			for (int i=0;i<userList.size();i++) {
				out.println("<tr><td>" + userList.get(i).getName() + "</td><td>" + userList.get(i).getEmail()+ "</td><td>"+userList.get(i).getPhone()+ "</td><td>" + userList.get(i).getUsername()
						+ "</td><td><button type='submit' name="+userList.get(i).getEmail()+" value="+userList.get(i).getUid()+">Edit</button></td>"+
						"<td><button type='submit' name="+userList.get(i).getUid()+" value="+userList.get(i).getUid()+">Delete</td>"
						);
			}
		%>
		<%
		
		//checking if delete button is clicked
		for (int i=0;i<userList.size();i++) {
			 if (request.getParameter(Integer.toString(userList.get(i).getUid())) != null){
				 util.test(request.getParameter(Integer.toString(userList.get(i).getUid())));
				 util.delete(request.getParameter(Integer.toString(userList.get(i).getUid())));
				 String redirectURL ="http://localhost:8080/eCommerceProject/admin/customerManagement";
				 response.sendRedirect(redirectURL);
			 }
			 
		}
		
		//checking if edit button is clicked
		for (int i=0;i<userList.size();i++) {
			 if (request.getParameter(userList.get(i).getEmail()) != null){
				 util.test(request.getParameter(userList.get(i).getEmail()));
				 session.setAttribute("idToChange", userList.get(i).getUid());
				// session.setAttribute("updateSuccess", "null");
				 //util.delete(request.getParameter(Integer.toString(userList.get(i).getUid())));
				 String redirectURL = "http://localhost:8080/eCommerceProject/admin/updateCustomer";
				 response.sendRedirect(redirectURL);
			 }

		}
		
		%>
</table>
</form>

<br> <a href="adminAddUser"><button>Add User</button></a>
</body>
</html>