<%@ page import="member.bean.MemberDTO" %>
<%@ page import="member.dao.MemberDAO_mybatis" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	//data
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String gender = request.getParameter("gender");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String tel1 = request.getParameter("tel1");
	String tel2 = request.getParameter("tel2");
	String tel3 = request.getParameter("tel3");
	String zipcode = request.getParameter("zipcode");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");

	MemberDTO memberDTO = new MemberDTO();
	memberDTO.setName(name);
	memberDTO.setId(id);
	memberDTO.setPwd(pwd);
	memberDTO.setGender(gender);
	memberDTO.setEmail1(email1);
	memberDTO.setEmail2(email2);
	memberDTO.setTel1(tel1);
	memberDTO.setTel2(tel2);
	memberDTO.setTel3(tel3);
	memberDTO.setZipcode(zipcode);
	memberDTO.setAddr1(addr1);
	memberDTO.setAddr2(addr2);
		
	MemberDAO_mybatis memberDAO_mybatis = MemberDAO_mybatis.getInstance();
	/* int su = memberDAO.memberUpdate(memberDTO); */
	memberDAO_mybatis.memberUpdate(memberDTO);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <%
if(su==0){ %>
	<h3>UPDATE 실패</h3>
	<input type='button' value='뒤로' onclick='history.go(-1)'>
<%} else { %>
	<h3>UPDATE 성공</h3>
<%} %> --%>
<h3>회원정보수정 완료!!</h3>
<script type="text/javascript">
	window.onload=function() {
		alert("회원정보 수정 완료!!");
		location.href="loginForm.jsp";
	}
</script>
</body>
</html>
</html>