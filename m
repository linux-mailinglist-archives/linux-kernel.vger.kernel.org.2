Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12FD454191
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhKQHGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:06:09 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44838 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhKQHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:06:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ux0WBIM_1637132585;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Ux0WBIM_1637132585)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Nov 2021 15:03:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     richard@nod.at
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ubifs: Fix kernel-doc
Date:   Wed, 17 Nov 2021 15:03:04 +0800
Message-Id: <1637132584-52066-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in fs/ubifs/io.c kernel-doc comment
to remove some warnings found by clang(make W=1 LLVM=1).

fs/ubifs/io.c:497: warning: expecting prototype for
wbuf_timer_callback(). Prototype was for wbuf_timer_callback_nolock()
instead
fs/ubifs/io.c:513: warning: expecting prototype for new_wbuf_timer().
Prototype was for new_wbuf_timer_nolock() instead
fs/ubifs/io.c:538: warning: expecting prototype for cancel_wbuf_timer().
Prototype was for cancel_wbuf_timer_nolock() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ubifs/io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 789a781..1dbee23 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -488,7 +488,7 @@ void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last)
 }
 
 /**
- * wbuf_timer_callback - write-buffer timer callback function.
+ * wbuf_timer_callback_nolock - write-buffer timer callback function.
  * @timer: timer data (write-buffer descriptor)
  *
  * This function is called when the write-buffer timer expires.
@@ -505,7 +505,7 @@ static enum hrtimer_restart wbuf_timer_callback_nolock(struct hrtimer *timer)
 }
 
 /**
- * new_wbuf_timer - start new write-buffer timer.
+ * new_wbuf_timer_nolock - start new write-buffer timer.
  * @c: UBIFS file-system description object
  * @wbuf: write-buffer descriptor
  */
@@ -531,7 +531,7 @@ static void new_wbuf_timer_nolock(struct ubifs_info *c, struct ubifs_wbuf *wbuf)
 }
 
 /**
- * cancel_wbuf_timer - cancel write-buffer timer.
+ * cancel_wbuf_timer_nolock - cancel write-buffer timer.
  * @wbuf: write-buffer descriptor
  */
 static void cancel_wbuf_timer_nolock(struct ubifs_wbuf *wbuf)
-- 
1.8.3.1

