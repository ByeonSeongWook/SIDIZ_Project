<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>SIDIZ</title>
<link rel="stylesheet" href="${path}/resources/css/bootstrap.css">
<link rel="stylesheet" href="${path}/resources/css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>


<script src="//ajax.googleapis.com/ajax/libs/jquery.min.js" charset="UTF-8"></script>

<script src="${path}/resources/js/address.js" charset="UTF-8"></script>
  <link rel="stylesheet" type="text/css" href="${path}/resources/css/default_basket.css"><!-- 공통 css -->
  <link rel="stylesheet" type="text/css" href="${path}/resources/css/order.css"><!-- 컨텐츠 css -->
  <%-- <script src="${path}/resources/js/jquery-2.0.0.js"></script><!-- jquery js --> --%>
  <script src="${path}/resources/js/jquery.easing.1.3.js"></script><!-- easing js-->
   <script src="${path}/resources/js/vendor.js"></script><!-- vendor js -->
  <!-- <script src="/js/common.js"></script> --><!-- 공통 js_body밑에 -->
  <script src="${path}/resources/js/script.js"></script><!-- 제이쿼리 --> 
  <script src="${path}/resources/js/nav_jquery.js"></script><!-- 네비 js --> 
  <!-- font --------------------------------------------->
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
      integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm"
      crossorigin="anonymous"
    />
<script>
	
	$(document).ready(function(){
		
		//--- 주소 모달 	
		$('#getAddrBtn').click(function(){
			var postCode	= $('#entry_postcode5').val();
			var doroAddr 	= $('#entry_address').val(); 
			var jibunAddr	= $('#entry_extra_info').val(); 
		
			$('#addr1').val(postCode);
			$('#addr2').val(doroAddr + ' ' + jibunAddr);
		
		});
		        	
		
		//--- 장바구니에 있는 리스트 불러오기
		var product_names = [];
		var colors = [];
		var product_counts = [];
		var order_prices = [];
		
		$('input:checkbox[name=product_name]:checked').each(function() {
			product_names.push($(this).val());
		});
		$('input:checkbox[name=color]:checked').each(function() {
			colors.push($(this).val());
		});
		$('input:checkbox[name=product_count]:checked').each(function() {
			product_counts.push($(this).val());
		});
		$('input:checkbox[name=order_price]:checked').each(function() {
			order_prices.push($(this).val());
		});
		
		
		//--- 주문자 정보 가져 오기
	   $("#checkOrderName").change(function(){
				// 주문 고객 정보와 동일 체크 시			   
		        if($("#checkOrderName").is(":checked")){
		        	alert($('#user_id').val());
					alert('주문자 정보와 동일!');
					$('#delTable_name').val($('#UserTable_name').val());
					$('#delTable_phone').val($('#UserTable_phone').val());
		        }
		        else{
					alert('체크해제!');
		        	$('#delTable_name').val(' ');
		        	$('#delTable_phone').val(' '); 
		        }
	    });

		
		//--- 데이터 전송(submit)시 검증	
		$('form').submit(function(e){
			var user_name 		= $('#user_name').val();
			var addr3				= $('#addr3').val();
			var user_phone 	= $('#user_phone').val();
			var user_tel 			= $('#user_tel').val();
			var order_memo 	= $('#order_memo').val();
			
			
			// 주문할 상품이 없을시
			if($('#product_name').val() == null) {
				alert('주문 목록이 없습니다!');
				e.preventDefault();
				return;
			}	
			
			// 이용약관 모두 체크 X 시
			else if($('#collect_third').is(':checked') != true || $('#collect').is(':checked') != true) {
				alert('이용약관에 모두 동의 해주세요!');
				e.preventDefault();
				return;
			}
			
			// 배송지 정보 전부 미 입력시	
			else if(user_name == "" || addr3 == "" || user_phone == "" || user_tel == "" || order_memo) {
				alert("배송지 정보의 모든 값을 입력 해주세요!");
				e.preventDefault();
				return;
			}
			
		})	;     
		
	});
