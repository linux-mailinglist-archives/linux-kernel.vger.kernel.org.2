Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA6B32DF9C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCECYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:24:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB942C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 18:24:15 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q20so967224pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 18:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J16a+yR5BNrYcWnVWtcRS9kbGRNIQOiOmYhsQIV8PMI=;
        b=YborE2j6kWspQbi8BVUVxiwJajhFLLbck/u9wMQNpvXOTievdYcY8Slm6wfGMvXe+l
         JKz8jLS3E1yMwRpARXEJlTe4P1ds/yGNNKuYTkAIaNrYUNcX6TJcgusCTPrWmznQCKew
         YI+siRjcWhrZ525ofbZnN8KM9w7XvjjbvLbDhT4brWWr1bIE79n14p2cmDF8hvx10A9f
         hBkTPIYVNF5F4ZCSYCaJJ9Gyjc4tw9K//31E6QM4XPwgFao6c54guy5HsTvIWENaREyg
         4pEiTdot32tVCqm50yy0W4YLWd4r2+eaN3AvzEXuwUZBFUupFN8nVZdlTMcYhpuhTSZY
         Oyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J16a+yR5BNrYcWnVWtcRS9kbGRNIQOiOmYhsQIV8PMI=;
        b=CldAbeC8P+769b1O6JaYRLE6X1nhdm2g0NabMcBLZ8Av2MPk+obNa5CLU05k9rU7tf
         z+UdZMS4Zp7qyaK+8z1VrijzGeV/FfVqNQeR4S02vnK7Al+xOFJlRmKCCU3/5zHcSp7D
         FqXfqueQZdY4ifWsaErpFa1zgJzHPveKcUavBjgB3G6JYLTo1toblkSQzDfiyg6FxaQ2
         e/xyrmlIXPdULBG8cLtiL7BExDWiEziRTUN7X1cvPqBOxBUhC+rDJmQBIXKA7ECeBwzD
         O40zRCc8qC+hbCR8fYSTAW6UCpS4K6LMjwyKtxGEt2t/KbDw4C5yPxt2tLJAnn5wVmCp
         7xZg==
X-Gm-Message-State: AOAM531mMQD0cWRDCNHfhZkDKO5BWcCzKKOFZznhkPO+TLc21816Cckw
        7uxnxw1L9uHnc/K//ufGxIp+CXA2L/A=
X-Google-Smtp-Source: ABdhPJyFS0R4ixUMby5AqMGRcsWtMRmzPIQwnxScOUONGEJ0hj5Yw67eV8Zy2AHQIAAvc0o1Z2y4mA==
X-Received: by 2002:a63:f055:: with SMTP id s21mr6344946pgj.293.1614911054707;
        Thu, 04 Mar 2021 18:24:14 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:bde2:8a9b:4961:759d])
        by smtp.gmail.com with ESMTPSA id b6sm567827pgt.69.2021.03.04.18.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 18:24:14 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: add sysfs nodes to get accumulated compression info
Date:   Fri,  5 Mar 2021 11:24:02 +0900
Message-Id: <20210305022402.2721974-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added acc_compr_inodes to show accumulated compressed inode count and
acc_compr_blocks to show accumulated secured block count with
compression in sysfs. These can be re-initialized to "0" by writing "0"
value in one of both.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: thanks to kernel test robot <lkp@intel.com>, fixed compile issue
    related to kernel config.
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++
 fs/f2fs/checkpoint.c                    |  8 ++++
 fs/f2fs/compress.c                      |  4 +-
 fs/f2fs/data.c                          |  2 +-
 fs/f2fs/f2fs.h                          | 50 ++++++++++++++++++++++++-
 fs/f2fs/file.c                          |  8 ++--
 fs/f2fs/inode.c                         |  1 +
 fs/f2fs/super.c                         | 10 ++++-
 fs/f2fs/sysfs.c                         | 45 ++++++++++++++++++++++
 include/linux/f2fs_fs.h                 |  4 +-
 10 files changed, 135 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index cbeac1bebe2f..f4fc87503754 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -409,3 +409,16 @@ Description:	Give a way to change checkpoint merge daemon's io priority.
 		I/O priority "3". We can select the class between "rt" and "be",
 		and set the I/O priority within valid range of it. "," delimiter
 		is necessary in between I/O class and priority number.
+
+What:		/sys/fs/f2fs/<disk>/acc_compr_inodes
+Date:		March 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show accumulated compressed inode count. If you write "0" here,
+		you can initialize acc_compr_inodes and acc_compr_blocks as "0".
+
+What:		/sys/fs/f2fs/<disk>/acc_compr_blocks
+Date:		March 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show accumulated secured block count with compression.
+		If you write "0" here, you can initialize acc_compr_inodes and
+		acc_compr_blocks as "0".
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 174a0819ad96..cd944a569162 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1514,6 +1514,14 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	seg_i->journal->info.kbytes_written = cpu_to_le64(kbytes_written);
 
 	if (__remain_node_summaries(cpc->reason)) {
+		/* Record compression statistics in the hot node summary */
+		spin_lock(&sbi->acc_compr_lock);
+		seg_i->journal->info.acc_compr_blocks =
+			cpu_to_le64(sbi->acc_compr_blocks);
+		seg_i->journal->info.acc_compr_inodes =
+			cpu_to_le32(sbi->acc_compr_inodes);
+		spin_unlock(&sbi->acc_compr_lock);
+
 		f2fs_write_node_summaries(sbi, start_blk);
 		start_blk += NR_CURSEG_NODE_TYPE;
 	}
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 77fa342de38f..9029e95f4ae4 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1351,8 +1351,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	}
 
 	if (fio.compr_blocks)
