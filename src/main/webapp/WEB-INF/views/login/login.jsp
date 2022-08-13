<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param value="집에가자" name="title"/>
</jsp:include>

    <form action="">
        <label for="username">아이디 : </label>
        <input type="text" id="username" name="username" />
        <label for="password">비밀번호 : </label>
        <input type="text" id="password" name="passowrd" />
        <input type="button" value="로그인" />
    </form>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>