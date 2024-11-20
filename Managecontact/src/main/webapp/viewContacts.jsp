<!-- viewContacts.jsp -->
<html>
<head>
    <title>Contact List</title>


    
<style>
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  body {
    font-family: Arial, sans-serif;
    background-color: #333333;
    width: 100%;	
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    gap: 20px;
    position: relative;
    margin: 25px 0;
  }
  table {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
    font-family: Arial, sans-serif;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    backdrop-filter: blur(15px);
    
    text-align: center;
}
  
  h2 {
    color: white;
    font-size: 30px;
  }
  th, td {
    border-bottom: 2px solid #ddd;
    padding: 12px;
  }
  th {
    color: white;
  }
  tr:nth-child(1) {
    background: linear-gradient(43deg, #95773f, #c850c0, #4158d0);
  }
  tr {
    color: white;
  }
  tr:hover {
    background: linear-gradient(145deg, #4158d0, #c850c0, #95773f);
    color: white;
  }
  th {
    font-size: 16px;
    text-transform: uppercase;
  }
  td {
    font-size: 14px;
  }
  
  /* Style for action links (Edit/Delete) */
  td a {
    display: inline; /* Ensure links are inline */
    margin: 0 5px; /* Add spacing between links */
    color: yellow;
    text-decoration: none;
  }
  td a:hover {
    text-decoration: underline; /* Add hover effect */
  }

  /* Fixed button for "Add New Contact" */
  .fixed-button {
    position: fixed;
    bottom: 50px;
    background-color: transparent;
    border: 1px solid yellow;
    padding: 15px;
    border-radius: 5px;
    backdrop-filter: blur(15px);
    text-decoration: none;
    font-weight: 650;
    color: yellow;
  }

  /* Decorative Divs */
  #div1, #div2, #div3 {
    border-radius: 1%;
    position: fixed;
    z-index: -5;
  }
  #div1 {
    left: 170px;
    top: 150px;
    width: 200px;
    height: 600px;
    background: linear-gradient(43deg, #4158d0, #c850c0, #ffcc70);
  }
  #div2 {
    left: 410px;
    top: 150px;
    width: 540px;
    height: 600px;
    background: linear-gradient(145deg, #4158d0, #c850c0, #ffcc70);
  }
  #div3 {
    left: 980px;
    top: 150px;
    width: 400px;
    height: 600px;
    background: linear-gradient(43deg, #4158d0, #c850c0, #ffcc70);
  }
</style>
</head>
<body>

  <div id="div1"></div>
  <div id="div2"></div>
  <div id="div3"></div>

  <h2>Contact List</h2>

  <table>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Phone</th>
      <th>Email</th>
      <th>Actions</th>
    </tr>
    <%-- Iterate through the contacts using a loop provided by the servlet --%>
    <%@ page import="java.sql.*" %>
    <%
      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;
      try {
          Class.forName("org.postgresql.Driver");
          conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/contactdb?user=postgres&password=root");
          stmt = conn.createStatement();
          rs = stmt.executeQuery("SELECT * FROM contacts");
          while (rs.next()) {
    %>
    <tr>
      <td><%= rs.getInt("id") %></td>
      <td><%= rs.getString("name") %></td>
      <td><%= rs.getString("phone") %></td>
      <td><%= rs.getString("email") %></td>
      <td>
        <a href="editContact.jsp?id=<%= rs.getInt("id") %>">Edit</a> |
        <a href="ContactServlet?action=delete&id=<%= rs.getInt("id") %>">Delete</a>
      </td>
    </tr>
    <%
          }
      } catch (Exception e) {
          e.printStackTrace();
      } finally {
          if (rs != null) rs.close();
          if (stmt != null) stmt.close();
          if (conn != null) conn.close();
      }
    %>
  </table>
  
  <a href="addContact.jsp" class="fixed-button">Add New Contact</a>
</body>

</html>

