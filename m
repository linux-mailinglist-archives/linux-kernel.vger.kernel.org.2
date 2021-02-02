Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A87B30BAE2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhBBJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhBBJYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:24:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3A0C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:23:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d2so1972160pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02o59vXLINonMWY3lvfSKv5YhEgXWDRF+6oMw1Rtfck=;
        b=dvbZHCCC2wCsFsn3ZB9On5c6cv6BpRNVs3k61OPBo37tW3+zqLhBwdcJcIJdN4Q2tO
         9vV8uFB59sKgFfT5fgwOsBSYs9++tJ5vw4g1a7fIjkhuK5HcTn9ZrZqh9cd6bH4ot/2J
         pMMHqLqRBNz9OmzXk+Tw6XB1LBgKleptIn4jcKjRpOSfSAldAj1awOBr9+3fEwNhQI3/
         qbRZlpJUsEyYFJyG6SYJkTUPAnnHvyvRC6oj9Q8zkQTrbR8Y5fk2o29CSkpsbu2Zip12
         Zj5rHaXq/dqYeuxOLcfi3TNUpGm5M7WcpvVxs4CsGhFiqsgeDCDGMgcd7ePOxrPy5Mhn
         vJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02o59vXLINonMWY3lvfSKv5YhEgXWDRF+6oMw1Rtfck=;
        b=neTR4kjRDkcvjAzxRq1dLPkeGJY8chodVUr9Ui5AOxwmfrgUumOxAWDAylCQn8kYw0
         Ux9hbIjSiatzhDxKZtPlMvRV2Q389QNXvyNSilg7XW0B8frxg0fA74AYIcbHHx2vUtDN
         ilHcOaQc34/aHrGokCbi/2/q9sKV4+Rc0x11gbX1cJqAAUz8+2NqWL97jE5+MoYFDXGj
         pKtrZEZPvjCisR+9ujw4HMv6z4pLXqXWlWUg5YD5nzn+7M5//Eys4AaGcNlbfqW/WT/m
         zp5sOLWmToupJj8FE6JoBeLeuwWIlaG0jeQqm19LX03Agc6wxBaUqARGr9BD3UZ/OJjQ
         BuiA==
X-Gm-Message-State: AOAM530hrhOJeRnSIN3QXUKoIrbGfflIoReGOGmwIGewqKXX+/tarsfG
        bzds7LfXDCCXMElGMmnEp8sKr0R1i7k=
X-Google-Smtp-Source: ABdhPJyrpSlsbXTUEFQmm5lItZjG9ycKquBR69ihP6zuhUjP2PimNHtffhLU1BiQP3++7bDakdDwxA==
X-Received: by 2002:a17:90a:de8a:: with SMTP id n10mr1494113pjv.227.1612257819588;
        Tue, 02 Feb 2021 01:23:39 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:4f5:ae3a:569d:491a])
        by smtp.gmail.com with ESMTPSA id c5sm21724500pgt.73.2021.02.02.01.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:23:38 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: rename checkpoint=merge mount option to checkpoint_merge
Date:   Tue,  2 Feb 2021 18:23:32 +0900
Message-Id: <20210202092332.2562006-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

As checkpoint=merge comes in, mount option setting related to checkpoint
had been mixed up and it became hard to understand. So, I separated
this option from "checkpoint=" and made another mount option
"checkpoint_merge" for this.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: renamed "checkpoint=merge" to "checkpoint_merge"
v3: removed "nocheckpoint_merge" option
---
 Documentation/filesystems/f2fs.rst |  6 +++---
 fs/f2fs/super.c                    | 21 +++++++++------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index d0ead45dc706..475994ed8b15 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -247,9 +247,9 @@ checkpoint=%s[:%u[%]]	 Set to "disable" to turn off checkpointing. Set to "enabl
 			 hide up to all remaining free space. The actual space that
 			 would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
 			 This space is reclaimed once checkpoint=enable.
-			 Here is another option "merge", which creates a kernel daemon
-			 and makes it to merge concurrent checkpoint requests as much
-			 as possible to eliminate redundant checkpoint issues. Plus,
+checkpoint_merge	 When checkpoint is enabled, this can be used to create a kernel
+			 daemon and make it to merge concurrent checkpoint requests as
+			 much as possible to eliminate redundant checkpoint issues. Plus,
 			 we can eliminate the sluggish issue caused by slow checkpoint
 			 operation when the checkpoint is done in a process context in
 			 a cgroup having low i/o budget and cpu shares. To make this
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 56696f6cfa86..b60dcef7f9d0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -215,7 +215,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
 	{Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
 	{Opt_checkpoint_enable, "checkpoint=enable"},
-	{Opt_checkpoint_merge, "checkpoint=merge"},
+	{Opt_checkpoint_merge, "checkpoint_merge"},
 	{Opt_compress_algorithm, "compress_algorithm=%s"},
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
@@ -1142,12 +1142,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
-	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
-			test_opt(sbi, MERGE_CHECKPOINT)) {
-		f2fs_err(sbi, "checkpoint=merge cannot be used with checkpoint=disable\n");
-		return -EINVAL;
-	}
-
 	/* Not pass down write hints if the number of active logs is lesser
 	 * than NR_CURSEG_PERSIST_TYPE.
 	 */
@@ -1782,7 +1776,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",checkpoint=disable:%u",
 				F2FS_OPTION(sbi).unusable_cap);
 	if (test_opt(sbi, MERGE_CHECKPOINT))
-		seq_puts(seq, ",checkpoint=merge");
+		seq_puts(seq, ",checkpoint_merge");
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
@@ -1827,6 +1821,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
 	set_opt(sbi, DISCARD);
+	clear_opt(sbi, MERGE_CHECKPOINT);
 	if (f2fs_sb_has_blkzoned(sbi))
 		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
 	else
@@ -2066,9 +2061,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
-	if (!test_opt(sbi, MERGE_CHECKPOINT)) {
-		f2fs_stop_ckpt_thread(sbi);
-	} else {
+	if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
+			test_opt(sbi, MERGE_CHECKPOINT)) {
 		err = f2fs_start_ckpt_thread(sbi);
 		if (err) {
 			f2fs_err(sbi,
@@ -2076,6 +2070,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			    err);
 			goto restore_gc;
 		}
+	} else {
+		f2fs_stop_ckpt_thread(sbi);
 	}
 
 	/*
@@ -3831,7 +3827,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* setup checkpoint request control and start checkpoint issue thread */
 	f2fs_init_ckpt_req_control(sbi);
-	if (test_opt(sbi, MERGE_CHECKPOINT)) {
+	if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
+			test_opt(sbi, MERGE_CHECKPOINT)) {
 		err = f2fs_start_ckpt_thread(sbi);
 		if (err) {
 			f2fs_err(sbi,
-- 
2.30.0.365.g02bc693789-goog

