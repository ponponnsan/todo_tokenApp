// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 機能要件
// タスクを作成する機能


// タスクを完了する機能
// タスクがあるかチェック
// タスクが完了しているか未完了かチェック

// 報酬を与える機能
// 報酬を与える際に親アカウントに残高が十分にあるかチェック
// ユーザーは報酬を得たことをTodoAppのモーダルかポップアップか何かで知る。


// 非機能要件
// 速度は早ければ早いほどいいが、ポリゴンのチェーンの速度がどうなっているかわからないので未定義
// また何かあれば追記すること


/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details
/// @param Documents a parameter just like in doxygen (must be followed by parameter name)

contract TaskToken is ERC20 {
    address public admin;
    uint8 public decimals = 18;
    constructor() ERC20("TaskToken", "TK") {
        admin = msg.sender;
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function rewardTaskCompletion(address worker, uint256 amount) external {
        require(msg.sender == admin, "only admin can reward tokens");
        _mint(worker, amount);
    }
}



contract TaskManagement {
    uint public taskCount = 0;
    event Created(uint id, string content);
    event TaskCompleted(uint id);

    // struct データの型を決めておく
    struct Task{
        uint id;
        string content;
        bool isCompleted;
    }

    // mapping 辞書のインスタンス化みたいなもの
    mapping(uint => Task) public maptasks;

    //constructor スマートコントラクトの初期設定を行う
    constructor (address _taskToken) public {
        taskToken = TaskToken(_taskToken);
        createTask("buy flowersssssssssss");
    }

    function create (string memory _content) public {
        taskCount++;
        maptasks[taskCount] = Task(taskCount, _content, false);
        // イベントの発火
        emit Created(taskCount, _content);
    }

    function complete(uint _id, address _worker) public {
        require(_id < taskCount, "task is not valid");
        require(!task.isCompleted, "Task is already completed!!");
        
        tasks[_id].isCompleted = true;
        taskToken.rewardTaskCompletion(_worker, 1)
        emit TaskCompleted(_id)
        
    }

}



// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// contract TaskToken is ERC20 {
//     address public admin;
    
//     constructor() ERC20("TaskToken", "TSK") {
//         admin = msg.sender;
//         _mint(msg.sender, 1000000 * 10 ** decimals());  // 初期供給
//     }

//     function rewardTaskCompletion(address worker, uint256 amount) external {
//         require(msg.sender == admin, "only admin can reward tokens");
//         _mint(worker, amount);
//     }
// }

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
