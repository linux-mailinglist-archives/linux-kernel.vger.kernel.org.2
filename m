Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9145030B6D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 06:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhBBFTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 00:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBBFTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 00:19:17 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9978BC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 21:18:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id e19so13546548pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 21:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxIbWKQee057BvPC22C9Txak/5Uxcdgh3GFtE4n47FM=;
        b=lANVz08oLU4V8erca40vM8pxbXD9ghcPYs+gn1O4VX6vuBFqLPoYigIdbxUH/OF3Le
         SoJlunknn8GNQMlFZsao2B13JJAUKyFgdkTB7+Dy3YyOSIiqT4Qce9ap1pHK7ow2KLqC
         gdfiu50z4giYPiNgmKy+QEWBnUusJ1g4sUtU2OBltnNa9ZikMaxtpNdEC13iM702hyQ6
         9qiBmJvy0jpazrY84HeufFd+AHJaZsKMEbxmtncsk4uDTpcEYEWAoXCtO8P/MzNZn+HZ
         KaDkZhGwzAmFWLAEl5HpsiWdGjQl0zHUsdpIwIuMSJ+/eeGVrKneG9is7/YDBSgKA6DS
         IXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxIbWKQee057BvPC22C9Txak/5Uxcdgh3GFtE4n47FM=;
        b=Ob0D5HRuZDnLWiC/eO/pymN0dxAY0TFdV5mxgbxKublx7L4QAECW7ZjsakRkSwXXwo
         jFpDZQ1y2YJoT8NzRy4/FYa5HQNfiGcRJiiVlWp+jpPAHfTSbQzBzhZ0f2kb3jLeYcQZ
         xo3U9do8KV3IeSOwrKS2UfBWElwMoPWuaHBA4eC8rdtoHNxFa4QL8064cBM4VfnbNr96
         RQc39pBQBaiAvUUdcO9/HP5MiTEzZ8b8hZtMkArHHnWALeAAyzyP/NrJe1xESOyDuhIA
         U7aZFetwYf4qtQ0f4nA7g0x3NTjRTR6afozHHW4OxZHqvZNi76XHEw9UvMyH55Xy34IQ
         6U2w==
X-Gm-Message-State: AOAM533h+CqoF7YL8M92irVmTkjYmWLS2w1cac2RIHdDZtwnSrkrtX5p
        3a+GpemLdWX/vhmOLAi8+lOE9+zwd5w=
X-Google-Smtp-Source: ABdhPJzWUBfvxKz37SEcLy+cwh/xiWGcQzvjJO+SePo3yBIDDj8LHKdhN91HBzxZEosc2bncxFRxJQ==
X-Received: by 2002:a62:5344:0:b029:1c7:eeea:8bad with SMTP id h65-20020a6253440000b02901c7eeea8badmr19597264pfb.1.1612243116589;
        Mon, 01 Feb 2021 21:18:36 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:3d90:5212:5281:e85d])
        by smtp.gmail.com with ESMTPSA id z16sm21318282pgj.51.2021.02.01.21.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 21:18:35 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: rename checkpoint=merge mount option to checkpoint_merge
Date:   Tue,  2 Feb 2021 14:18:29 +0900
Message-Id: <20210202051829.2127214-1-daeho43@gmail.com>
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
---
 Documentation/filesystems/f2fs.rst |  6 +++---
 fs/f2fs/super.c                    | 26 ++++++++++++++------------
 2 files changed, 17 insertions(+), 15 deletions(-)

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
index 56696f6cfa86..d8603e6c4916 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -145,6 +145,7 @@ enum {
 	Opt_checkpoint_disable_cap_perc,
 	Opt_checkpoint_enable,
 	Opt_checkpoint_merge,
+	Opt_nocheckpoint_merge,
 	Opt_compress_algorithm,
 	Opt_compress_log_size,
 	Opt_compress_extension,
@@ -215,7 +216,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
 	{Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
 	{Opt_checkpoint_enable, "checkpoint=enable"},
-	{Opt_checkpoint_merge, "checkpoint=merge"},
+	{Opt_checkpoint_merge, "checkpoint_merge"},
+	{Opt_nocheckpoint_merge, "nocheckpoint_merge"},
 	{Opt_compress_algorithm, "compress_algorithm=%s"},
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
@@ -946,6 +948,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_checkpoint_merge:
 			set_opt(sbi, MERGE_CHECKPOINT);
 			break;
+		case Opt_nocheckpoint_merge:
+			clear_opt(sbi, MERGE_CHECKPOINT);
+			break;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		case Opt_compress_algorithm:
 			if (!f2fs_sb_has_compression(sbi)) {
@@ -1142,12 +1147,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
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
@@ -1782,7 +1781,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",checkpoint=disable:%u",
 				F2FS_OPTION(sbi).unusable_cap);
 	if (test_opt(sbi, MERGE_CHECKPOINT))
-		seq_puts(seq, ",checkpoint=merge");
+		seq_puts(seq, ",checkpoint_merge");
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
@@ -1827,6 +1826,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
 	set_opt(sbi, DISCARD);
+	clear_opt(sbi, MERGE_CHECKPOINT);
 	if (f2fs_sb_has_blkzoned(sbi))
 		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
 	else
@@ -2066,9 +2066,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -2076,6 +2075,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			    err);
 			goto restore_gc;
 		}
+	} else {
+		f2fs_stop_ckpt_thread(sbi);
 	}
 
 	/*
@@ -3831,7 +3832,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
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

