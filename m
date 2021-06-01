Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86B391A83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhEZOof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234632AbhEZOod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:44:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E816610A2;
        Wed, 26 May 2021 14:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622040182;
        bh=/CZD5GLvG6VjL1VhEfXjZ80ZHpG1p7/LKpkac/fY6Ps=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aGO2jp72B+puqrQi8Vsl5Xjvt2Dy/6Q7OOEd6ax1sU9BgZ8cuFqWAEm4dufinm9qJ
         zMcNT6oMPxr2Kb0+5c3BBfjPWwFBbJj+lAxklYSyApPFDGkT2L5RLUQaALGDo2zYyC
         wwKwWIw1CxR9hLl+lyJ0TwkB4D5CdsbWbUsa5sbuX6g9Gawk6MrYH7+97mNQmM784K
         yJOW0ipWaHMs2H/t4X1TyJy7anYaY8ZD3/JwgDJoDxjEuC2a/61h47OGWfNpMfSAsg
         aYs3xdGdC6HqEck8y3QibxnY5VEsxncVYGqpbcgVyxzZIdtPTeATG4TNs+ScKHc6Be
         WVRBk6neaPVKg==
Date:   Wed, 26 May 2021 07:43:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2 v3] f2fs: support RO feature
Message-ID: <YK5edM0igwfd47LV@google.com>
References: <20210521190217.2484099-1-jaegeuk@kernel.org>
 <20210521190217.2484099-2-jaegeuk@kernel.org>
 <YK5UOfzwdZni7c5W@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK5UOfzwdZni7c5W@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given RO feature in superblock, we don't need to check provisioning/reserve
spaces and SSA area.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v2:
 - allow curseg updates
 - fix some bugs

 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c |  4 ++++
 fs/f2fs/super.c   | 37 +++++++++++++++++++++++++++++++------
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eaf57b5f3c4b..9ad502f92529 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -168,6 +168,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_SB_CHKSUM		0x0800
 #define F2FS_FEATURE_CASEFOLD		0x1000
 #define F2FS_FEATURE_COMPRESSION	0x2000
+#define F2FS_FEATURE_RO			0x4000
 
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
 	((raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -940,6 +941,7 @@ static inline void set_new_dnode(struct dnode_of_data *dn, struct inode *inode,
 #define	NR_CURSEG_DATA_TYPE	(3)
 #define NR_CURSEG_NODE_TYPE	(3)
 #define NR_CURSEG_INMEM_TYPE	(2)
+#define NR_CURSEG_RO_TYPE	(2)
 #define NR_CURSEG_PERSIST_TYPE	(NR_CURSEG_DATA_TYPE + NR_CURSEG_NODE_TYPE)
 #define NR_CURSEG_TYPE		(NR_CURSEG_INMEM_TYPE + NR_CURSEG_PERSIST_TYPE)
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8668df7870d0..02e0c38be7eb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4683,6 +4683,10 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
 		struct seg_entry *se = get_seg_entry(sbi, curseg->segno);
 		unsigned int blkofs = curseg->next_blkoff;
 
+		if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) &&
+			i != CURSEG_HOT_DATA && i != CURSEG_HOT_NODE)
+			continue;
+
 		sanity_check_seg_type(sbi, curseg->seg_type);
 
 		if (f2fs_test_bit(blkofs, se->cur_valid_map))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e70aca8f97bd..6788e7b71e27 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -555,7 +555,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 	int ret;
 
 	if (!options)
-		return 0;
+		goto default_check;
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
@@ -1090,6 +1090,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			return -EINVAL;
 		}
 	}
+default_check:
 #ifdef CONFIG_QUOTA
 	if (f2fs_check_quota_options(sbi))
 		return -EINVAL;
@@ -1162,6 +1163,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 	 */
 	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_TYPE)
 		F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
+
+	if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) && !f2fs_readonly(sbi->sb)) {
+		f2fs_err(sbi, "Allow to mount readonly mode only");
+		return -EROFS;
+	}
 	return 0;
 }
 
@@ -1819,7 +1825,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 static void default_options(struct f2fs_sb_info *sbi)
 {
 	/* init some FS parameters */
-	F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
+	if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO))
+		F2FS_OPTION(sbi).active_logs = NR_CURSEG_RO_TYPE;
+	else
+		F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
+
 	F2FS_OPTION(sbi).inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
 	F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
 	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
@@ -2001,6 +2011,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (f2fs_readonly(sb) && (*flags & SB_RDONLY))
 		goto skip;
 
+	if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) && !(*flags & SB_RDONLY)) {
+		err = -EROFS;
+		goto restore_opts;
+	}
+
 #ifdef CONFIG_QUOTA
 	if (!f2fs_readonly(sb) && (*flags & SB_RDONLY)) {
 		err = dquot_suspend(sb, -1);
@@ -3134,14 +3149,15 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
 	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
 
-	if (unlikely(fsmeta < F2FS_MIN_META_SEGMENTS ||
+	if (!F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) &&
+			unlikely(fsmeta < F2FS_MIN_META_SEGMENTS ||
 			ovp_segments == 0 || reserved_segments == 0)) {
 		f2fs_err(sbi, "Wrong layout: check mkfs.f2fs version");
 		return 1;
 	}
-
 	user_block_count = le64_to_cpu(ckpt->user_block_count);
-	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
+	segment_count_main = le32_to_cpu(raw_super->segment_count_main) +
+			(F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) ? 1 : 0);
 	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	if (!user_block_count || user_block_count >=
 			segment_count_main << log_blocks_per_seg) {
@@ -3172,6 +3188,10 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
 			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
 			return 1;
+
+		if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO))
+			goto check_data;
+
 		for (j = i + 1; j < NR_CURSEG_NODE_TYPE; j++) {
 			if (le32_to_cpu(ckpt->cur_node_segno[i]) ==
 				le32_to_cpu(ckpt->cur_node_segno[j])) {
@@ -3182,10 +3202,15 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 			}
 		}
 	}
+check_data:
 	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
 		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
 			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
 			return 1;
+
+		if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO))
+			goto skip_cross;
+
 		for (j = i + 1; j < NR_CURSEG_DATA_TYPE; j++) {
 			if (le32_to_cpu(ckpt->cur_data_segno[i]) ==
 				le32_to_cpu(ckpt->cur_data_segno[j])) {
@@ -3207,7 +3232,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 			}
 		}
 	}
-
+skip_cross:
 	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
 	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

