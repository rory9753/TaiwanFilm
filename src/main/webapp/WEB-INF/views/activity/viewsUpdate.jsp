<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/favicon.ico"/> 
<meta charset="UTF-8">
 <link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<title>TaiwanFilms</title>
<link rel='stylesheet'
	href='${pageContext.request.contextPath}/css/movie.css' type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/menuStyle.css"
	type="text/css">
<style>
.container h2{
	font-size: 40px;
	font-weight: bold;
	text-align: center
}

.row img{
	width: 75%;
	height: 100%
}

.col-md-5{
	width: 100%;
}
.left-bar{
left: 0px;
}
.container{
<<<<<<< Updated upstream
width: 80%;display: inline-block;padding-top: 100px}
=======
width: 80%;display: inline-block;position: absolute;padding-top: 100px}
>>>>>>> Stashed changes
</style>


</head>
<body style="text-align: center;background-image: url(${pageContext.request.contextPath}/img/wall1.jpeg)">

	<jsp:include page="../fragment/menu.jsp" />
	
		<section class="container">
			<h2>${activity.activityTitle}</h2>
			<hr>
			<div class="row">  
				<div style="text-align: center;	text-align: center; 
						background-position: center;
						background-repeat: no-repeat;
						background-image: url('../getPicture/${activity.activityId}');
						height: 500px;">
					 
				</div>
				<hr> 
				<div class="col-md-5">
					<h2>${activity.activityTitle}</h2>
					<h3 style="font-size: 20px;text-align: center">${activity.activityMainContent}</h3>
					<p style="font-size: 18px">${activity.activityContent}</p>
					<p>所屬類別: ${activity.category}</p>
					
					<p>
						<strong>活動編號: </strong> <span class='label label-warning'>
							${activity.activityId} </span>
					</p>  
					<p>  
						 <a href="/TaiwanFilm" class="btn btn-default">
							<span class="glyphicon-hand-left glyphicon"></span>返回 
						<%-- <a href="<spring:url value='/activities' />" class="btn btn-default">
							<span class="glyphicon-hand-left glyphicon"></span>返回 --%>
						<a href="<spring:url value='/SignUpActivity?id=${activity.activityId}' />"class="btn btn-default">
						<span class="glyphicon-hand-left glyphicon"></span>註冊活動</a>
					</p>
				</div>  
			</div>
		</section>
		
	   
	<jsp:include page="../fragment/footer.jsp" /> 

	<script>
		$(".btn-warning").click(function(){
			$(".btn-warning").css("backgroundColor","#f0ad4e");
			$(".btn-warning").css("color","red"); 
			
		});
	</script>

</body>
</html>
