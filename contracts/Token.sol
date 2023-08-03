// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TaskToken is ERC20 {
    address public admin;
    constructor(uint256 initialSupply) ERC20("TaskToken", "TK") {
        admin = msg.sender;
        _mint(msg.sender, initialSupply);
    }

    function rewardTaskCompletion(address worker, uint256 amount) external {
    require(msg.sender == admin, "only admin can reward tokens");
    _mint(worker, amount);
    }
}


// 機能要件
// タスクが完了したら、報酬を与える

contract TaskManagement {
    uint public taskCount = 0;
    event Created(uint id, string content);
    event IsCompleted(uint id, bool completed);

    // struct データの型を決めておく
    struct Task{
        uint id;
        string content;
        bool isCompleted;
    }

    // mapping 辞書のインスタンス化みたいなもの
    mapping(uint => Task) public maptasks;


    function create (string memory _content) public {
        taskCount++;
        maptasks[taskCount] = Task(taskCount, _content, false);
        emit Created(taskCount, _content);
    }

        //constructor スマートコントラクトの初期設定を行う
    constructor () public {
        createTask("buy flowers");
    }

    function complete(uint _id, address _worker) public {
        Task memory _task = maptasks[_id];
        require(_task.isCompleted == true, "you haven't finished this task yet");
    }


}
// タスクがあるかチェック
// タスクが完了しているか未完了かチェック
// 報酬を与える際に親アカウントに残高が十分にあるかチェック


// 非機能要件
//タスクが正確に完了した時のみ、報酬がもらえる。タスクが完了していなかったらエラーを吐く。
// ユーザーは報酬を得たことをTodoAppのモーダルかポップアップか何かで知る。
// 速度は早ければ早いほどいいが、ポリゴンのチェーンの速度がどうなっているかわからないので未定義


pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TaskToken is ERC20 {
    address public admin;
    
    constructor() ERC20("TaskToken", "TSK") {
        admin = msg.sender;
        _mint(msg.sender, 1000000 * 10 ** decimals());  // 初期供給
    }

    function rewardTaskCompletion(address worker, uint256 amount) external {
        require(msg.sender == admin, "only admin can reward tokens");
        _mint(worker, amount);
    }
}

// contract TaskContract {
//     TaskToken public token;
//     uint256 public taskCount = 0;
//     mapping(uint256 => Task) public tasks;

//     struct Task {
//         uint256 id;
//         string description;
//         bool completed;
//         uint256 reward;
//     }
    
//     event TaskCreated(
//         uint256 id,
//         string description,
//         bool completed,
//         uint256 reward
//     );
    
//     event TaskCompleted(
//         uint256 id,
//         address worker
//     );

//     constructor(address _token) {
//         token = TaskToken(_token);
//     }
    
//     function createTask(string memory _description, uint256 _reward) public {
//         taskCount ++;
//         tasks[taskCount] = Task(taskCount, _description, false, _reward);
//         emit TaskCreated(taskCount, _description, false, _reward);
//     }

//     function completeTask(uint256 _id, address _worker) public {
//         Task memory _task = tasks[_id];
//         require(_task.id != 0, "Task does not exist");
//         require(_task.completed == false, "Task already completed");
//         _task.completed = true;
//         tasks[_id] = _task;
//         token.rewardTaskCompletion(_worker, _task.reward);
//         emit TaskCompleted(_task.id, _worker);
//     }
// }
