
<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = "", phone = "", email = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/contactdb?user=postgres&password=root");
        String sql = "SELECT * FROM contacts WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            phone = rs.getString("phone");
            email = rs.getString("email");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: Arial, sans-serif;
        background-color: #333333; 
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        position: relative;
        overflow: hidden;
      }

      h2 {
        text-align: center;
        color: #ffffff;
      }

      .container {
        background: rgba(255, 255, 255, 0.2); 
        backdrop-filter: blur(15px);
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 8px #4caf50; 
        width: 400px;
      }

      form {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center; 
      }

      input[type="text"],
      input[type="submit"] {
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
      }

      input[type="text"] {
        width: calc(100% - 20px);
        background-color: #bff3f9;
        outline: none;
        font-size: 14px;
        transition: background-color 0.3s;
      }

      input[type="text"]:focus {
        background-color: #e1ebed; /* Focus effect */
      }

      input[type="submit"] {
        background-image: linear-gradient(to right, #16a085 0%, #f4d03f 51%, #16a085 100%);
        background-size: 200% auto;
        color: white;
        cursor: pointer;
        transition: 0.5s;
        box-shadow: 0 0 20px #eee;
        border: none;
        text-transform: uppercase;
        text-align: center;
        padding: 15px 45px;
      }

      input[type="submit"]:hover {
        background-position: right center; /* Sliding gradient effect */
        color: #fff;
      }

      #div1,
      #div2 {
        border-radius: 50%;
        width: 200px;
        height: 200px;
        position: absolute;
        z-index: -1;
        background: linear-gradient(43deg, #4158d0, #c850c0, #ffcc70);
      }

      #div1 {
        left: 470px;
        top: 150px;
        transform: rotate(145deg);
      }

      #div2 {
        left: 790px;
        top: 450px;
        background: linear-gradient(180deg, #fddb92, #d1fdff, #9890e3);
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h2>Edit Contact</h2>
      <form action="ContactServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>" />
        <input type="text" name="name" value="<%= name %>" placeholder="Enter Name" /><br />
        <input type="text" name="phone" value="<%= phone %>" placeholder="Enter Phone Number" /><br />
        <input type="text" name="email" value="<%= email %>" placeholder="Enter Email" /><br />
        <input type="submit" value="Update Contact" />
      </form>
    </div>
    <div id="div1"></div>
    <div id="div2"></div>
  </body>
</html>