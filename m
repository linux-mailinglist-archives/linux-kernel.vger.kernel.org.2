Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA46376381
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhEGKWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:22:03 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45561 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233362AbhEGKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:22:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UY2DuHm_1620382853;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UY2DuHm_1620382853)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 May 2021 18:20:58 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] powerpc/xive: Fix unsigned comparison with less than zero
Date:   Fri,  7 May 2021 18:20:51 +0800
Message-Id: <1620382851-67480-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to irq_domain_alloc_irqs() is int, it can be
a negative error code, however this is being assigned to an unsigned
int variable 'irq', this may lead to invalid if statement detection,
so that kfree execution is invalid. So making 'irq' an int.

Clean up the following coccicheck warning:

./arch/powerpc/sysdev/xive/common.c:1157:6-14: WARNING: Unsigned
expression compared with zero: xid -> irq < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/powerpc/sysdev/xive/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index a830432..a5fd45a 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -65,7 +65,7 @@
 #ifdef CONFIG_SMP
 /* The IPIs use the same logical irq number when on the same chip */
 static struct xive_ipi_desc {
-	unsigned int irq;
+	int irq;
 	char name[16];
 } *xive_ipis;
 
-- 
1.8.3.1

