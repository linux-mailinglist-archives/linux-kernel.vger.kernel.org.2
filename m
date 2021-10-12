Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6957E42AE47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhJLU7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbhJLU73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:59:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD65060D07;
        Tue, 12 Oct 2021 20:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634072247;
        bh=3PqXsZtkDqPckt18caPVvmKI6pnv8yKy72GqUMz8y1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2HM9D7RGLVEbsY3gjf06LpPghM/KDfSHfShWw7nUtGX6r9M5ND9GyYPQpBWKbclN
         CZiEBOMh5sMmb3O9PU4sqPANfvmuml0QAqufmasB+xM43RrZ9zuOzWMLmo/teEEdTI
         qNopwQ3RSHd6qOTFqY+yLoqZw/n6qAXHbWm3XcYWeNFX6mzJ0SW+RqNCh7W6DMcdxS
         mc2K+oW6sPQVskYSxcj08xLEfcEI8Ynnty4jWOkLpWTpSMTdH+GV+WZNx1cuoOP2Zu
         9Bd/YimBc5BwUvYBN2PUreTTbDq+W4CLndJy53qMaYSIPzKvZm9WyF4RLaUFoQjtIT
         sxfReQ5HVavQQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mm/damon/dbgfs: Allow users to set initial monitoring target regions
Date:   Tue, 12 Oct 2021 20:57:05 +0000
Message-Id: <20211012205711.29216-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012205711.29216-1-sj@kernel.org>
References: <20211012205711.29216-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some 'damon-dbgfs' users would want to monitor only a part of the entire
virtual memory address space.  The program interface users in the kernel
space could use '->before_start()' callback or set the regions inside
the context struct as they want, but 'damon-dbgfs' users cannot.

For the reason, this commit introduces a new debugfs file called
'init_region'.  'damon-dbgfs' users can specify which initial monitoring
target address regions they want by writing special input to the file.
The input should describe each region in each line in the below form:

    <pid> <start address> <end address>

Note that the regions will be updated to cover entire memory mapped
regions after a 'regions update interval' is passed.  If you want the
regions to not be updated after the initial setting, you could set the
interval as a very long time, say, a few decades.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 28d6abf27763..1cce53cd241d 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -394,6 +394,152 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	return ret;
 }
 
+static ssize_t sprint_init_regions(struct damon_ctx *c, char *buf, ssize_t len)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	int written = 0;
+	int rc;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t) {
+			rc = scnprintf(&buf[written], len - written,
+					"%lu %lu %lu\n",
+					t->id, r->ar.start, r->ar.end);
+			if (!rc)
+				return -ENOMEM;
+			written += rc;
+		}
+	}
+	return written;
+}
+
+static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	char *kbuf;
+	ssize_t len;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		mutex_unlock(&ctx->kdamond_lock);
+		len = -EBUSY;
+		goto out;
+	}
+
+	len = sprint_init_regions(ctx, kbuf, count);
+	mutex_unlock(&ctx->kdamond_lock);
+	if (len < 0)
+		goto out;
+	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
+
+out:
+	kfree(kbuf);
+	return len;
+}
+
+static int add_init_region(struct damon_ctx *c,
+			 unsigned long target_id, struct damon_addr_range *ar)
+{
+	struct damon_target *t;
+	struct damon_region *r, *prev;
+	unsigned long id;
+	int rc = -EINVAL;
+
+	if (ar->start >= ar->end)
+		return -EINVAL;
+
+	damon_for_each_target(t, c) {
+		id = t->id;
+		if (targetid_is_pid(c))
+			id = (unsigned long)pid_vnr((struct pid *)id);
+		if (id == target_id) {
+			r = damon_new_region(ar->start, ar->end);
+			if (!r)
+				return -ENOMEM;
+			damon_add_region(r, t);
+			if (damon_nr_regions(t) > 1) {
+				prev = damon_prev_region(r);
+				if (prev->ar.end > r->ar.start) {
+					damon_destroy_region(r, t);
+					return -EINVAL;
+				}
+			}
+			rc = 0;
+		}
+	}
+	return rc;
+}
+
+static int set_init_regions(struct damon_ctx *c, const char *str, ssize_t len)
+{
+	struct damon_target *t;
+	struct damon_region *r, *next;
+	int pos = 0, parsed, ret;
+	unsigned long target_id;
+	struct damon_addr_range ar;
+	int err;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r, t);
+	}
+
+	while (pos < len) {
+		ret = sscanf(&str[pos], "%lu %lu %lu%n",
+				&target_id, &ar.start, &ar.end, &parsed);
+		if (ret != 3)
+			break;
+		err = add_init_region(c, target_id, &ar);
+		if (err)
+			goto fail;
+		pos += parsed;
+	}
+
+	return 0;
+
+fail:
+	damon_for_each_target(t, c) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r, t);
+	}
+	return err;
+}
+
+static ssize_t dbgfs_init_regions_write(struct file *file,
+					  const char __user *buf, size_t count,
+					  loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	char *kbuf;
+	ssize_t ret = count;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	err = set_init_regions(ctx, kbuf, ret);
+	if (err)
+		ret = err;
+
+unlock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+	kfree(kbuf);
+	return ret;
+}
+
 static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
@@ -445,6 +591,12 @@ static const struct file_operations target_ids_fops = {
 	.write = dbgfs_target_ids_write,
 };
 
+static const struct file_operations init_regions_fops = {
+	.open = damon_dbgfs_open,
+	.read = dbgfs_init_regions_read,
+	.write = dbgfs_init_regions_write,
+};
+
 static const struct file_operations kdamond_pid_fops = {
 	.open = damon_dbgfs_open,
 	.read = dbgfs_kdamond_pid_read,
@@ -453,9 +605,9 @@ static const struct file_operations kdamond_pid_fops = {
 static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 {
 	const char * const file_names[] = {"attrs", "schemes", "target_ids",
-		"kdamond_pid"};
+		"init_regions", "kdamond_pid"};
 	const struct file_operations *fops[] = {&attrs_fops, &schemes_fops,
-		&target_ids_fops, &kdamond_pid_fops};
+		&target_ids_fops, &init_regions_fops, &kdamond_pid_fops};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(file_names); i++)
-- 
2.17.1

