Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE6430BEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhBBM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhBBM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:58:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7638C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 04:57:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cl8so936851pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 04:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v45bS+5J5I6ABfY+sXqAeT4Q3Py85OIA8x3/cYZh11w=;
        b=MfpKIB39gMkmkjjQTDyTj96EnTGkhMOd5LnzvK6Yb3z8kma5g2OtDnvIuWvn4fgadV
         aMrBBCYyopD1l/BSOGsqCTiYHjODSXF5VZWoVFDMJI+FxrC9FzmQL+bj1UlERXH0O6bF
         p+UM7ax6cj5+8F6QgIWR5rcCsylaKbBx2vQjyxJ0rr3FvW6fOGndlhu7wsQYq1i6Nhiz
         k9auQJmILe6Ez8faGgN9FbNHZj8MK7jayAcoXtZT/Fz+ktQJaWp2qmh5vQTss/43/Mrf
         JJnZf863aSB3vHVYVNU+oQbg62VfiN/sQtsy3WgqIW86K8HrwC7DrXwnHqcD2RRbTcFW
         1cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v45bS+5J5I6ABfY+sXqAeT4Q3Py85OIA8x3/cYZh11w=;
        b=eSDjeSwe4DbaacGsesz0kLn/w5opj1/HLCz5S96N0KOm4mnhOKQGnW4um53rqcChcN
         i0TtVVg+iwtck/xFCjj3sxKvB2TFycUujaHmJVoFWigcwZVkjp17EzcEhAaiXQBt4Qql
         QuB2bsegZC1oWc0gxScpOReywCHPaQgVzut/W3xHv6sKKCDlEN+imiOtxqMooDA4OHKE
         lPuSxUE+Dnxv0LBSWGOld68WoL7tWmO1XGb24AAVIan/LHzjpZHcvG9qwtZAXgKpfJEO
         t0uZNOuPGjnuApd4ZhqFGpMd08YL2pQToVwLPStmL6YbqGdbjizNssYxNsdWCd5n6dBv
         rcbA==
X-Gm-Message-State: AOAM530LKGg54UTn7Ffw+Vrx/hiSeR9myvU5SXuofr5rPCJbHVf3OtfS
        RjNQX7RKVG0QeG+1494fqZBPfwhl1UA=
X-Google-Smtp-Source: ABdhPJz2bzwtNxsjEuMl6QTIzUC8LVFzlrnqGAz2MD8Unfi8w/Dmf3RfdWL2r0zAP8du3bB4HZXTIQ==
X-Received: by 2002:a17:90b:118e:: with SMTP id gk14mr2609909pjb.34.1612270642888;
        Tue, 02 Feb 2021 04:57:22 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:4f5:ae3a:569d:491a])
        by smtp.gmail.com with ESMTPSA id q132sm4219037pfq.171.2021.02.02.04.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 04:57:22 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v4] f2fs: rename checkpoint=merge mount option to checkpoint_merge
Date:   Tue,  2 Feb 2021 21:57:16 +0900
Message-Id: <20210202125716.2635406-1-daeho43@gmail.com>
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
---
 Documentation/filesystems/f2fs.rst |  6 +++---
 fs/f2fs/super.c                    | 25 +++++++++++++------------
 2 files changed, 16 insertions(+), 15 deletions(-)

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
index 56696f6cfa86..f1791b9c1eac 100644
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
@@ -2066,9 +2065,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -2076,6 +2074,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			    err);
 			goto restore_gc;
 		}
+	} else {
+		f2fs_stop_ckpt_thread(sbi);
 	}
 
 	/*
@@ -3831,7 +3831,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
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

