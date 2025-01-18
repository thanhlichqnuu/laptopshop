<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Chatbot</title>
    <style>
      #chatbot-container {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 1000;
      }

      #chatbot-icon {
        cursor: pointer;
        background-color: transparent;
      }

      #chatbot-icon img {
        width: 80px;
        height: 80px;
      }

      #chatbot-window {
        display: none;
        width: 350px;
        height: 500px;
        border: 1px solid #ddd;
        border-radius: 15px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
        overflow: hidden;
      }

      #chatbot-header {
        background: #007bff;
        color: white;
        font-size: 18px;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      #close-chatbot {
        background: none;
        border: none;
        color: white;
        cursor: pointer;
        font-size: 24px;
      }

      #chatbox {
        height: 400px;
        overflow-y: auto;
        padding: 10px;
        background-color: #f9f9f9;
      }

      .message {
        margin-bottom: 10px;
        padding: 10px;
        border-radius: 10px;
        max-width: 80%;
      }

      .user-message {
        background-color: #007bff;
        color: white;
        margin-left: auto;
        text-align: left;
      }

      .bot-message {
        background-color: #e1e1e1;
        color: #333;
        margin-right: auto;
        text-align: left;
      }

      #chatbot-input-container {
        padding: 10px;
        background-color: #fff;
        border-top: 1px solid #ddd;
        display: flex;
        gap: 10px;
      }

      #userInput {
        width: 75%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
      }

      #sendButton {
        width: 20%;
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
      }

      #sendButton:hover {
        background-color: #0056b3;
      }
    </style>
  </head>
  <body>
    <div id="chatbot-container">
      <div id="chatbot-icon">
        <img src="/images/chatbot-icon.png" alt="Chatbot" />
      </div>
      <div id="chatbot-window">
        <div id="chatbot-header">
          <strong style="margin-left: 10px">Chatbot tư vấn</strong>
          <button style="margin-right: 10px" id="close-chatbot">×</button>
        </div>
        <div id="chatbox">
          <!-- Chat messages will be displayed here -->
        </div>
        <div id="chatbot-input-container">
          <input
            type="text"
            id="userInput"
            placeholder="Type your message..."
          />
          <button id="sendButton" onclick="sendMessage()">Send</button>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>
      const chatbox = document.getElementById("chatbox");
      const chatbotIcon = document.getElementById("chatbot-icon");
      const chatbotWindow = document.getElementById("chatbot-window");
      const closeChatbot = document.getElementById("close-chatbot");

      let isFirstOpen = true;

      chatbotIcon.addEventListener("click", function () {
        chatbotWindow.style.display =
          chatbotWindow.style.display === "none" ? "block" : "none";

        if (isFirstOpen) {
          const welcomeMessage = document.createElement("div");
          welcomeMessage.className = "message bot-message";
          welcomeMessage.innerHTML =
            "Chào bạn! Chúc bạn một ngày tốt lành. Bạn cần tôi giúp gì không?";
          chatbox.appendChild(welcomeMessage);
          isFirstOpen = false;
          chatbox.scrollTop = chatbox.scrollHeight;
        }
      });

      closeChatbot.addEventListener("click", function () {
        chatbotWindow.style.display = "none";
      });

      let chatHistory = [];

      const sendMessage = async () => {
        const userInput = document.getElementById("userInput").value;
        if (userInput.trim() === "") return;

        const userMessage = document.createElement("div");
        userMessage.className = "message user-message";
        userMessage.textContent = userInput;
        chatbox.appendChild(userMessage);

        document.getElementById("userInput").value = "";

        const thinkingMessage = document.createElement("div");
        thinkingMessage.className = "message bot-message";
        thinkingMessage.textContent = "Đang suy nghĩ...";
        chatbox.appendChild(thinkingMessage);

        chatbox.scrollTop = chatbox.scrollHeight;

        try {
          const { data } = await axios.post("http://localhost:8000/chat", {
            query: userInput,
            history: chatHistory,
          });

          const formattedResponse = data.result
            .replace(/\*\*/g, "")
            .replace(/\n/g, "<br>");

          thinkingMessage.innerHTML = formattedResponse;

          chatHistory = data.history;
        } catch (error) {
          console.error("Error:", error);
          thinkingMessage.textContent =
            "Rất tiếc, đã xảy ra lỗi khi xử lý yêu cầu của bạn!";
        }
        chatbox.scrollTop = chatbox.scrollHeight;
      };

      userInput.addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
          sendMessage();
        }
      });
    </script>
  </body>
</html>
