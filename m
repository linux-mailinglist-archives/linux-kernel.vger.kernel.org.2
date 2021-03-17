Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB79D33EA08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCQGp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:45:29 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:48312 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230112AbhCQGpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:45:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0USESfUc_1615963512;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0USESfUc_1615963512)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 14:45:17 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jk@ozlabs.org
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] sched: replace if (cond) BUG() with BUG_ON()
Date:   Wed, 17 Mar 2021 14:45:10 +0800
Message-Id: <1615963510-89830-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./arch/powerpc/platforms/cell/spufs/sched.c:908:2-5: WARNING: Use BUG_ON
instead of if condition followed by BUG.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/powerpc/platforms/cell/spufs/sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 3692064..139a6ec 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -904,8 +904,7 @@ static noinline void spusched_tick(struct spu_context *ctx)
 	struct spu_context *new = NULL;
 	struct spu *spu = NULL;
 
-	if (spu_acquire(ctx))
-		BUG();	/* a kernel thread never has signals pending */
+	BUG_ON(spu_acquire(ctx));	/* a kernel thread never has signals pending */
 
 	if (ctx->state != SPU_STATE_RUNNABLE)
 		goto out;
-- 
1.8.3.1

