Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8CE33380E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhCJJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:01:10 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58098 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231197AbhCJJAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:00:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0URGffM1_1615366836;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0URGffM1_1615366836)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Mar 2021 17:00:36 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2] char/mwave: turn tp3780I_Cleanup() into void function
Date:   Wed, 10 Mar 2021 17:00:34 +0800
Message-Id: <1615366834-20545-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function always return '0' and no callers use the return value.
So make it a void function.

This eliminates the following coccicheck warning:
./drivers/char/mwave/tp3780i.c:182:5-11: Unneeded variable: "retval".
Return "0" on line 187

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

Change in v2:
-correct the subject line

 drivers/char/mwave/tp3780i.c | 6 +-----
 drivers/char/mwave/tp3780i.h | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mwave/tp3780i.c b/drivers/char/mwave/tp3780i.c
index 5e1618a..8588b51 100644
--- a/drivers/char/mwave/tp3780i.c
+++ b/drivers/char/mwave/tp3780i.c
@@ -177,14 +177,10 @@ int tp3780I_InitializeBoardData(THINKPAD_BD_DATA * pBDData)
 	return retval;
 }
 
-int tp3780I_Cleanup(THINKPAD_BD_DATA * pBDData)
+void tp3780I_Cleanup(THINKPAD_BD_DATA *pBDData)
 {
-	int retval = 0;
-
 	PRINTK_2(TRACE_TP3780I,
 		"tp3780i::tp3780I_Cleanup entry and exit pBDData %p\n", pBDData);
-
-	return retval;
 }
 
 int tp3780I_CalcResources(THINKPAD_BD_DATA * pBDData)
diff --git a/drivers/char/mwave/tp3780i.h b/drivers/char/mwave/tp3780i.h
index 07685b6..8bd976d 100644
--- a/drivers/char/mwave/tp3780i.h
+++ b/drivers/char/mwave/tp3780i.h
@@ -91,7 +91,7 @@
 int tp3780I_ResetDSP(THINKPAD_BD_DATA * pBDData);
 int tp3780I_StartDSP(THINKPAD_BD_DATA * pBDData);
 int tp3780I_QueryAbilities(THINKPAD_BD_DATA * pBDData, MW_ABILITIES * pAbilities);
-int tp3780I_Cleanup(THINKPAD_BD_DATA * pBDData);
+void tp3780I_Cleanup(THINKPAD_BD_DATA *pBDData);
 int tp3780I_ReadWriteDspDStore(THINKPAD_BD_DATA * pBDData, unsigned int uOpcode,
                                void __user *pvBuffer, unsigned int uCount,
                                unsigned long ulDSPAddr);
-- 
1.8.3.1

