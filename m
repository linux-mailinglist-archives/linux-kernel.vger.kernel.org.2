Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52033B5F11
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhF1Nhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhF1Ngz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:36:55 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838B9C0617AD;
        Mon, 28 Jun 2021 06:34:24 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id m15so9249067qvc.9;
        Mon, 28 Jun 2021 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CAWyn55jAy6QBa0v4wXy3wf41ZbR52B5jAw9LOUZo/A=;
        b=kIcRh7x9aQX1Emh5uZOc0m78Vl92vPe4ntdpd3HoWIvSyPxJbZV3BAOKerbKtDXbof
         T+hYR1crjkcm/BYbVegDOGPbQm9smcnXKHeVQVUw9B4Ic4fmQkAk3ZM5RMl8HwcZSRw0
         +KUX2Zch+ZHl4irFXh2ZeZ9YdYVpCy59KyL0Hmu9I2cJNSkTzSGDGsmHgj+iMFODpggB
         qc/WShrHochc7tpYIDDcA7QB/JzHHoDiE0mA2i4TXrRjOOwqUfVsjMP8b83zxfgVOBA1
         7P9yJ4CC1BjOcoYEphBczX2Y2+NqyHMpqqTh2migXmQ+oXUtM2UYaTajAjN4/Bqmi/AP
         PLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CAWyn55jAy6QBa0v4wXy3wf41ZbR52B5jAw9LOUZo/A=;
        b=lmf7VI6Pfjm0D8TRoM3t3OlVjuZDjCYex5UUodex4zQdlur1iBkFaZpu8vRPe8/JKQ
         BgtlpKB8tgIawC/3ZNpLbgYMMM0QK2h/WQjuZIVaFfMmLzXY/ogXvSLuEbefOi0xVCmR
         Aah4LYH3vXm7SWHnvr1NnIZnev3LFSPK2svn82bfS09Gxf9jXW2HHkjwVBWf6gey9vXg
         hV1YJJcFew5uZjB+8eij8SfZmeGNi6c4CRgLWG/67HRQRjoi1NlvhBC+VoBr5Pqu0kCg
         oG9Am63+7G8EqoayboWljWbk7LhXwX6Ta0PDCCyCNsUQZkxbZag5YloiUONlvUFcgTE6
         gKxA==
X-Gm-Message-State: AOAM532iIDECsEqz49O0Nfrmur2Zo7+joTtk8FsmaUbih7AcQ8k+x6Nk
        ti9pY1ta3xHt774xaGVzeV4=
X-Google-Smtp-Source: ABdhPJyWcAF0TkYN6LTTjchRpk8imKRALAQ8aH2/6bWxG28H9o66AoS1w6lB82ZYpDGtTiDKg2XwhQ==
X-Received: by 2002:ad4:5004:: with SMTP id s4mr25926293qvo.8.1624887263752;
        Mon, 28 Jun 2021 06:34:23 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h1sm2276030qkm.50.2021.06.28.06.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 06:34:23 -0700 (PDT)
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
Subject: [PATCH v32 08/13] mm/damon/dbgfs: Export kdamond pid to the user space
Date:   Mon, 28 Jun 2021 13:33:50 +0000
Message-Id: <20210628133355.18576-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210628133355.18576-1-sj38.park@gmail.com>
References: <20210628133355.18576-1-sj38.park@gmail.com>
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