</script>
</head>

<body>
  <div class="wrapper">
    <!-- [상단(header)] -->
    <header id="header">
      <!-- 상단 : 로고 -->
      <h1 class="logo"><a href="${path }/">SIDIZ</a></h1>
    </header>
    <!-- 상단-네비 : 우측 아이콘 -->
    <div id="header_icon">
    			
      <ul class="nav-group">

        <li>
            <a href="#"><img src="${path}/resources/images/main_images/nav_my.png" alt="" /></a>
        </li>
        <li>
            <img src="${path}/resources/images/main_images/nav_write.png" alt="" class="write"/>
            <div class="search">
              <input type="text" id="search_form" name="keyword" class="top_srarch_text" title="" placeholder="검색" autocomplete="off">
              <input type="image" src="${path}/resources/images/main_images/nav_glass12.png" id="btnSearchTop" class="btn_top_srarch" title="검색" value="검색" alt="검색">
              <p class="search-box-close">
                X
              </p>
            </div>
        </li>
      </ul>
      <a href="#" class="nav-viewer">
        <i></i>
        <i></i>
        <i></i>
        
      </a>
    </div>

    <!-- [네비] -->
    <nav id="main_mn">
      <div class="nav-inner">
        <article id="side_mn">  
          <ul>
          <li>
	         <p>
		         	<!-- 로그인 안했을 때 표시  -->
		         	<c:if test = "${empty user_id}" >
		         		<a href = "${path}/login">
		         		<img src="${path}/resources/images/nav_images/logout.png" alt="" />Login
		         		</a>
		         	</c:if>
		         	
		         	<!-- 로그인 했을 때 표시  -->
		         	<c:if test = "${not empty user_id}" >
		         		<a href = "${path}/logout">
		         		<img src="${path}/resources/images/nav_images/logout.png" alt="" />Logout
		         		</a>
		         	</c:if>
		         
	         </p>
          </li>
            <li class="has-sp sp-1">
              <p>
                <a href="#">
                  <img src="${path}/resources/images/nav_images/nav_login_mypge.png" alt="" />My Page
                </a>
              </p>
            </li>
            <li class="has-sp sp-2">
              <p>
                <a href="basket">
                  <img src="${path}/resources/images/nav_images/nav_ShoppingBasket.png" alt="" />Shopping Basket
                </a>
              </p>
            </li>
            <li class="has-sp sp-3">
              <p>
                <a href="review">
                  <img src="${path}/resources/images/nav_images/nav_Review.png" alt="" />Review
                </a>
              </p>
            </li>
            <li class="has-sp sp-4">
              <p>
                <a href="comparison">
                  <img src="${path}/resources/images/nav_images/nav_Compare.png" alt="" />Compare
                </a>
              </p>
            </li>
            <li class="has-sp sp-5">
              <p>
                <a href="event">
                  <img src="${path}/resources/images/nav_images/nav_Event2.png " alt="" />Event
                </a>
              </p>
            </li>
          </ul>
        </article>

        <article id="menu">
          <ul>
            <li id="about">
              <h4 class="has-sp sp-6">
                <p> <b>ABOUT SIDIZ</b> </p>
              </h4>
              <div class="contents">
                <ul id="first">
                  <li class="nav_title">
                    <a href="brand_story">
                      BRAND STORY
                      <img src="${path}/resources/images/nav_images/nav_ABOUT SIDIZ_1.png" alt="" id="brand_img"/>
                    </a>
                  </li>
                  <li class="nav_title">
                    <a href="news ">
                      NEWS<img src="${path}/resources/images/nav_images/nav_ABOUT SIDIZ_2.png" alt="" />
                    </a>
                  </li>
                </ul>
              </div>
            </li>
            <li id="products"  class="nav_title">
              <h4 class="has-sp sp-7" style="font-size:80px">
                <p> <b>PRODUCTS</b> </p>
              </h4>
              <div class="contents">
                <ul id="second">
                  <li>
                    <a href="productMenu">
                      사무용
                      <img src="${path}/resources/images/nav_images/nav_PRODUCTS_1.png" alt="" />
                    </a>
                  </li>
                  <li>
                    <a href="productMenu">
                      학생용
                      <img src="${path}/resources/images/nav_images/nav_PRODUCTS_2.png" alt="" />
                    </a>
                  </li>
                  <li>
                    <a href="productMenu">
                      유아용
                      <img src="${path}/resources/images/nav_images/nav_PRODUCTS_3.jpg" alt="" />
                    </a>
                  </li>
                  <li>
                    <a href="productMenu">
                      인테리어
                      <img src="${path}/resources/images/nav_images/nav_PRODUCTS_4.png" alt="" id="interior_img"/>
                    </a>
                  </li>
                  <li>
                    <a href="productMenu">
                      모든제품
                      <img src="${path}/resources/images/nav_images/nav_PRODUCTS_5.png" alt="" id="all_img"/>
                    </a>
                  </li>
                  
                </ul>
              </div>
            </li>
            <li id="support">
              <h4 class="has-sp sp-8">
                <p> <b>SUPPORT</b> </p>
              </h4>
              <div class="contents">
                <ul id="third">
                  <li>
                    <a href="bbs">
                      Q&A
                      <img src="${path}/resources/images/nav_images/nav_SUPPORT_1.png" alt="" />
                    </a>
                  </li>
                  <li>
                    <a href="https://bizmessage.kakao.com/chat/5bp5waCQLFl4-xgLbLGeNgf8qH_smEtv_c_acLTkgmU/5p0dRciBenRIQOKmSzS7Ag">
                      친절상담
                      <img src="${path}/resources/images/nav_images/nav_SUPPORT_2.png" alt="" id="counsel_img"/>
                    </a>
                  </li>
                  <li>
                    <a href="search_store">
                      매장찾기
                      <img src="${path}/resources/images/nav_images/nav_SUPPORT_3(1).png" alt="" id="map_img"/>
                    </a>
                  </li>
                </ul>
              </div>
            </li>
          </ul>
        </article>
      </div>
    </nav>
	<!-- [네비 끝 ] -->
	
	<!-- [내용(contents)] 부분  -->

      <div id="order">
        <div id="select_menu">
          <ul>
            <li><span><a href="/" style = "color: #777">HOME</a></span></li>
            <li>주문결제</li>
          </ul>
        </div>
        <div class="e_contents">
          <!-- 주 제목 -->
          <header class="ec_header">
            <h4>주문결제</h4>
          </header>

          <!-- 부 제목 -->
          <!-- 제목 위 보더 스타일 -->
          <div id="boarder">
            <div class="b_box"></div>
            <div class="b_box bb_t"></div>
            <!-- 제목 위 보더 스타일 끝 -->
            <div class="b_title">
              <h5>주문결제</h5>
            </div>
          </div>

          <!-- 주문 결제 시작 -->
          <div id="img_box">
            <img src="${path}/resources/images/order.png" alt="" />
          </div>
          <div id="order_box">
           <table id="tb">
           	<thead>
	              <tr style="background-color: #e7e7e7">
	               
	               <!-- 장바구니 항목 -->
	                <td
	                  colspan="2"
	                  style="width: 40.8%; height: 45px; text-align: center"
	                >
	                  제품정보
	                </td>
	                <td style="width: 12.8%; height: 45px; text-align: center">
	                  색상/소재
	                </td>
	                <td style="width: 11.8%; height: 45px; text-align: center">
	                  판매가격
	                </td>
	                <td style="width: 10.8%; height: 45px; text-align: center">
	                  수량
	                </td>
	                <td style="width: 23.8%; height: 45px; text-align: center">
	                  주문금액
	                </td>
	              </tr>
              </thead>
              
              <c:if test = "${empty ub_list}">
              <tr>
                <td colspan="8" style="height: 127px; text-align: center">
                  장바구니에 담긴 품목이 없습니다.
                </td>
              </tr>
              </c:if>
              
              <tbody id = "basketListTable">
              <c:forEach var= "basket" items ="${ub_list}">
					<tr>

		               
		               <!-- 장바구니 항목 -->
		               <td style="width: 13.8%; height: 50px; text-align: right; border-right: 0">
       		             <input type="hidden" id = "product_name" value = "${basket.product_name}" class="checked">
		                 <input type="hidden" id = "user_id" value = "${basket.user_id}">
		                <img src="${path}/resources/images/${basket.basket_img}">
		                </td>
		               
		                <td style="width: 40.8%; height: 50px; text-align: center" id = "product_name">
		                  ${basket.product_name}
		                </td>
		                
		                <td style="width: 12.8%; height: 50px; text-align: center">
		                  ${basket.color}
		                </td>
		                <td style="width: 11.8%; height: 50px; text-align: center">
		                  ${basket.product_price}
		                </td>
		                <td style="width: 10.8%; height: 50px; text-align: center">
		                  ${basket.product_count}
		                </td>
		                <td style="width: 23.8%; height: 50px; text-align: center">
		                  ${basket.product_price * basket.product_count} 
		                </td>
		            </tr>
              </c:forEach>
              </tbody>
              
              <!-- 총 결제 금액 	-->
              <tfoot id="totalOrderPrice">
              <tr style="background-color: #e7e7e7">
                <td colspan="2" style="height: 67px; text-align: center"></td>
                <td colspan="2"  style="height: 67px; text-align: center">총 결제금액</td>
				
				<td colspan="2"   style="text-align: center; color: red">${totalOrderPrice} 원</td>
              </tr>
              </tfoot>
            </table>
          </div>
          <div id="order_detail">
            <div id="provision">
              <div id="provision_left">
                <div id="useText">
                	<!-- 이용약관 페이지 불러오기 -->
					<jsp:include page="../termsofUse_txt.jsp"/>
                </div>
                	<!-- 비회원일시 출력 작업하기 -->
	                <input type="checkbox" id="nonUser" />
	                <label for="nonUser">
	                  비회원 쇼핑을 이용약관에 동의합니다.
	                </label>
              </div>
              <div id="provision_right">
                <div id="collectText">
                	<!--개인정보 수집 동의 불러오기 -->
 					<jsp:include page="../termsofUse_txt.jsp"/>
                </div>
                <p id="first">
                  <input type="checkbox" id="collect" />
                  <label for="collect">
                    개인정보 수집 및 이용에 동의합니다.
                  </label>
                </p>
                <p id="second">
                  <input type="checkbox" 	id="collect_third"/>
                  <label for="collect_third">
                    개인정보 제 3자 제공 동의 (필수)
                  </label>
                </p>
                <p id="third">
                  *미동의시 홈페이지 이용 및 제품 구매/배송에 제한이 될 수
                  있습니다.
                </p>
              </div>
            </div>
            <div id="order_info">
              <div id="info_left">
                <div id="user_table">
                  <table width="400" height="245">
                    <tr>
                      <td colspan="2" id="table_header">
                        <h2>주문고객 정보</h2>
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 30%">이름</td>
                      <td style="width: 70%">
                        <input type="text" id="UserTable_name" />
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 30%">이메일</td>
                      <td style="width: 70%">
                        <input type="text" id="UserTable_email" />
                      </td>
                    </tr>
                    <tr>
                      <td style="width: 30%">휴대전화</td>
                      <td style="width: 70%">
                        <input type="text" id="UserTable_phone" /> 예&#41;
                        010-1234-5678
                      </td>
                    </tr>
                  </table>
                </div>
              </div>
              <div id="info_right">
                <div id="delivery_table">
                
                <!-- 주문 정보 입력 -->
                <form method = "POST" action = "./addOrderAction">
                  
                  <table width="490" height="535">
                  
                    <tr>
                      <td colspan="2" id="delTable_header">
                        <h2>배송지 정보</h2>
                      </td>
                    </tr>
                    
                    <tr id="userCheck">
                      <td colspan="2"  style="padding: 10px">
                      <!-- 주문고객정보 넣기 -->
                        <input type="checkbox" id = "checkOrderName" style="padding-top: 3px;"/>
                        <label for="check_UserInfo">주문 고객 정보와 동일</label>
                        <c:forEach var= "ub_list" items ="${ub_list}">
	                        <input type="checkbox" style="display: none;" name ="product_names" value="${ub_list.product_name}" checked/>
	                        <input type="checkbox" style="display: none;" name ="colors" value = "${ub_list.color}" checked/>
	                        <input type="checkbox" style="display: none;" name ="product_counts" value = "${ub_list.product_count}" checked/>
	                        <input type="checkbox" style="display: none;" name ="order_prices" value = "${ub_list.product_count * ub_list.product_price}" checked/>
                        </c:forEach>
                      </td>
                    </tr>
                    
                    <tr>
                      <td style="width: 30%">받는 사람</td>
                      <td style="width: 70%">
                        <input type="text" name = "user_name" id="delTable_name"  value=""/>
                      </td>
                    </tr>
                    
                    <tr>
                      <td style="width: 30%">주소</td>
                      <td style="width: 70%; padding-left: 0px;">
                        <p>
                          <input type="text" id="addr1" readonly />
                          <button
                            type="button"
                            id="search"
                            data-toggle = "modal"
                            data-target = "#addrModal"
                          >주소 검색</button>
                        </p>
                        <p><input type="text" id="addr2" name = "addr2" readonly /></p>
                        <p><input type="text" id="addr3" name = "addr3"/></p>
                      </td>
                    </tr>
                    
                    <tr>
                      <td style="width: 30%">휴대전화</td>
                      <td style="width: 70%">
                        <input type="text" name = "user_phone" id="delTable_phone" value=""/> 예&#41;
                        010-1234-5678
                      </td>
                    </tr>
                    
                    <tr>
                      <td style="width: 30%">전화번호</td>
                      <td style="width: 70%">
                        <input type="text" name = "user_tel" id="delTable_tel" /> 예&#41;
                        02-1234-5678
                      </td>
                    </tr>
                    
                    <tr>
                      <td style="width: 30%">배송 요청사항</td>
                      <td style="width: 70%">
                        <input type="text" name = "order_memo" id="delTable_require" />
                      </td>
                    </tr>
                    
                    <tr id="delPrice">
                      <td colspan="2" style="color: red;">총 결제금액 ${totalOrderPrice} 원</td>
                    </tr>
                    
                	</table>
	
                  
                </div>
              </div>
            </div>
            
            <div id="buy_way">
              <div id="select">
                <h2>결제수단 선택</h2>
                <div>
                  <input type="radio" id="credit" name="sel" value="credit" />
                  <label for="credit">신용카드</label>
                  <input type="radio" id="credit" name="sel" value="credit" />
                  <label for="credit">계좌이체</label>
                  <input type="radio" id="credit" name="sel" value="credit" />
                  <label for="credit">가상계좌(무통장)</label>
                </div>
              </div>
              <div id="confirm">
                <img src="${path}/resources/images/confirm.png" alt="" />
                <div id="error">결제오류센터 &#62;</div>
              </div>
            </div>
            <div id="btns">
	          	<div>
	           		<input type="image" src="${path}/resources/images/orderBtn.png" alt="제출하기 이미지" style="width: 87px; height:35px; margin-top: 7px"/>
	          	</div>
	          	<div>
	            	<a href="basket"><img src="${path}/resources/images/backBtn.png" alt="" /></a>
	          	</div>
       		</div>
        </form>

            
          </div>
        </div>
      </div>


      <button onclick="location.href='search_store '" class="shop_btn">매장찾기</button><!-- 매장찾기 버튼 -->
      <button onclick="window.open('https://bizmessage.kakao.com/chat/open/%40sidiz_official?bot=true&amp;event=WEB_WELCOME')" class="chat_btn">챗봇문의</button><!-- 챗본문의 버튼 -->
  
      <!-- [하단(footer)] 부분 -->
      <footer id="footer">
          <!--하단 : 탑 부분-->
          <div id="f_top">
            <h2>
              <a href="index ">
                <img src="${path}/resources/images/main_images/footer_logo.png" alt="">
              </a>
            </h2>
            <span class="f_sns">
              <ul>
                <li>
                  <a href="https://www.facebook.com/sidizchair" target="_blank">
                    <img src="${path}/resources/images/main_images/footer_facebook.png" alt="">
                  </a>
                </li>
                <li>
                  <a href="https://www.instagram.com/sidiz_official/" target="_blank">
                    <img src="${path}/resources/images/main_images/footer_insta.png" alt="">
                  </a>
                </li>
                <li>
                  <a href="https://blog.naver.com/chairblues" target="_blank">
                    <img src="${path}/resources/images/main_images/footer_blog.png" alt="">
                  </a>
                </li>
              </ul>
            </span>
          </div>
    
          <!--하단 : 바텀 부분-->
          <div id="f_bom">
            <article class="wp30">
              <p class="lh18">
                  Copyright (c) 2019 SIDIZ, INC.<br>
                  All rights reserved.<br><br>
              </p>
              <p class="lh22">
                  (주)시디즈<br><br>
              </p>
              <p class="lh20">
                  대표이사 · 이상배<br>
                  경기도 평택시 세교산단로 67-20 (세교동)<br><br>
                  사업자등록번호 · 215-87-48121<br>
                  통신판매신고번호 · 2018-경기평택-0099<br>
                  부가통신사업신고필증 · 022094<br><br>
                  FAX · 02-3400-4800<br>
                  개인정보관리책임자 · 이상배 I sidiz_official@fursys.com<br><br><br>
              </p>
              
              <a class="wp100" href="https://www.sidiz.com/img/footer/ESCROW_SIDIZ.jpg" target="_blank">
                  <img src="${path}/resources/images/main_images/footer.png" alt="">
                  <span class="lh21">에스크로 가입사실 확인</span>
              </a>
            </article>
            <article class="wp70">
              <div class="h55">
                  <ul class="subUl subUlTop">
                    <li class="mgr74">
                      <a href="https://www.sidiz.com/policy/view.do?policyNo=11">이용약관</a>
                    </li>
                    <li class="mgr74">
                      <a class="fntClr_1a59ff" href="https://www.sidiz.com/policy/view.do?policyNo=12">개인정보처리방침</a>
                    </li>
                  </ul>
              </div>
              <div>
                  <ul>
                    <li class="menuTitle">투자정보
                      <ul class="subUl mgt20">
                        <li><a href="https://www.sidiz.com/ir/noticeList?page=1">공고·IR</a></li>
                      </ul>
                    </li>
                  <li class="menuTitle">ABOUT SIDIZ
                    <ul class="subUl mgt20">
                      <li><a href="brand_story ">BRAND STORY</a></li>
                      <li><a href="news ">NEWS</a></li>
                    </ul>
                  </li>
                  <li class="menuTitle">제품
                    <ul class="subUl mgt20">
                      <li><a href="productMenu ">마블x시디즈 태스크</a></li>
                      <li><a href="productMenu ">디즈니x시디즈 키즈</a></li>
                      <li><a href="productMenu ">사무용의자</a></li>
                      <li><a href="productMenu ">학생용의자</a></li>
                      <li><a href="productMenu ">유아용의자</a></li>
                      <li><a href="productMenu ">중역용의자</a></li>
                      <li><a href="productMenu ">회의실/컨퍼런스의자</a></li>
                      <li><a href="productMenu ">인테리어의자</a></li>
                      <li><a href="productMenu ">스툴/좌식의자</a></li>
                      <li><a href="productMenu ">액세서리</a></li>
                    </ul>
                  </li>
                  <li class="menuTitle">고객센터
                    <ul class="subUl mgt20">
                      <li><a href="productMenu ">FAQ</a></li>
                      <li><a href="productMenu ">친절상담</a></li>
                      <li><a href="productMenu ">A/S신청</a></li>
                      <li><a href="#">A/S안내</a></li>
                      <li><a href="search_store ">매장 찾기</a></li>
                      <li><a href="productMenu ">품질 보증 서비스</a></li>
                      <li><a href="productMenu ">제품설명서 다운로드</a></li>
                      <li><a href="productMenu ">카탈로그 다운로드</a></li>
                      <li><a href="productMenu ">시디즈 서비스</a></li>
                    </ul>
                  </li>
                  <li class="mgr34 menuTitle">문의사항
                    <p class="f24 mgt20">1899 - 3176</p>
                    <p class="f13 mgt20">
                    <strong>평일</strong> | 09:30 - 17:30<br> <span class="col999">* 점심시간 | 12:30 - 13:30</span><br><br>토요일 | 09:30 - 12:30<br>일요일, 공휴일 휴무<br></p>
                  </li>
                </ul>
              </div>
            </article>
          </div>
      </footer>
    </div>
  
  <%-- 주소 검색 모달 --%>
