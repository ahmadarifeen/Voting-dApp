// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {

    struct Candidate {
        string name;
        string party;
        uint voteCount;
    }

    Candidate[] public candidates;

    event CandidateAdded(string name, string party);
    event CandidateInfo(string info);

    function addCandidate(string memory name, string memory party) public {
        candidates.push(Candidate(name, party, 0));
        emit CandidateAdded(name, party);
    }

    function vote(string memory candidateName) public {
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i].name)) == keccak256(bytes(candidateName))) {
                candidates[i].voteCount++;
                break;
            }
        }
    }

    function getCandidates() public view returns (string[] memory, string[] memory, uint[] memory) {
        string[] memory candidateNames = new string[](candidates.length);
        string[] memory partyNames = new string[](candidates.length);
        uint[] memory voteCounts = new uint[](candidates.length);

        for (uint i = 0; i < candidates.length; i++) {
            candidateNames[i] = candidates[i].name;
            partyNames[i] = candidates[i].party;
            voteCounts[i] = candidates[i].voteCount;
        }

        return (candidateNames, partyNames, voteCounts);
    }

    function viewCandidates() public {
        for (uint i = 0; i < candidates.length; i++) {
            string memory candidateInfo = string(abi.encodePacked(candidates[i].name, " (", candidates[i].party, "): ", candidates[i].voteCount, " votes"));
            emit CandidateInfo(candidateInfo);
        }
    }
}
