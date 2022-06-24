<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="market.ProductDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="product" class="market.Product" scope= "page"/>
<jsp:setProperty name="product" property="productTitle" />
<jsp:setProperty name="product" property="productCategory" />
<jsp:setProperty name="product" property="productPhoto" />
<jsp:setProperty name="product" property="productPrice" />
<jsp:setProperty name="product" property="productContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 홈페이지</title>
</head>
<body>
    <%
    String userID =null;
    if(session.getAttribute("userID") != null){
    	userID = (String) session.getAttribute("userID");
    }
    
    if(userID == null){
    	PrintWriter script = response.getWriter();
    	script.println("<script>");
    	script.println("alert('로그인을 하세요.')");
    	script.println("location.href = 'login.jsp'");
    	script.println("</script>");
    }else{
    	if(product.getProductTitle() == null ||product.getProductCategory() == null ||
    	product.getProductPrice() == null || product.getProductContent() == null){
    		
    		    	PrintWriter script = response.getWriter();
    		    	script.println("<script>");
    		    	script.println("alert('입력이 안 된 사항이 있습니다.')");
    		    	script.println("history.back()");
    		    	script.println("</script>");	
    		    	
    		 }else
    		 {
    		    	ProductDAO productDAO = new ProductDAO();
    		    	
    		        int result = productDAO.write(product.getProductTitle(),
    		        		userID,
    		        		product.getProductCategory(),
    		        		product.getProductPhoto(),
    		        		product.getProductPrice(),
    		        		product.getProductContent());
    		        
    		        if (result == -1){
    		        	PrintWriter script = response.getWriter();
    		        	script.println("<script>");
    		        	script.println("alert('글쓰기에 실패했습니다.')");
    		        	script.println("history.back()");
    		        	script.println("</script>");
    		        }else{
    		        	PrintWriter script = response.getWriter();
    		        	script.println("<script>");
    		        	script.println("location.href = 'market.jsp'");
    		        	script.println("</script>");
    		        }
    		    }
    }
    %>
</body>
</html>