-		f2fs_i_compr_blocks_update(inode, fio.compr_blocks - 1, false);
-	f2fs_i_compr_blocks_update(inode, cc->nr_cpages, true);
+		f2fs_i_compr_blocks_update(inode, fio.compr_blocks - 1, false, true);
+	f2fs_i_compr_blocks_update(inode, cc->nr_cpages, true, true);
 
 	set_inode_flag(cc->inode, FI_APPEND_WRITE);
 	if (cc->cluster_idx == 0)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9721c8f116c..d3afb9b0090e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2591,7 +2591,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	ClearPageError(page);
 
 	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR)
-		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
+		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false, true);
 
 	/* LFS mode write path */
 	f2fs_outplace_write_data(&dn, fio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e2d302ae3a46..a12edf5283cd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1609,6 +1609,11 @@ struct f2fs_sb_info {
 	u64 sectors_written_start;
 	u64 kbytes_written;
 
+	/* For accumulated compression statistics */
+	u64 acc_compr_blocks;
+	u32 acc_compr_inodes;
+	spinlock_t acc_compr_lock;
+
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
 
@@ -3985,6 +3990,43 @@ static inline int __init f2fs_init_compress_cache(void) { return 0; }
 static inline void f2fs_destroy_compress_cache(void) { }
 #endif
 
+#define inc_acc_compr_inodes(inode)					\
+	do {								\
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
+		if (f2fs_compressed_file(inode)) {			\
+			spin_lock(&sbi->acc_compr_lock);                \
+			sbi->acc_compr_inodes++;                        \
+			spin_unlock(&sbi->acc_compr_lock);              \
+		}                                                       \
+	} while (0)
+#define dec_acc_compr_inodes(inode)					\
+	do {								\
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
+		if (f2fs_compressed_file(inode)) {			\
+			spin_lock(&sbi->acc_compr_lock);		\
+			if (sbi->acc_compr_inodes)			\
+				sbi->acc_compr_inodes--;		\
+			spin_unlock(&sbi->acc_compr_lock);		\
+		}							\
+	} while (0)
+#define add_acc_compr_blocks(inode, blocks)				\
+	do {								\
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
+		spin_lock(&sbi->acc_compr_lock);			\
+		sbi->acc_compr_blocks += diff;				\
+		spin_unlock(&sbi->acc_compr_lock);			\
+	} while (0)
+#define sub_acc_compr_blocks(inode, blocks)				\
+	do {								\
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
+		spin_lock(&sbi->acc_compr_lock);			\
+		if (sbi->acc_compr_blocks >= diff)			\
+			sbi->acc_compr_blocks -= diff;			\
+		else							\
+			sbi->acc_compr_blocks = 0;			\
+		spin_unlock(&sbi->acc_compr_lock);			\
+	} while (0)
+
 static inline void set_compress_context(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -4006,6 +4048,7 @@ static inline void set_compress_context(struct inode *inode)
 	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
 	set_inode_flag(inode, FI_COMPRESSED_FILE);
 	stat_inc_compr_inode(inode);
+	inc_acc_compr_inodes(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
@@ -4021,6 +4064,7 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
 	stat_dec_compr_inode(inode);
+	dec_acc_compr_inodes(inode);
 	clear_inode_flag(inode, FI_COMPRESSED_FILE);
 	f2fs_mark_inode_dirty_sync(inode, true);
 	return true;
@@ -4114,7 +4158,7 @@ static inline bool f2fs_may_compress(struct inode *inode)
 }
 
 static inline void f2fs_i_compr_blocks_update(struct inode *inode,
-						u64 blocks, bool add)
+					u64 blocks, bool add, bool accumulate)
 {
 	int diff = F2FS_I(inode)->i_cluster_size - blocks;
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -4126,9 +4170,13 @@ static inline void f2fs_i_compr_blocks_update(struct inode *inode,
 	if (add) {
 		atomic_add(diff, &fi->i_compr_blocks);
 		stat_add_compr_blocks(inode, diff);
+		if (accumulate)
+			add_acc_compr_blocks(inode, diff);
 	} else {
 		atomic_sub(diff, &fi->i_compr_blocks);
 		stat_sub_compr_blocks(inode, diff);
+		if (accumulate)
+			sub_acc_compr_blocks(inode, diff);
 	}
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d26ff2ae3f5e..6e704383fe86 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -568,7 +568,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 					!(cluster_index & (cluster_size - 1))) {
 			if (compressed_cluster)
 				f2fs_i_compr_blocks_update(dn->inode,
-							valid_blocks, false);
+							valid_blocks, false, true);
 			compressed_cluster = (blkaddr == COMPRESS_ADDR);
 			valid_blocks = 0;
 		}
@@ -597,7 +597,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	}
 
 	if (compressed_cluster)
-		f2fs_i_compr_blocks_update(dn->inode, valid_blocks, false);
+		f2fs_i_compr_blocks_update(dn->inode, valid_blocks, false, true);
 
 	if (nr_free) {
 		pgoff_t fofs;
@@ -3503,7 +3503,7 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 			f2fs_set_data_blkaddr(dn);
 		}
 
-		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, false);
+		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, false, false);
 		dec_valid_block_count(sbi, dn->inode,
 					cluster_size - compr_blocks);
 
