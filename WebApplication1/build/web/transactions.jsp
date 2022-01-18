<%-- 
    Document   : transactions
    Created on : Jan 4, 2022, 4:19:10 PM
    Author     : hp
--%>

<%@page import="java.util.Objects"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>PHRS Panel</title>
        <!-- plugins:css -->
        <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
        <!-- endinject -->
        <!-- Plugin css for this page -->
        <link rel="stylesheet" href="assets/vendors/select2/select2.min.css">
        <link rel="stylesheet" href="assets/vendors/select2-bootstrap-theme/select2-bootstrap.min.css">

        <link rel="stylesheet" href="assets/css/style.css">
        <!-- End layout styles -->
        <link rel="shortcut icon" href="assets/images/favicon.png" />
    </head>
    <body>
        <jsp:useBean id="KullaniciBilgileri" scope="session" class="veri.DBKatmani" />
        <%! String username; %>
        <%
            HttpSession oturum = request.getSession();
            String kullaniciAdi = (String) oturum.getAttribute("KullaniciAdi");
            username = kullaniciAdi;

            String deletePet = (String) request.getParameter("choosedeletepet");
            String deleteRes = (String) request.getParameter("choosedeleteres");

            if (!Objects.equals(deletePet, "Choose Pet Name")) {
                if (deletePet != null) {
                    out.println(deletePet);
                     out.println(username);
                    KullaniciBilgileri.hayvanSil(username, deletePet);
                }
            }
            if (!Objects.equals(deleteRes, "Choose Reservation Date")) {
                if (deleteRes != null) {
                    String Day[] = deleteRes.split(" ");
                    int day = Integer.parseInt(Day[0]);
                    out.println(day);
                    KullaniciBilgileri.rezervasyonSil(day);
                }

            } else {

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

                <!-- partial -->
                <div class="main-panel" style="padding-top:0px;">
                    <div class="content-wrapper">
                        <div class="page-header">
                            <h3 class="page-title"> Transaction Form  </h3>

                        </div>
                        <div class="row">

                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title">Delete Options</h4>
                                        <p class="card-description"> Please choose the form carefully so that we can offer you the best service. </p>
                                        <form class="forms-sample" action="transactions.jsp">

                                            <div class="form-group">
                                                <label for="exampleSelectGender">Choose Pet Name You Want To Delete</label>
                                                <select class="form-control" name="choosedeletepet" id="exampleSelectGender">
                                                    <option>Choose Pet Name</option>
                                                    <%! int i;
                                                        int dataSize;
                                                    %>

                                                    <%
                                                        String Arr[] = KullaniciBilgileri.veriBilgileri(2, username, "pet").split(" ");
                                                        dataSize = Arr.length;
                                                        for (int i = 0; i < dataSize; i++) {

                                                    %>
                                                    <option><%= Arr[i]%></option>
                                                    <% }%>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleSelectGender">Choose Reservation Date You Want To Delete</label>
                                                <select class="form-control" name="choosedeleteres" id="exampleSelectGender">
                                                    <option>Choose Reservation Date</option>
                                                    <%! int i2;
                                                        int dataSize2;
                                                                                                                                                                                                                                                                                                                                                 %>

                                                    <%
                                                        String Res[] = KullaniciBilgileri.kullaniciRezervasyonTarihleri(username).split(",");
                                                        dataSize2 = Res.length;
                                                        for (int i2 = 0; i2 < dataSize2; i2++) {

                                                    %>
                                                    <option><%= Res[i2]%></option>
                                                    <% }%>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-primary mr-2">Delete</button>
                                        </form>


                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- content-wrapper ends -->
                    <!-- partial:partials/_footer.html -->
                    <footer class="footer">
                        <div class="d-sm-flex justify-content-center justify-content-sm-between">
                            <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © bootstrapdash.com 2020</span>
                            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"> Free <a href="https://www.bootstrapdash.com/bootstrap-admin-template/" target="_blank">Bootstrap admin templates</a> from Bootstrapdash.com</span>
                        </div>
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
        <script src="assets/vendors/select2/select2.min.js"></script>
        <script src="assets/vendors/typeahead.js/typeahead.bundle.min.js"></script>
        <!-- End plugin js for this page -->
        <!-- inject:js -->
        <script src="assets/js/off-canvas.js"></script>
        <script src="assets/js/hoverable-collapse.js"></script>
        <script src="assets/js/misc.js"></script>
        <script src="assets/js/settings.js"></script>
        <script src="assets/js/todolist.js"></script>
        <!-- endinject -->
        <!-- Custom js for this page -->
        <script src="assets/js/file-upload.js"></script>
        <script src="assets/js/typeahead.js"></script>
        <script src="assets/js/select2.js"></script>
        <!-- End custom js for this page -->
    </body>
</html>
