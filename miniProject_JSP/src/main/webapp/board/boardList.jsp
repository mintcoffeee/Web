<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page 
		 import="board.bean.BoardPaging"
		 import="board.dao.BoardDAO_mybatis"
		 import="board.bean.BoardDTO"
		 
		 import="java.text.SimpleDateFormat"
		 import="java.util.HashMap"
		 import="java.util.List"
		 import="java.util.Map"
%>
<%
	request.setCharacterEncoding("UTF-8");

	//data
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	//session
	String memId = (String)session.getAttribute("memId"); //java 코드는 값이 없으면 null	
	String pwd = (String)session.getAttribute("memPwd");
	
	//DB	
	BoardDAO_mybatis boardDAO = BoardDAO_mybatis.getInstance();	
	
	/*   startNum	endNum
	PG=1 RN>=1  AND RN<=5
	PG=2 RN>=6  AND RN<=10
	PG=3 RN>=11 AND RN<=15
	*/
	
	//1페이징 5개씩 
	int endNum = pg * 5;
	int startNum = endNum - 4;
	
	Map<String, Integer> map = new HashMap<String, Integer>();
	map.put("startNum", startNum);
	map.put("endNum", endNum);
	
	List<BoardDTO> list  = boardDAO.boardList(map);
	
	
	//페이징 처리
	int totalA = boardDAO.getTotalA(); //총글수 

	BoardPaging boardPaging = new BoardPaging();
	boardPaging.setCurrentPage(pg);
	boardPaging.setPageBlock(3);
	boardPaging.setPageSize(5);
	boardPaging.setTotalA(totalA);
	
	boardPaging.makePagingHTM();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.subjectA:link {color:black; text-decoration: none;} /* 한 번도 클릭하지 않았을 경우 */
.subjectA:visited {color:black; text-decoration: none;} /* 마우스 클릭 후 */
td .subjectA:hover {color:pink; text-decoration: underline;} /* 마우스를 올렸을 때, td 는 부모 */
.subjectA:active {color:black; text-decoration: none;} /* 마우스를 누르고 있을 때 */

#currentPaging{
	color: red;
	border: 1px solid red;
	padding: 5px 8px; /* (top, bottom) , (left, right) */
	margin: 5px; /* top, right, bottom, left */
	cursor: pointer;
}
#paging {
	color: black;
	padding: 5px;
	margin: 5px;
	cursor: pointer;
}
</style>
</head>
<body>
<!-- 
1. Data
목록으로 넘어올 때, 전달받을 데이터 X

2. DB: BoardDAO.java와 연동
SELECT * FROM BOARD ORDER BY SEQ DESC;
작성된 글이 여러개이므로 ArrayList<BoardDTO>에 담아오기
글번호, 제목, 작성자(ID), 조회수(hit), 작성일(YYYY.MM.DD) 불러오기

3. Response
return boardList
 -->
 
 
<img src="../image/3.gif" width="70" height="70" alt="잘자콩"
	onclick="location.href='../index.jsp'" style="cursor: pointer;">
<table border="1" cellpadding="5" cellspacing="0" frame="hsides" rules="rows">
<!-- th: 표 제목, tr: 행, td: 열 -->
	<tr>
		<th width="100">글번호</th>
		<th width="400">제목</th>
		<th width="150">작성자</th>
		<th width="100">조회수</th>
		<th width="150">작성일</th>
	</tr>
	
	<% if(list != null){ %>
		<% for(BoardDTO boardDTO : list) {%>
			<tr>
				<td align="center"><%=boardDTO.getSeq() %></td>
				<td><a class="subjectA" href="#" onclick="isLogin('<%=memId %>',<%=boardDTO.getSeq()%>, <%=pg %>)"><%=boardDTO.getSubject() %></a></td>
													<!-- ''가 memId를 감싸고 있기 때문에 null 이 아니라 'null' -->
				<!-- id attribute: 1번만 사용
				 	class attribute: 여러번 사용(현재 for문을 통해서 a tag가 여러번 사용됨) -->
				<td align="center"><%=boardDTO.getId() %></td>
				<td align="center"><%=boardDTO.getHit() %></td>	<!-- 조회수 -->
				<td align="center">
					<%=new SimpleDateFormat("yyyy.MM.dd").format(boardDTO.getLogtime()) %>
					<!-- java code에서 date 출력 형식 변경,
					 변수를 지정하지 않았으므로 일회용으로만 사용 가능 -->
				</td>
			</tr>
			<%} //for %>
		<%} //if %>
</table>	

<div style="margin-top: 15px; width: 850px; text-align: center;">
	<%=boardPaging.getPagingHTML() %>
</div>

<script type="text/javascript">
function boardPaging(pg) {
	location.href="boardList.jsp?pg=" + pg;	
}
function isLogin(memId, seq, pg){
	if(memId == 'null'){
		alert("먼저 로그인 하세요")
		location.href="../member/loginForm.jsp"
	}else {
		location.href="boardView.jsp?seq="+ seq +"&pg=" + pg;
	} 
}
</script>
</body>
</html>