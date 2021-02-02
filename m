Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548F330BFC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhBBNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhBBNjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:39:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F019BC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 05:38:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id g15so2390557pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 05:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C69QpALUz/Vmi9PK2ISxOpgUe2yzE/S6S1X6OGff0v8=;
        b=lE5QgpRQANr285lptntXBKpZ0mfRKgwqNpjOT4+XiB148qmXATeLVDvu1BnjzBs2Z2
         UtIZd7vv8CGDG28WO9VtH0WpLxZwP1uMzhkWOEsEBsGMi3dNtDd6aRYsijDmnHDjVf+3
         t4dS8TUA1pb9fx1bpa0fgGwdM/OzUuA1PcK5a0/TaDWTr+9VzA/cfYuYUmp4d3SFIhHw
         u3K4EoxvXxm80jN/Xoajzw+HvvlYV7+DRJT9ODIdZhzHkP6CoI3yo/zPEBYTzJaKKNLR
         RpoUlBQ/2H1uEA73njCQbaSLtfChGVyHMkVqYAinMhNVxf+4b/hoUq09iNvivlI4iV2c
         gAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C69QpALUz/Vmi9PK2ISxOpgUe2yzE/S6S1X6OGff0v8=;
        b=Tzr7a2CKDBTQ60WYSgvYXvG49SyKhdv3hdRGw66jHWU94gTQQr48hC7k3YEnq7sABA
         OcwcspAGYHkQ3fLCwuGizy7dkqeXjAfWjguNMd9GboXOQ14dA0dOCiM20gtLMUso6jvO
         7AbTuRqLoT7r1PLD1MLHCtVkLMZ5QxKbaTnLpYKgD+HrhhXiTzT6ZQ6y8qpuaUB3rZBC
         8+293pKNgf69c0xHdLYt61ddl50mA3ENF2eM6uydR6Xa6pFTa+XiM3M+Tlss6rSnqIgF
         GEjCL5T5uNdZnmr1AU/Xk+SHMKoZbcAtY8dUDCiea1NG70mRpSEaC/TS5kcLg+I0cKXc
         9C3w==
X-Gm-Message-State: AOAM532rhr3uqbB6Ss6Mixm4Z+dRpgH3em/RLtOCOH+xxmOQM1O21PnE
        9qRc6jUFk1Pw4I112Y4tJz+eXbt4gGM=
X-Google-Smtp-Source: ABdhPJxZTcDSxyk50PeK+2qJYkaWv2iltg+9IXpptRym6j1r1bYGeqBheNDqoMYhaRfz4bta/h0G5w==
X-Received: by 2002:a17:90a:dc01:: with SMTP id i1mr4309237pjv.134.1612273115992;
        Tue, 02 Feb 2021 05:38:35 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:4f5:ae3a:569d:491a])
        by smtp.gmail.com with ESMTPSA id a30sm21367022pfh.66.2021.02.02.05.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 05:38:35 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v5] f2fs: rename checkpoint=merge mount option to checkpoint_merge
Date:   Tue,  2 Feb 2021 22:38:29 +0900
Message-Id: <20210202133829.2671108-1-daeho43@gmail.com>
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
v4: re-added "nocheckpoint_merge" option to make it possible to disable
    just only "checkpoint_merge" when remount
v5: added the description about "nocheckpoint_merge" in rst and added it
    in show_options
---
 Documentation/filesystems/f2fs.rst |  7 ++++---
 fs/f2fs/super.c                    | 27 +++++++++++++++------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index d0ead45dc706..f75ec244762f 100644
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
@@ -257,6 +257,7 @@ checkpoint=%s[:%u[%]]	 Set to "disable" to turn off checkpointing. Set to "enabl
 			 to "3", to give one higher priority than other kernel threads.
 			 This is the same way to give a I/O priority to the jbd2
 			 journaling thread of ext4 filesystem.
+nocheckpoint_merge	 Disable checkpoint merge feature.
 compress_algorithm=%s	 Control compress algorithm, currently f2fs supports "lzo",
 			 "lz4", "zstd" and "lzo-rle" algorithm.
 compress_algorithm=%s:%d Control compress algorithm and its compress level, now, only
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 56696f6cfa86..1000d21120ca 100644
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
@@ -1782,7 +1781,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",checkpoint=disable:%u",
 				F2FS_OPTION(sbi).unusable_cap);
 	if (test_opt(sbi, MERGE_CHECKPOINT))
-		seq_puts(seq, ",checkpoint=merge");
+		seq_puts(seq, ",checkpoint_merge");
+	else
+		seq_puts(seq, ",nocheckpoint_merge");
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
@@ -2066,9 +2067,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -2076,6 +2076,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			    err);
 			goto restore_gc;
 		}
+	} else {
+		f2fs_stop_ckpt_thread(sbi);
 	}
 
 	/*
@@ -3831,7 +3833,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
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

