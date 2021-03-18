Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD73402E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhCRKK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCRKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:10:21 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC18C06174A;
        Thu, 18 Mar 2021 03:10:20 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h7so3601387qtx.3;
        Thu, 18 Mar 2021 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aKeb3fcwK9W0TVkoKsvlqPl7wq54ptWNz0E2zQWWcJc=;
        b=ShHum+5ovOm1NJ5iEw76D05I7655PcHacbwu/axeF0GnGmE8sxVFRes9jy3I3K3HnZ
         HpedKe/ABKMbLwgctO52RI9kdcG/V3nG+uBm/nJlutYEHfzGnk+mz9fteZvA6UvPqPq9
         zLZcqsIzUXZe6RGjaySBjPO5qhf14Cbt1dtFIAYHztVnDnDNAmumH4nL3cKC1irLCybu
         2nO+WPf49E1rvE7qxJRfO1W+pypXbbt2isZN0Bz4tfRlgIFvAl5YNkpqQ67OmZHLWRIt
         7cpSGW1pX+hPFY7xtxUWHBIOTRsZFmMNggeiBBlUs7a5U70e+iJFomw3xKWn43BIbkEb
         /toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aKeb3fcwK9W0TVkoKsvlqPl7wq54ptWNz0E2zQWWcJc=;
        b=hVZcByFWEhE9HsUaMImnk83SMMoPNwTuZBPaGTbF545EpBIQkSeNmYFMrOeqWUwKJf
         sId7D8UICnm/Gk4nSfJNULxMLYqm0gPEzehk283SwqD+8rZ5zq1l9Xb9Z6aNKpjI0UoO
         WKLG468C+C2kM53P+TOEwQe7yuBEQ0k892M0TOtnrz0a9Byh09A/h/AN5c+qo7qvmUWg
         teQaV/SKuMuzRpqR67sIU/2MD2YmeJ4LfxQjVVwSUDwnfNVRgXTB6I8JB02ptcAq8Ck2
         a9Oq9dJ/cTrLfknyAmYhmXeVVQtmaYQJtReAR3rLW926sb8SLFZuu4juI/pa7LnGSFSm
         ysnw==
X-Gm-Message-State: AOAM530wXBXzxLENayrB60rg5ElUFh/Cr0AqiV+L/dnaUnHWA4Cnq6DK
        OX15iSf8zIlbsvTqzTQUOhc=
X-Google-Smtp-Source: ABdhPJwedHgK+H4l2ncmYruYsBfxcLCyzW+a5kzlNCuxgbraegwwPej5zrsd2zBl+nZeBcT8NLbDuA==
X-Received: by 2002:ac8:4314:: with SMTP id z20mr2976539qtm.127.1616062219573;
        Thu, 18 Mar 2021 03:10:19 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id d16sm1358101qka.43.2021.03.18.03.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:10:19 -0700 (PDT)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, gthelen@google.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v25 09/13] mm/damon/dbgfs: Support multiple contexts
Date:   Thu, 18 Mar 2021 10:08:52 +0000
Message-Id: <20210318100856.34715-10-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318100856.34715-1-sj38.park@gmail.com>
References: <20210318100856.34715-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

In some use cases, users would want to run multiple monitoring context.
For example, if a user wants a high precision monitoring and dedicating
multiple CPUs for the job is ok, because DAMON creates one monitoring
thread per one context, the user can split the monitoring target regions
into multiple small regions and create one context for each region.  Or,
someone might want to simultaneously monitor different address spaces,
e.g., both virtual address space and physical address space.

The DAMON's API allows such usage, but 'damon-dbgfs' does not.
Therefore, only kernel space DAMON users can do multiple contexts
monitoring.

This commit allows the user space DAMON users to use multiple contexts
monitoring by introducing two new 'damon-dbgfs' debugfs files,
'mk_context' and 'rm_context'.  Users can create a new monitoring
context by writing the desired name of the new context to 'mk_context'.
Then, a new directory with the name and having the files for setting of
the context ('attrs', 'target_ids' and 'record') will be created under
the debugfs directory.  Writing the name of the context to remove to
'rm_context' will remove the related context and directory.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index aec2b7d81809..9edef931ed00 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -18,6 +18,7 @@
 static struct damon_ctx **dbgfs_ctxs;
 static int dbgfs_nr_ctxs;
 static struct dentry **dbgfs_dirs;
