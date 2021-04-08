Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF866358502
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhDHNnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:43:19 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:14517 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhDHNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:43:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UUu0lrj_1617889378;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0UUu0lrj_1617889378)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Apr 2021 21:43:06 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     wufengguang@huawei.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@gmail.com>
Subject: [PATCH for vm-scalability] usemem: Add code for touch-alloc
Date:   Thu,  8 Apr 2021 21:42:55 +0800
Message-Id: <20210408134255.12330-1-teawater@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code for touch-alloc.
And Change read memory to write memory to avoid use the zero-page for
reads in do_anonymous_page.

Signed-off-by: Hui Zhu <teawater@gmail.com>
---
 usemem.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/usemem.c b/usemem.c
index e2c46ec..5b90aae 100644
--- a/usemem.c
+++ b/usemem.c
@@ -329,6 +329,18 @@ void detach(void)
 	}
 }
 
+unsigned long do_access(unsigned long *p, unsigned long idx, int read)
+{
+	volatile unsigned long *vp = p;
+
+	if (read)
+		return vp[idx];	/* read data */
+	else {
+		vp[idx] = idx;	/* write data */
+		return 0;
+	}
+}
+
 unsigned long * allocate(unsigned long bytes)
 {
 	unsigned long *p;
@@ -355,6 +367,14 @@ unsigned long * allocate(unsigned long bytes)
 		p = (unsigned long *)ALIGN((unsigned long)p, pagesize - 1);
 	}
 
+	if (opt_touch_alloc) {
+		unsigned long i;
+		unsigned long m = bytes / sizeof(*p);
+
+		for (i = 0; i < m; i += 1)
+			do_access(p, i, 0);
+	}
+
 	return p;
 }
 
@@ -436,18 +456,6 @@ void shm_unlock(int seg_id)
 	shmctl(seg_id, SHM_UNLOCK, NULL);
 }
 
-unsigned long do_access(unsigned long *p, unsigned long idx, int read)
-{
-	volatile unsigned long *vp = p;
-
-	if (read)
-		return vp[idx];	/* read data */
-	else {
-		vp[idx] = idx;	/* write data */
-		return 0;
-	}
-}
-
 #define NSEC_PER_SEC  (1UL * 1000 * 1000 * 1000)
 
 long nsec_sub(long nsec1, long nsec2)
@@ -953,6 +961,8 @@ int main(int argc, char *argv[])
 				opt_punch_holes = 1;
 			} else if (strcmp(opts[opt_index].name, "init-time") == 0) {
 				opt_init_time = 1;
+			} else if (strcmp(opts[opt_index].name, "touch-alloc") == 0) {
+				opt_touch_alloc = 1;
 			} else
 				usage(1);
 			break;
-- 
2.17.1

