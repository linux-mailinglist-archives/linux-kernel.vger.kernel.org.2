Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2504C44C055
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhKJLu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhKJLu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:50:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1453261075;
        Wed, 10 Nov 2021 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636544859;
        bh=HAO6aFEMaWpdHaMdIfE22fc41HEPpX/j7kdI4dDL97c=;
        h=From:To:Cc:Subject:Date:From;
        b=AZ1A8gW0cBa1s97CL/kF6K5RgjQULkrjQ71GONhbxMs/wfrjY8QdcyYLRdEX3M5ue
         XYD2mOH5MwMGlvf5y1hVcU83MVih0nHLll7MvWkSbVm3eDH8ELqNY8ag4F1cL7UqOI
         15xRTw5GJkTxj/et2niPO4eeNgSOu4V2LpJ9lTTpVnXopmByn1oBXsnvS/Up+rB8/m
         4EfNirtpfuzmeo/ravwCZfoh89hZnVvMol4UhB9bRopOeF9qowSbQepEvydQmckznX
         kJ3PgQ8+FMzrXDnOBDmsohurVYJFADlmwDeWyOdKnFVIgD+i5zG1dJNQyUyUX4Sq+8
         UJCAZ97yKcZeA==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm/damon: remove damon_lock
Date:   Wed, 10 Nov 2021 19:47:21 +0800
Message-Id: <20211110114721.133808-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

Variable nr_running_ctxs guards by damon_lock, but a lock for a int
variable seems a bit heavy, a atomic_t is enough.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: SeongJae Park <sj@kernel.org> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: linux-mm@kvack.org 
Cc: linux-kernel@vger.kernel.org 
---
 include/linux/damon.h |  1 -
 mm/damon/core.c       | 31 +++++--------------------------
 mm/damon/dbgfs.c      |  8 +++++---
 3 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b4d4be3cc987..e5dcc6336ef2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -453,7 +453,6 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
 int damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
-int damon_nr_running_ctxs(void);
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c381b3c525d0..e821e36d5c10 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -26,8 +26,7 @@
 /* Get a random number in [l, r) */
 #define damon_rand(l, r) (l + prandom_u32_max(r - l))
 
-static DEFINE_MUTEX(damon_lock);
-static int nr_running_ctxs;
+atomic_t nr_running_ctxs;
 
 /*
  * Construct a damon_region struct
@@ -356,20 +355,6 @@ int damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 	return 0;
 }
 
-/**
- * damon_nr_running_ctxs() - Return number of currently running contexts.
- */
-int damon_nr_running_ctxs(void)
-{
-	int nr_ctxs;
-
-	mutex_lock(&damon_lock);
-	nr_ctxs = nr_running_ctxs;
-	mutex_unlock(&damon_lock);
-
-	return nr_ctxs;
-}
-
 /* Returns the size upper limit for each monitoring region */
 static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 {
@@ -408,7 +393,7 @@ static int __damon_start(struct damon_ctx *ctx)
 	if (!ctx->kdamond) {
 		err = 0;
 		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
-				nr_running_ctxs);
+				atomic_read(&nr_running_ctxs));
 		if (IS_ERR(ctx->kdamond)) {
 			err = PTR_ERR(ctx->kdamond);
 			ctx->kdamond = NULL;
@@ -437,19 +422,15 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
 	int i;
 	int err = 0;
 
-	mutex_lock(&damon_lock);
-	if (nr_running_ctxs) {
-		mutex_unlock(&damon_lock);
+	if (atomic_read(&nr_running_ctxs))
 		return -EBUSY;
-	}
 
 	for (i = 0; i < nr_ctxs; i++) {
 		err = __damon_start(ctxs[i]);
 		if (err)
 			break;
-		nr_running_ctxs++;
+		atomic_inc(&nr_running_ctxs);
 	}
-	mutex_unlock(&damon_lock);
 
 	return err;
 }
@@ -1078,9 +1059,7 @@ static int kdamond_fn(void *data)
 	ctx->kdamond = NULL;
 	mutex_unlock(&ctx->kdamond_lock);
 
-	mutex_lock(&damon_lock);
-	nr_running_ctxs--;
-	mutex_unlock(&damon_lock);
+	atomic_dec(&nr_running_ctxs);
 
 	return 0;
 }
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index eccc14b34901..7182a46f6a2a 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -20,6 +20,8 @@ static int dbgfs_nr_ctxs;
 static struct dentry **dbgfs_dirs;
 static DEFINE_MUTEX(damon_dbgfs_lock);
 
+extern atomic_t nr_running_ctxs;
+
 /*
  * Returns non-empty string on success, negative error code otherwise.
  */
@@ -688,7 +690,7 @@ static int dbgfs_mk_context(char *name)
 	struct dentry *root, **new_dirs, *new_dir;
 	struct damon_ctx **new_ctxs, *new_ctx;
 
-	if (damon_nr_running_ctxs())
+	if (atomic_read(&nr_running_ctxs))
 		return -EBUSY;
 
 	new_ctxs = krealloc(dbgfs_ctxs, sizeof(*dbgfs_ctxs) *
@@ -772,7 +774,7 @@ static int dbgfs_rm_context(char *name)
 	struct damon_ctx **new_ctxs;
 	int i, j;
 
-	if (damon_nr_running_ctxs())
+	if (atomic_read(&nr_running_ctxs))
 		return -EBUSY;
 
 	root = dbgfs_dirs[0];
@@ -853,7 +855,7 @@ static ssize_t dbgfs_monitor_on_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
 	char monitor_on_buf[5];
-	bool monitor_on = damon_nr_running_ctxs() != 0;
+	bool monitor_on = atomic_read(&nr_running_ctxs) != 0;
 	int len;
 
 	len = scnprintf(monitor_on_buf, 5, monitor_on ? "on\n" : "off\n");
-- 
2.25.1

