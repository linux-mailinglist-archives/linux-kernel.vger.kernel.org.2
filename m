Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5201A33E78F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCQDQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:16:16 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59858 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhCQDQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:16:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0USCyl7O_1615950962;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0USCyl7O_1615950962)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 11:16:07 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] sparc64: replace if (cond) BUG() with BUG_ON()
Date:   Wed, 17 Mar 2021 11:16:01 +0800
Message-Id: <1615950961-109704-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./arch/sparc/kernel/traps_64.c:419:2-5: WARNING: Use BUG_ON instead of
if condition followed by BUG.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  - Replace BUG with BUG_ON.

 arch/sparc/kernel/traps_64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index a850dcc..78d04b2 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -415,8 +415,7 @@ static void spitfire_clean_and_reenable_l1_caches(void)
 {
 	unsigned long va;
 
-	if (tlb_type != spitfire)
-		BUG();
+	BUG_ON(tlb_type != spitfire);
 
 	/* Clean 'em. */
 	for (va =  0; va < (PAGE_SIZE << 1); va += 32) {
-- 
1.8.3.1

