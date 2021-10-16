Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEB04303D5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbhJPQ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 12:58:34 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37198 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhJPQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 12:58:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UsLiVv4_1634403381;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UsLiVv4_1634403381)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 17 Oct 2021 00:56:22 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/core: Optimize kdamod.%d thread creation code
Date:   Sun, 17 Oct 2021 00:56:16 +0800
Message-Id: <20211016165616.95849-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
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
be created, this is meaningless, so t

So there adds a judgment. only if the ctx->adaptive_targets
list is not empty, and ctx->kdamond pointer is NULL, then call
the __damon_start function.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/core.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 30e9211f494a..998c707fdca2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -107,6 +107,11 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }
 
+static int damon_target_empty(struct damon_ctx *ctx)
+{
+	return list_empty(&ctx->adaptive_targets);
+}
+
 static void damon_del_target(struct damon_target *t)
 {
 	list_del(&t->list);
@@ -307,15 +312,14 @@ static int __damon_start(struct damon_ctx *ctx)
 	int err = -EBUSY;
 
 	mutex_lock(&ctx->kdamond_lock);
-	if (!ctx->kdamond) {
+	ctx->kdamond_stop = false;
+	ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
+				   nr_running_ctxs);
+	if (IS_ERR(ctx->kdamond)) {
+		err = PTR_ERR(ctx->kdamond);
+		ctx->kdamond = 0;
+	} else {
 		err = 0;
-		ctx->kdamond_stop = false;
-		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
-				nr_running_ctxs);
-		if (IS_ERR(ctx->kdamond)) {
-			err = PTR_ERR(ctx->kdamond);
-			ctx->kdamond = 0;
-		}
 	}
 	mutex_unlock(&ctx->kdamond_lock);
 
@@ -347,10 +351,12 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
 	}
 
 	for (i = 0; i < nr_ctxs; i++) {
-		err = __damon_start(ctxs[i]);
-		if (err)
-			break;
-		nr_running_ctxs++;
+		if (!damon_target_empty(ctxs[i]) && !ctxs[i]->kdamond) {
+			err = __damon_start(ctxs[i]);
+			if (err)
+				break;
+			nr_running_ctxs++;
+		}
 	}
 	mutex_unlock(&damon_lock);
 
-- 
2.31.0