<div id = "addrModal" class = "modal fade" role = "dialog">
		<div class = "modal-dialog">
				<div class = modal-content>
						<div class = "modal-header">
								<button type = "button" class = "close" data-dismiss = "modal">&times;</button>
								<h4 class = "modal-title">주소 검색</h4>
						</div>
						<div class = "modal-body">
								<div class = "row" id = "postcodify">
								<script>
										$('#postcodify').postcodify({
												insertPostcode5 	: '#entry_postcode5',
												insertAddress		: '#entry_address',
												insertExtraInfo		: '#entry_extra_info',
												userFullJibeon		: true,
												mapLinkProvider	: 'google',
												
												ready : function() {
													$('#postcodify div.postcode_search_status.empty').hide();
												},
												
												beforeSearch 	: function() {
													$('#entry_box').hide();
												},
												
												afterSearch 		: function(selectedEntry) {
													$('#postcodify div.postcode_search_result').remove();
													$('#postcodify div.postcode_search_status.summary').hide();
													$('#entry_box').show();
													$('#entry_details').focus();
												}
												
										});
								</script>
							</div>
								<div>
										<p>
												<label for = "entry_postcode5">우편번호</label>
												<input type = "text" class = "form-control" id = "entry_postcode5" readonly>
										</p>
										<p>
												<label for = "entry_address">도로명주소</label>
												<input type = "text" class = "form-control" id = "entry_address" readonly>
										</p>
										<p>
												<label for = "entry_extra_info">지명주소</label>
												<input type = "text" class = "form-control" id = "entry_extra_info" readonly>
										</p>
								</div>
						</div>
						<div class = "modal-footer">
								<button type = "button" id = "getAddrBtn" class = "btn btn-primary" data-dismiss = "modal">확인</button>
						</div>
				</div>
		</div>
</div>
<%-- 주소 검색 모달 종료--%>
  
    <script src="${path}/resources/js/common.js"></script><!-- 메인-공통 js -->

<script>

$(document).ready(function(){
	var msg = '${msg}';
	if(msg != null && msg != '') alert(msg);
});

</script>

</body>
</html>