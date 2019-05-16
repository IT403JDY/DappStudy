# DappStudy
블록체인 = 블록들이 연결된 체인 암호학과 결합하여 좋아진다.
블록 = 데이터의 집합

블록체인 네트워크 = 모든 사용자가 같은 블록체인정보를 갖고 있다., 가능한 많은 사람이 알아야 보안이 늘어난다.

머클트리 = 해시가 이용된 트리 구조
라이트노드 = 모든 데이터가 아닌 머클루트만 갖고 있는 노드
거래검증 = 머클트리가 머클경로를 알려주면 해당 경로룰 통해 검증이 가능하다.

-블록채인의 활용-
블록체인은 가치전달이 가능하다.
A->B에서 송금한 정보에 대한 변경이 불가능 하기때문에 그것만으로는 가치가있다.
이더리움서 부터는 단지 금전적인 가치 이상의 데이터의 가치를 갖게 된다.

-이더리움과 스마트컨트랙트-
이더리움위에 스마트 컨트랙트가 존재할 수 있다.
스마트 컨트랙트는 간단히 블록체인 위에 존재하는 계약서이다.
Decentralized Application(Dapp) : 이더리움 기반의 스마트컨트랙트가 담긴 앱

-블록체인과 이더리움의 문제-
1.프라이버시 : 블록체인은 항상기록, 오픈 장부
2.트랜잭션 코스트 : 이더리움 트랜잭션을 실행할때 수도료로 가스를 재공해야된다. 
3.트랜잭션 스피드 : 중앙화 처리에 비해 느리다. 1초에 20개처리가능. 10정도의 컴펌이 필요로 하기때문에 바로 적용된다고 할 수 없다. 3분걸림
4.블록 사이즈 : 모든 채굴자가 모든 블록을 가져야하고 매달 2G의 블록이 생성된다. 

-솔리디티-
EVM을 타겟으로 만들어짐
EVM - 이더리움의 네트워크를 이루는 가상의 머신
상속 라이브러리등 ...지원
한번 메인넷에 올리면 변경 힘듬 공개됨

튜링완전 = 방법문과 제어문 사용가능
msg.sender : 메시지 보낸 주소
msg.value : 메시지 값

-스마트 컨트랙트 구조-
스마트컨트랙트는 클래스와 비슷하다. 상태변수 함수, 함수 변경자, 이벤트 열거형, 상속, 다형성 등이 포함될 수 있다.

-솔리디티 데이터 타입-
string public myString = "wow"; => utf8로 인코딩된다.
bytes12 public myRawString = "wowowow"; => 안된다.
--------------------------------------------
mapping(address => string) myMapp;
키와 value의 쌍으로 이루어진 형태 즉, 딕셔너리랑 비슷
---------------------------------------------
동적 배열과 정적 배열 모두 사용가능
인터페이스를 사용해서 추상계층 사용가능

// 1. 컨트랙트 선언
contract Sample {
    // 2. 상태 변수 선언
    uint256 data;
    address owner;
    
    // 3. 이벤트 정의
    event logData(uint256 dataToLog);
    
    // 4. 함수 변경자 정의
    modifier onlyOwner() {
        if(msg.sender != owner) revert();
        _;
    }
    
    // 5. 생성자
    function Sample(uint256 initData, address initOwner) {
        data = initData;
        onwer = initOwner;
    }
    
    // 6. 함수(메소드) 정의
    function getData() returns (uint256 returned) {
        return data;
    }
    function setData(uint256 newData) onlyOwner {
        logData(newData);
        data = newData;
    }
}

-솔리디티의 데이터 위치-
storage = 전역 변수 -> 블록체인
meemory = 로컬 -> 사용 후 휘발

-가시성 접근성-
external(다른 트랜잭션에의해서 실행, this.h), public(모든방법), internal(내부적), private(내부적 + 상속된것에서는 사용안됨)


-EVM 가스-
EVM에서 무엇인가 실행되면 지불하는 요금
가스 리밋 : 수수료의 한계치
가스 프라이스 : 수수료 비싸지면 채굴자 돈많이벌게되게된다.
가스 프라이스 * 가스 리밋 = 수수료

======================================
탈중화된 중앙서버 없는 투표앱을 만들겠다.
컨트랙트를 만들고 배포하는 방법 등을 알아 볼 수 있다.

내가 만들 블록체인을 가나슈를 통해 배포하고 RPC를 통해 remote할 수 있다.
이 RPC를 할 수 있는 자바스크립트 라이브러리가 web3.js이다.

constructor = 컨트랙트가 배포될때 딱한 번만 초기화된다. 배포를 해서 컨트랙트가 여러번 배포되면 여러개의 인스턴스가 생기게되는 것이고 수정이나 변경을 불가능하게된다.

cd /dir
npm install ganache-cli web3@0.2.0.3 solc
node_modules/.bin/ganache-cli => 가나슈 실행

컴파일
node_modulse/.bin/solcjs --bin --abi voting.sol

voting_sol_voting.abi => like api 블록체인에 올리고 사용자들이 사용할 수 있도록 인터페이스를 제공
voting_sol_voting.bin => 바이트 코드
=>블록체인이 이 컨트랙트를 받아들이려며 이 두가지가 필요하다.

블록체인(가나슈)에 배포하는 단계
컨트랙트 객체를 생성
web3 api사용

블록체인에 배포하는것을 바이트 코드이다. 따라서 node안에서 json을 바이트코드로 바꾸어줘야한다.
> Web3 = require('web3')
> web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
> bytecode = fs.readFileSync('./voting_sol_voting.bin').toString();
> abi = fs.readFileSync('./voting_sol_voting.abi').toString();
> abi = JSON.parse(fs.readFileSync('./voting_sol_voting.abi').toString()) // json형식이어야함
> VotingContract = new web3.eth.contract(abi);

//web3.utils.asciiToHex ==> fromAscii
#>>>>>npm install web3-utils
