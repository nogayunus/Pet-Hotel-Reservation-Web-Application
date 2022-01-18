package veri;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

public class DBKatmani {
    
    private Connection connection;
    String DBurl = "jdbc:derby://localhost:1527/PetHotel";
    
    public Connection baglan() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
            connection = DriverManager.getConnection(DBurl, "pethoteladmin", "pethoteladmin");
            System.out.println("Veritabanı Bağlantısı Kuruldu.");
        } catch (Exception e) {
            System.out.println("Bağlantı Gerçekleştirilemedi.");
        }
        return connection;
    }
    
    public void musteriListesi() {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from CUSTOMER");
            while (query.next()) {
                System.out.println(query.getString(1));
                
            }
        } catch (Exception e) {
        }
        
    }
    
    public boolean kullaniciAdiKontrol(String kullaniciAdi) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String kAdi = " ";
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select username from CUSTOMER where USERNAME='" + kullaniciAdi + "'");
            while (query.next()) {
                kAdi = query.getString(1);
            }
            return kAdi.equals(kullaniciAdi);
        } catch (Exception e) {
        }
        return false;
    }
    
    public boolean sifreKontrol(String kullaniciAdi, String sifre) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String password = " ";
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select password from CUSTOMER where username='" + kullaniciAdi + "'");
            while (query.next()) {
                password = query.getString(1);
            }
            return password.equals(sifre);
        } catch (Exception e) {
        }
        return false;
    }
    
    public boolean hayvanKontrol(String kullaniciAdi) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String kAdi = " ";
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from pet where owner='" + kullaniciAdi + "'");
            while (query.next()) {
                kAdi = query.getString(1);
            }
            if (kAdi != " ") {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }
    
    public void musteriEkle(String kullaniciAdi, String isimSoyisim, String sifre, String telefonNumarasi, String adres, String email) {
        baglan();
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("insert into customer values ('" + kullaniciAdi + "','" + isimSoyisim + "','" + telefonNumarasi + "','" + adres + "','" + email + "','" + sifre + "')");
            
        } catch (Exception e) {
        }
        
    }
    
    public String kullaniciAdSoyadBul(String kullaniciAdi) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String kAdi = " ";
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select NAMESURNAME from CUSTOMER where USERNAME='" + kullaniciAdi + "'");
            while (query.next()) {
                kAdi = (query.getString(1));
            }
            
            return kAdi;
        } catch (Exception e) {
        }
        return null;
    }
    
    public void evcilhayvanEkle(String hayvanadi, String hayvanturu, String yasi, String hayvancinsiyeti, String kullaniciAdi) {
        baglan();
        int i = 1;
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from PET");
            while (query.next()) {
                System.out.println(query.getString(1));
                i++;
            }
        } catch (Exception e) {
        }
        int hayvanyasi = Integer.parseInt(yasi);
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("insert into pet values (" + i + ",'" + hayvanadi + "','" + hayvanturu + "'," + hayvanyasi + ",'" + hayvancinsiyeti + "','" + kullaniciAdi + "')");
            
        } catch (Exception e) {
        }
    }
    
    public void reservasyonEkle(String hayvanAdi, String kullaniciAdi, String date) {
        baglan();
        int i = 1;
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from reservation");
            while (query.next()) {
                System.out.println(query.getString(1));
                i++;
            }
        } catch (Exception e) {
        }
        String s = "";
        int petid;
        String Date[] = date.split(" ");
        int bday = Integer.parseInt(Date[0]);
        try {
            Statement statement = connection.createStatement();
            ResultSet query2 = statement.executeQuery("select petid from pet where petname='" + hayvanAdi + "' and owner='" + kullaniciAdi + "'");
            while (query2.next()) {
                s = query2.getString(1);
                
            }
            
            petid = Integer.parseInt(s);
            System.out.println("insert into reservation values (" + i + ",'" + kullaniciAdi + "'," + petid + "," + bday + ")");
            System.out.println("update bdate set status=false where bday=" + bday);
            statement.executeUpdate("insert into reservation values (" + i + ",'" + kullaniciAdi + "'," + petid + "," + bday + ")");
            statement.executeUpdate("update bdate set status=false where bday=" + bday);
            
        } catch (Exception e) {
        }
    }
    
    public String veriBilgileri(int columnNumber, String kullaniciAdi, String tableName) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String s = "";
        
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from " + tableName + " where owner='" + kullaniciAdi + "'");
            ResultSetMetaData rsmd = query.getMetaData();
            while (query.next()) {
                s = s + query.getString(columnNumber) + " ";
            }
            return s;
        } catch (Exception e) {
        }
        return "";
        
    }
    
    public String rezervasyonHayvanIsımleri(int columnNumber) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String s = "";
        
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select petname from pet p inner join reservation r on p.petid=r.petid");
            ResultSetMetaData rsmd = query.getMetaData();
            while (query.next()) {
                s = s + query.getString(columnNumber) + " ";
            }
            return s;
        } catch (Exception e) {
        }
        return "";
        
    }
    
    public String rezervasyonTarihleri() {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String s = "";
        
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from bdate b inner join reservation r on r.bday=b.bday");
            ResultSetMetaData rsmd = query.getMetaData();
            while (query.next()) {
                s = s + query.getString(1) + " " + query.getString(2) + " " + query.getString(3) + ",";
            }
            return s;
        } catch (Exception e) {
        }
        return "";
        
    }
    
    public void hayvanSil(String kullaniciAdi, String hayvanIsmi) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String s = "";
        
        try {
            Statement statement = connection.createStatement();
            ResultSet petid = statement.executeQuery("select petid from pet where owner='" + kullaniciAdi + "' and petname='" + hayvanIsmi + "'");
            while (petid.next()) {
                s = petid.getString(1);
            }            
            int petID = Integer.parseInt(s);
            
            statement.executeUpdate("delete from reservation r where r.petid=" + petID);
            statement.executeUpdate("delete from pet p where p.petid=" + petID);
            
        } catch (Exception e) {
        }
    }
    
    public void rezervasyonSil(int tarih) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String s = "";
        
        try {
            Statement statement = connection.createStatement();
            
            statement.executeUpdate("delete from reservation r where r.bday=" + tarih);
            statement.executeUpdate("update bdate set status=true where bday=" + tarih);
        } catch (Exception e) {
        }
        
    }
    
    public String kullaniciRezervasyonTarihleri(String kullaniciAdi) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String s = "";
        
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from bdate b inner join reservation r on r.bday=b.bday and r.username='" + kullaniciAdi + "'");
            ResultSetMetaData rsmd = query.getMetaData();
            while (query.next()) {
                s = s + query.getString(1) + " " + query.getString(2) + " " + query.getString(3) + ",";
            }
            return s;
        } catch (Exception e) {
        }
        return "";
        
    }
    
    public String veriBilgileriRezervasyon(int columnNumber, String kullaniciAdi, String tableName) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String s = "";
        
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from " + tableName + " where username='" + kullaniciAdi + "'");
            ResultSetMetaData rsmd = query.getMetaData();
            while (query.next()) {
                s = s + query.getString(columnNumber) + " ";
            }
            return s;
        } catch (Exception e) {
        }
        return "";
        
    }
    
    public String queryOlustur(int columnNumber, String queryOlustur) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String s = "";
        
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery(queryOlustur);
            ResultSetMetaData rsmd = query.getMetaData();
            while (query.next()) {
                s = s + query.getString(columnNumber) + ",";
            }
            return s;
        } catch (Exception e) {
        }
        return "";
    }
    
    public String rezervasyonListesi() {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        String s = "";
        
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from bdate where status=true");
            
            while (query.next()) {
                s = s + query.getString(1) + " " + query.getString(2) + " " + query.getString(3) + ",";
            }
            return s;
        } catch (Exception e) {
        }
        return "";
    }
    
    public int getColumnSize(String tableName) {
        if (connection == null) {
            System.out.println("Bağlantı Kurulamadı. Tekrar deneniyor.");
            baglan();
        }
        int columnCount = -1;
        try {
            Statement statement = connection.createStatement();
            ResultSet query = statement.executeQuery("select * from " + tableName);
            ResultSetMetaData rsmd = query.getMetaData();
            columnCount = rsmd.getColumnCount();
            return columnCount;
        } catch (Exception e) {
        }
        return columnCount;
    }
    
    public static void main(String args[]) {
        DBKatmani DB = new DBKatmani();
        DB.baglan();
        DB.hayvanSil("mirar", "Duman");
        System.out.println(DB.queryOlustur(2, "select * from pettype pt inner join pet p on p.pettype=pt.pettype and p.owner='mirar'"));
        DB.musteriListesi();
        
    }
}
