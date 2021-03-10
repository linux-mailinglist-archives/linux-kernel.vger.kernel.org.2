Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49193337D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhCJIuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:50:54 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36750 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhCJIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:50:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0URGJwvU_1615366220;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0URGJwvU_1615366220)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Mar 2021 16:50:21 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     monstr@monstr.eu
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] microblaze: remove unneeded variable 'err'
Date:   Wed, 10 Mar 2021 16:50:18 +0800
Message-Id: <1615366218-7634-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./arch/microblaze/kernel/signal.c:60:14-17: Unneeded variable: "err".
Return "0" on line 78

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/microblaze/kernel/signal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index fc61eb0..c4b7b30 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -57,8 +57,6 @@ struct rt_sigframe {
 static int restore_sigcontext(struct pt_regs *regs,
 				struct sigcontext __user *sc, int *rval_p)
 {
-	unsigned int err = 0;
-
 #define COPY(x)		{err |= __get_user(regs->x, &sc->regs.x); }
 	COPY(r0);
 	COPY(r1);
@@ -75,7 +73,7 @@ static int restore_sigcontext(struct pt_regs *regs,
 
 	*rval_p = regs->r3;
 
-	return err;
+	return 0;
 }
 
 asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
-- 
1.8.3.1

