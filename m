Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CED34E3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhC3JGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhC3JGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:06:14 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10FCC061762;
        Tue, 30 Mar 2021 02:06:13 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id q12so7770513qvc.8;
        Tue, 30 Mar 2021 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W8+A/g3U4DodIE6llQ+hDjB/HFXop9Ja1bxfrVH/yAg=;
        b=LDQ5ryqtA8+D9rvRlvwrCBUAU0iQ3DGAgoZZqK1NpuLn97qOrBSIzELw0Lsk4PMh2J
         YPn3tbyXz1dWsFW41ERB1doJxXDTcAysZ0esZ0I3qoCfOpUiwCsTX5Z4tp/84rn3gU79
         RlZO9tKkbm5VXJ12j0r2R/fKiMQsAa/yGzbwXdZOyrVXUynjeeHkQbZC7mF394hdcQzw
         INvk6RcEvBT4xIvknE4BhG6uXMRYYQ9vrUAMEsi3V3sEHZzu4sRIY9qfZJu5SQ7BeJ8n
         Mriq6Cz5bTN9w4gnkyA3HqDv747mIwXOMBPhPGIg7q1qAifafpDFT2drWLnccC8ERrT6
         dpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W8+A/g3U4DodIE6llQ+hDjB/HFXop9Ja1bxfrVH/yAg=;
        b=Z3h5Cs3VQa+9T+n4TxUzMDSb82PBfEEsC5Z8GqXBG8wJ6/fL8NZy437UY0qN3pL83w
         nz90fTllTW8xrpr1zIp3cSLknZ98C0RnuJcRRuEfH41fn++HdI4zRwc6+n5IGtlEIaFW
         oiOT5Vu5d3lEa9GgQFVnyVbJzbV1wykF8amVJNkVF/iNLwRGtVyWac0XG8WQxdqzNOcS
         m/Zeg9Rq6LDppmlJ3j4WXIowonnEWjgRAiXASTgSyyae3m72BU57IJT7w67myjLBrkj7
         9gpaClOoTbS2UxEuLzG/QEqJpCFT6c24Ionud7Tvcw8EE/cG91FPZqxZuHEGSzGqf00E
         YDbw==
X-Gm-Message-State: AOAM533i1JjbSBAB/pYKTWOINOtLB10m3VUzrclWG6gtcXO8Q/txQ8v4
        xN16iIaAEo8Ch8zDxmJtZ8k=
X-Google-Smtp-Source: ABdhPJyRjGTqSUKlNYgNG0XLD2eSfgVel59IOpaSZRQui14bQKl5x8NUFOtRE5FhU9EtAvVW+YI1+w==
X-Received: by 2002:a05:6214:906:: with SMTP id dj6mr23121183qvb.38.1617095173219;
        Tue, 30 Mar 2021 02:06:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 8sm14630011qkc.32.2021.03.30.02.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:06:12 -0700 (PDT)
From:   sj38.park@gmail.com
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
Subject: [PATCH v26 08/13] mm/damon/dbgfs: Export kdamond pid to the user space
Date:   Tue, 30 Mar 2021 09:05:32 +0000
Message-Id: <20210330090537.12143-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330090537.12143-1-sj38.park@gmail.com>
References: <20210330090537.12143-1-sj38.park@gmail.com>
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
index 02b27be9187a..aec2b7d81809 100644
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
 static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
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