@@ -3675,7 +3675,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		if (reserved != cluster_size - compr_blocks)
 			return -ENOSPC;
 
-		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
+		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true, false);
 
 		reserved_blocks += reserved;
 next:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 349d9cb933ee..32a3cbb60409 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -776,6 +776,7 @@ void f2fs_evict_inode(struct inode *inode)
 			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
 	}
 	sb_end_intwrite(inode->i_sb);
+	dec_acc_compr_inodes(inode);
 no_delete:
 	dquot_drop(inode);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7069793752f1..994895e0d326 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3861,11 +3861,19 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* For write statistics */
 	sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
 
+	/* For accumulated compression statistics */
+	spin_lock_init(&sbi->acc_compr_lock);
+
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
-	if (__exist_node_summaries(sbi))
+	if (__exist_node_summaries(sbi)) {
 		sbi->kbytes_written =
 			le64_to_cpu(seg_i->journal->info.kbytes_written);
+		sbi->acc_compr_blocks =
+			le64_to_cpu(seg_i->journal->info.acc_compr_blocks);
+		sbi->acc_compr_inodes =
+			le32_to_cpu(seg_i->journal->info.acc_compr_inodes);
+	}
 
 	f2fs_build_gc_manager(sbi);
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e38a7f6921dd..cc85a1028e19 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -282,6 +282,32 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return len;
 	}
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (!strcmp(a->attr.name, "acc_compr_blocks")) {
+		u64 bcount;
+		int len;
+
+		spin_lock(&sbi->acc_compr_lock);
+		bcount = sbi->acc_compr_blocks;
+		spin_unlock(&sbi->acc_compr_lock);
+
+		len = scnprintf(buf, PAGE_SIZE, "%llu\n", bcount);
+		return len;
+	}
+
+	if (!strcmp(a->attr.name, "acc_compr_inodes")) {
+		u32 icount;
+		int len;
+
+		spin_lock(&sbi->acc_compr_lock);
+		icount = sbi->acc_compr_inodes;
+		spin_unlock(&sbi->acc_compr_lock);
+
+		len = scnprintf(buf, PAGE_SIZE, "%u\n", icount);
+		return len;
+	}
+#endif
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sprintf(buf, "%u\n", *ui);
@@ -458,6 +484,19 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (!strcmp(a->attr.name, "acc_compr_blocks") ||
+		!strcmp(a->attr.name, "acc_compr_inodes")) {
+		if (t != 0)
+			return -EINVAL;
+		spin_lock(&sbi->acc_compr_lock);
+		sbi->acc_compr_blocks = 0;
+		sbi->acc_compr_inodes = 0;
+		spin_unlock(&sbi->acc_compr_lock);
+		return count;
+	}
+#endif
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -668,6 +707,8 @@ F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
 F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, acc_compr_blocks, acc_compr_blocks);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, acc_compr_inodes, acc_compr_inodes);
 #endif
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
@@ -730,6 +771,10 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(moved_blocks_foreground),
 	ATTR_LIST(moved_blocks_background),
 	ATTR_LIST(avg_vblocks),
+#endif
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	ATTR_LIST(acc_compr_blocks),
+	ATTR_LIST(acc_compr_inodes),
 #endif
 	NULL,
 };
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index c6cc0a566ef5..7b707ddeca99 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -429,7 +429,7 @@ struct summary_footer {
 /* Reserved area should make size of f2fs_extra_info equals to
  * that of nat_journal and sit_journal.
  */
-#define EXTRA_INFO_RESERVED	(SUM_JOURNAL_SIZE - 2 - 8)
+#define EXTRA_INFO_RESERVED	(SUM_JOURNAL_SIZE - 2 - 20)
 
 /*
  * frequently updated NAT/SIT entries can be stored in the spare area in
@@ -462,6 +462,8 @@ struct sit_journal {
 
 struct f2fs_extra_info {
 	__le64 kbytes_written;
+	__le64 acc_compr_blocks;
+	__le32 acc_compr_inodes;
 	__u8 reserved[EXTRA_INFO_RESERVED];
 } __packed;
 
-- 
2.30.1.766.gb4fecdf3b7-goog

