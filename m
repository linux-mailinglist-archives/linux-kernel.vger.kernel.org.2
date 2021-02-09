Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2A314B72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhBIJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:23:05 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33020 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhBIJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:20:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UOHYKit_1612862376;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UOHYKit_1612862376)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Feb 2021 17:19:36 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: backing-dev: Remove duplicated macro definition
Date:   Tue,  9 Feb 2021 17:19:22 +0800
Message-Id: <d1ccdf2d3116dce9814f2bcc1f0415ecb4c76ea5.1612862230.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the K() macro a little forward to remove the same macro definition.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/backing-dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 71a2bf4..576220a 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -33,6 +33,8 @@
 /* bdi_wq serves all asynchronous writeback tasks */
 struct workqueue_struct *bdi_wq;
 
+#define K(x) ((x) << (PAGE_SHIFT - 10))
+
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -70,7 +72,6 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 	global_dirty_limits(&background_thresh, &dirty_thresh);
 	wb_thresh = wb_calc_thresh(wb, dirty_thresh);
 
-#define K(x) ((x) << (PAGE_SHIFT - 10))
 	seq_printf(m,
 		   "BdiWriteback:       %10lu kB\n"
 		   "BdiReclaimable:     %10lu kB\n"
@@ -99,7 +100,6 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   nr_more_io,
 		   nr_dirty_time,
 		   !list_empty(&bdi->bdi_list), bdi->wb.state);
-#undef K
 
 	return 0;
 }
@@ -147,8 +147,6 @@ static ssize_t read_ahead_kb_store(struct device *dev,
 	return count;
 }
 
-#define K(pages) ((pages) << (PAGE_SHIFT - 10))
-
 #define BDI_SHOW(name, expr)						\
 static ssize_t name##_show(struct device *dev,				\
 			   struct device_attribute *attr, char *buf)	\
-- 
1.8.3.1

