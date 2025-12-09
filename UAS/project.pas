program StudentFinance;
uses crt;

const
  MAX_TRANSAKSI = 100;  // batas maksimal transaksi

type
  TransaksiRecord = record
    Tipe        : String[10]; // jenis transaksi
    Deskripsi   : String[50]; // keterangan transaksi
    Jumlah      : Real;       // nominal uang
  end;

var
  DataTransaksi : array[1..MAX_TRANSAKSI] of TransaksiRecord;   // data transaksi
  JumlahTransaksi: Integer;   // jumlah transaksi
  TotalSaldo     : Real;    // saldo saat ini

procedure TampilkanMenu;  // menampilkan menu utama program
begin
  ClrScr;
  Writeln('==========================================');
  Writeln('  STUDENT FINANCE: Manajemen Keuangan Harian');
  Writeln('==========================================');
  Writeln('  Saldo Saat Ini: Rp ', TotalSaldo:0:2);
  Writeln('------------------------------------------');

  Writeln('1. Tambah Transaksi (Pemasukan/Pengeluaran)');
  Writeln('2. Tampilkan Ringkasan Keuangan');
  Writeln('3. Keluar Program');
  Writeln('------------------------------------------');
  Write('Pilih Menu (1-3): ');
end;

procedure TambahTransaksi; // menambahkan transaksi pemasukan atau pengeluaran
var
  PilihanTipe: Char;
  DeskripsiBaru: String[50];
  JumlahBaru: Real;
begin
  ClrScr;
  if JumlahTransaksi >= MAX_TRANSAKSI then
  begin
    Writeln('ERROR: Batas maksimum transaksi (', MAX_TRANSAKSI, ') telah tercapai.');
    Readln;
    Exit; 
  end;

  Writeln('--- Tambah Transaksi ---');
  Write('Tipe (P/p = Pemasukan, K/k = Pengeluaran): ');
  Readln(PilihanTipe);
  
  if UpCase(PilihanTipe) = 'P' then
    DataTransaksi[JumlahTransaksi + 1].Tipe := 'Pemasukan'
  else if UpCase(PilihanTipe) = 'K' then
    DataTransaksi[JumlahTransaksi + 1].Tipe := 'Pengeluaran'
  else
  begin
    Writeln('Pilihan tidak valid. Kembali ke menu utama.');
    Readln;
    Exit;
  end;
  
  Write('Deskripsi Transaksi: ');
  Readln(DeskripsiBaru);
  DataTransaksi[JumlahTransaksi + 1].Deskripsi := DeskripsiBaru;
  
  Write('Jumlah (Rp): ');
  Readln(JumlahBaru);
  
  if JumlahBaru <= 0 then
  begin
    Writeln('Jumlah harus lebih dari nol. Kembali ke menu utama.');
    Readln;
    Exit;
  end;
  
  DataTransaksi[JumlahTransaksi + 1].Jumlah := Abs(JumlahBaru);
  JumlahTransaksi := JumlahTransaksi + 1;
  if DataTransaksi[JumlahTransaksi].Tipe = 'Pemasukan' then
    TotalSaldo := TotalSaldo + DataTransaksi[JumlahTransaksi].Jumlah
  else
    TotalSaldo := TotalSaldo - DataTransaksi[JumlahTransaksi].Jumlah;
  if TotalSaldo < 0 then
  begin
    Writeln('*** PERINGATAN! Saldo Anda menjadi negatif! ***');
    Writeln('Pastikan Anda memantau pengeluaran Anda dengan baik.');
  end;
  
  Writeln('Transaksi berhasil ditambahkan.');
  Readln;
end;

procedure TampilkanRingkasan; // menampilkan ringkasan keuangan dan saldo
var
  i: Integer;
  TotalMasuk, TotalKeluar: Real;
begin
  ClrScr;
  Writeln('==========================================');
  Writeln('          RINGKASAN KEUANGAN');
  Writeln('==========================================');
  TotalMasuk := 0;
  TotalKeluar := 0;
  if JumlahTransaksi = 0 then
  begin
    Writeln('Belum ada data transaksi yang tercatat.');
  end
  else
  begin
    Writeln('No. | Tipe        | Jumlah (Rp)    | Deskripsi');
    Writeln('----------------------------------------------------');
    for i := 1 to JumlahTransaksi do
    begin
      if DataTransaksi[i].Tipe = 'Pemasukan' then
        TotalMasuk := TotalMasuk + DataTransaksi[i].Jumlah
      else
        TotalKeluar := TotalKeluar + DataTransaksi[i].Jumlah;
      
      Write(i:3, '. | ');
      Write(DataTransaksi[i].Tipe:10, ' | ');
      Write(DataTransaksi[i].Jumlah:10:2, '     | ');
      Writeln(DataTransaksi[i].Deskripsi);
    end;
    Writeln('----------------------------------------------------');
  end;
  Writeln('TOTAL PEMASUKAN : Rp ', TotalMasuk:0:2);
  Writeln('TOTAL PENGELUARAN : Rp ', TotalKeluar:0:2);
  Writeln('SALDO AKHIR     : Rp ', TotalSaldo:0:2);
  Writeln('==========================================');
  Writeln('Tekan ENTER untuk kembali ke menu utama...');
  Readln;
end;

procedure ProsesPilihan(Pilihan: Integer; var Lanjut: Boolean); // memproses pilihan menu pengguna
begin
  case Pilihan of
    1: TambahTransaksi;      
    2: TampilkanRingkasan;   
    3: begin
      Writeln('Terima kasih telah menggunakan Student Finance. Sampai jumpa!');
      Lanjut := False; 
    end;
    else
      begin
        Writeln('Pilihan tidak valid. Silakan coba lagi.');
        Readln;
      end;
  end;
end;

var
  PilihanMenu: Integer;
  Jalan: Boolean;
  
begin
  JumlahTransaksi := 0; // inisialisasi data awal
  TotalSaldo := 0.0;
  Jalan := True;
  while Jalan do
  begin
    TampilkanMenu; 
    Readln(PilihanMenu); 
    ProsesPilihan(PilihanMenu, Jalan);
  end;
  Readln; 
end.