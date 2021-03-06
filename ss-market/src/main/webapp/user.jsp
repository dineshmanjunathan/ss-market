<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html class="no-js" lang="en">
<head>
<%@ include file="header.jsp"%>
<meta charset="ISO-8859-1">
<script type="text/javascript" charset="utf-8">

function getSponserName() {
    	$.ajax({
            url: "/get/sponser",
            data: {
                "sponserId": document.getElementById("referedby").value
            },
            type: "get",
            cache: false,
            success: function (data) {

            	if(data.length>0) {
                	var s = document.getElementById("sponsername"); s.value = data;
                	$("#errmsg").text("");
                }else{
                	$("#errmsg").text("Invalid Sponsor Id");
                	$("span").css("color", "red");
                    document.getElementById("errmsg").style.visibility = "visible";
                    document.getElementById("sponsername").value='';
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log('ERROR:' + XMLHttpRequest.status + ', status text: ' + XMLHttpRequest.statusText);
            }
        });
}
function enableTermsAndCond(){
	var checker = document.getElementById('terms').checked;
	var prichecker = document.getElementById('pripolicy').checked;
	var bt = document.getElementById('btSubmit');
	if(checker && prichecker){
		bt.disabled = false;
	} else {
		bt.disabled = true;
	}
}

function checkPhNumExists() {
	$.ajax({
        url: "/member/phNoExists",
        data: {
            "phonenumber": document.getElementById("phonenumber").value
        },
        type: "get",
        cache: false,
        success: function (data) {
        	if(data.length>0) {
        		$("#errmsgmobno").text("Mobile Number Already Exists");
            	$("span").css("color", "red");
                document.getElementById("errmsgmobno").style.visibility = "visible";
                document.getElementById("phonenumber").value='';
            }else{
            	var s = document.getElementById("phonenumber"); 
            	s.value = data;
            	$("#errmsgmobno").text("");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log('ERROR:' + XMLHttpRequest.status + ', status text: ' + XMLHttpRequest.statusText);
        }
    });
}
</script>
</head>
<body>
	<!-- Single pro tab review Start-->
	<div class="col-md-10 col-md-offset-1 row">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="product-payment-inner-st">
					<ul id="myTabedu1" class="tab-review-design">
						<li class="active"><a href="">Member Registration</a></li>
					</ul>
				 <div class="payment-adress">
						<a
							class="rmk btn btn-primary waves-effect waves-light col-md-offset-10 col-md-2"
							href="/index.jsp" type="submit" name="submit"
							value="adminListing">Back</a>
					</div>

					<div id="myTabContent" class="tab-content custom-product-edit">
						<div class="product-tab-list tab-pane fade active in"
							id="description">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="review-content-section">
										<form action="/register" method="post">

											<p style="color: red" align="center">${errormsg}</p>

											<input type="hidden" name="id" id="id" value="${member.id}">
											<input type="hidden" name="role" id="role" value="MEMBER">

											<div id="dropzone1" class="pro-ad">

												<p style="color: green" align="center">${successMessage}</p>
												<p style="color: red" align="center">${deletesuccessmessage}</p>
												
												<li class="active"><a >Sponsor Details:</a></li>
												
												<div class="well row">
													<div class=" col-lg-6 col-md-5 col-sm-6 col-xs-12">
													<c:choose>
													<c:when test="${not empty member}">
													<div class="form-group">
																	<input name="referedby" id="referedby" type="text" onblur="getSponserName();"
																		class="form-control" placeholder="Sponsor Id"
																		value="${member.referedby}" readonly>
													</div>
													</c:when>
													<c:otherwise>
													<div class="form-group">
																	<input name="referedby" id="referedby" type="text" onblur="getSponserName();"
																		class="form-control" placeholder="Sponsor Id"
																		value="${member.referedby}" required>
													</div>
													</c:otherwise>
													</c:choose>
													<span id="errmsg"></span>
													</div>
												<div class=" col-lg-6 col-md-5 col-sm-6 col-xs-12">
												<div class="form-group">
																	<input name="sponsername" id="sponsername" type="text"
																		class="form-control" placeholder="Sponsor Name"
																		value="${SPONSERNAME}" readonly required>
												</div>
												</div>
												</div>
												<li class="active"><a >User Details:</a></li>
												

												<div class="well row">
														<div class=" col-lg-6 col-md-5 col-sm-6 col-xs-12">
														<div class="form-group"></div>
														<div class="form-group">
															<input name="name" type="text" class="form-control"
																placeholder="Name as Per PAN Card" value="${member.name}"
																required>
														</div>

														<div class="form-group">
															<input name="password" type="password" 
																class="form-control" placeholder="Password" minlength="8"  maxlength="10"
																value="${member.password}" required>
														</div>
														<div class="form-group">
															<input name="email" type="email" class="form-control"
																placeholder="Email" value="${member.email}">
														</div>
													<br>													
													</div>
													<div class=" col-lg-6 col-md-5 col-sm-6 col-xs-12">
														<div class="form-group">
															<label>Date of Birth:</label> <input name="dob"
																type="date" class="form-control"
																placeholder="Date of Birth" value="${member.dob}"
																required>
														</div>

														<div class="form-group">
															<label>Gender :</label> <input name="gender"
																class=" required " id="gender" type="radio" value="Male"
																${member.gender eq 'Male' ?'Checked':''}>Male <input
																name="gender" class=" required " id="gender"
																type="radio" value="Female"
																${member.gender eq 'Female' ?'Checked':''}>Female
														</div>

														<div class="form-group">
															<input name="phonenumber" type="text" id="phonenumber"
																class="form-control" placeholder="Phone Number" minlength="10"
																value="${member.phonenumber}"  required onblur="checkPhNumExists();">
														</div>
														<span id="errmsgmobno"></span>

													</div>
														</div>
														<div class="form-group">
														<input type="checkbox" name="pripolicy" id="pripolicy" value="Privacy Policy" onclick="enableTermsAndCond();" > I have read and agree to the following 
														<a target="_blank" data-toggle="modal" data-target="#PrivacyPolicy" rel="nofollow noopener ugc" >Company terms and condition.</a>
													</div>
  
													<div class="form-group">
														<input type="checkbox" name="terms" id="terms" value="Conditions" onclick="enableTermsAndCond();"> I have read and agree to the following 
														<a target="_blank" data-toggle="modal" data-target="#Termsandconditions" rel="nofollow noopener ugc" >Marketing terms and condition.</a>
													</div>
											</div>
											<div class="row">
												<div class="col-lg-12">
													<div class="payment-adress">
														<button class="rmk btn btn-primary waves-effect waves-light"
															type="submit" name="submit" id="btSubmit" value="register" disabled>Submit</button>
														<button class="rmk btn btn-primary waves-effect waves-light"
															type="reset" name="reset" value="reset">Clear</button>

													</div>
												</div>
											</div>

										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="PrivacyPolicy" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Privacy Policy</h4>
				</div>
				<div class="modal-body">
					<p><b>Terms of Use</b></p> <p>This document is an electronic record of the website www.ssmarket.in terms of Information Technology Act, 2000 and rules there under as applicable and the amended provisions pertaining to electronic records in various statutes as amended by the Information Technology Act, 2000. This electronic record is generated by a computer system and does not require any physical or digital signatures.</p> <p>This document is published in accordance with the provisions of Rule 3 (1) of the Information Technology (Intermediaries guidelines) Rules, 2011 that require publishing the rules and regulations, privacy policy and Terms of Use for access or usage of domain name www.ssmarket.in</p> <p>These Terms of Use of the website www.ssmarket.in and mobile application names as "SS MARKET" is between SS MARKET (partnership firm) (hereinafter referred to as "SS MARKET" or "SUPERSHOP" or "We" or "Us" or "Our") and the registered users of the Website (hereinafter referred to as "You" or "Your" or "Yourself" or "User") describe the terms on which SS MARKET  offers You access to the Website and such other services as are incidental and ancillary thereto ("Services").</p> <p>PLEASE READ THESE TERMS OF USE CAREFULLY BEFORE USING OR REGISTERING ON THE WEBSITE OR ACCESSING ANY MATERIAL, INFORMATION OR SERVICES THROUGH THE WEBSITE. IF YOU DO NOT AGREE WITH THESE TERMS OF USE, PLEASE DO NOT USE THE WEBSITE.</p> <p><b>Amendments:</b></p> <p>When You use any of the services provided by Us through the SS MARKET, including but not limited to, (e.g. Product Reviews, Seller Reviews), You will be subject to the rules, guidelines, policies, terms, and conditions applicable to such service, and they shall be deemed to be incorporated into this Terms of Use and shall be considered as part and parcel of this Terms of Use.</p> <p>We reserve the right, at our sole discretion, to change, modify, add or make any changes of these Terms of Use, at any time without any prior written notice to you. It is your responsibility to review these Terms of Use periodically for updates/changes. Your continued use of the Platform following the posting of changes will mean that you accept and agree to the revisions. As long as you comply with these Terms of Use, We grant you a personal, non-exclusive, non-transferable, limited privilege to enter and use the Platform.</p> <p>ACCESSING, BROWSING OR OTHERWISE USING THE SITE INDICATES YOUR AGREEMENT TO ALL THE TERMS AND CONDITIONS UNDER THESE TERMS OF USE, SO PLEASE READ THE TERMS OF USE CAREFULLY BEFORE PROCEEDING.</p> <p>By impliedly or expressly accepting these Terms of Use, You also accept and agree to be bound by SS MARKET Policies as amended from time to time.</p> <p><b>1. Membership Eligibility</b></p> <p>Use of the SS MARKET  is available only to persons who can perform legally binding contracts under Indian Contract Act, 1872. Persons who are "incompetent to contract" within the meaning of the Indian Contract Act, 1872 including minors, un-discharged insolvents etc. are not eligible to use the SS MARKET website. If you are a minor i.e. under the age of 18 years, you shall not register as a member of the Website and should not purchase except through your legal guardian or parents who have registered as users on the Website or can use the Website as a Guest User. SS MARKET reserves the right to cancel your membership and refuse to provide you with access to the Website/application if it is brought to our notice or if it is recognised that you are under the age of 18 years.</p> <p>Business entity registration: If you are registering as a business entity, you represent that you are duly authorized to accept this User Agreement and you have the authority to bind your business/legal entity to this User Agreement.</p> <p>Guest User: As a Guest User, Buyer will not be eligible for Clues Bucks and all other benefits that are not assignable to a non-registered user.</p> <p><b>2. Your Account and Registration Obligations</b></p> <p>If you use the SS MARKET website as a Registered User, you are responsible for maintaining the confidentiality of Your User ID and Password. You are responsible for all activities that occur under Your User ID and Password or email ID and phone number as the case may be.</p> <p>1. Provide true, accurate, current and complete information about yourself as prompted by SS MARKET registration.</p> <p>2. You must include any of your contact details such as email addresses etc. in Your User ID while registering as a Registered User.</p> <p>3. You must immediately notify us of any unauthorized use of your password or account or any other breach of security.</p> <p>4. Ensure that you exit from your account at the end of each session.</p> <p>If you provide any information that is untrue, inaccurate, not correct or incomplete, SS MARKET  has reasonable grounds to suspect that such information is untrue, inaccurate, not current or incomplete, or not in accordance with the User Agreement. SS MARKET has the right to indefinitely suspend or terminate or block access of your membership with the Website and refuse to provide you with access to the Website. SS MARKET shall not be liable for any loss or damage arising from your failure to comply with this Clause 2.</p> <p><b>3. Electronic Execution and Communications</b></p> <p>When You use the Website data, information or communication to SS MARKET, You agree and understand that You are communicating with SS MARKET through electronic records. You agree to receive communications from us electronically. For contractual purposes, You consent to receive communications (including transactional, promotional and/or commercial messages), from us with respect to your use of the SS MARKET and/or your order placed on the our website. We will communicate with You by email, whats app or by posting notices on the Website or through any other SS MARKET services. You agree that all the agreements, notices, disclosures and other communications that we provide to You electronically shall be deemed to be an adequate service of notice/electronic record and satisfy any legal requirement that such communications be in writing.</p> <p><b>4.Taxes and Non-payment</b></p> <p>4.1. Taxes: You agree to bear all and any applicable taxes, charges, etc. levied thereon in accordance with the Law or Government Regulations for the time being in force.</p> <p>4.2. Non-payment: SS MARKET reserves the right to issue a warning, temporarily/indefinitely suspend or terminate Your membership of the Website and refuse to provide You with access to all current and future use of the Website in case of non-payment by You to SS MARKET also reserves the right to take legal action in case of non-payment of fees.</p> <p><b>4. Use of the SS MARKET Website</b></p> <p>You agree, undertake and confirm that Your use of SS MARKET shall be strictly governed by the following binding principles:</p> <p>You shall not host, display, upload, modify, publish, transmit, update or share any information which:</p> <p>a) belongs to another person and to which You does not have any right to;</p> <p>b) Subject to compliance with the Agreement(s), SS MARKET grants You a non-exclusive, non-sub-licensable, non-transferable, revocable, and limited right to access and use this Website and the Services provided therein.</p> <p>c) You agree to adhere to all limitations on dissemination, use and reproduction of any materials (such as the Product catalogues) that Your access on the Website in accordance with clause 7.</p> <p>d) engages in business activities and/or sales without Our prior written approval such as contests, sweepstakes, barter, advertising and pyramid schemes, or the buying or selling of "virtual" products related to the Platform. Throughout this Terms of Use, SS MARKET prior written consent means a communication coming from SS MARKET Legal Department, specifically in response to Your request, and specifically addressing the activity or conduct for which You seek authorization,</p> <p>e) solicits gambling or engages in any gambling activity which We, in Our sole discretion, believes is or could be construed as being illegal,</p> <p>f) interferes with another USER's use and enjoyment of the Platform or any other individual's User and enjoyment of similar services,</p> <p>g) harm minors in any way,</p> <p>h) infringes any patent, trademark, copyright or other proprietary rights or third party's trade secrets or rights of publicity or privacy or shall not be fraudulent or involve the sale of counterfeit or stolen products,</p> <p>i) SS MARKET shall have all the rights to take necessary action and claim damages that may occur due to your involvement/participation in any way on your own or through group/s of people, intentionally or unintentionally in DoS/DDoS (Distributed Denial of Services).</p> <p><b>Policies and Procedures</b></p> <p>It is the responsibility of each Promoter to read, understand, adhere to, and ensure that he or she is aware of and operating under the most current version of these Policies. When enrolling a new Promoter, it is the responsibility of the enrolling Promoter to provide the most current version of these Policies, the SS MARKET Terms and Conditions and the Business Plan to the applicant prior to his or her execution of the Promoter Agreement.</p> <p>SS MARKET reserves the right to change these Policies and Procedures, Terms and Conditions, Compensation Plan and Marketing Policy at any time.</p> <p><b>1. Ethics</b></p> <p>The COMPANY conducts business in an ethical and credible manner and requires its promoters to deal ethically with their customers, with each other and with the COMPANY. The COMPANY permits no unethical or illegal activity and will intercede when such behavior may exist, and the COMPANY reserves the right to use its best judgment in deciding whether certain Promoter activities are unethical. Furthermore, the COMPANY may use its own discretion in determining the appropriate course of action. If the COMPANY determines that unethical activities may exist, then it reserves the right to suspend or terminate that promoter status, including but not limited to all commissions and payments of any kind. Under no circumstances is an Promoter who is terminated for unethical or illegal activity entitled to a refund of their renewal fee, nor are they entitled to sell or transfer their position.</p> <p>Examples of unethical behaviour include but are not limited to the following:</p> <p>A. Making any false or misleading remarks, statements, innuendos or rumours that may disparage the COMPANY, its products or services, its Business plan, its employees, its founders or another COMPANY Promoter</p> <p>B. Making any claim regarding the COMPANY’s products that are not found on the COMPANY’s current websites or official, current marketing material</p> <p>C. Directly or indirectly disclosing any information to a third party other than an official COMPANY authorized employee for the purpose of assisting you with a specific issue.</p> <p>D. Providing, selling or revealing any customer lists and/or their contact information that appears in your down line report to a third party. This includes the customer lists and/or their contact information that belongs to the COMPANY or appears in any other Promoter activity report or down line report.</p> <p>E. Directly or indirectly disclosing the password or other access code to third parties</p> <p>F. Any unauthorized use of the COMPANY’s name, logos, photos, videos, trademarks or copyrighted material in any way</p> <p>G. Violation of any state or federal laws or regulations</p> <p>H. Competing with the COMPANY’s products or services directly or indirectly through association with another business or through your own personal efforts</p> <p>I. Aggressive or abusive language, behaviour or treatment or any inappropriate behaviour toward any COMPANY employee, founder or another COMPANY Promoter.</p> <p><b>2. Marketing Advertising Policy</b></p> <p>SS MARKET offers a unique different Business plan that is provided by the company to help you build your business. These materials such as brochures and business PPT's are available through the website and given to you by company. There are those Promoters who prefer to use their own materials or create materials for certain special meetings. In the meetings this is the case, we have outlined our policy and procedures for personalized marketing materials. SS MARKET requires that all personalized marketing material be approved, by the COMPANY before a Promoter can DISTRIBUTE such material.</p> <p><b>Personal Information</b></p> <p>The COMPANY maintains a strong commitment to protecting the privacy of our customers and Promoters and their personal information. “Personal Information” means any information about an identifiable individual, other than business contact information. We protect that information. Unauthorized disclosure or access of personal information, including but not limited to account information or personal identification number, is a violation of the COMPANY’s Privacy Policy and is strictly prohibited.</p> <p>The Promoter acknowledges that during this Agreement, he or she will be provided or will be exposed to or will have access to personal information and that such personal information is confidential. The Promoter agrees that such Personal Information will be collected, used and disclosed only for the purposes for which it was collected and only in relation to the provision of the COMPANY’s services or products.</p> <p>The Promoter agrees to co-operate with the COMPANY in any regulatory investigation or in any internal investigation regarding any alleged privacy breach or complaint.</p> <p><b>Conclusion</b></p> <p>The rules and regulations outlined in this document are intended to protect the opportunity for all involved.</p> <p>Please follow the Terms and Conditions as well as the Policies and Procedures as set forth here to ensure that you are in compliance. Please note that any infraction of these rules and regulations may result in suspension or immediate deactivation/termination of your status as an SS MARKET Promoter</p> <p>It is the goal of the COMPANY to introduce our applications, products and vision to as many members/clients as possible with the purpose in mind of offering them a Business opportunity for earning. Coupled with this is our desire to help others achieve financial reward for being involved with us as a Promoters. The COMPANY desires to develop a long term, stable relationship of mutual respect, trust and integrity with our Promoters. By assisting them in achieving their goals and dreams, the COMPANY’s goal of establishing a long-lasting team will be realized</p> <p><b>5. Contents Posted on Platform</b></p> <p>All text, graphics, user interfaces, visual interfaces, photographs, trademarks, logos, are third-party user-generated content and SS MARKET has no control over such third-party user-generated content as SS MARKET is merely an intermediary for the purposes of this Terms of Use.</p> <p>Except as expressly provided in these Terms of Use, no part of the Platform and no Content may be duplicated, copied, republished, uploaded, posted, openly displayed, encoded, altered, transmitted or shared in any way to any other network, server, Platform or another medium for publication or distribution or any commercial enterprise, without SS MARKET express prior written approval.</p> <p>You may use the information on the products and services purposely made available on the Platform for downloading, provided that You (1) do not remove any proprietary notice language in all copies of such documents, (2) use such information only for your personal, non-commercial informational purpose and do not copy or post such information on any networked computer or broadcast it in any media, (3) make no modifications to any such information, and (4) do not make any additional representations or warranties relating to such documents.</p> <p>You shall be responsible for any notes, messages, emails, reviews, ratings, billboard postings, photos, drawings, profiles, opinions, ideas, images, videos, audio files or other materials or information posted or transmitted to the Platform (collectively, "Content"). Such Content will become Our property and You grant Us the worldwide, perpetual and transferable rights in such Content. We shall be entitled to, consistent with Our Privacy Policy as adopted in accordance with applicable law, use the Content or any of its elements for any type of use forever, including but not limited to promotional and advertising purposes and in any media whether now known or hereafter devised, including the creation of derivative works that may include the Content You provide. You agree that any Content You post may be used by us, consistent with Our Privacy Policy and Rules of Conduct on Site as mentioned herein, and You are not entitled to any payment or other compensation for such use.</p> <p>SOME CONTENT OFFERED ON THE PLATFORM MAY NOT BE SUITABLE FOR SOME VIEWERS AND THEREFORE VIEWER DISCRETION IS ADVISED. ALSO, SOME CONTENT OFFERED ON THE PLATFORM MAY NOT BE APPROPRIATE FOR VIEWERSHIP BY CHILDREN. PARENTS AND/OR LEGAL GUARDIANS ARE ADVISED TO EXERCISE DISCRETION BEFORE ALLOWING THEIR CHILDREN AND/OR WARDS TO ACCESS CONTENT ON THE PLATFORM.</p> <p><b>6. Disclaimer of Warranties and Liability</b></p> <p>SS MARKET, all the materials and products (including but not limited to software) and services, included on or otherwise made available to You through this site are provided on "as is" and "as available" basis without any representation or warranties, express or implied except otherwise specified in writing. Without prejudice to the foregoing paragraph, SS MARKET does not warrant that: This Platform will be constantly available, or available at all; or The information on this Platform is complete, true, accurate or non-misleading. SS MARKET will not be liable to You in any way or about the Contents of, or use of, or otherwise in connection with, the Platform. SS MARKET does not warrant that this site; information, Content, materials, product (including software) or services included on or otherwise made available to You through the Platform; their servers; or electronic communication sent from Us are free of viruses or other harmful components.</p> <p>Nothing on Platform constitutes or is meant to constitute, advice of any kind. All the Products sold on SS MARKET are governed by different state laws and if Seller is unable to deliver such Products due to implications of different state laws, Seller will return or will give credit for the amount (if any) received in advance by Seller from the sale of such Product that could not be delivered to You.</p> <p>You will be required to enter a valid phone number while placing an order on the Platform. By registering your phone number with us, you consent to be contacted by us via phone calls, SMS notifications, mobile applications and/or any other electronic mode of communication in case of any order or shipment or delivery related updates. We will not use your personal information to initiate any promotional phone calls or SMS.</p> <p><b>7. Terms</b></p> <p>The Agreement will continue to apply until terminated by either you or SS MARKET as set forth below. If you want to terminate your agreement with SS MARKET, You may do so by (i) not accessing the Website; or (ii) closing Your Account for all of the Services that you use, where SS MARKET has made this option available to you.</p> <p>You agree that SS MARKET may, in its sole discretion and without prior notice, terminate your access to the Website and block your future access to the Website if SS MARKET determines that you have violated the terms of these Terms of Use or any other Agreement(s). You also agree that any violation by you of the Agreement(s) will cause irreparable harm to SS MARKET, for which monetary damages may be inadequate, and you consent to SS MARKET obtaining any injunctive or equitable relief that SS MARKET deems necessary or appropriate in such circumstances. These remedies are in addition to any other remedies SS MARKET may have at law or in equity.</p> <p>SS MARKET may, at any time, with or without notice, terminate these Terms of Use with you if:</p> <p>• SS MARKET is required to do so by law (for example, where the provision of the Services to You is, or becomes, unlawful), or upon request by any law enforcement or other government agencies;</p> <p>• In the event, SS MARKET faces any unexpected technical issues or problems that prevent the Website and / or Services from working.</p> <p>SS MARKET may also terminate or suspend all or a portion of Your Account or access to the Services with or without reason. Except as may be set forth in any Additional Terms applicable to a particular Service, termination of Your Account may include (i) removal of access to all offerings within the Website or with respect to the Services; (ii) disabling access to the Account Information, including Your personal information, log-in ID and password, and all related information, files and materials associated with or inside Your Account (or any part thereof), and any User Content uploaded by You; and (iii) prohibiting further use of the Services.</p> <p><b>8. Privacy</b></p> <p>We view protection of your privacy as a very important principle. We understand clearly that You and Your Personal Information is one of our most important assets. We store and process Your Information including any sensitive financial information collected (as defined under the Information Technology Act, 2000), if any, on computers that may be protected by physical as well as reasonable technological security measures and procedures in accordance with Information Technology Act 2000 and Rules thereunder.</p> <p>We may share personal information with our other corporate entities and affiliates. These entities and affiliates may market to you as a result of such sharing unless you are explicitly opt-out.</p> <p><b>9. Governing Law and Jurisdiction</b></p> <p>These Terms of Use and all transactions entered into on or through the SS MARKET and the relationship between you and SS MARKET shall be governed by the laws of India without reference to conflict of laws principles.</p> <p>You agree that all claims, differences and disputes arising under or in connection with or in relation here to the Website, these Terms of Use, the Agreement or any transactions entered into on or through the Website or the relationship between You and SS MARKET shall be subject to the exclusive jurisdiction of the courts at New Delhi, India and You hereby accede to and accept the jurisdiction of such courts. Each party hereby irrevocably waives any objection which such party may now or hereafter have to the laying of improper venue or forum non convenient. Each party agrees that a judgment in any such action or proceeding may be enforced in other jurisdictions by suit on the judgment or in any manner provided by law. Any service of process and any other notice in any such suit, action or proceeding for this Agreement shall be effective against a party if given as provided herein.</p> <p><b>10. Report Abuse and Take Down Policy</b></p> <p>In the event You come across any abuse or violation of these Terms of Use or if You become aware of any objectionable content on the Website, or if You believe your intellectual property rights have been violated in any manner through the Website, please refer to the SS MARKET Report and Take Down Policy available at "Terms & conditions" or under "Policy Info" section.</p> <p><b>11. Communications</b></p> <p>When You use the Website or send emails or other data, information or communication to SS MARKET, You agree and understand that You are communicating with SS MARKET through electronic records and You consent to receive communications via electronic records from SS MARKET periodically and as and when required. SS MARKET will communicate with you by email/ what's app or by notices on Website or electronic records on the Website or on Your mobile number which will be deemed adequate service of notice / electronic record to the maximum extent permitted under any applicable law.</p> <p>Notice: All notices with respect to these Terms of Use from SS MARKET will be served to you by whatsapp / email / or by general notification on the Website.</p> <p><b>12. Feedback and Information</b></p> <p>Any feedback you provide to this Website shall be deemed to be non-confidential. SS MARKET shall be free to use such information on an unrestricted basis. Further, by submitting the feedback, You represent and warrant that (i) Your feedback does not contain confidential or proprietary information of You or of third parties; (ii) SS MARKET is not under any obligation of confidentiality, express or implied, with respect to the feedback; (iii) SS MARKET may have something similar to the feedback already under consideration or in development; and (iv) You are not entitled to any compensation or reimbursement of any kind from SS MARKET for the feedback under any circumstances.</p>
				</div>
					<div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
			</div>

		</div>
	</div>
	<div class="modal fade" id="Termsandconditions" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<!-- <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Terms and Conditions</h4>
				</div> -->
				<div class="modal-body">
					<p><h5><center>SS MARKET</center></h5></p> <p><h5><center>MARKETING TERMS AND CONDITIONS</center></h5></p> <p>SS MARKET offers a unique Uni-level Compensation Plan to all of its Direct Sellers. </p> <p><b>1.DEFINITIONS:</b></p> <p>The following words used in these presents shall have the meaning as defined hereunder: -</p> <p><b>A.DIRECT SELLER</b><p> <p>Any registered customer who makes a purchase of products worth of 730/1460/2190 B.V is considered to be a Direct Seller as per the Marketing Plan.</p> <p><b>B.BUSINESS VOLUME (B.V)</b></p> <p>Total volume of purchase based on the allocated value of B.V per product is considered to be the Business Volume. A direct seller’s B.V is calculated based on the total sales volume achieved by his/her Team Members performance.</p> <p><b>C.LINE OF SPONSORSHIP (LOS)</b></p> <p>LOS defines the sponsoring table of an individual Direct Seller. If a Direct Seller sponsors a person into this business, and that person sponsors another, and the chain/line of sponsoring continues as such. That total line of sponsoring persons by persons in multi levels is called as LINE OF SPONSORSHIP (LOS) </p> <p><b>2.COMPENSATION / COMMISSION RULES</b></p> <p>Commission / Compensation is given to the Direct Seller based on the first purchase and repurchase of his/her own down line team up to 7 levels of his/her LOS. Total B.V achieved through his/her team as per the divisions allocated in the Marketing Plan and that too in 30/60/90 active days of a Direct Seller is considered to be the total sales volume achieved by him/her.</p> <p>All commissions are given as per the turn over sales volume created by a Direct Seller utilising his/her 7 level team and it is arrived by using the B.V. </p> <p>Any B.V created through a purchase lasts for 30/60/90 days (one business month) and after 30/60/90 days it is purely the members’ choice to make a repurchase.<p> <p>No commission / compensation is promised to the Direct Seller for making any kind of self purchase done by him/her.</p> <p>The compensation plan is based on the B.V that any Direct Seller creates by his/her LOS and it is limited only up to 7 levels of his/her own down line team.</p> <p>B.V created other than 7 levels of his/her own LOS will not be taken into consideration for calculating the compensation/commission.</p> <p>The B.V achieved by a purchase is distributed to 7 levels up the table according to the LOS, and as per the divisions of B.V according to the Marketing plan.</p> <p>The B.V achieved lasts for 30/60/90 active days (one business month) and the B.V is split into 30/60/90 equal parts and are awarded on a daily basis to the Direct Seller. But this condition is applied only to the B.V created by Level 2 to Level 7 team of any Direct Seller.</p> <p>The Level -1 B.V of any Direct Seller achieved by him / her by making his / her immediate down lines to purchase products worth of 730/1460/2190 B.V is calculated for one single time and is awarded immediately if the purchase is made.</p> <p>Only active direct sellers who made a purchase of 730/1460/2190 B.V is eligible to receive level B.V from his/her team sales and it is valid only up to 30/60/90 days. After completing 30/60/90 days from the date of purchase, the Direct Seller must do a repurchase worth of 730/1460/2190 B.V in order to keep receiving B.V from his/her team.</p> <p>Those Direct Sellers who misses to do a repurchase worth of 730/1460/2190 B.V after 30/60/90 days are considered to be inactive and are not eligible to receive any B.V from their teams’ sales volume.</p> <p>However an Inactive Direct Seller won’t lose his LOS and can activate his ID anytime he/she wants and can enjoy the eligible level benefits from the day of activation.</p> <p>Provisions are given to renew/repurchase early even before his/her 30/60/90 days are over. In such conditions of early or advanced repurchase 30/60/90 days will be added to the existing active days for every additional 730/1460/2190 B.V purchase.</p> <p><b>3.DIVISION OF B.V TO 7 LEVELS</b></p> <p>This division of B.V is calculated for every purchase of 730/1460/2190 B.V. Here is a tabular illustration of how this 730/1460/2190 B.V is distributed up to the level of sponsors in the LOS. A direct seller gets the allocated B.V according to each sales happens in his/her team in each level up to 7 Levels of his/her own LOS.</p> <p>LEVEL 1  -  100/200/300 B.V (awarded one single time on every purchase)</p> <p>LEVEL 2  -    60/120/180 B.V (awarded 2 B.V per day x 30/60/90 days) </p> <p>LEVEL 3  -    60/120/180 B.V (awarded 2 B.V per day x 30/60/90 days) </p> <p>LEVEL 4  -    90/180/270 B.V (awarded 3 B.V per day x 30/60/90 days) </p> <p>LEVEL 5  -  120/240/360 B.V (awarded 4 B.V per day x 30/60/90 days) </p> <p>LEVEL 6  -  150/300/450 B.V (awarded 5 B.V per day x 30/60/90 days) </p> <p>LEVEL 7  -  150/300/450 B.V (awarded 5 B.V per day x 30/60/90 days)</p> <p>Likewise all level commissions are calculated for every sale of 730/1460/2190 PV in each level and are distributed to the levels as per the compensation plan.</p> <p><b>4.LEVEL INCOME CONDITIONS</b></p> <p>The compensation plan is applied with certain conditions for awarding the level B.V to any Direct Seller. </p> <p>a) To receive Level 1 benefit, a Direct Seller must sponsor at least one active down line in his L-1 Team. </p> <p>b) To receive Level 2 benefit, a Direct Seller must sponsor at least two active down lines in his L-1 Team. </p> <p>c) To receive Level 3 benefit, a Direct Seller must sponsor at least three active down lines in his L-1 Team. </p> <p>d) To receive Level 4 & Level 5 benefit, a Direct Seller must sponsor at least four active down lines in his L-1 Team. </p> <p>e) To receive Level 6 & Level 7 benefits a Direct Seller must sponsor at least five active down lines in his L-1 Team. </p> <p>A Direct Seller must comply with all the above said conditions to avail all the level benefits from his/her own team.</p> <p>A Direct Seller can sponsor any number of active down lines in his Level 1 Team. There is no limit for sponsoring. But he/she must have sponsored a minimum of 5 members to receive all 7 Level benefits.</p> <p><b>5.CAPPING CONDITIONS</b></p> <p><b>a)Income Capping</b></p> <p>Commission income is calculated based on the B.V achieved by the Direct Seller through his/her  level team and is awarded every day at the end of the day.<p> <p><center><b>1 B.V = 1 INR</b></center><p> <p>The Total accumulated B.V per Direct Seller achieved by his/her 7 Level Team is limited up to 80,000 B.V per day.</p> <p>Even if any of the Direct Sellers B.V exceeds the daily capping limit of 80,000 B.V on a single day, the exceeding B.V is flushed out and will not be taken into consideration for creating commission income.</p> <p><b>b)Level Capping</b></p> <p>Up to 2000 B.V per day	     -	No capping conditions are applied</p> <p>More than 2000 B.V per day   -	2 active down line purchase in Level 1 Team</p> <p>More than 6000 B.V per day   -     4 active down line purchase in Level 1 Team</p> <p>More than10000 B.V per day  -     5 active down line purchase in Level 1 Team </p> <p><b>6.DEDUCTIONS .</b></p> <p>A total of 11% is deducted in the commission Income and the break up for those reductions are illustrated below.</p> <p><center><b>5% - Towards TDS (20% for No PAN CARD Submissions)</b></center></p> <p><center><b>5% - Towards Admin Charges and Website Usage</b></center></p> <p><center><b>1% - Towards Charity (to the needy Direct Sellers)</b></center></p>
				</div>
					<div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
			</div>

		</div>
	</div>
</body>

</html>

