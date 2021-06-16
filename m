Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A113A9405
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhFPHeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhFPHd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:33:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C6FC0617AF;
        Wed, 16 Jun 2021 00:31:49 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g142so113003qke.4;
        Wed, 16 Jun 2021 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27fs4ayWfwDx66gepojtp7zAr2zH3uKkjECbTbsrrQM=;
        b=jyer3sBmKMRf2V2n7cpG2hLatrNS1r/8fSSKAeIbpQ+GMJY9L4YL45268EVFSmtDX4
         bQevQyR8lCW3uwiA2Uy2zBaOc22DqRMgUYUhsXw6Ck36sEFbKk0JYIJccxPWkqS/vl7T
         9ssPje6pABpHHo9QempP2D7obPC9MXel3nFIrHOfnK5IpvP+qEeLVl6HExxjZHPQVnrG
         PUrTrzefBI7AB30pxX+Kp/5cLn/XXTN7sU2XhkK2VEdq+2kV3gRrgVrKb9hLleamLw3g
         zsg8mAgjfzmPDhIMonBHoFmR2ZrTX5TSA6ClQtoMwUtWcfDtdy3889KjmQ+r0iEfRDJB
         Rmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27fs4ayWfwDx66gepojtp7zAr2zH3uKkjECbTbsrrQM=;
        b=kS+ssLpZuKvf17tCCUKF7zf7prxoLSMy2XaAvw5pNLnyU4zEZs+xhsSw0YGhQomL/o
         CkAbhVKN/QKN3+KdoTTXJk/HXddm0TWYT6RvUNcZZwydkksJDEEIzZyPunmw8QMCHtLI
         z5ruMaG3326XZ5gFqELwraF9TodHjG302nP0X3mQygTldAJT018rJ8Rhxmi/36NeCBBu
         EfX7bFcO+vmapnfnn8HTFSfZyCJeF1WhldHOREHhXWqRYXE9rlKViUZb3Q+nRUQ687qd
         LUYXx8C732+IAWoC2E8ix5gudomUkxdAB6QAIfqbLwqTPXyH5Y94mJnZxocBUSd7Hw9d
         tOAg==
X-Gm-Message-State: AOAM533yvxPvhwejXpLEcpP6iWPjaPyyJt7FY8Lyz39uHSFfE+q1jYOR
        IP/5s4Bpk/Q9NyuNiFUuZ6I=
X-Google-Smtp-Source: ABdhPJxkPgaqbDsIKxTzfPCdvreeKQNdMzWFxQNE3BD2Bj7Ckj0tHvBCzEatZRfm4+/cqtJJBWCraw==
X-Received: by 2002:a37:be44:: with SMTP id o65mr3772815qkf.29.1623828708880;
        Wed, 16 Jun 2021 00:31:48 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h5sm1080697qkg.122.2021.06.16.00.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:31:48 -0700 (PDT)
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
Subject: [PATCH v30 08/13] mm/damon/dbgfs: Export kdamond pid to the user space
Date:   Wed, 16 Jun 2021 07:31:14 +0000
Message-Id: <20210616073119.16758-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210616073119.16758-1-sj38.park@gmail.com>
References: <20210616073119.16758-1-sj38.park@gmail.com>
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
 mm/damon/dbgfs.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index c4a4a6f1dc79..524362f8c628 100644
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

