Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FFA3C706C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhGMMhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbhGMMhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:37:23 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A728FC0613DD;
        Tue, 13 Jul 2021 05:34:32 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r17so5524013qtp.5;
        Tue, 13 Jul 2021 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CAWyn55jAy6QBa0v4wXy3wf41ZbR52B5jAw9LOUZo/A=;
        b=cFLUlhaUOiTXGEgpOnuV1D0JZLj6MH6cHinbGi/Gp3GPxpCAAuVaoEEBwMax5wpzli
         fELR3QtP2yWgOcxhG1tdyQf1bzlqlzPdPCfr+RoWC+Qvs0lYa48dCEJLuQAodN1YgssK
         7/UnnCMdLJ8yLt7Nmir9nshX8oNZS1qJeCA4kOAHPdgeucVIQE1tIa7NCVLLOPY8xC5/
         yImbX0iQYI+f1glE/aue71QBof4G1GUG9oCmDVbZogzOccfv1Q39XHLptwQRPnLrRQWJ
         8u9WMOy9Ecu8ggLZpHBtQ4upUYCARt3GjQ39S+kS/dkSP3Jj/CjcgbSXIObFeAhOBtdn
         SOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CAWyn55jAy6QBa0v4wXy3wf41ZbR52B5jAw9LOUZo/A=;
        b=d23hTGUiC7FP5r3pNF8y8xPj495rcjhiucZ3C9kKu5SV4BuDIyT4lRCbNoYP18RZmf
         JnQ5xb9TTgoPt+3bn1lRBHSVAGDk5g18fg3LR9T7O5425A+eSbRAK7GceR20LYlSgozd
         3qpGRiR8CfuInvNZjvQa3m4A42oTrQSNrJ8HChy7EyxU2Bjyfyjakl+jbp0UXK6duWdL
         TP0bYWZxkHCGqyoDuh0ArrETHa/qc6zJD+NvcKFRAMOjb7+5YXEevJ9g+z7sTdd4bSs1
         lp0U/GEWvltSOjHDBLQKd4p3qk7KcmuBJ4q3zaa3KzXYRgj0RZKHMyXQOZCkpJsUKf/n
         teag==
X-Gm-Message-State: AOAM533LUS55WhEhID7Ixa33BBnZMesRU6g2zZUuriDurd15xDNOYfcc
        2Ll7RjVZHqqvQKCcDNrh3uI=
X-Google-Smtp-Source: ABdhPJwdssHK/Qhn87+nRgBiH9d2OsAsOlF/tUgVpCxcITnqHbqDyVAhGOkzaqBQGhxlbjCC1GT24Q==
X-Received: by 2002:ac8:6d0:: with SMTP id j16mr3841743qth.331.1626179671875;
        Tue, 13 Jul 2021 05:34:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id k14sm6849327qtm.18.2021.07.13.05.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:34:31 -0700 (PDT)
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
Subject: [PATCH v33 08/13] mm/damon/dbgfs: Export kdamond pid to the user space
Date:   Tue, 13 Jul 2021 12:33:51 +0000
Message-Id: <20210713123356.6924-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210713123356.6924-1-sj38.park@gmail.com>
References: <20210713123356.6924-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

For CPU usage accounting, knowing pid of the monitoring thread could be
helpful.  For example, users could use cpuaccount cgroups with the pid.

This commit therefore exports the pid of currently running monitoring
thread to the user space via 'kdamond_pid' file in the debugfs
directory.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Fernand Sieber <sieberf@amazon.com>
---
 mm/damon/dbgfs.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 322f624710d7..bd9bc6ede40e 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -237,6 +237,32 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	return ret;
 }
 
+static ssize_t dbgfs_kdamond_pid_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
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
+	if (ctx->kdamond)
+		len = scnprintf(kbuf, count, "%d\n", ctx->kdamond->pid);
+	else
+		len = scnprintf(kbuf, count, "none\n");
+	mutex_unlock(&ctx->kdamond_lock);
+	if (!len)
+		goto out;
+	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
+
+out:
+	kfree(kbuf);
+	return len;
+}
+
 static int damon_dbgfs_open(struct inode *inode, struct file *file)
 {
 	file->private_data = inode->i_private;
@@ -256,10 +282,17 @@ static const struct file_operations target_ids_fops = {
 	.write = dbgfs_target_ids_write,
 };
 
+static const struct file_operations kdamond_pid_fops = {
+	.open = damon_dbgfs_open,
+	.read = dbgfs_kdamond_pid_read,
+};
+
 static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 {
-	const char * const file_names[] = {"attrs", "target_ids"};
-	const struct file_operations *fops[] = {&attrs_fops, &target_ids_fops};
+	const char * const file_names[] = {"attrs", "target_ids",
+		"kdamond_pid"};
+	const struct file_operations *fops[] = {&attrs_fops, &target_ids_fops,
+		&kdamond_pid_fops};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(file_names); i++)
-- 
2.17.1

