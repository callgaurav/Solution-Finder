<%@page import="includes.DataManager"%>
<%@page import="java.util.List"%>
<%@page import="includes.StudentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String e1=(String)session.getAttribute("ses_email");
    if(e1==null)
    {
        response.sendRedirect("AuthError.jsp");
        return;
    }
    String utype=(String)session.getAttribute("ses_type");
    if(!utype.equals("stud"))
    {
        response.sendRedirect("AuthError.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link href="SourcePackage/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <meta charset="UTF-8">
        <script src="SourcePackage/jquery.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>    
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
        <script>
            $(document).ready(function(){
               $('#tool').tooltip();
                $('#log').tooltip();
            });
        </script>
        <style>
ul.breadcrumb {
    padding: 10px 16px;
    list-style: none;
    background-color: #eee;
}
ul.breadcrumb li {
    display: inline;
    font-size: 18px;
}
ul.breadcrumb li+li:before {
    padding: 8px;
    color: black;
    content: ">>\00a0";
}
ul.breadcrumb li a {
    color: #0275d8;
    text-decoration: none;
}
ul.breadcrumb li a:hover {
    color: #01447e;
    text-decoration: underline;
}
</style>
    </head>
    <body>
         <%
            List<StudentManager> list= StudentManager.getRecords("select * from studentmaster where email='"+e1+"'");
        %>
        <div class="container-fluid">
            <nav class="navbar navbar-default ">
                <div class="container-fluid">
                    <div class="navbar-header navbar-left">
                        <button class="navbar-toggle" data-target="#mynavbar" data-toggle="collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a href="studentconsole.jsp" class="navbar-brand">Solution Finder</a>
                    </div>
                    <div class="collapse navbar-collapse" id="mynavbar">
                        <ul class="nav navbar-nav">
                        <li><a href="askQuestion.jsp">Ask Question</a></li>
                        <li class="active" class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" >
                                My Account<span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li class="active" role="presentation"><a href="editProfile.jsp" tabindex="-1" role="menuitem"><span class="glyphicon glyphicon-edit"></span>&nbsp;Edit Profile</a></li>
                                    <li role="presentation"><a href="chngPic.jsp" tabindex="-1" role="menuitem"><span class="glyphicon glyphicon-user"></span>&nbsp;Change Profile Pic</a></li>
                                    <li role="presentation"><a href="chngPassword" tabindex="-1" role="menuitem"><span class="glyphicon glyphicon-lock"></span>&nbsp;Change Password</a></li>
                                </ul>   
                        </li>
                        <li><a href="#">My Questions</a></li>
                    </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#" id="tool" data-placement="bottom" data-toggle="tooltip" title="<% out.print(list.get(0).getName());%>" >
                                <img class="img-circle img-responsive" alt="User" width="22" src="images/img_avatar.png"/>
                             </a></li>
                              <li><a href="Logout.jsp" id="log" data-placement="bottom" data-toggle="tooltip" title="Are u want to Logout?" ><span class="glyphicon glyphicon-log-out">Logout</span></a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
        
        <div class="container-fluid">
            <!-- HEADING -->
            <ul class="breadcrumb">
                <li><a href="studentconsole.jsp">Home</a></li>
                <li class="active">Change Password</li>
            </ul>
            <%
                try{
                if(request.getParameter("updatePwd")!=null)
                {
                    String old_pwd=request.getParameter("old_pwd");
                    String new_pwd=request.getParameter("new_pwd");
                    int n= DataManager.executeUpdate("update loginmaster set pwd='"+new_pwd+"' where email='"+e1+"' and pwd='"+old_pwd+"'");
                    if(n==1)
                    {
             %>
                    <div class="alert alert-success">
                        <p><strong>Success : </strong>You Password is Changed....<a href="#" class="alert-link">Thank U</a></p>
                    </div>
             <%
                    }
                    else
                        {
             %>               
                                <div class="alert alert-danger">
                                    <p><strong>Error : </strong>Fail to change your password.. <a href="chngPwd.jsp" class="alert-link">Try Again</a></p>
                    </div>
               <%
                                }
                }
                else
                {
                        
            %>
            
            
            <h2 class='page-header text-muted'>Change Password Form</h2>
                    <form class="form-horizontal" method="post" action="">
                        
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="old_pwd">Old Password:</label>
                          <div class="col-sm-8">
                              <input type="password"  name="old_pwd" class="form-control"  id="old_pwd" placeholder="Enter Old Password">
                          </div>
                        </div>               
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="pwd">New Password:</label>
                          <div class="col-sm-8">
                              <input type="password"  name="new_pwd" class="form-control" id="pwd" placeholder="Enter New Password">
                          </div>
                        </div>                
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="con_pwd">Confirm New Password:</label>
                          <div class="col-sm-8">
                              <input type="password" name="con_pwd" class="form-control" id="con_pwd" placeholder="Confirm New Password">
                          </div>
                        </div>
                        <div class="form-group"> 
                          <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" name="updatePwd" class="btn btn-info btn-lg">Change Password</button>
                          </div>
                        </div>
                     </form>
                              <%
                                  }
}
catch(Exception ex)
{
out.print("sads");
}
                              %>
        </div>                            
    </body>
</html>
