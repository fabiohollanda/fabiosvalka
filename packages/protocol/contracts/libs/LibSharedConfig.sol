// SPDX-License-Identifier: MIT
//  _____     _ _         _         _
// |_   _|_ _(_) |_____  | |   __ _| |__ ___
//   | |/ _` | | / / _ \ | |__/ _` | '_ (_-<
//   |_|\__,_|_|_\_\___/ |____\__,_|_.__/__/

pragma solidity ^0.8.9;

import "../L1/TaikoData.sol";

library LibSharedConfig {
    /// Returns shared configs for both TaikoL1 and TaikoL2 for production.
    function getConfig() internal pure returns (TaikoData.Config memory) {
        return
            TaikoData.Config({
                chainId: 167, // Taiko chain ID
                maxNumBlocks: 2049, // up to 2048 pending blocks
                blockHashHistory: 100000,
                // This number is calculated from maxNumBlocks to make
                // the 'the maximum value of the multiplier' close to 20.0
                zkProofsPerBlock: 1,
                maxVerificationsPerTx: 20,
                commitConfirmations: 0,
                maxProofsPerForkChoice: 5,
                blockMaxGasLimit: 5000000, // TODO
                maxTransactionsPerBlock: 20, // TODO
                maxBytesPerTxList: 10240, // TODO
                minTxGasLimit: 21000, // TODO
                anchorTxGasLimit: 250000,
                feePremiumLamda: 590,
                rewardBurnBips: 100, // 100 basis points or 1%
                proposerDepositPctg: 25, // 25%
                // Moving average factors
                feeBaseMAF: 1024,
                blockTimeMAF: 1024,
                proofTimeMAF: 1024,
                rewardMultiplierPctg: 400, // 400%
                feeGracePeriodPctg: 125, // 125%
                feeMaxPeriodPctg: 375, // 375%
                blockTimeCap: 48 seconds,
                proofTimeCap: 60 minutes,
                bootstrapDiscountHalvingPeriod: 180 days,
                initialUncleDelay: 60 minutes,
                enableTokenomics: false,
                enablePublicInputsCheck: true
            });
    }

    function validateConfig(TaikoData.Config memory config) internal pure {
        require(config.chainId > 1, "C:chainId");
        require(config.maxNumBlocks > 0, "C:maxNumBlocks");
        require(config.blockHashHistory > 0, "C:blockHashHistory");
        require(config.zkProofsPerBlock > 0, "C:zkProofsPerBlock");
        // maxVerificationsPerTx
        // commitConfirmations
        require(config.maxProofsPerForkChoice > 0, "C:maxProofsPerForkChoice");
        require(config.blockMaxGasLimit > 0, "C:blockMaxGasLimit");
        require(
            config.maxTransactionsPerBlock > 0,
            "C:maxTransactionsPerBlock"
        );
        require(config.maxBytesPerTxList > 0, "C:maxBytesPerTxList");
        require(config.minTxGasLimit > 0, "C:minTxGasLimit");
        require(config.anchorTxGasLimit > 0, "C:anchorTxGasLimit");
        require(config.feePremiumLamda > 0, "C:feePremiumLamda");
        require(config.rewardBurnBips <= 10000, "C:rewardBurnBips");
        require(config.feeBaseMAF > 1, "C:feeBaseMAF");
        require(config.blockTimeMAF > 1, "C:blockTimeMAF");
        require(config.proofTimeMAF > 1, "C:proofTimeMAF");
        require(config.rewardMultiplierPctg >= 100, "C:rewardMultiplierPctg");
        require(config.feeGracePeriodPctg >= 100, "C:feeGracePeriodPctg");
        require(
            config.feeMaxPeriodPctg >= config.feeGracePeriodPctg,
            "C:feeMaxPeriodPctg<feeGracePeriodPctg"
        );
        require(config.blockTimeCap > 0, "C:blockTimeCap");
        require(config.proofTimeCap > 0, "C:proofTimeCap");
        require(
            config.bootstrapDiscountHalvingPeriod > 0,
            "C:bootstrapDiscountHalvingPeriod"
        );
        // initialUncleDelay
    }
}
