Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7740C434790
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhJTJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:05:32 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:56949 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhJTJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:05:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ut1iyHi_1634720585;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Ut1iyHi_1634720585)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 17:03:14 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/2] mm/damon/dbgfs: Add adaptive_targets list check before enable monitor_on
Date:   Wed, 20 Oct 2021 17:03:01 +0800
Message-Id: <0a60a6e8ec9d71989e0848a4dc3311996ca3b5d4.1634720326.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1634720326.git.xhao@linux.alibaba.com>
References: <cover.1634720326.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ctx->adaptive_targets list is empty,
I did some test on monitor_on interface like this.

    # cat /sys/kernel/debug/damon/target_ids
    #
    # echo on > /sys/kernel/debug/damon/monitor_on
    # damon: kdamond (5390) starts

Though the ctx->adaptive_targets list is empty, but the
kthread_run still be called, and the kdamond.x thread still
be created, this is meaningless.

So there adds a judgment in 'dbgfs_monitor_on_write',
if the ctx->adaptive_targets list is empty, return -EINVAL.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       |  5 +++++
 mm/damon/dbgfs.c      | 15 ++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 715dadd21f7c..4fce5f1f6dad 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -316,6 +316,7 @@ void damon_destroy_scheme(struct damos *s);

 struct damon_target *damon_new_target(unsigned long id);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
+bool damon_targets_empty(struct damon_ctx *ctx);
 void damon_free_target(struct damon_target *t);
 void damon_destroy_target(struct damon_target *t);
 unsigned int damon_nr_regions(struct damon_target *t);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2f6785737902..c3a1374dbe0b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -156,6 +156,11 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }

+bool damon_targets_empty(struct damon_ctx *ctx)
+{
+	return list_empty(&ctx->adaptive_targets);
+}
+
 static void damon_del_target(struct damon_target *t)
 {
 	list_del(&t->list);
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index c90988a20fa4..a02cf6bee8e8 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -861,12 +861,21 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 		return -EINVAL;
 	}

-	if (!strncmp(kbuf, "on", count))
+	if (!strncmp(kbuf, "on", count)) {
+		int i;
+
+		for (i = 0; i < dbgfs_nr_ctxs; i++) {
+			if (damon_targets_empty(dbgfs_ctxs[i])) {
+				kfree(kbuf);
+				return -EINVAL;
+			}
+		}
 		ret = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
-	else if (!strncmp(kbuf, "off", count))
+	} else if (!strncmp(kbuf, "off", count)) {
 		ret = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
-	else
+	} else {
 		ret = -EINVAL;
+	}

 	if (!ret)
 		ret = count;
--
2.31.0
