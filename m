Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE173B92FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhGAOOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:14:32 -0400
Received: from smtpbg704.qq.com ([203.205.195.105]:59269 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232081AbhGAOOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:14:31 -0400
X-QQ-mid: bizesmtp54t1625148715t01joxvb
Received: from localhost.localdomain (unknown [182.148.13.55])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 01 Jul 2021 22:11:54 +0800 (CST)
X-QQ-SSF: 0100000000800040B000D00A0000000
X-QQ-FEAT: 9waYh4jnNPyqOv0ygbC1/m0a12KsCMqDbI1aToSne+xL3DjS7+G9rBaosHAWB
        dEe7NJmbOC9e1dhde2jrjIwUlbQUvm7RWjW5/sYo8+unHRDgvcf/ayyTawMlzFSYWlW0C3W
        rQpGomGd9IqITzL7R4yLpOvme4n73ht1Q7lni582decm5Lng+pYfLOT/qqfSgOWU9d8sUAx
        bDCh3JgWv245YQNsBXrfiPnKybpT4J4tbms3SXsZ1H4jdr/8ZFyJUNbEo87J64eQ5q+n3+o
        OSYFPt21WhC0i2uXTijHaYMDGX3PooGpVbiPdzYs7272WJa9vH/gem1ajNqw30UGOawu3MP
        eRebsxwCQ10VfvOdvMhPkQg1wL13DgwWDtSXDl1
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jk@ozlabs.org
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH v2] sched: Use BUG_ON
Date:   Thu,  1 Jul 2021 22:11:30 +0800
Message-Id: <20210701141130.940-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BUG_ON macro simplifies the if condition followed by BUG, so that
we can use BUG_ON instead of if condition followed by BUG.

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
+	BUG_ON(spu_acquire(ctx));
 
 	if (ctx->state != SPU_STATE_RUNNABLE)
 		goto out;
-- 
2.32.0



