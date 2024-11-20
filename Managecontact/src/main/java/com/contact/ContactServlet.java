package com.contact;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get input parameters from the form
        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // Input validation
        if (name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            out.println("<p style='color:red;'>All fields are required. Please fill in all the details.</p>");
            out.println("<a href='editContact.jsp?id=" + idParam + "'>Go back</a>");
            return;
        }

        if (!phone.matches("\\d{10}")) {
            out.println("<p style='color:red;'>Invalid phone number. Please enter a 10-digit phone number.</p>");
            out.println("<a href='editContact.jsp?id=" + idParam + "'>Go back</a>");
            return;
        }

        if (!email.matches("^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
            out.println("<p style='color:red;'>Invalid email format. Please enter a valid email address.</p>");
            out.println("<a href='editContact.jsp?id=" + idParam + "'>Go back</a>");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load the PostgreSQL driver
            Class.forName("org.postgresql.Driver");
            // Connect to the database (update the URL, username, and password)
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/contactdb?user=postgres&password=root");

            if (idParam != null && !idParam.trim().isEmpty()) {
                // Update the existing contact
                int id = Integer.parseInt(idParam);
                String sqlUpdate = "UPDATE contacts SET name = ?, phone = ?, email = ? WHERE id = ?";
                pstmt = conn.prepareStatement(sqlUpdate);
                pstmt.setString(1, name);
                pstmt.setString(2, phone);
                pstmt.setString(3, email);
                pstmt.setInt(4, id);
                pstmt.executeUpdate();
                
                out.println("<div style='display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100vh;'>");

//                out.println("<p>Contact updated successfully!</p>");
                out.println("<p style='margin: 10px; font-size: 18px;'>Contact updated successfully!</p>");
            } else {
                // Insert the new contact into the database
                String sqlInsert = "INSERT INTO contacts (name, phone, email) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sqlInsert);
                pstmt.setString(1, name);
                pstmt.setString(2, phone);
                pstmt.setString(3, email);
                pstmt.executeUpdate();

//                out.println("<p>Contact added successfully!</p>");
                out.println("<p style='margin: 10px; font-size: 18px;'>Contact added successfully!</p>");
            }
//            out.println("<a href='viewContacts.jsp'>View Contact List</a>");
            out.println("<a href='viewContacts.jsp' style='margin: 10px; text-decoration: none; font-size: 16px; color: blue;'>View Contact List</a>");
            out.println("</div>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : -1;

        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load the PostgreSQL driver
            Class.forName("org.postgresql.Driver");
            // Connect to the database (update the URL, username, and password)
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/contactdb?user=postgres&password=root");

            if ("delete".equalsIgnoreCase(action) && id != -1) {
                // Delete the contact from the database
                String sqlDelete = "DELETE FROM contacts WHERE id = ?";
                pstmt = conn.prepareStatement(sqlDelete);
                pstmt.setInt(1, id);
                pstmt.executeUpdate();
                response.sendRedirect("viewContacts.jsp"); // Redirect after deletion
            } else {
                // Query to retrieve all contacts
                stmt = conn.createStatement();
                String sqlSelect = "SELECT * FROM contacts";
                rs = stmt.executeQuery(sqlSelect);

                // Generate HTML to display the contact list
                out.println("<html><head><title>Contact List</title></head><body>");
                out.println("<h2>Contact List</h2>");
                out.println("<table border='1'><tr><th>ID</th><th>Name</th><th>Phone</th><th>Email</th><th>Action</th></tr>");

                while (rs.next()) {
                    int contactId = rs.getInt("id");
                    String contactName = rs.getString("name");
                    String contactPhone = rs.getString("phone");
                    String contactEmail = rs.getString("email");

                    out.println("<tr>");
                    out.println("<td>" + contactId + "</td>");
                    out.println("<td>" + contactName + "</td>");
                    out.println("<td>" + contactPhone + "</td>");
                    out.println("<td>" + contactEmail + "</td>");
                    out.println("<td><a href='editContact.jsp?id=" + contactId + "'>Edit</a> | <a href='ContactServlet?action=delete&id=" + contactId + "' onclick='return confirm(\"Are you sure you want to delete this contact?\");'>Delete</a></td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                out.println("<a href='addContact.jsp'>Add New Contact</a>");
                out.println("</body></html>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
