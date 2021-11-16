Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F1F45355D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbhKPPNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:13:08 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28542 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237880AbhKPPL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:11:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UwuFdX6_1637075295;
Received: from VM20190228-102.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0UwuFdX6_1637075295)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 23:08:48 +0800
From:   Guanghui Feng <guanghuifeng@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        zhangliguang@linux.alibaba.com
Subject: [PATCH] arm64: clear_page: use stnp non-temporal instruction for performance optimizing
Date:   Tue, 16 Nov 2021 23:08:14 +0800
Message-Id: <1637075294-30747-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When clear page mem, there is no need to alloc cache for storing these
mem value. And the copy_page.S have used stnp instruction for optimizing.
So I rewrite the clear_page.S with stnp. At the same time, I have tested it
with stnp instruction which will get about twice the performance improvement.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 arch/arm64/lib/clear_page.S | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/lib/clear_page.S b/arch/arm64/lib/clear_page.S
index b84b179..e9dc2d6 100644
--- a/arch/arm64/lib/clear_page.S
+++ b/arch/arm64/lib/clear_page.S
@@ -15,13 +15,18 @@
  *	x0 - dest
  */
 SYM_FUNC_START_PI(clear_page)
-	mrs	x1, dczid_el0
-	and	w1, w1, #0xf
-	mov	x2, #4
-	lsl	x1, x2, x1
-
-1:	dc	zva, x0
-	add	x0, x0, x1
+	mov	x1, #0
+	mov	x2, #0
+1:
+	stnp	x1, x2, [x0]
+	stnp	x1, x2, [x0, #16]
+	stnp	x1, x2, [x0, #32]
+	stnp	x1, x2, [x0, #48]
+	stnp	x1, x2, [x0, #64]
+	stnp	x1, x2, [x0, #80]
+	stnp	x1, x2, [x0, #96]
+	stnp	x1, x2, [x0, #112]
+	add	x0, x0, #128
 	tst	x0, #(PAGE_SIZE - 1)
 	b.ne	1b
 	ret
-- 
1.8.3.1

