Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D565342D02C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhJNCFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:05:41 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40267 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbhJNCFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:05:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UrjbVWe_1634177013;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UrjbVWe_1634177013)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Oct 2021 10:03:34 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mm/damon/dbgfs: remove unnecessary variables
Date:   Thu, 14 Oct 2021 10:03:33 +0800
Message-Id: <20211014020333.10330-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some functions, it's unnecessary to declare 'err'
and 'ret' variables at the same time. This patch mainly
to simplify the issue of such declarations by reusing
one variable.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/damon/dbgfs.c | 66 +++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 28d6abf27763..5cd4932800df 100644
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
@@ -342,9 +341,8 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	char *kbuf, *nrs;
 	unsigned long *targets;
 	ssize_t nr_targets;
-	ssize_t ret = count;
+	ssize_t ret;
 	int i;
-	int err;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
@@ -352,7 +350,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 
 	nrs = kbuf;
 
-	targets = str_to_target_ids(nrs, ret, &nr_targets);
+	targets = str_to_target_ids(nrs, count, &nr_targets);
 	if (!targets) {
 		ret = -ENOMEM;
 		goto out;
@@ -378,11 +376,12 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		goto unlock_out;
 	}
 
-	err = damon_set_targets(ctx, targets, nr_targets);
-	if (err) {
+	ret = damon_set_targets(ctx, targets, nr_targets);
+	if (ret) {
 		if (targetid_is_pid(ctx))
 			dbgfs_put_pids(targets, nr_targets);
-		ret = err;
+	} else {
+		ret = count;
 	}
 
 unlock_out:
@@ -548,8 +547,7 @@ static ssize_t dbgfs_mk_context_write(struct file *file,
 {
 	char *kbuf;
 	char *ctx_name;
-	ssize_t ret = count;
-	int err;
+	ssize_t ret;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
@@ -567,9 +565,9 @@ static ssize_t dbgfs_mk_context_write(struct file *file,
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
@@ -638,8 +636,7 @@ static ssize_t dbgfs_rm_context_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	char *kbuf;
-	ssize_t ret = count;
-	int err;
+	ssize_t ret;
 	char *ctx_name;
 
 	kbuf = user_input_str(buf, count, ppos);
@@ -658,9 +655,9 @@ static ssize_t dbgfs_rm_context_write(struct file *file,
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
@@ -684,9 +681,8 @@ static ssize_t dbgfs_monitor_on_read(struct file *file,
 static ssize_t dbgfs_monitor_on_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
-	ssize_t ret = count;
+	ssize_t ret;
 	char *kbuf;
-	int err;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
@@ -699,14 +695,14 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
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
2.27.0

