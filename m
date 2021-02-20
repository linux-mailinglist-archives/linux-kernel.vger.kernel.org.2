Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69456320484
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 09:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhBTI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 03:58:23 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36284 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhBTI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 03:58:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UP0IAvR_1613811457;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UP0IAvR_1613811457)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 20 Feb 2021 16:57:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] powerpc/sstep: Use bitwise instead of arithmetic operator for flags
Date:   Sat, 20 Feb 2021 16:57:35 +0800
Message-Id: <1613811455-2457-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccinelle warnings:
./arch/powerpc/lib/sstep.c:1090:20-21: WARNING: sum of probable
bitmasks, consider |
./arch/powerpc/lib/sstep.c:1115:20-21: WARNING: sum of probable
bitmasks, consider |
./arch/powerpc/lib/sstep.c:1134:20-21: WARNING: sum of probable
bitmasks, consider |

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/lib/sstep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index ede093e..e568cc5 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1087,7 +1087,7 @@ static nokprobe_inline void add_with_carry(const struct pt_regs *regs,
 
 	if (carry_in)
 		++val;
-	op->type = COMPUTE + SETREG + SETXER;
+	op->type = COMPUTE | SETREG | SETXER;
 	op->reg = rd;
 	op->val = val;
 #ifdef __powerpc64__
@@ -1112,7 +1112,7 @@ static nokprobe_inline void do_cmp_signed(const struct pt_regs *regs,
 {
 	unsigned int crval, shift;
 
-	op->type = COMPUTE + SETCC;
+	op->type = COMPUTE | SETCC;
 	crval = (regs->xer >> 31) & 1;		/* get SO bit */
 	if (v1 < v2)
 		crval |= 8;
@@ -1131,7 +1131,7 @@ static nokprobe_inline void do_cmp_unsigned(const struct pt_regs *regs,
 {
 	unsigned int crval, shift;
 
-	op->type = COMPUTE + SETCC;
+	op->type = COMPUTE | SETCC;
 	crval = (regs->xer >> 31) & 1;		/* get SO bit */
 	if (v1 < v2)
 		crval |= 8;
-- 
1.8.3.1

