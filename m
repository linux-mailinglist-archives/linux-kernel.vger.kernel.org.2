Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070983402E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCRKKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCRKKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:10:18 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F987C06174A;
        Thu, 18 Mar 2021 03:10:18 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s7so1390122qkg.4;
        Thu, 18 Mar 2021 03:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W8+A/g3U4DodIE6llQ+hDjB/HFXop9Ja1bxfrVH/yAg=;
        b=kT1pBhR3JRIX8rnvf+m/6UkT8V+sxoRM6EP4NLs6YuBOiFd1REtu+fiP9/rVZIT/iR
         kAqBc+1iKTBqAkqcPRLAaijgDp9PcL+0+KecKQbUQbbMupn7DlgrSM6yDZdDd5E8S7fi
         OnGeY6vy2K1eyPKbK7XdRhXKLIq0HvkInXI2QoSboDnYGMIyBt1D07nkocIyJL9l96ND
         yhfO6wbHxXKxxThPSYVVQBv6hCHiigw9TW6J5F8T9LT+j4VhG7fUvhTfEzoe/aVrV+uh
         VQcO/UUAYWhdYnjAnErE9bUv2O7QBl+2/nHOhRj57QV65RUChXIcVsyjg7jjSgdoBtLr
         nHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W8+A/g3U4DodIE6llQ+hDjB/HFXop9Ja1bxfrVH/yAg=;
        b=r8aLuupT8AhSU0OP0rIqS+ZuhZECTbd7j7xYv60HCvfq6ld/L7bDF70ABedCFeTYUU
         QQUfRfpAEOUdeONLRlnfEHCB4YrTS4joqg3isHahvQ4GwGdq6vk3Ix08BiSr7vePKePO
         pGwhCHH4JPN5F9qB/l08E2an0JVJKhEIUPOUPmN7E2naNIaNdgzW5vLMtxVX12oE6fTA
         05+EWL+hx39p+4dLlBedtro2ONOQeBiZRbo33vYMikxxDBvA8tiFKojnF68YN+RR9ugP
         8/BpXaVHp69xIx6SLFfs369Op6hNfEKqu5WhHZ+Ix6dv7IoWteFCpX2Ix7jK4HnfLNIP
         zQsw==
X-Gm-Message-State: AOAM5328XOwTsZ1vbk9RO/SS4EbSvVosFwk/Jk6U5FiKamXy+SXutniw
        M0hbdi1be0C1GI+ZGFNbe5tluQBgC376vQsB09g=
X-Google-Smtp-Source: ABdhPJx9r52cWcfoEbyqWv9MA5ztg2rt1UpinGbFCS45+PeKAjitAAjlvY+RVJdVuNlf5TFvPYHD6Q==
X-Received: by 2002:a37:a715:: with SMTP id q21mr3363655qke.309.1616062217486;
        Thu, 18 Mar 2021 03:10:17 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id d16sm1358101qka.43.2021.03.18.03.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:10:17 -0700 (PDT)
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
Subject: [PATCH v25 08/13] mm/damon/dbgfs: Export kdamond pid to the user space
Date:   Thu, 18 Mar 2021 10:08:51 +0000
Message-Id: <20210318100856.34715-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318100856.34715-1-sj38.park@gmail.com>
References: <20210318100856.34715-1-sj38.park@gmail.com>
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

