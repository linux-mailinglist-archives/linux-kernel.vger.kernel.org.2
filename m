Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05096356237
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243795AbhDGDxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:53:01 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38514 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233392AbhDGDxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:53:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UUklzHF_1617767559;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUklzHF_1617767559)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 07 Apr 2021 11:52:50 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] staging: rtl8192e: rtl8192E_dev: remove unused variable
Date:   Wed,  7 Apr 2021 11:52:38 +0800
Message-Id: <1617767558-114050-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:693:15: warning: variable
‘tmpRegC’ set but not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index ff843d7..8dbb31f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -690,7 +690,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	u8 tmpvalue;
 	u8 ICVersion, SwitchingRegulatorOutput;
 	bool bfirmwareok = true;
-	u32 tmpRegA, tmpRegC, TempCCk;
+	u32 tmpRegA, TempCCk;
 	int i = 0;
 	u32 retry_times = 0;
 
@@ -889,8 +889,8 @@ bool rtl92e_start_adapter(struct net_device *dev)
 		if (priv->IC_Cut >= IC_VersionCut_D) {
 			tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
 						    bMaskDWord);
-			tmpRegC = rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance,
-						    bMaskDWord);
+			rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance, bMaskDWord);
+
 			for (i = 0; i < TxBBGainTableLength; i++) {
 				if (tmpRegA == dm_tx_bb_gain[i]) {
 					priv->rfa_txpowertrackingindex = (u8)i;
-- 
1.8.3.1

