Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A113C433860
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJSO2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:28:23 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44741 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJSO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:28:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Usyv4Hp_1634653565;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Usyv4Hp_1634653565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 22:26:07 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon/dbgfs: Add adaptive_targets list check before enable monitor_on
Date:   Tue, 19 Oct 2021 22:26:04 +0800
Message-Id: <f3866832af20c5bc8148e0607a8e47081d8c3b02.1634653088.git.bier@B-X3VXMD6M-2058.local>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1634653088.git.bier@B-X3VXMD6M-2058.local>
References: <cover.1634653088.git.bier@B-X3VXMD6M-2058.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ctx->adaptive_targets list is empty,
i did some test on monitor_on interface like this.

echo on > /sys/kernel/debug/damon/monitor_on
[  851.988307] damon: kdamond (5390) starts

Though the ctx->adaptive_targets list is empty, but the
kthread_run still be called, and the kdamond.x thread still
be created, this is meaningless.

So there adds a judgment in 'dbgfs_monitor_on_write',
if the ctx->adaptive_targets list is empty, return -EINVAL.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       |  5 +++++
 mm/damon/dbgfs.c      | 10 ++++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 715dadd21f7c..06acf73fe9db 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -316,6 +316,7 @@ void damon_destroy_scheme(struct damos *s);

 struct damon_target *damon_new_target(unsigned long id);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
+int damon_target_empty(struct damon_ctx *ctx);
 void damon_free_target(struct damon_target *t);
 void damon_destroy_target(struct damon_target *t);
 unsigned int damon_nr_regions(struct damon_target *t);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2f6785737902..c651b49249e5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -156,6 +156,11 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }

+int damon_target_empty(struct damon_ctx *ctx)
+{
+	return list_empty(&ctx->adaptive_targets);
+}
+
 static void damon_del_target(struct damon_target *t)
 {
 	list_del(&t->list);
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 38188347d8ab..bac42dd358d1 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -865,9 +865,15 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 		return -EINVAL;
 	}

-	if (!strncmp(kbuf, "on", count))
+	if (!strncmp(kbuf, "on", count)) {
+		int i;
+
+		for (i = 0; i < dbgfs_nr_ctxs; i++) {
+			if (damon_target_empty(dbgfs_ctxs[i]))
+				return -EINVAL;
+		}
 		err = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
-	else if (!strncmp(kbuf, "off", count))
+	} else if (!strncmp(kbuf, "off", count))
 		err = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
 	else
 		err = -EINVAL;
--
2.31.0
