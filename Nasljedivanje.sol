pragma solidity >= 0.7.0 < 0.9.0;

contract Vozilo {
    address public vlasnik;
    string public proizvodac;
    string public model;
    uint256 public godina;
    bool public pokrenut;

    event PrijenosVlasnistva(address indexed prethodniVlasnik, address indexed noviVlasnik);
    event Pokrenut();
    event Zaustavljen();

    constructor(address _vlasnik, string memory _proizvodac, string memory _model, uint256 _godina) {
        vlasnik = _vlasnik;
        proizvodac = _proizvodac;
        model = _model;
        godina = _godina;
        pokrenut = false;
    }

    function prenesiVlasnistvo(address noviVlasnik) public {
        require(msg.sender == vlasnik, "Samo vlasnik moze prenijeti vlasnistvo");
        emit PrijenosVlasnistva(vlasnik, noviVlasnik);
        vlasnik = noviVlasnik;
    }

    function pokreni() public {
        require(msg.sender == vlasnik, "Samo vlasnik moze pokrenuti vozilo");
        pokrenut = true;
        emit Pokrenut();
    }

    function zaustavi() public {
        require(msg.sender == vlasnik, "Samo vlasnik moze zaustaviti vozilo");
        pokrenut = false;
        emit Zaustavljen();
    }
}

contract Automobil is Vozilo {
    uint256 public brojVrata;

    constructor(address _vlasnik, string memory _proizvodac, string memory _model, uint256 _godina, uint256 _brojVrata)
        Vozilo(_vlasnik, _proizvodac, _model, _godina)
    {
        brojVrata = _brojVrata;
    }

    function otvoriGepek() public view returns (string memory) {
        require(msg.sender == vlasnik, "Samo vlasnik moze otvoriti gepek");
        return "Gepek je otvoren";
    }
}

contract Motor is Vozilo {
    bool public imaKacigu;

    constructor(address _vlasnik, string memory _proizvodac, string memory _model, uint256 _godina, bool _imaKacigu)
        Vozilo(_vlasnik, _proizvodac, _model, _godina)
    {
        imaKacigu = _imaKacigu;
    }

    function provjeriKacigu() public view returns (string memory) {
        require(msg.sender == vlasnik, "Samo vlasnik moze provjeriti kacigu");
        if (imaKacigu) {
            return "Vozac ima kacigu";
        } else {
            return "Vozac nema kacigu";
        }
    }
}

contract Bicikl is Vozilo {
    bool public imaKorpu;

    constructor(address _vlasnik, string memory _proizvodac, string memory _model, uint256 _godina, bool _imaKorpu)
        Vozilo(_vlasnik, _proizvodac, _model, _godina)
    {
        imaKorpu = _imaKorpu;
    }

    function provjeriKorpu() public view returns (string memory) {
        require(msg.sender == vlasnik, "Samo vlasnik moze provjeriti korpu");
        if (imaKorpu) {
            return "Bicikl ima korpu";
        } else {
            return "Bicikl nema korpu";
        }
    }
}
