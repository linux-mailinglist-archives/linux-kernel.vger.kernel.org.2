Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A83CB3FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhGPITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbhGPITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:19:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144CDC06175F;
        Fri, 16 Jul 2021 01:16:09 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c68so3193075qkf.9;
        Fri, 16 Jul 2021 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CAWyn55jAy6QBa0v4wXy3wf41ZbR52B5jAw9LOUZo/A=;
        b=UPauRKvaVrm8Wz9f+ZaTLFzWpeDFDkupScmml1EHw9Dasnz3C4Wbmys3sZzSWrlM1D
         rmxLeqR1QC76QMI8zkye6C7QbV2m9SVX0EiagNjrt5dYv9TDfKmIf38nuMNef9Ozu4BH
         XOlPHsJ/10x+OqgjqVDjqEFPORhItfG5Rapbdw2TS8krNJBaIAuSoPo/FpDPi6qNzEW3
         uCA1PMPcE0UDka3THGs3/pLhboNeZiZRmEP9sHs554hhM21XQao0mFsUr5EjP9nROzrI
         ky9A4u23aIE4hfewucmj5CxrERXPoF50/+n8cDZZt6OFBfMiquYm6jAIzElEuoLDe9pN
         h7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CAWyn55jAy6QBa0v4wXy3wf41ZbR52B5jAw9LOUZo/A=;
        b=Q/tw7xMH6uIkzfSMar7vgF7qsgDinpM86984MfZEXP9qR2NrQOFGMzdRtX9NK7wTC2
         zIs/rjGOZf39US3c8spmqHIG0/LprhZFRkrx27UaRl4EBk3Dwtxba9mSxhDBZ1EVnpcE
         roB4WnUp7J/G66SnDvrV9q7BkTHsgAUDpTtN5j5HDK6YJ/SlECfZTONCFRXNBg7Rupj6
         KjvIgdJr5KZiM8ewSMcgSMzqoxvTj0eBoYsFDdBwHAeEdqRobXcZUyw8eBblX4AfHuB2
         4Wflm42C1dbRS772IgqFFm/YEo7eIO6LnECLdWW2/SXxIyhmG4iIJ4Ji6D84x3gwQpQk
         //3Q==
X-Gm-Message-State: AOAM5338RJpI8kIEHLNM4yKVmeWdFpfdQJzqhpcHN3cz3a10dJgmxIux
        Hb6EYuEsNJcFkHgG/7e5sQ4=
X-Google-Smtp-Source: ABdhPJz2G0AHGFnY/YIjOTEzIJuHfL8D2qUXRsPL5wf4WHhVu3rDxZu2pn1Zm4wZAQb5fEU6Ss4cxw==
X-Received: by 2002:a37:a252:: with SMTP id l79mr8518813qke.128.1626423368263;
        Fri, 16 Jul 2021 01:16:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id c22sm2868464qtd.42.2021.07.16.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:16:07 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v34 08/13] mm/damon/dbgfs: Export kdamond pid to the user space
Date:   Fri, 16 Jul 2021 08:14:44 +0000
Message-Id: <20210716081449.22187-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210716081449.22187-1-sj38.park@gmail.com>
References: <20210716081449.22187-1-sj38.park@gmail.com>
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

