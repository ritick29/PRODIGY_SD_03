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
        /* background-color: #f0f8ff; */
        background-color: #333333;
        width: 100%;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        gap: 40px;
        position: relative;
        overflow: hidden;
      }
      h2 {
        color: #ffffff;
      }
      form {
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 20px;
        min-width: 400px;
        height: 400px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        display: flex;
        /* align-items: center; */
        justify-content: center;
        flex-direction: column;
        background: rgb(255, 255, 255, 0.2);
        backdrop-filter: blur(15px);


        box-shadow: 0 0 8px #4caf50; /* Add a glowing effect */
      }
      input[type="text"],
      input[type="email"] {
        width: calc(100% - 20px);
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
      }

      /* Commented by me */
      /* input[type="submit"] {
        background-color: #4caf50;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 10px 15px;
        cursor: pointer;
        font-size: 16px;
      }
      input[type="submit"]:hover {
        background-color: #45a049;
      } */
      label {
        font-weight: bold;
      }

      #div1,
      #div2 {
        border-radius: 50%;
        width: 200px;
        height: 200px;
        /* border: black 1px solid; */
        position: absolute;
        left: 470px;
        top: 150px;
        background: linear-gradient(43deg, #4158d0, #c850c0, #ffcc70);
        /* transform: rotate(90deg); */
        transform: rotate(145deg);
        z-index: -5;
      }
      #div2 {
        left: 790px;
        top: 450px;
        background: linear-gradient(180deg, #fddb92, #d1fdff, #9890e3);
      }
      input::placeholder {
        color: rgb(85, 85, 85);
        font-size: 16px;
        font-weight: 600;
      }
      input {
        background-color: #bff3f9;
        outline: none;
        font-size: 14px;
      }
      input:focus {
        outline: none;
        background-color: #e1ebed;
      }

      .btn-grad {
        background-image: linear-gradient(
          to right,
          #16a085 0%,
          #f4d03f 51%,
          #16a085 100%
        );
      }
      .btn-grad {
        margin: 10px;
        padding: 15px 45px;
        text-align: center;
        text-transform: uppercase;
        transition: 0.5s;
        background-size: 200% auto;
        color: white;
        box-shadow: 0 0 20px #eee;
        border-radius: 10px;
        display: block;
        border: none;
      }

      .btn-grad:hover {
        background-position: right center; 
        color: #fff;
        text-decoration: none;
      }
    </style>
  </head>
  <body>
    <h2>Add Contact</h2>
    <form action="ContactServlet" method="post">
      <!-- <label for="name">Name:</label> -->
      <!-- commented by manish -->
      <input
        type="text"
        id="name"
        name="name"
        required
        placeholder="Enter name"
      /><br />

      <!-- <label for="phone">Phone:</label> -->
      <input
        type="text"
        id="phone"
        name="phone"
        required
        pattern="[0-9]{10}"
        title="Enter a valid 10-digit phone number"
        placeholder="Enter Phone number"
      /><br />

      <!-- <label for="email" >Email:</label> -->
      <input
        type="email"
        id="email"
        name="email"
        required
        placeholder="Enter email"
      /><br />

      <input type="submit" value="Add Contact" class="btn-grad" />
    </form>
    <script src="timepass.js"></script>
    <div id="div1"></div>
    <!-- html Added by manish  -->
    <div id="div2"></div>
    <!-- html Added by manish  -->
  </body>
</html>