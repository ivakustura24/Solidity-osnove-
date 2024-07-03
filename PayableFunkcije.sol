pragma solidity >=0.6.0 < 0.9.0;

contract Prodavac{
    event primljenoPlacanje(address sender, uint256 amount);
    receive() external payable{
        emit primljenoPlacanje(msg.sender, msg.value);
    }
    function dohvatiStanje() public view returns(uint){
        return address(this).balance;
    }
}
contract Kupac{
    uint public ukupnaCijenaNarudzbi;
    struct racun{
       address adresaKupca;
       string proizvod;
       uint cijena; 
    }
    racun[] public narudzbe;
    

    function ukupnoPotroseno() public view returns(uint) {
        return ukupnaCijenaNarudzbi;
    }

    function brojNarudzbi() public view returns(uint) {
        return narudzbe.length;
    }
    function platiRacun(address payable prodavac, string memory proizvod) public payable{
        narudzbe.push(racun(msg.sender, proizvod, msg.value));
        ukupnaCijenaNarudzbi += msg.value;
        prodavac.transfer(msg.value);
    }
     function dohvatiProizvod(uint index) public view returns ( string memory){
        racun memory dohvaceniRacun = narudzbe[index];
        return  (dohvaceniRacun.proizvod);
    }

}