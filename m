Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2766839213E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhEZUHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:07:19 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:54644 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234459AbhEZUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:07:17 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6DD36837F24C;
        Wed, 26 May 2021 20:05:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 219641A29FD;
        Wed, 26 May 2021 20:05:38 +0000 (UTC)
Message-ID: <1703a46c87dff3dbfdab008f1d268fe0b24c7db1.camel@perches.com>
Subject: [PATCH] f2fs: logging neatening
From:   Joe Perches <joe@perches.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 26 May 2021 13:05:36 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 219641A29FD
X-Spam-Status: No, score=-2.68
X-Stat-Signature: ug7h9zepu4g4uyqgxq1puiqwraq1m35i
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18A1Rzd4sQ/htvceLOWlsdhNRXuSc3/URk=
X-HE-Tag: 1622059538-128403
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the logging uses that have unnecessary newlines as the f2fs_printk
function and so its f2fs_<level> macro callers already adds one.

This allows searching single line logging entries with an easier grep and
also avoids unnecessary blank lines in the logging.

Miscellanea:

o Coalesce formats
o Align to open parenthesis

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/f2fs/data.c    | 16 +++++++---------
 fs/f2fs/file.c    | 12 +++++-------
 fs/f2fs/gc.c      |  4 ++--
 fs/f2fs/segment.c |  2 +-
 fs/f2fs/super.c   |  4 ++--
 5 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d4795eda12fa2..37f4ab79d0148 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3833,7 +3833,7 @@ static int f2fs_is_file_aligned(struct inode *inode)
 
 		/* hole */
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
-			f2fs_err(sbi, "Swapfile has holes\n");
+			f2fs_err(sbi, "Swapfile has holes");
 			ret = -ENOENT;
 			goto out;
 		}
@@ -3854,9 +3854,8 @@ static int f2fs_is_file_aligned(struct inode *inode)
 		cur_lblock += nr_pblocks;
 	}
 	if (not_aligned)
-		f2fs_warn(sbi, "Swapfile (%u) is not align to section: \n"
-			"\t1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
-			not_aligned);
+		f2fs_warn(sbi, "Swapfile (%u) is not align to section: 1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
+			  not_aligned);
 out:
 	return ret;
 }
@@ -3904,7 +3903,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 
 		/* hole */
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
-			f2fs_err(sbi, "Swapfile has holes\n");
+			f2fs_err(sbi, "Swapfile has holes");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3950,9 +3949,8 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	sis->highest_bit = cur_lblock - 1;
 
 	if (not_aligned)
-		f2fs_warn(sbi, "Swapfile (%u) is not align to section: \n"
-			"\t1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
-			not_aligned);
+		f2fs_warn(sbi, "Swapfile (%u) is not align to section: 1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
+			  not_aligned);
 out:
 	return ret;
 }
@@ -4060,7 +4058,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 out:
 	return ret;
 bad_bmap:
-	f2fs_err(sbi, "Swapfile has holes\n");
+	f2fs_err(sbi, "Swapfile has holes");
 	return -EINVAL;
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4714925e1974e..6afd4562335fc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3235,7 +3235,7 @@ static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
 
 	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
 		f2fs_warn(F2FS_I_SB(inode),
-			  "Can't enable fs-verity on inode %lu: the verity feature is not enabled on this filesystem.\n",
+			  "Can't enable fs-verity on inode %lu: the verity feature is not enabled on this filesystem",
 			  inode->i_ino);
 		return -EOPNOTSUPP;
 	}
@@ -4019,9 +4019,8 @@ static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
 							LLONG_MAX);
 
 	if (ret)
-		f2fs_warn(sbi, "%s: The file might be partially decompressed "
-				"(errno=%d). Please delete the file.\n",
-				__func__, ret);
+		f2fs_warn(sbi, "%s: The file might be partially decompressed (errno=%d). Please delete the file.",
+			  __func__, ret);
 out:
 	inode_unlock(inode);
 	file_end_write(filp);
@@ -4093,9 +4092,8 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 	clear_inode_flag(inode, FI_ENABLE_COMPRESS);
 
 	if (ret)
-		f2fs_warn(sbi, "%s: The file might be partially compressed "
-				"(errno=%d). Please delete the file.\n",
-				__func__, ret);
+		f2fs_warn(sbi, "%s: The file might be partially compressed (errno=%d). Please delete the file.",
+			  __func__, ret);
 out:
 	inode_unlock(inode);
 	file_end_write(filp);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bcb3b488dbca4..ab1c0123904f5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1031,8 +1031,8 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 		if (unlikely(check_valid_map(sbi, segno, offset))) {
 			if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
-				f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u\n",
-						blkaddr, source_blkaddr, segno);
+				f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u",
+					 blkaddr, source_blkaddr, segno);
 				f2fs_bug_on(sbi, 1);
 			}
 		}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 57c3966e16ebf..5d9df24e705b3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3920,7 +3920,7 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 	/* sanity check for summary blocks */
 	if (nats_in_cursum(nat_j) > NAT_JOURNAL_ENTRIES ||
 			sits_in_cursum(sit_j) > SIT_JOURNAL_ENTRIES) {
-		f2fs_err(sbi, "invalid journal entries nats %u sits %u\n",
+		f2fs_err(sbi, "invalid journal entries nats %u sits %u",
 			 nats_in_cursum(nat_j), sits_in_cursum(sit_j));
 		return -EINVAL;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 700a73e5518cb..4dedec3ab6d0f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1153,7 +1153,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 	}
 
 	if (test_opt(sbi, DISABLE_CHECKPOINT) && f2fs_lfs_mode(sbi)) {
-		f2fs_err(sbi, "LFS not compatible with checkpoint=disable\n");
+		f2fs_err(sbi, "LFS not compatible with checkpoint=disable");
 		return -EINVAL;
 	}
 
@@ -3571,7 +3571,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_BLK_DEV_ZONED
 		if (bdev_zoned_model(FDEV(i).bdev) == BLK_ZONED_HM &&
 				!f2fs_sb_has_blkzoned(sbi)) {
-			f2fs_err(sbi, "Zoned block device feature not enabled\n");
+			f2fs_err(sbi, "Zoned block device feature not enabled");
 			return -EINVAL;
 		}
 		if (bdev_zoned_model(FDEV(i).bdev) != BLK_ZONED_NONE) {