+static DEFINE_MUTEX(damon_dbgfs_lock);
 
 /*
  * Returns non-empty string on success, negarive error code otherwise.
@@ -316,6 +317,192 @@ static struct damon_ctx *dbgfs_new_ctx(void)
 	return ctx;
 }
 
+static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
+{
+	damon_destroy_ctx(ctx);
+}
+
+/*
+ * Make a context of @name and create a debugfs directory for it.
+ *
+ * This function should be called while holding damon_dbgfs_lock.
+ *
+ * Returns 0 on success, negative error code otherwise.
+ */
+static int dbgfs_mk_context(char *name)
+{
+	struct dentry *root, **new_dirs, *new_dir;
+	struct damon_ctx **new_ctxs, *new_ctx;
+	int err;
+
+	if (damon_nr_running_ctxs())
+		return -EBUSY;
+
+	new_ctxs = krealloc(dbgfs_ctxs, sizeof(*dbgfs_ctxs) *
+			(dbgfs_nr_ctxs + 1), GFP_KERNEL);
+	if (!new_ctxs)
+		return -ENOMEM;
+
+	new_dirs = krealloc(dbgfs_dirs, sizeof(*dbgfs_dirs) *
+			(dbgfs_nr_ctxs + 1), GFP_KERNEL);
+	if (!new_dirs) {
+		kfree(new_ctxs);
+		return -ENOMEM;
+	}
+
+	dbgfs_ctxs = new_ctxs;
+	dbgfs_dirs = new_dirs;
+
+	root = dbgfs_dirs[0];
+	if (!root)
+		return -ENOENT;
+
+	new_dir = debugfs_create_dir(name, root);
+	dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;
+
+	new_ctx = dbgfs_new_ctx();
+	if (!new_ctx) {
+		debugfs_remove(new_dir);
+		dbgfs_dirs[dbgfs_nr_ctxs] = NULL;
+		return -ENOMEM;
+	}
+	dbgfs_ctxs[dbgfs_nr_ctxs] = new_ctx;
+
+	err = dbgfs_fill_ctx_dir(dbgfs_dirs[dbgfs_nr_ctxs],
+			dbgfs_ctxs[dbgfs_nr_ctxs]);
+	if (err)
+		return err;
+
+	dbgfs_nr_ctxs++;
+	return 0;
+}
+
+static ssize_t dbgfs_mk_context_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	char *kbuf;
+	char *ctx_name;
+	ssize_t ret = count;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+	ctx_name = kmalloc(count + 1, GFP_KERNEL);
+	if (!ctx_name) {
+		kfree(kbuf);
+		return -ENOMEM;
+	}
+
+	/* Trim white space */
+	if (sscanf(kbuf, "%s", ctx_name) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&damon_dbgfs_lock);
+	err = dbgfs_mk_context(ctx_name);
+	if (err)
+		ret = err;
+	mutex_unlock(&damon_dbgfs_lock);
+
+out:
+	kfree(kbuf);
+	kfree(ctx_name);
+	return ret;
+}
+
+/*
+ * Remove a context of @name and its debugfs directory.
+ *
+ * This function should be called while holding damon_dbgfs_lock.
+ *
+ * Return 0 on success, negative error code otherwise.
+ */
+static int dbgfs_rm_context(char *name)
+{
+	struct dentry *root, *dir, **new_dirs;
+	struct damon_ctx **new_ctxs;
+	int i, j;
+
+	if (damon_nr_running_ctxs())
+		return -EBUSY;
+
+	root = dbgfs_dirs[0];
+	if (!root)
+		return -ENOENT;
+
+	dir = debugfs_lookup(name, root);
+	if (!dir)
+		return -ENOENT;
+
+	new_dirs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_dirs),
+			GFP_KERNEL);
+	if (!new_dirs)
+		return -ENOMEM;
+
+	new_ctxs = kmalloc_array(dbgfs_nr_ctxs - 1, sizeof(*dbgfs_ctxs),
+			GFP_KERNEL);
+	if (!new_ctxs) {
+		kfree(new_dirs);
+		return -ENOMEM;
+	}
+
+	for (i = 0, j = 0; i < dbgfs_nr_ctxs; i++) {
+		if (dbgfs_dirs[i] == dir) {
+			debugfs_remove(dbgfs_dirs[i]);
+			dbgfs_destroy_ctx(dbgfs_ctxs[i]);
+			continue;
+		}
+		new_dirs[j] = dbgfs_dirs[i];
+		new_ctxs[j++] = dbgfs_ctxs[i];
+	}
+
+	kfree(dbgfs_dirs);
+	kfree(dbgfs_ctxs);
+
+	dbgfs_dirs = new_dirs;
+	dbgfs_ctxs = new_ctxs;
+	dbgfs_nr_ctxs--;
+
+	return 0;
+}
+
+static ssize_t dbgfs_rm_context_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	char *kbuf;
+	ssize_t ret = count;
+	int err;
+	char *ctx_name;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+	ctx_name = kmalloc(count + 1, GFP_KERNEL);
+	if (!ctx_name) {
+		kfree(kbuf);
+		return -ENOMEM;
+	}
+
+	/* Trim white space */
+	if (sscanf(kbuf, "%s", ctx_name) != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&damon_dbgfs_lock);
+	err = dbgfs_rm_context(ctx_name);
+	if (err)
+		ret = err;
+	mutex_unlock(&damon_dbgfs_lock);
+
+out:
+	kfree(kbuf);
+	kfree(ctx_name);
+	return ret;
+}
+
 static ssize_t dbgfs_monitor_on_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
@@ -358,6 +545,16 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 	return ret;
 }
 
+static const struct file_operations mk_contexts_fops = {
+	.owner = THIS_MODULE,
+	.write = dbgfs_mk_context_write,
+};
+
+static const struct file_operations rm_contexts_fops = {
+	.owner = THIS_MODULE,
+	.write = dbgfs_rm_context_write,
+};
+
 static const struct file_operations monitor_on_fops = {
 	.owner = THIS_MODULE,
 	.read = dbgfs_monitor_on_read,
@@ -367,8 +564,10 @@ static const struct file_operations monitor_on_fops = {
 static int __init __damon_dbgfs_init(void)
 {
 	struct dentry *dbgfs_root;
-	const char * const file_names[] = {"monitor_on"};
-	const struct file_operations *fops[] = {&monitor_on_fops};
+	const char * const file_names[] = {"mk_contexts", "rm_contexts",
+		"monitor_on"};
+	const struct file_operations *fops[] = {&mk_contexts_fops,
+		&rm_contexts_fops, &monitor_on_fops};
 	int i;
 
 	dbgfs_root = debugfs_create_dir("damon", NULL);
-- 
2.17.1

