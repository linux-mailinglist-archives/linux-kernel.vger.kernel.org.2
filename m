Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA937BA18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhELKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:12:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2057 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhELKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:12:20 -0400
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fg9SH1gl8zWhw6;
        Wed, 12 May 2021 18:06:55 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 12 May 2021 18:11:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RFC] f2fs: support migrating swapfile in aligned write mode
Date:   Wed, 12 May 2021 18:11:00 +0800
Message-ID: <20210512101100.101424-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---

*do not merge this patch*, I haven't tested this patch yet, just send this
out for comments.

 fs/f2fs/data.c    | 117 +++++++++++++++++++++++++++++++++-------------
 fs/f2fs/f2fs.h    |   1 +
 fs/f2fs/node.h    |   3 ++
 fs/f2fs/segment.c |   3 ++
 4 files changed, 92 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 258c5d7a3bfa..ea47d301ccb0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2472,6 +2472,10 @@ static inline bool check_inplace_update_policy(struct inode *inode,
 
 bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
 {
+	/* swap file is migrating in algined write mode */
+	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
+		return false;
+
 	if (f2fs_is_pinned_file(inode))
 		return true;
 
@@ -3832,6 +3836,70 @@ int f2fs_migrate_page(struct address_space *mapping,
 #endif
 
 #ifdef CONFIG_SWAP
+static int f2fs_migrate_blocks(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int secidx, blkofs;
+	unsigned int blk_per_sec = BLKS_PER_SEC(sbi);
+	unsigned int total_secs = DIV_ROUND_UP(i_size_read(inode),
+					blk_per_sec << F2FS_BLKSIZE_BITS);
+	unsigned int last_blkidx = DIV_ROUND_UP(i_size_read(inode),
+							F2FS_BLKSIZE);
+	int ret = 0;
+
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
+
+	for (secidx = 0; secidx < total_secs; secidx++) {
+		down_write(&sbi->pin_sem);
+
+		f2fs_lock_op(sbi);
+		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
+		f2fs_unlock_op(sbi);
+
+		set_inode_flag(inode, FI_DO_DEFRAG);
+
+		for (blkofs = 0; blkofs < blk_per_sec; blkofs++) {
+			struct page *page;
+			unsigned int blkidx = secidx * blk_per_sec + blkofs;
+
+			if (blkidx >= last_blkidx) {
+				up_write(&sbi->pin_sem);
+				goto done;
+			}
+
+			page = f2fs_get_lock_data_page(inode, blkidx, true);
+			if (IS_ERR(page)) {
+				up_write(&sbi->pin_sem);
+				ret = PTR_ERR(page);
+				goto done;
+			}
+
+			set_page_dirty(page);
+			f2fs_put_page(page, 1);
+		}
+
+		clear_inode_flag(inode, FI_DO_DEFRAG);
+
+		set_inode_flag(inode, FI_ALIGNED_WRITE);
+		ret = filemap_fdatawrite(inode->i_mapping);
+		clear_inode_flag(inode, FI_ALIGNED_WRITE);
+
+		up_write(&sbi->pin_sem);
+
+		if (ret)
+			break;
+	}
+
+done:
+	clear_inode_flag(inode, FI_DO_DEFRAG);
+
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
+	return ret;
+}
+
 static int f2fs_is_file_aligned(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -3841,7 +3909,6 @@ static int f2fs_is_file_aligned(struct inode *inode)
 	block_t pblock;
 	unsigned long nr_pblocks;
 	unsigned int blocks_per_sec = BLKS_PER_SEC(sbi);
-	unsigned int not_aligned = 0;
 	int ret = 0;
 
 	cur_lblock = 0;
@@ -3874,20 +3941,12 @@ static int f2fs_is_file_aligned(struct inode *inode)
 
 		if ((pblock - main_blkaddr) & (blocks_per_sec - 1) ||
 			nr_pblocks & (blocks_per_sec - 1)) {
-			if (f2fs_is_pinned_file(inode)) {
-				f2fs_err(sbi, "Swapfile does not align to section");
-				ret = -EINVAL;
-				goto out;
-			}
-			not_aligned++;
+			ret = FILE_NOT_ALIGNED;
+			goto out;
 		}
 
 		cur_lblock += nr_pblocks;
 	}
-	if (not_aligned)
-		f2fs_warn(sbi, "Swapfile (%u) is not align to section: \n"
-			"\t1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
-			not_aligned);
 out:
 	return ret;
 }
@@ -3905,8 +3964,6 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	sector_t highest_pblock = 0;
 	int nr_extents = 0;
 	unsigned long nr_pblocks;
-	unsigned int blocks_per_sec = BLKS_PER_SEC(sbi);
-	unsigned int not_aligned = 0;
 	int ret = 0;
 
 	/*
@@ -3943,16 +4000,6 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 		pblock = map.m_pblk;
 		nr_pblocks = map.m_len;
 
-		if ((pblock - SM_I(sbi)->main_blkaddr) & (blocks_per_sec - 1) ||
-				nr_pblocks & (blocks_per_sec - 1)) {
-			if (f2fs_is_pinned_file(inode)) {
-				f2fs_err(sbi, "Swapfile does not align to section");
-				ret = -EINVAL;
-				goto out;
-			}
-			not_aligned++;
-		}
-
 		if (cur_lblock + nr_pblocks >= sis->max)
 			nr_pblocks = sis->max - cur_lblock;
 
@@ -3979,11 +4026,6 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	sis->max = cur_lblock;
 	sis->pages = cur_lblock - 1;
 	sis->highest_bit = cur_lblock - 1;
-
-	if (not_aligned)
-		f2fs_warn(sbi, "Swapfile (%u) is not align to section: \n"
-			"\t1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
-			not_aligned);
 out:
 	return ret;
 }
@@ -4003,13 +4045,24 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	sector_t highest_block = 0;
 	int nr_extents = 0;
 	int ret = 0;
+	bool migrated = false;
 
-	if (PAGE_SIZE == F2FS_BLKSIZE)
-		return check_swap_activate_fast(sis, swap_file, span);
-
+recheck:
 	ret = f2fs_is_file_aligned(inode);
-	if (ret)
+	if (ret < 0)
 		goto out;
+	else if (ret == FILE_NOT_ALIGNED) {
+		if (migrated)
+			return -EINVAL;
+		ret = f2fs_migrate_blocks(inode);
+		if (ret)
+			return ret;
+		migrated = true;
+		goto recheck;
+	}
+
+	if (PAGE_SIZE == F2FS_BLKSIZE)
+		return check_swap_activate_fast(sis, swap_file, span);
 
 	blocks_per_page = bytes_to_blks(inode, PAGE_SIZE);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 70c0bd563732..570ffdf068ee 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -707,6 +707,7 @@ enum {
 	FI_COMPRESS_CORRUPT,	/* indicate compressed cluster is corrupted */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
 	FI_ENABLE_COMPRESS,	/* enable compression in "user" compression mode */
+	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index d85e8659cfda..e5235dfe4670 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -38,6 +38,9 @@
 /* return value for read_node_page */
 #define LOCKED_PAGE	1
 
+/* check pinned file's alignment status of physical blocks */
+#define FILE_NOT_ALIGNED	1
+
 /* For flag in struct node_info */
 enum {
 	IS_CHECKPOINTED,	/* is it checkpointed before? */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 72c75694c9c5..edc3a28970a4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3292,6 +3292,9 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 	if (fio->type == DATA) {
 		struct inode *inode = fio->page->mapping->host;
 
+		if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
+			return CURSEG_COLD_DATA_PINNED;
+
 		if (page_private_gcing(fio->page)) {
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
-- 
2.29.2

