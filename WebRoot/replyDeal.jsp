<%@ page language="java" import="java.util.*, java.sql.*, com.bbs.*" pageEncoding="GB18030"%>

<%
request.setCharacterEncoding("GBK");

int pid = Integer.parseInt(request.getParameter("pid"));
int rootId = Integer.parseInt(request.getParameter("rootId"));



String title = request.getParameter("title");
System.out.println(title);
String cont = request.getParameter("cont");
System.out.println(cont);
Connection conn = DB.getConn();

boolean autoCommit = conn.getAutoCommit();
conn.setAutoCommit(false);

String sql = "insert into article values (null, ?, ?, ?, ?, now(), ?)";
PreparedStatement pstmt = DB.prepareStmt(conn, sql);
pstmt.setInt(1, pid);
pstmt.setInt(2, rootId);
pstmt.setString(3, title);
pstmt.setString(4, cont);
pstmt.setInt(5, 0);
pstmt.executeUpdate();

Statement stmt = DB.createStmt(conn);
stmt.executeUpdate("update article set isleaf = 1 where id = " + pid);

conn.commit();
conn.setAutoCommit(autoCommit);
DB.close(pstmt);
DB.close(stmt);
DB.close(conn);


 %>

<span id="time" style="background:red">5</span>秒钟后自动跳转，如果不跳转，请点击下面链接

<script language="JavaScript1.2" type="text/javascript">
<!--
//  Place this in the 'head' section of your page.  

function delayURL(url){
	var delay = document.getElementById("time").innerHTML;
	//alert(delay);
	if(delay > 0){
		delay--;
		document.getElementById("time").innerHTML = delay;
	}else{
		window.top.location.href=url;
	}
	
	setTimeout("delayURL('" + url + "')", 1000);
}

//-->

</script>


<a href="article.jsp">主题列表</a>
<script type="text/javascript">
	delayURL("article.jsp");
</script>