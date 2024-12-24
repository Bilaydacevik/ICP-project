import Map "mo:base/HashMap"; // mo.base kütüphanesinden HashMap modülünü import ediyoruz.
import Text "mo:base/Text";     // metinsel işlemler için Text tipini import ediyoruz.

actor {
  // Name tipi, kişilerin isimlerini temsil eden metinsel bir değer tipidir.
  type Name = Text;

  // Phone tipi, kişilerin telefon numaralarını temsil eden metinsel bir değer tipidir.
  type Phone = Text;

  // Entry tipi, telefon rehberinde her kişi için kullanılan veri yapısını temsil eder.
  type Entry = {
    desc: Text;    // Kişinin açıklaması (örneğin, kişinin soyadı gibi)
    phone: Phone;  // Kişinin telefon numarası
  };

  // Message tipi, gönderilen mesajın yapısını temsil eder.
  type Message = {
    receiver: Text; // Mesajın alıcısı
    mess: Text;     // Mesaj içeriği
  };

  // phoneBook, kişisel bilgilerin tutulduğu bir HashMap olarak tanımlanıyor.
  let phoneBook = Map.HashMap<Name, Entry>(0, Text.equal, Text.hash); 
  // HashMap'in anahtar tipi Name, değer tipi Entry'dir. Eşitlik kontrolü ve hash işlemi Text tipi için yapılandırılıyor.

  // MessageHistory, gönderilen mesajların tutulduğu bir HashMap olarak tanımlanıyor.
  let MessageHistory = Map.HashMap<Phone, Message>(0, Text.equal, Text.hash); 
  // HashMap'in anahtar tipi Phone, değer tipi Message'dır. Eşitlik kontrolü ve hash işlemi Text tipi için yapılandırılıyor.

  // Telefon rehberine yeni bir giriş ekler. asenkron bir işlevdir.
  public func insert(name: Name, entry: Entry): async() {
    phoneBook.put(name, entry);  // Telefon rehberine (phoneBook) yeni bir giriş ekler.
  };

  // Belirli bir telefon numarasına mesaj gönderir. asenkron bir işlevdir.
  public func sendMessage(senderPhone: Phone, message: Message): async() {
    MessageHistory.put(senderPhone, message);  // Mesaj geçmişine (MessageHistory) yeni bir mesaj ekler.
  };

  // Belirli bir isme ait telefon bilgilerini alır. Eğer bilgi yoksa null dönebilir.
  public func getPhone(name: Name): async ?Entry {
    return phoneBook.get(name);  // phoneBook'tan isme ait girişleri alır, eğer bulunamazsa null dönebilir.
  };

  // Belirli bir telefon numarasına ait mesajları alır. Eğer mesaj yoksa null dönebilir.
  public func getMessage(senderPhone: Phone): async ?Message {
    return MessageHistory.get(senderPhone);  // MessageHistory'den telefon numarasına ait mesajları alır, eğer yoksa null dönebilir.
  };
}
