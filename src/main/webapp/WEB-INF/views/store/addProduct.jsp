<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.js"></script>

<style type="text/css">
label {
	color: #428bca;
	font-size: 16px;
}

input, select {
	height: 35px;
	border-radius: 5px;
}

textarea {
	border-radius: 5px;
}

input[type="checkbox"] {
	height: 20px;
	width: 20px;
}

span {
	font-size: 16px;
}

.inputLarge {
	width: 500px;
}

.category-content {
	margin-bottom: 50px;
}

fieldset {
	padding-left: 170px;
}
</style>
<title>Products</title>
</head>
<body style="background-color: #fffcfa;">

	<jsp:include page="../backstage.jsp" />



	<section class="container"
		style="position: absolute; left: 17%; width: 80%; padding-top: 100px">

		<div class="category-content">
			<h1 style="text-align: center; margin: 0">新增商品</h1>
		</div>
		<!--       三個地方要完全一樣 -->
		<form:form method='POST' modelAttribute="productbean"
			class='form-horizontal' enctype="multipart/form-data">
			<fieldset>
				<div class="form-group">
					<label class="control-label col-lg-2 col-lg-2" for='title'>
						商品 </label>
					<div class="col-lg-10">
						<form:input id="title" path="title" type='text' class='inputLarge' />
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-lg-2 col-lg-2" for='author'>
						電影 </label>
					<div class="col-lg-10">
						<form:input id="author" path="author" type='text'
							class='inputLarge' />
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-lg-2 col-lg-2"
						for='productDescription'> 商品描述 </label>
					<div class="col-lg-10">
						<form:textarea id="productDescription" path="productDescription"
							rows="5" cols="30" class='inputLarge' />
					</div>
				</div>

				<div class="form-group">
					<label class='control-label col-lg-2 col-lg-2' for="category">
						類別 </label>
					<div class="col-lg-10" id="category">
						<form:checkbox path="category" value="服飾" />
						<span>服飾</span>
						<form:checkbox path="category" value="文具" />
						<span>文具</span>
						<form:checkbox path="category" value="專輯" />
						<span>專輯</span>
						<form:checkbox path="category" value="海報" />
						<span>海報</span>
						<form:checkbox path="category" value="生活用品" />
						<span>生活用品</span>
						<form:checkbox path="category" value="其他" />
						<span>其他</span>
					</div>
				</div>


				<div class="form-group">
					<label class='control-label col-lg-2 col-lg-2' for="price">
						價格 </label>
					<div class='col-lg-10'>
						<form:input id="price" path="price" type='text'
							class='form:input-large' />
					</div>
				</div>

				<div class="form-group">
					<label class='control-label col-lg-2 col-lg-2' for="stock">
						庫存 </label>
					<div class='col-lg-10'>
						<form:input id="stock" path="stock" type='text'
							class='form:input-large' />
					</div>
				</div>


				<div class="form-group">
					<label class='control-label col-lg-2 col-lg-2' for="companyId">
						廠商 </label>
					<div class='col-lg-10'>
						 <form:select path="companyId">
							<form:option value="-1" label="請挑選" />
							<form:options items="${companyList}" />
						</form:select> 
					</div>
				</div>

				<div class="form-group">
					<label class='control-label col-lg-2 col-lg-2' for="productImage">
						主圖 </label>
					<div class='col-lg-10'>
						<form:input id="productImage" path="productImage" type='file'
							class='form:input-large' />
					</div>
				</div>

				<div class="form-group subImg2" style="display: none;">
					<label class='control-label col-lg-2 col-lg-2' for="productImage2">
						小圖(1) </label>
					<div class='col-lg-10'>
						<input id="productImage2" name="productImage2" type='file'
							class='form:input-large' />
					</div>
				</div>
				<div class="form-group subImg3" style="display: none;">
					<label class='control-label col-lg-2 col-lg-2' for="productImage3">
						小圖(2)</label>
					<div class='col-lg-10'>
						<input id="productImage3" name="productImage3" type='file'
							class='form:input-large' />
					</div>
				</div>

				<div class="form-group">
					<button
						style="border-style: groove;color: lightcyan;border-radius: 9%; display: inline-block; margin-left: 178px; font-size: 14px; background: mediumturquoise; padding: 10px 10px;"
						type="button" id="addImages">+ img</button>
				</div>



				<div class="form-group">
					<label class='control-label col-lg-2 col-lg-2' for="status">
						狀態</label>
					<div class='col-lg-10'>
						<form:select class='form:select-large' id="status" path="status">
							<form:option selected="true" value="-1" disabled="true"
								label="請選擇" />
							<form:option value="上架中" label="上架" />
							<form:option value="下架" label="下架" />
						</form:select>
					</div>
				</div>

				<br>

				<div class="form-group">
					<div class='col-lg-offset-2 col-lg-10'>
						<input id="btnAdd" type='submit' class='btn btn-primary'
							value="送出" />
					</div>
				</div>



			</fieldset>
		</form:form>


	</section>
</body>
<script>
	//新增圖片按紐
	var count = 0;
	$('#addImages').click(function() {
		$('.subImg2').show();
		count++;
		if (count == 2) {
			$('.subImg3').show();
		}
	});
</script>
</html>
