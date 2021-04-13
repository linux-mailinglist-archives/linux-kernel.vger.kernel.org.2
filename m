Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359FC35E186
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346375AbhDMObG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbhDMO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:29:56 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC08C06138C;
        Tue, 13 Apr 2021 07:29:35 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 18so1147730qkl.3;
        Tue, 13 Apr 2021 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eYTdxL2E49yq4b0Ub99eMeKNygqCtQlWSQ8UNjQ6vgA=;
        b=Wz8kRlNr4zj9Wxg3LJJXUtaqyTxuCR5hEZ//Hpw6L2z+VO641agxv0ky6VroYNJXM3
         hFEn3rtK8m8eMGPclor2d8elOgrV9O+kZfn6XAR8SHqDrvcaDBU/YpnvAQYBbEOCdH3J
         x4nsQyZegO/jBr4MTsVt/6Sz2Py+qIQhOmiQsHLwFBWW2kGpaVSpOKO5AHJ78ihX0KG2
         NrsUySVuck0nlJN25eInOl3+RbV2YsQ21dF/e7atfNcWiOZK64jaKFeHeE0L8yi8ZZ9V
         qgYtxadBmATKZOHJXAEXPMmo2YFi11D/nuiAnUafPoyUGTIzjRoUcQK3Aid7+icpMcme
         G9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eYTdxL2E49yq4b0Ub99eMeKNygqCtQlWSQ8UNjQ6vgA=;
        b=JQ6xhS/WDKxzCH7Ef2PxHET9gOTa/Zj45N8PjJVLcDtuIkDlalfaL3M2PgWr9bsva2
         2z/8vWYJ5cU0HZbbxqUKqFqEzyzNt4PR7swYVQ99pVtjZGj1Qz1LEhVIcvIX7WU3K86D
         uHVIox4kS0x71kMFnzivPXfh+tGWYeqrjGwuhUr4OvmS1h6k/K2/ydm7KjQ4+p6TdY8+
         nM6+lLiJjJRYdCYIe/npBbEjjN/fsr2tIP4pUT17i27JVCGGWUBH6Vt54WsreHcMlK3o
         5Efs/5BDGE0jIlCeyE4wdGA3j/dtsKyFfaIRJGn71DlMBDxOx4nZCHA6SKXtxeV7Kyg+
         1Bzg==
X-Gm-Message-State: AOAM533TZGiCmpa74mEnPtOg2wgx3ytpaBRfl31YusoaW7lbnckmEdr5
        g7Y3zhb0brAsZCH4DJ3q4mE=
X-Google-Smtp-Source: ABdhPJxQnXlkyAbIHRo5s7SK/my4hQVkz/C02pOx0AYmMEkXxRiK2i7wI9iMKMnx8/oC068AtCo1AA==
X-Received: by 2002:a37:64c3:: with SMTP id y186mr25700000qkb.244.1618324174723;
        Tue, 13 Apr 2021 07:29:34 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 2sm6160911qko.134.2021.04.13.07.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:29:34 -0700 (PDT)
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
Subject: [PATCH v28 08/13] mm/damon/dbgfs: Export kdamond pid to the user space
Date:   Tue, 13 Apr 2021 14:28:59 +0000
Message-Id: <20210413142904.556-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210413142904.556-1-sj38.park@gmail.com>
References: <20210413142904.556-1-sj38.park@gmail.com>
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

