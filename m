Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5274A33EA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCQHeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:34:00 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:37334 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230033AbhCQHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:33:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0USELFXx_1615966422;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0USELFXx_1615966422)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 15:33:52 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jk@ozlabs.org
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] sched: replace if (cond) BUG() with WARN_ON()
Date:   Wed, 17 Mar 2021 15:33:39 +0800
Message-Id: <1615966419-20549-1-git-send-email-jiapeng.chong@linux.alibaba.com>
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
Changes in v2:
  - replace BUG with WARN_ON.

 arch/powerpc/platforms/cell/spufs/sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 3692064..1031448 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -904,8 +904,7 @@ static noinline void spusched_tick(struct spu_context *ctx)
 	struct spu_context *new = NULL;
 	struct spu *spu = NULL;
 
-	if (spu_acquire(ctx))
-		BUG();	/* a kernel thread never has signals pending */
+	WARN_ON(spu_acquire(ctx));	/* a kernel thread never has signals pending */
 
 	if (ctx->state != SPU_STATE_RUNNABLE)
 		goto out;
-- 
1.8.3.1

