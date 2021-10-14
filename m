Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07BA42D3A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhJNHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhJNHcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:32:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D7D660FDA;
        Thu, 14 Oct 2021 07:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634196617;
        bh=7fbS2G9SSp+dZHJvHhEqa/tHkvS+Oa6iHxmA/f692NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLHXJu6sO6g4qwF5lshM/XoquExgXy8p95PG0eYZSVlxtxbL4CaCT03Ttoy95Ns6f
         +jvHzF7ouE8D70qdfwDz9TQ6RjnIbpwPHCqbRTYsOIXWiR7zCjadpRI9lLRtwpR9s2
         Z7vs9pyvUGs0Gfi4vIeTmJPJBLnDsgTPkNDfpKGV7cN+oJbn0mM62mKiWU6VEM5JoJ
         cxMZPVlS0iTLPcnxdrXKMXKnmh+S4sDheFuoTAWmmfxHmMNF5pZ7m91AX09xvzXrR2
         gYpCgJ8nQcV466Dm8TFystxIAQ6GHpZkBqrpPtjtoQ8JLCVjBsnMU/YkYQI1wGz6H4
         ZGIHX6OCkRJgg==
From:   SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v3] mm/damon/dbgfs: remove unnecessary variables
Date:   Thu, 14 Oct 2021 07:30:14 +0000
Message-Id: <20211014073014.35754-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014072158.35478-1-sj@kernel.org>
References: <20211014072158.35478-1-sj@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rongwei Wang <rongwei.wang@linux.alibaba.com>

In some functions, it's unnecessary to declare 'err'
and 'ret' variables at the same time. This patch mainly
to simplify the issue of such declarations by reusing
one variable.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v2
(https://lore.kernel.org/linux-mm/20211014020333.10330-1-rongwei.wang@linux.alibaba.com/)
- Rebased on latest -mm tree (v5.15-rc5-mmots-2021-10-13-19-55)

 mm/damon/dbgfs.c | 66 +++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 38188347d8ab..c90988a20fa4 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -69,8 +69,7 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 	struct damon_ctx *ctx = file->private_data;
 	unsigned long s, a, r, minr, maxr;
 	char *kbuf;
-	ssize_t ret = count;
-	int err;
+	ssize_t ret;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
@@ -88,9 +87,9 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 		goto unlock_out;
 	}
 
-	err = damon_set_attrs(ctx, s, a, r, minr, maxr);
-	if (err)
-		ret = err;
+	ret = damon_set_attrs(ctx, s, a, r, minr, maxr);
+	if (!ret)
+		ret = count;
 unlock_out:
 	mutex_unlock(&ctx->kdamond_lock);
 out:
@@ -220,14 +219,13 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 	struct damon_ctx *ctx = file->private_data;
 	char *kbuf;
 	struct damos **schemes;
-	ssize_t nr_schemes = 0, ret = count;
-	int err;
+	ssize_t nr_schemes = 0, ret;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
-	schemes = str_to_schemes(kbuf, ret, &nr_schemes);
+	schemes = str_to_schemes(kbuf, count, &nr_schemes);
 	if (!schemes) {
 		ret = -EINVAL;
 		goto out;
@@ -239,11 +237,12 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 		goto unlock_out;
 	}
 
-	err = damon_set_schemes(ctx, schemes, nr_schemes);
-	if (err)
-		ret = err;
-	else
+	ret = damon_set_schemes(ctx, schemes, nr_schemes);
+	if (!ret) {
+		ret = count;
 		nr_schemes = 0;
+	}
+
 unlock_out:
 	mutex_unlock(&ctx->kdamond_lock);
 	free_schemes_arr(schemes, nr_schemes);
@@ -343,9 +342,8 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	char *kbuf, *nrs;
 	unsigned long *targets;
 	ssize_t nr_targets;
-	ssize_t ret = count;
+	ssize_t ret;
 	int i;
-	int err;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
@@ -358,7 +356,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		scnprintf(kbuf, count, "42    ");
 	}
 
-	targets = str_to_target_ids(nrs, ret, &nr_targets);
+	targets = str_to_target_ids(nrs, count, &nr_targets);
 	if (!targets) {
 		ret = -ENOMEM;
 		goto out;
@@ -393,11 +391,12 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	else
 		damon_pa_set_primitives(ctx);
 
-	err = damon_set_targets(ctx, targets, nr_targets);
-	if (err) {
+	ret = damon_set_targets(ctx, targets, nr_targets);
+	if (ret) {
 		if (id_is_pid)
 			dbgfs_put_pids(targets, nr_targets);
-		ret = err;
+	} else {
+		ret = count;
 	}
 
 unlock_out:
@@ -715,8 +714,7 @@ static ssize_t dbgfs_mk_context_write(struct file *file,
 {
 	char *kbuf;
 	char *ctx_name;
-	ssize_t ret = count;
-	int err;
+	ssize_t ret;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
@@ -734,9 +732,9 @@ static ssize_t dbgfs_mk_context_write(struct file *file,
 	}
 
 	mutex_lock(&damon_dbgfs_lock);
-	err = dbgfs_mk_context(ctx_name);
-	if (err)
-		ret = err;
+	ret = dbgfs_mk_context(ctx_name);
+	if (!ret)
+		ret = count;
 	mutex_unlock(&damon_dbgfs_lock);
 
 out:
@@ -805,8 +803,7 @@ static ssize_t dbgfs_rm_context_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	char *kbuf;
-	ssize_t ret = count;
-	int err;
+	ssize_t ret;
 	char *ctx_name;
 
 	kbuf = user_input_str(buf, count, ppos);
@@ -825,9 +822,9 @@ static ssize_t dbgfs_rm_context_write(struct file *file,
 	}
 
 	mutex_lock(&damon_dbgfs_lock);
-	err = dbgfs_rm_context(ctx_name);
-	if (err)
-		ret = err;
+	ret = dbgfs_rm_context(ctx_name);
+	if (!ret)
+		ret = count;
 	mutex_unlock(&damon_dbgfs_lock);
 
 out:
@@ -851,9 +848,8 @@ static ssize_t dbgfs_monitor_on_read(struct file *file,
 static ssize_t dbgfs_monitor_on_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
-	ssize_t ret = count;
+	ssize_t ret;
 	char *kbuf;
-	int err;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
@@ -866,14 +862,14 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 	}
 
 	if (!strncmp(kbuf, "on", count))
-		err = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
+		ret = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
 	else if (!strncmp(kbuf, "off", count))
-		err = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
+		ret = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
 	else
-		err = -EINVAL;
+		ret = -EINVAL;
 
-	if (err)
-		ret = err;
+	if (!ret)
+		ret = count;
 	kfree(kbuf);
 	return ret;
 }
-- 
2.17.1

