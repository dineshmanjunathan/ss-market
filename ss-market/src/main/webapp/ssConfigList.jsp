<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file = "header.jsp" %> 
<meta charset="ISO-8859-1"> 
</head>
<body> 
				<div class="col-md-10 col-md-offset-2 row">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="product-payment-inner-st">
							<ul id="myTabedu1" class="tab-review-design">
								<center><li class="active"><a href="">SS Configuration</a></li></center>
							</ul>

							<div id="myTabContent" class="tab-content custom-product-edit">
								<div class="product-tab-list tab-pane fade active in"
									id="description">
									<div class="row">
									<table class="full-right">
									<tr>
									<td>
										<a href="/admin/menu"
											class="btn btn-primary m-btn m-btn--custom m-btn--icon col-md-offset-1 col-md-12">
											<span><i class="fa fa-arrow-left"></i> <span>Back to Main</span>
										</span>
										</a>
									</td>
									<td>
										<a href="/admin/ssconfig"
											class="btn btn-primary m-btn m-btn--custom m-btn--icon col-md-offset-2 col-md-12">
											<span> <i class="fa fa-plus"></i> <span>Create</span>
										</span>
										</a>
									</td>
									</tr> 
									</table>
									<p style="color: green" align="center">${successMessage}</p>
								    <p style="color: green" align="center">${deletesuccessmessage}</p>
									<%-- <p style="color: red" align="center">${errormsg}</p> --%>
							<div class="sparkline13-graph">
                                <div class="datatable-dashv1-list custom-datatable-overright">
                                    <div id="toolbar">
                                        <select class="form-control dt-tb">
											<option value="">Export Basic</option>
											<option value="all">Export All</option>
											<option value="selected">Export Selected</option>
										</select>
                                    </div>
                                     <table id="table" data-toggle="table" data-pagination="true" data-search="true" data-show-columns="true" data-show-pagination-switch="true" data-show-refresh="false" data-key-events="true" data-show-toggle="true" data-resizable="true" data-cookie="true"
                                        data-cookie-id-table="saveId" data-show-export="true" data-click-to-select="true" data-toolbar="#toolbar">
                                     <thead>
										<tr> 
											<th data-field="code" data-editable="false">Code</th>
											<th data-field="description" data-editable="false">Description</th>
											<th data-field="value" data-editable="false">Value</th>
											<th data-field="comment" data-editable="false">Comment</th>
											<th data-field="action" data-editable="false">Action</th>
										</tr>
									</thead>
                                        <tbody> 
                                        <c:forEach var="details" items="${ssConfigList}" varStatus="status">
                                            <tr>
												<td>${details.code}</td>
												<td>${details.description}</td>
												<td>${details.value}</td>
												<td>${details.comment}</td>
												
												 <td><a href="<c:url value='/admin/ssconfig/edit?id=${details.code}'/>"><center><i class="fa fa-pencil-square-o" aria-hidden="true"></i></center></a>
		        								 <a class="btn-danger" onclick="return confirm('Are you sure you want to delete?')" 
		        								 href="<c:url value='/admin/ssconfig/delete?id=${details.code}' />" >
		        								  <center><i class="fa fa-trash-o" aria-hidden="true"></i></center></a></td> 
												      								 
                                            </tr> 
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>  
	  						 
		   
		   
</body>
</html>