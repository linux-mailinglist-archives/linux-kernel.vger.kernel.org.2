Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A1C45D812
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354561AbhKYKUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:20:03 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:55076 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245468AbhKYKSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:18:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyFpqIF_1637835250;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UyFpqIF_1637835250)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Nov 2021 18:14:50 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rth@twiddle.net
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] mm: Fix warning comparing pointer to 0
Date:   Thu, 25 Nov 2021 18:14:00 +0800
Message-Id: <1637835240-51114-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./arch/alpha/mm/fault.c:193:52-53: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -For the follow advice:
   https://lore.kernel.org/lkml/5391025983087ae9d1292387bc0b2b37c9c57863.camel@perches.com/

 arch/alpha/mm/fault.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 6c0a277..89e265e 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -190,10 +190,9 @@
 
  no_context:
 	/* Are we prepared to handle this fault as an exception?  */
-	if ((fixup = search_exception_tables(regs->pc)) != 0) {
-		unsigned long newpc;
-		newpc = fixup_exception(dpf_reg, fixup, regs->pc);
-		regs->pc = newpc;
+	fixup = search_exception_tables(regs->pc);
+	if (fixup) {
+		regs->pc = fixup_exception(dpf_reg, fixup, regs->pc);
 		return;
 	}
 
-- 
1.8.3.1

