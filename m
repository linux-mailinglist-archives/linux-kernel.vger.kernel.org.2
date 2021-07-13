Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE83C706E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhGMMh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhGMMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:37:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58731C0613E9;
        Tue, 13 Jul 2021 05:34:35 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e14so21357972qkl.9;
        Tue, 13 Jul 2021 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fq1ZoPC42eMqWQGbnrLrlL4Ve1LVuhTF5O3t1T5h2G8=;
        b=YuwQmQtJ88AJlFtyI1LCVljSg6E07LaRuYVlwZ5OJOk3TlYjOtjJf7itBXLzrwkAYT
         C+GzGGo7b1zDbJ7YAsJs2BrdhES6wD2nL21Gz4qTJstQt0dihmapzk8kOyXynCk5XxQ/
         OpacN399XxccfhPWX91qwW3A5sIfiHxnaXGM8jHqbJsZR0QpGivLwEBdpc1okiZKvI4p
         mdVQw8g3xIWqn4ERh20NtleAwHmcvvQlBxIjfMPHcOPp/bNNYB+Yj5X2kSjYyMcmDSzQ
         3bUbK9Od2/LwkFjWZ/kkjpM7O6iY1OHaXQj4V0gnQoNeZU8gWTv8E4TqXO7SsCvnWHNK
         X/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fq1ZoPC42eMqWQGbnrLrlL4Ve1LVuhTF5O3t1T5h2G8=;
        b=pWCJFSd8mAzdgYOm7QQ4oPkle4+k9lwYt0/9dqs59NoSGpMDii8APk7AjuobKzyYGt
         6b8Da1YVzamv5smmDjDc/zeuqPoLw9KSlFtpipyMtprGjhssXXxAKHUKZcD2mEdGIFp1
         tJpSJT/dRcBkUAx162R3HiE8hch6wDyZOxa+oeKAcqILnf5jfjHBRU8mOGR+dTWTBVnD
         u2aD55FejBcanOjNDk+8wdbAHY1lUNgGVtsvpKTEZlKd/mMHccgCgHVNXl5u1wFVAmmZ
         YVoz03dlRDqFNCUCMMTA6P+clbukpDAeHxLDQRtj7rPAkRDzwZ6QOqgWUeG/SvGdxRwr
         6j0A==
X-Gm-Message-State: AOAM533TqhdOCR0HuCyzF5UPrgx/+qn9fHJzEKOFLKqG9mtVv46K0Zxf
        w0zGYJkR206Qexnpj2QqqgY=
X-Google-Smtp-Source: ABdhPJx9gXNs1xSlLOsJRh9/8megaYf36oIV7X2mMja4OYriBxNPtwN5mI5wwvZ36yyorEOx9CU1Jg==
X-Received: by 2002:ae9:f201:: with SMTP id m1mr3855046qkg.381.1626179674507;
        Tue, 13 Jul 2021 05:34:34 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id k14sm6849327qtm.18.2021.07.13.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:34:34 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v33 09/13] mm/damon/dbgfs: Support multiple contexts
Date:   Tue, 13 Jul 2021 12:33:52 +0000
Message-Id: <20210713123356.6924-10-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210713123356.6924-1-sj38.park@gmail.com>
References: <20210713123356.6924-1-sj38.park@gmail.com>
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
Reviewed-by: Fernand Sieber <sieberf@amazon.com>
---
 mm/damon/dbgfs.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 193 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index bd9bc6ede40e..cd2cc0a9c52a 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -18,6 +18,7 @@
 static struct damon_ctx **dbgfs_ctxs;
 static int dbgfs_nr_ctxs;
 static struct dentry **dbgfs_dirs;
+static DEFINE_MUTEX(damon_dbgfs_lock);
 
 /*
  * Returns non-empty string on success, negative error code otherwise.
@@ -326,6 +327,186 @@ static struct damon_ctx *dbgfs_new_ctx(void)
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
+
+	if (damon_nr_running_ctxs())
+		return -EBUSY;
+
+	new_ctxs = krealloc(dbgfs_ctxs, sizeof(*dbgfs_ctxs) *
+			(dbgfs_nr_ctxs + 1), GFP_KERNEL);
+	if (!new_ctxs)
+		return -ENOMEM;
+	dbgfs_ctxs = new_ctxs;
+
+	new_dirs = krealloc(dbgfs_dirs, sizeof(*dbgfs_dirs) *
+			(dbgfs_nr_ctxs + 1), GFP_KERNEL);
+	if (!new_dirs)
+		return -ENOMEM;
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
+
+	dbgfs_ctxs[dbgfs_nr_ctxs] = new_ctx;
+	dbgfs_fill_ctx_dir(dbgfs_dirs[dbgfs_nr_ctxs],
+			dbgfs_ctxs[dbgfs_nr_ctxs]);
+	dbgfs_nr_ctxs++;
+
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
@@ -368,6 +549,14 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 	return ret;
 }
 
+static const struct file_operations mk_contexts_fops = {
+	.write = dbgfs_mk_context_write,
+};
+
+static const struct file_operations rm_contexts_fops = {
+	.write = dbgfs_rm_context_write,
+};
+
 static const struct file_operations monitor_on_fops = {
 	.read = dbgfs_monitor_on_read,
 	.write = dbgfs_monitor_on_write,
@@ -376,8 +565,10 @@ static const struct file_operations monitor_on_fops = {
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

