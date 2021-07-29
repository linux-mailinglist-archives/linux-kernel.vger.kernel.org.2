Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE78E3DA049
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhG2Jck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:32:40 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38499 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235492AbhG2Jcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:32:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UhKSVrp_1627551149;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UhKSVrp_1627551149)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Jul 2021 17:32:34 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: rate limit ipmi smi_event failure message
Date:   Thu, 29 Jul 2021 17:32:28 +0800
Message-Id: <20210729093228.77098-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we can't get a valid si_sm_data, and we print an error
message accordingly. But the ipmi module seem to like retrying a lot,
in which case we flood the kernel log with a lot of messages, eg:

[46318019.164726] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318020.109700] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318021.158677] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318022.212598] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318023.258564] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318024.210455] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318025.260473] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318026.308445] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318027.356389] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318028.298288] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
[46318029.363302] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Baoyou Xie <baoyou.xie@alibaba-inc.com>
Cc: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
---
 drivers/char/ipmi/ipmi_si_intf.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 62929a3..f64c3ac 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -591,7 +591,7 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		smi_info->handlers->get_result(smi_info->si_sm, msg, 3);
 		if (msg[2] != 0) {
 			/* Error clearing flags */
-			dev_warn(smi_info->io.dev,
+			dev_warn_ratelimited(smi_info->io.dev,
 				 "Error clearing flags: %2.2x\n", msg[2]);
 		}
 		smi_info->si_state = SI_NORMAL;
@@ -683,10 +683,11 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		/* We got the flags from the SMI, now handle them. */
 		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
 		if (msg[2] != 0) {
-			dev_warn(smi_info->io.dev,
-				 "Couldn't get irq info: %x.\n", msg[2]);
-			dev_warn(smi_info->io.dev,
-				 "Maybe ok, but ipmi might run very slowly.\n");
+#define IPMI_WARN_CHECKING_ENABLES "Maybe ok, but ipmi might run very slowly."
+
+			dev_warn_ratelimited(smi_info->io.dev,
+				"Couldn't get irq info: %x, %s\n",
+				msg[2], IPMI_WARN_CHECKING_ENABLES);
 			smi_info->si_state = SI_NORMAL;
 			break;
 		}
@@ -721,7 +722,7 @@ static void handle_transaction_done(struct smi_info *smi_info)
 
 		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
 		if (msg[2] != 0)
-			dev_warn(smi_info->io.dev,
+			dev_warn_ratelimited(smi_info->io.dev,
 				 "Could not set the global enables: 0x%x.\n",
 				 msg[2]);
 
@@ -1343,7 +1344,7 @@ static int try_get_dev_id(struct smi_info *smi_info)
 
 		if (cc != IPMI_CC_NO_ERROR &&
 		    ++retry_count <= GET_DEVICE_ID_MAX_RETRY) {
-			dev_warn(smi_info->io.dev,
+			dev_warn_ratelimited(smi_info->io.dev,
 			    "BMC returned 0x%2.2x, retry get bmc device id\n",
 			    cc);
 			goto retry;
-- 
1.8.3.1

