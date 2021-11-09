Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E9144A47A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhKICQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:16:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234245AbhKICQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:16:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89EE86117A;
        Tue,  9 Nov 2021 02:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636424017;
        bh=lSc7e7ZAt9bXIp1vfm0B7Qc/M2TOjO8dFI4+XqwsTPM=;
        h=From:To:Cc:Subject:Date:From;
        b=s4vtpJZ+Z6Tm5Xzhi6WmGr8zG/LVwvj7DoGnqzj1AnTzTsmvFWbiyVZIq0UCH9D+W
         AS4WYRTUgwGVXCI2fQSKDgKQcjGu6R0DgF/KNOXrueyvNzX132ew2wR3C3QBA+BqZy
         jRbzUuf/+PaLmTuNi/6IEIpSmWdfDLyexonxZoFO7CnBa56YmW2xWFu6t0L3Pd4kwv
         iBAhCwmdnCc4eN4HPXBuWFCHPTEWDr4QHVZkqFAMn+PWVVvxTtB3m6hn0x888dL/rI
         bKyVlnjUKGpEe6epBJT6PEsvAKFR5OGdaYAwLY/YFjUXUeDmFqNlmKXrSMw4SKWNhS
         mZM54DvuZRJqQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: provide a way to attach HIPRI for Direct IO
Date:   Mon,  8 Nov 2021 18:13:36 -0800
Message-Id: <20211109021336.3796538-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a way to attach HIPRI by expanding the existing sysfs's
data_io_flag. User can measure IO performance by enabling it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 16 +++++++++-------
 fs/f2fs/data.c                          |  2 ++
 fs/f2fs/f2fs.h                          |  3 +++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index b268e3e18b4a..ac52e1c6bcbc 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -369,13 +369,15 @@ Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Give a way to attach REQ_META|FUA to data writes
 		given temperature-based bits. Now the bits indicate:
 
-		+-------------------+-------------------+
-		|      REQ_META     |      REQ_FUA      |
-		+------+------+-----+------+------+-----+
-		|    5 |    4 |   3 |    2 |    1 |   0 |
-		+------+------+-----+------+------+-----+
-		| Cold | Warm | Hot | Cold | Warm | Hot |
-		+------+------+-----+------+------+-----+
+		+------------+-------------------+-------------------+
+		| HIPRI_DIO  |      REQ_META     |      REQ_FUA      |
+		+------------+------+------+-----+------+------+-----+
+		|          6 |    5 |    4 |   3 |    2 |    1 |   0 |
+		+------------+------+------+-----+------+------+-----+
+		|        All | Cold | Warm | Hot | Cold | Warm | Hot |
+		+------------+------+------+-----+------+------+-----+
+
+		Note that, HIPRI_DIO bit is only for direct IO path.
 
 What:		/sys/fs/f2fs/<disk>/node_io_flag
 Date:		June 2020
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9f754aaef558..faa40aca2848 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3707,6 +3707,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		if (do_opu)
 			down_read(&fi->i_gc_rwsem[READ]);
 	}
+	if (sbi->data_io_flag & HIPRI_DIO)
+		iocb->ki_flags |= IOCB_HIPRI;
 
 	err = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
 			iter, rw == WRITE ? get_data_block_dio_write :
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ce9fc9f13000..094f1e8ff82b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1557,6 +1557,9 @@ struct decompress_io_ctx {
 #define MAX_COMPRESS_LOG_SIZE		8
 #define MAX_COMPRESS_WINDOW_SIZE(log_size)	((PAGE_SIZE) << (log_size))
 
+/* HIPRI for direct IO used in sysfs/data_io_flag */
+#define HIPRI_DIO			(1 << 6)
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
-- 
2.34.0.rc0.344.g81b53c2807-goog

