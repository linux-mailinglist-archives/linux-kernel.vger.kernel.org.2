Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF83AFB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhFVCkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:40:05 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43618 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231381AbhFVCkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:40:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UdGVF.o_1624329462;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UdGVF.o_1624329462)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Jun 2021 10:37:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] powerpc/interrupts: Fix duplicate included asm/interrupt.h
Date:   Tue, 22 Jun 2021 10:37:17 +0800
Message-Id: <1624329437-84730-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:

./arch/powerpc/kernel/interrupt.c: asm/interrupt.h is included more than
once.

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/powerpc/kernel/interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index e0938ba..557ec14 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -7,7 +7,6 @@
 #include <asm/asm-prototypes.h>
 #include <asm/kup.h>
 #include <asm/cputime.h>
-#include <asm/interrupt.h>
 #include <asm/hw_irq.h>
 #include <asm/interrupt.h>
 #include <asm/kprobes.h>
-- 
1.8.3.1

