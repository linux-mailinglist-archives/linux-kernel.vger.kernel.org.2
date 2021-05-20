Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A44389F47
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhETH6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhETH6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:58:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909ECC061574;
        Thu, 20 May 2021 00:57:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id k127so15287565qkc.6;
        Thu, 20 May 2021 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eYTdxL2E49yq4b0Ub99eMeKNygqCtQlWSQ8UNjQ6vgA=;
        b=c9FVE5uwYIM3lXv+C3JpSBaly9KVd8wPMpzBIplRSw/HW329GASetd1p+9g0bO+5xY
         CynrJ0Yz0EpQvIKkuGI/tiweDmkLJL8+CCf7QuFITRsAzE9ee+E234Fpq/w81rGm7Cc7
         tay/NVe4d81fi9/3JXrH2XmjRFPXGxO4BhbrGIHaeUp1/Uw8RDNQ76w6EJPUBybImOwU
         01FwgIiDxlf2wkB0nhrrEFovmZ17UTDPBGR05jGl6dz+e5K5Y4UA/bIYa56c5sZ+hvSD
         czcLoKZIz/TqJzkTOmUvYKIfAb71jKyXHoEKkWC1+xhMrRs9ZHqT2OBB9MCbhkhw3RRx
         iq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eYTdxL2E49yq4b0Ub99eMeKNygqCtQlWSQ8UNjQ6vgA=;
        b=fT64ui7QvPVTqCfta/GE8QvkNFdUnU/iek8z3QRzb1ekxqIhCXQT7UFw9SM0VY1lf+
         6wJCoM4W0/BmyHvfPCTfvUrFCVdQMnnltk+AJDkMV7II1cshTirmmIcBVxy0+kJmhqsM
         HlqjX9+Z19CwsN8xoihcRghh3bGUqbNleCPf3ajxZmR+3BgSuO9L+fN9uk8mo8zZJvAB
         UupyDx1XbY50nGR9E1m7mAS19y3wN7hhTZPHibfrBMHQMQvrha/gT3SurVnUoEIj/w89
         3DaYp2/q2o5paRWuQv5tcv8v5JpVifR5MNhpI/0reb41Mg6HsN1wh06QliUNpC7RM5Mh
         dE9A==
X-Gm-Message-State: AOAM532Tb+Xr/YUHo/rHt1Vc1ZRtPIHZSylMcGYU3HujzixcQNh1PUwc
        rFCVbE1OivquRvyFbjkq40A=
X-Google-Smtp-Source: ABdhPJzpa41hVSwqynBA/vWcMdswyjw5aWK6S73xsrvkJYfnHfkiyS+tdMGNQVFSU0rk51h7lsgAXg==
X-Received: by 2002:a05:620a:21c5:: with SMTP id h5mr3410195qka.395.1621497422822;
        Thu, 20 May 2021 00:57:02 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g9sm1478254qka.38.2021.05.20.00.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:57:02 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v29 08/13] mm/damon/dbgfs: Export kdamond pid to the user space
Date:   Thu, 20 May 2021 07:56:24 +0000
Message-Id: <20210520075629.4332-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520075629.4332-1-sj38.park@gmail.com>
References: <20210520075629.4332-1-sj38.park@gmail.com>
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
---
 mm/damon/dbgfs.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 17c7878cfcb8..67b273472c0b 100644
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
@@ -258,10 +284,18 @@ static const struct file_operations target_ids_fops = {
 	.write = dbgfs_target_ids_write,
 };
 
+static const struct file_operations kdamond_pid_fops = {
+	.owner = THIS_MODULE,
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

