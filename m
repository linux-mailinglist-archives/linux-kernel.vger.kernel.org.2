Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A1937F5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhEMKrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 06:47:32 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53894 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231282AbhEMKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 06:47:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UYkPA7P_1620902770;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UYkPA7P_1620902770)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 May 2021 18:46:18 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] x86/traps: Fix duplicate included asm/proto.h
Date:   Thu, 13 May 2021 18:46:08 +0800
Message-Id: <1620902768-53822-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:

./arch/x86/kernel/traps.c: asm/proto.h is included more than once.

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 853ea7a..c4710e7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -64,13 +64,13 @@
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
-#include <asm/proto.h>
 #else
 #include <asm/processor-flags.h>
 #include <asm/setup.h>
-#include <asm/proto.h>
 #endif
 
+#include <asm/proto.h>
+
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
 
 static inline void cond_local_irq_enable(struct pt_regs *regs)
-- 
1.8.3.1

