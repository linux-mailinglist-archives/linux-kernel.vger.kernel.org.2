Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC293333609
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 07:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhCJGyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:54:03 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:27817 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhCJGxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:53:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0URCZoLM_1615359220;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0URCZoLM_1615359220)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Mar 2021 14:53:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bcain@codeaurora.org
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] hexagon: fix warning comparing pointer to 0
Date:   Wed, 10 Mar 2021 14:53:39 +0800
Message-Id: <1615359219-1528-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./arch/hexagon/kernel/traps.c:142:6-7: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 904134b..58083df 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -139,7 +139,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 		}
 
 		/* Attempt to continue past exception. */
-		if (0 == newfp) {
+		if (!newfp) {
 			struct pt_regs *regs = (struct pt_regs *) (((void *)fp)
 						+ 8);
 
-- 
1.8.3.1

