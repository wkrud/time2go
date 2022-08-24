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
<%-- <sec:authentication property="principal" var="loginMember"/> --%>
    <script type="text/javascript">
        $(() => {
            /* if (${loginMember.id} == '') {
                location.href = '/t2g/login/login';
            }; */
            const getCoffee = (() => {
                $.ajax({
                    
                });
            });
        });
    </script>
    <div class="header">
        <h1>퇴근시간은 알아야지</h1>
    </div>
    <div id="day-wrapper">
        <div id="dayDiv">
            <div id="enter-time-wrapper">
                <label for="">출근시간 : 
                    <input type="number" id="enter-hour" value="9"><span style="color: black;">시</span>
                    <input type="number" id="enter-minute" value="0"><span style="color: black;">분</span>
                </label><br><br>
                <label for=""> 근무시간 : 
                    <select id="work-time">
                        <option value="all">종일</option>
                        <option value="before">오전반차</option>
                        <option value="after">오후반차</option>
                    </select>
                </label>
                <input type="number" id="work-hour" value="9" style="display: none;">
            </div><br><hr>
            <h1></h1>
            <h2 style="display: inline-block;"></h2>
            <h3 style="display: inline-block;"></h3>
        </div>
        <div id="day-bar">
            <div id="dBar"></div>
        </div>
        <div id=" endTime">
            <h2>점심시간 : <span id="lunch"></span></h2>
            <h2>퇴근시간 : <span id="home"></span></h2>
        </div>
        <div id="hidden-goods"></div>
    </div><br>
    <div id="clean-wrapper">
        <div id="coffee">
            <caption>
                <span id="coffeeCap" style="font-weight: 700; font-size: 1.5rem; color: blueviolet;"></span>    
            </caption>

            <table>
                <thead>
                    <tr>
                        <th>월</th>
                        <th>화</th>
                        <th>수</th>
                        <th>목</th>
                        <th>금</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>한아름</td>
                        <td>진현지</td>
                        <td>김재경</td>
                        <td>하나현</td>
                        <td>강혜정</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div><br>
    <script>
        let day = new Date();
        let comeTime = 9 * 60;
        let minusTime = 0;
        let millis = 0;
        let seconds = 0;
        let minutes = 0;
        let hours = 0;
        let days = 0;
        let krDays = '';
        const week = ['일', '월', '화', '수', '목', '금', '토'];
        
        let amPm = '';
        let current = 0;
        let startHour = 0;
        let endHour = 0;

        let enterHour = $('#enter-hour');
        let enterMinute = $('#enter-minute');
        let workHour = $('#work-hour');
        let workHours = $('#work-time');

        $(() => {
            $('#coffeeCap').text((day.getMonth() + 1) + '월의 커피청소');
            days = day.getDay();
            if (days > 0) {
                $('table thead th').eq(days - 1).css({'color' : 'red', 'font-size' : '1.5rem'});
            };
        });
        
        $(document).ready(function(){
            enterHour.on('input', function(){
                comeTime = 9 * 60;
                if(this.value > 14 || this.value <0){
                    alert("제대로 적으십쇼");
                    enterHour.val(9);
                }
                else{
                    comeTime = (parseInt(enterHour.val()) * 60) + parseInt(enterMinute.val());
                    calcTime();
                } 
                calcMinusTime();
            })
            enterMinute.on('input', function(){
                comeTime = 9 * 60;
                if(this.value > 60 || this.value <0){
                    alert("제대로 적으십쇼");
                    enterMinute.val(0);
                }
                else {
                    comeTime = parseInt(enterMinute.val()) + (parseInt(enterHour.val())*60); 
                    calcTime();
                }
                calcMinusTime();
            })
            workHours.on('change', calcMinusTime);
        });
        function calcMinusTime(){
            if(workHours.val() == "after"){
                minusTime = 4 * 60;
                if(parseInt(enterHour.val())*60 + parseInt(enterMinute.val()) <= 8 * 60){
                    minusTime = 4 * 60 + 60
                }   
            }
            else {
                minusTime = 0
            }
        }
        function thisTime () {
            day = new Date();
            
            if (day.getHours() < 12) {
                amPm = 'AM';
            } else {
                amPm = 'PM';
            };

            let curTime = 0;
            if (day.getHours() == 12) {
                curTime = day.getHours();
            } else {
                curTime = day.getHours() % 12;
            };
            seconds = day.getSeconds();
            minutes = day.getMinutes();
            hours = day.getHours();
            millis = day.getMilliseconds();            
            days = day.getDay();            
            krDays = week[days];

            startHour = enterHour.val();
            endHour = enterHour.val() * 60 * 60 * 1000 + workHour.val() * 60 * 60 * 1000;
            let millisTime = hours * 60 * 60 * 1000 + minutes * 60 * 1000 + seconds * 1000 + millis;
            let millisStartHour = startHour * 60 * 60 * 1000;

            if (days == 0 || days == 6) {
                // 주말의 경우
                endMsg('WEND');
            } else if ((millisTime - millisStartHour) <= 0 && startHour < millisStartHour) {
                endMsg('END');
            } else {
                $('#day-bar').show();
                $('#hidden-goods').hide();
            }

            let today = (day.getFullYear() + "/" + (day.getMonth() + 1) + "/" + day.getDate() + " " + krDays + "요일");
            let time = (amPm + ' ' + curTime + ":" + minutes + ":" + seconds);
            let h3Text = millis + '지루하면 보는 밀리초';

            $('#dayDiv > h1').text(today);
            $('#dayDiv > h2').text(time);
            $('#dayDiv > h3').text(h3Text);
            
            if (days == 4) {
                current = (100 / ((workHours.val() == 'all' ? 9 : 4) * 60 * 60 * 1000)) * (millisTime - millisStartHour + (30 * 60 * 1000));
            } else if (days == 5) {
                current = (100 / ((workHours.val() == 'all' ? 9 : 4) * 60 * 60 * 1000)) * (millisTime - millisStartHour);
                $('#dayDiv > h1').css({'color' : 'red', 'font-size' : '2.5rem'});
            } else {
                current = (100 / ((workHours.val() == 'all' ? 9 : 4) * 60 * 60 * 1000)) * (millisTime - millisStartHour);
            };

            // 시작시간 적용
            if (current <= 100 && (hours > startHour
            || (hours == startHour && minutes >= enterMinute.val()))) {
                let perc = Math.floor(current) + '%';
                $('#dBar').css('width', perc);
                $('#dBar').text(Math.floor(current * 10000) / 10000 + '%');
                if (current >= 60) {
                    $('#dBar').css('background-color', 'blueviolet');
                } else if (current >= 95) {
                    $('#dBar').css('background-color', 'red');
                } else {
                    $('#dBar').css('background-color', 'green');
                }
            };
        };

        setInterval(function() {
            thisTime();
            calcTime();           
        }, 1);

        function calcTime(){
            //점심 11:45분
            if(hours*60 + minutes<11* 60 + 45){
                let time = 11*60+45 - (hours*60 + minutes);
                $('#lunch').text(parseInt(time/60)+'시간'+(time%60)+'분 전')
            }
            else{
                $('#lunch').text('점심 끝')
            }
            if(hours<= 18){  
                    let time = 18 * 60-( (9 * 60) - parseInt(comeTime) ) - (hours*60 + minutes) - minusTime;
                    
                    if(days ==3) { time = time -30 }
                   
                    if(time< 60){
                        if (time % 60 < 0) {
                            $('#home').text('+' + ((time%60) * -1)+'분 야근중')
                            $('#home').css('color', 'red');
                        } else {
                            $('#home').text((time%60)+'분 전')
                            $('#home').css('color', 'red');
                        }
                    }
                    else{
                        $('#home').text(parseInt(time/60)+'시간'+(time%60)+'분 전')
                        $('#home').css('color', 'black');
                    }
            }
        }

        function endMsg(res) {
            $('#day-bar').hide();
            $('#hidden-goods').show();
            if (res == 'END') {
                if (amPm == 'AM') {
                    $('#hidden-goods').text('출근하자!!!');
                } else {
                    $('#hidden-goods').text('퇴근이닷!!!');
                }
            } else if (res = 'WEND') {
                $('#hidden-goods').text('주말이얏!!!');
            };
        };
    </script>

    <!-- 댓글 기능 -->
    <div id="disqus_thread"></div>
    <script>
        /**
        *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
        *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables    */
        /*
        var disqus_config = function () {
        this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
        this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
        };
        */
        (function() { // DON'T EDIT BELOW THIS LINE
        var d = document, s = d.createElement('script');
        s.src = 'https://gohomebar.disqus.com/embed.js';
        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
        })();
    </script>
    <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>