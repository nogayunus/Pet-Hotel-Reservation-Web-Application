<%-- 
    Document   : gonder
    Created on : Dec 30, 2021, 10:56:13 PM
    Author     : hp
--%>





<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>PHRS Panel</title>
        <!-- plugins:css -->
        <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">

        <link rel="stylesheet" href="assets/css/style.css">

        <link rel="shortcut icon" href="assets/images/favicon.png" />

    </head>
    <body>
        <jsp:useBean id="KullaniciBilgileri" scope="session" class="veri.DBKatmani" />
        <%! String username; String roomtype; %>
        <%

            HttpSession oturum = request.getSession();
            String kullaniciAdi = (String) oturum.getAttribute("KullaniciAdi");
            username = kullaniciAdi;
            String petname = null;
            String reservationDay = null;
            
            petname = (String) request.getParameter("petname");
            reservationDay = (String) request.getParameter("choosedate");
            if (petname != (null)) {
                //add pet informations
                String pettype = (String) request.getParameter("pettype");
                String petage = (String) request.getParameter("petage");
                String petgender = (String) request.getParameter("petgender");
                KullaniciBilgileri.evcilhayvanEkle(petname, pettype, petage, petgender, kullaniciAdi);
            }
            if (reservationDay != null) {
                //add reservation informations
                String choosepetname = (String) request.getParameter("choosepetname");
                roomtype = (String) request.getParameter("chooseroomtype");
                KullaniciBilgileri.reservasyonEkle(choosepetname, kullaniciAdi, reservationDay);
             
            }
            

        %>
        <div class="container-scroller">

            <nav class="sidebar sidebar-offcanvas" id="sidebar">
                <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
                    <a class="sidebar-brand brand-logo" href="index.html"><img src="assets/images/phrs.png" alt="logo" /></a>
                    <a class="sidebar-brand brand-logo-mini" href="index.html"><img src="assets/images/logo-mini.svg" alt="logo" /></a>
                </div>
                <ul class="nav">
                    <li class="nav-item profile">
                        <div class="profile-desc">
                            <div class="profile-pic">
                                <div class="count-indicator">
                                    <img class="img-xs rounded-circle " src="assets/images/faces/face15.jpg" alt="">
                                    <span class="count bg-success"></span>
                                </div>
                                <div class="profile-name">
                                        <h5 class="mb-0 font-weight-normal"><% String s = (String) oturum.getAttribute("KullaniciAdi");
                                        out.print(KullaniciBilgileri.kullaniciAdSoyadBul(s));%></h5>

                                </div>
                            </div>
                            <a href="#" id="profile-dropdown" data-toggle="dropdown"><i class="mdi mdi-dots-vertical"></i></a>
                            <div class="dropdown-menu dropdown-menu-right sidebar-dropdown preview-list" aria-labelledby="profile-dropdown">
                                <a href="#" class="dropdown-item preview-item">
                                    <div class="preview-thumbnail">
                                        <div class="preview-icon bg-dark rounded-circle">
                                            <i class="mdi mdi-settings text-primary"></i>
                                        </div>
                                    </div>
                                    <div class="preview-item-content">
                                        <p class="preview-subject ellipsis mb-1 text-small">Settings</p>
                                    </div>
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="#" class="dropdown-item preview-item">
                                    <div class="preview-thumbnail">
                                        <div class="preview-icon bg-dark rounded-circle">
                                            <i class="mdi mdi-onepassword  text-info"></i>
                                        </div>
                                    </div>
                                    <div class="preview-item-content">
                                        <p class="preview-subject ellipsis mb-1 text-small">Change Password</p>
                                    </div>
                                </a>

                            </div>
                        </div>
                    </li>
                    <li class="nav-item nav-category">
                        <span class="nav-link">Member</span>
                    </li>
                    <li class="nav-item menu-items">
                        <a class="nav-link" href="home.jsp">
                            <span class="menu-icon">
                                <i class="mdi mdi-home "></i>
                            </span>
                            <span class="menu-title">Home</span>
                        </a>
                    </li>
                    <%
                        if (KullaniciBilgileri.hayvanKontrol(username)) {
                    %>
                    <li class="nav-item menu-items">
                        <a class="nav-link" href="reservation.jsp">
                            <span class="menu-icon">
                                <i class="mdi mdi-calendar-plus "></i>
                            </span>
                            <span class="menu-title">Make A Reservation</span>
                        </a>
                    </li>
                    <% } %>
                    <li class="nav-item menu-items">
                        <a class="nav-link" href="addapet.jsp">
                            <span class="menu-icon">
                                <i class="mdi mdi-hospital "></i>
                            </span>
                            <span class="menu-title">Add A Pet</span>
                        </a>
                    </li>

                   <%
                        if (KullaniciBilgileri.hayvanKontrol(username)) {
                    %>
                    <li class="nav-item menu-items">
                        <a class="nav-link" href="transactions.jsp">
                            <span class="menu-icon">
                                <i class="mdi mdi-home "></i>
                            </span>
                            <span class="menu-title">Transactions</span>
                        </a>
                    </li>
                    <% }%>
                    
                </ul>
            </nav>
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial:partials/_navbar.html -->
                <nav class="navbar p-0 fixed-top d-flex flex-row">
                    <div class="navbar-brand-wrapper d-flex d-lg-none align-items-center justify-content-center">
                        <a class="navbar-brand brand-logo-mini" href="index.html"><img src="assets/images/logo-mini.svg" alt="logo" /></a>
                    </div>
                </nav>
                <!-- partial -->
                <div class="main-panel" style="padding-top:0px;">
                    <div class="content-wrapper">
                        <%
                            if (!KullaniciBilgileri.hayvanKontrol(username)) {
                        %>
                        <div class="row">
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card corona-gradient-card">
                                    <div class="card-body py-0 px-0 px-sm-3">
                                        <div class="row align-items-center">
                                            <div class="col-4 col-sm-3 col-xl-2">
                                                <img src="assets/images/dashboard/Group126@2x.png" class="gradient-corona-img img-fluid" alt="">
                                            </div>
                                            <div class="col-5 col-sm-7 col-xl-8 p-0">
                                                <h4 class="mb-1 mb-sm-0">Do you want to make a reservation?</h4>
                                                <p class="mb-0 font-weight-normal d-none d-sm-block">To make a reservation, you must first register your pet.</p>
                                            </div>
                                            <div class="col-3 col-sm-2 col-xl-2 pl-0 text-center">
                                                <span>
                                                    <a href="http://localhost:8080/WebApplication1/addapet.jsp" class="btn btn-outline-light btn-rounded get-started-btn">Add A Pet</a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>  

                        <div class="page-header">
                            <h3 class="page-title"> Reservation & Pet Lists</h3>

                        </div>
                        <div class="row">
                            <div class="col-lg-6 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title">Reservation List</h4>
                                        <div class="table-responsive">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Reservation ID</th>
                                                        <th>Pet Name</th>
                                                        <th>Date</th>
                                                        <th>Room Type</th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                    <%! int m;
                                                        int size;
                                                                                                                                                                                                        %>

                                                    <%
                                                        String resID[] = KullaniciBilgileri.veriBilgileriRezervasyon(1, username, "reservation").split(" ");
                                                        if(resID[0] != ("")){
                                                        String PetName[] = KullaniciBilgileri.rezervasyonHayvanIsımleri(1).split(" ");
                                                        String ResDate[] = KullaniciBilgileri.rezervasyonTarihleri().split(",");
                                                        String RoomType[] = KullaniciBilgileri.queryOlustur(1, "select rt.roomtype from roomtype rt inner join pettype pt on rt.roomtype=pt.roomtype inner join pet p on p.pettype=pt.pettype inner join reservation r on  r.petid=p.petid").split(",");
                                                        size = resID.length;
                                                        for (int m = 0; m < size; m++) {

                                                    %>

                                                    <tr>
                                                        <td><%= resID[m]%></td>
                                                        <td><%= PetName[m]%></td>
                                                        <td><%= ResDate[m]%></td>
                                                        <td><%= RoomType[m]%></td>
                                                    </tr>
                                                    <% } }%>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title">Pet List</h4>

                                        <div class="table-responsive">
                                            <table class="table table-hover" >
                                                <thead>
                                                    <tr>
                                                        <th>Pet ID</th>
                                                        <th>Pet Name</th>
                                                        <th>Type</th>
                                                        <th>Age</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%! int i;
                                                        int dataSize;
                                                                                                                                                                                                        %>

                                                    <%
                                                        String petID[] = KullaniciBilgileri.veriBilgileri(1, username, "pet").split(" ");
                                                        String petName[] = KullaniciBilgileri.veriBilgileri(2, username, "pet").split(" ");
                                                        String petType[] = KullaniciBilgileri.veriBilgileri(3, username, "pet").split(" ");
                                                        String petAge[] = KullaniciBilgileri.veriBilgileri(4, username, "pet").split(" ");
                                                        dataSize = petName.length;
                                                        for (int i = 0; i < dataSize; i++) {

                                                    %>

                                                    <tr>
                                                        <td><%= petID[i]%></td>
                                                        <td><%= petName[i]%></td>
                                                        <td><%= petType[i]%></td>
                                                        <td><%= petAge[i]%></td>
                                                    </tr>
                                                    <% }%>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- content-wrapper ends -->
                    <!-- partial:partials/_footer.html -->
                    <footer class="footer">

                    </footer>
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <!-- container-scroller -->
        <!-- plugins:js -->
        <script src="assets/vendors/js/vendor.bundle.base.js"></script>
        <!-- endinject -->
        <!-- Plugin js for this page -->
        <!-- End plugin js for this page -->
        <!-- inject:js -->
        <script src="assets/js/off-canvas.js"></script>
        <script src="assets/js/hoverable-collapse.js"></script>
        <script src="assets/js/misc.js"></script>
        <script src="assets/js/settings.js"></script>
        <script src="assets/js/todolist.js"></script>
        <!-- endinject -->
        <!-- Custom js for this page -->
        <!-- End custom js for this page -->
    </body>
</html>
