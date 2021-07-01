Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334033B91CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhGAMxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 08:53:49 -0400
Received: from smtpbg704.qq.com ([203.205.195.105]:51332 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236392AbhGAMxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 08:53:47 -0400
X-Greylist: delayed 1574 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2021 08:53:46 EDT
X-QQ-mid: bizesmtp34t1625143869t3i3nq03
Received: from localhost.localdomain (unknown [182.148.13.55])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 01 Jul 2021 20:51:07 +0800 (CST)
X-QQ-SSF: 0100000000800030B000B00A0000000
X-QQ-FEAT: t5mnTZTTCFeiPWU/OhvvZsxrc8tP+EEDaPod+tKJ092DO7dk3bByzAqv1Qzzm
        hHR43sKAqPWSZkcjOsXUTJt7z2CH2KesOtIVPZvzchEl8F/0/O5x/ZzvCHORyq4svZjIcq0
        hfenTeYswyxotkoNrpGCuN8egV38/l1SCPnZtno5K5khVUwNsTFH7xAXZTjLr/GRQx8mQt9
        31uamDbKgFWfMgUrEa9gSXVfoff+T3K8FgHIqx2TsV95O/y4CSPUmhcbgJg4HF2+zF34WPc
        Oebven09p4zeA/2MQFwiFrut5SheqGuP2+Rvd+m9Xx6IGdYxm5rDQC+CwsbE8X5n7SqKuxN
        2IUE0aMnt03eDj5i5nOf0Ao4OSZ1A==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jk@ozlabs.org
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] sched: Use WARN_ON
Date:   Thu,  1 Jul 2021 20:50:46 +0800
Message-Id: <20210701125046.43018-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BUG_ON macro simplifies the if condition followed by BUG, but it
will lead to the kernel crashing. Therefore, we can try using WARN_ON
instead of if condition followed by BUG.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/platforms/cell/spufs/sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 369206489895..0f218d9e5733 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -904,8 +904,8 @@ static noinline void spusched_tick(struct spu_context *ctx)
 	struct spu_context *new = NULL;
 	struct spu *spu = NULL;
 
-	if (spu_acquire(ctx))
-		BUG();	/* a kernel thread never has signals pending */
+	/* a kernel thread never has signals pending */
+	WARN_ON(spu_acquire(ctx));
 
 	if (ctx->state != SPU_STATE_RUNNABLE)
 		goto out;
-- 
2.32.0



