Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6829E3204BE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhBTJgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:36:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12931 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhBTJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:36:38 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DjNZR2FL5zjPMl;
        Sat, 20 Feb 2021 17:34:39 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 17:35:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to allow migrating fully valid segment
Date:   Sat, 20 Feb 2021 17:35:40 +0800
Message-ID: <20210220093541.63899-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F2FS_IOC_FLUSH_DEVICE/F2FS_IOC_RESIZE_FS needs to migrate all blocks of
target segment to other place, no matter the segment has partially or fully
valid blocks.

However, after commit 803e74be04b3 ("f2fs: stop GC when the victim becomes
fully valid"), we may skip migration due to target segment is fully valid,
result in failing the ioctl interface, fix this.

Fixes: 803e74be04b3 ("f2fs: stop GC when the victim becomes fully valid")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    |  9 +++++----
 fs/f2fs/gc.c      | 21 ++++++++++++---------
 fs/f2fs/segment.c |  2 +-
 fs/f2fs/super.c   |  2 +-
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2860003a09ed..ed7807103c8e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3548,7 +3548,7 @@ void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
 int f2fs_start_gc_thread(struct f2fs_sb_info *sbi);
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
-int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
+int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background, bool force,
 			unsigned int segno);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8e53f8898688..e1e6b2ad5c54 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1656,7 +1656,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		if (has_not_enough_free_secs(sbi, 0,
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
 			down_write(&sbi->gc_lock);
-			err = f2fs_gc(sbi, true, false, NULL_SEGNO);
+			err = f2fs_gc(sbi, true, false, false, NULL_SEGNO);
 			if (err && err != -ENODATA && err != -EAGAIN)
 				goto out_err;
 		}
@@ -2487,7 +2487,7 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 		down_write(&sbi->gc_lock);
 	}
 
-	ret = f2fs_gc(sbi, sync, true, NULL_SEGNO);
+	ret = f2fs_gc(sbi, sync, true, false, NULL_SEGNO);
 out:
 	mnt_drop_write_file(filp);
 	return ret;
@@ -2523,7 +2523,8 @@ static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
 		down_write(&sbi->gc_lock);
 	}
 
-	ret = f2fs_gc(sbi, range->sync, true, GET_SEGNO(sbi, range->start));
+	ret = f2fs_gc(sbi, range->sync, true, false,
+				GET_SEGNO(sbi, range->start));
 	if (ret) {
 		if (ret == -EBUSY)
 			ret = -EAGAIN;
@@ -2976,7 +2977,7 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 		sm->last_victim[GC_CB] = end_segno + 1;
 		sm->last_victim[GC_GREEDY] = end_segno + 1;
 		sm->last_victim[ALLOC_NEXT] = end_segno + 1;
-		ret = f2fs_gc(sbi, true, true, start_segno);
+		ret = f2fs_gc(sbi, true, true, true, start_segno);
 		if (ret == -EAGAIN)
 			ret = 0;
 		else if (ret < 0)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 39330ad3c44e..b3af76340026 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -112,7 +112,7 @@ static int gc_thread_func(void *data)
 		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
 
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi, sync_mode, true, NULL_SEGNO))
+		if (f2fs_gc(sbi, sync_mode, true, false, NULL_SEGNO))
 			wait_ms = gc_th->no_gc_sleep_time;
 
 		trace_f2fs_background_gc(sbi->sb, wait_ms,
@@ -1354,7 +1354,8 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
  * the victim data block is ignored.
  */
 static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
-		struct gc_inode_list *gc_list, unsigned int segno, int gc_type)
+		struct gc_inode_list *gc_list, unsigned int segno, int gc_type,
+		bool force_migrate)
 {
 	struct super_block *sb = sbi->sb;
 	struct f2fs_summary *entry;
@@ -1383,8 +1384,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		 * race condition along with SSR block allocation.
 		 */
 		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
-				get_valid_blocks(sbi, segno, true) ==
-							BLKS_PER_SEC(sbi))
+			(!force_migrate && get_valid_blocks(sbi, segno, true) ==
+							BLKS_PER_SEC(sbi)))
 			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
@@ -1519,7 +1520,8 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 
 static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				unsigned int start_segno,
-				struct gc_inode_list *gc_list, int gc_type)
+				struct gc_inode_list *gc_list, int gc_type,
+				bool force_migrate)
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
@@ -1606,7 +1608,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 								gc_type);
 		else
 			submitted += gc_data_segment(sbi, sum->entries, gc_list,
-							segno, gc_type);
+							segno, gc_type,
+							force_migrate);
 
 		stat_inc_seg_count(sbi, type, gc_type);
 		migrated++;
@@ -1634,7 +1637,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 }
 
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
-			bool background, unsigned int segno)
+			bool background, bool force, unsigned int segno)
 {
 	int gc_type = sync ? FG_GC : BG_GC;
 	int sec_freed = 0, seg_freed = 0, total_freed = 0;
@@ -1696,7 +1699,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	if (ret)
 		goto stop;
 
-	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type);
+	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type, force);
 	if (gc_type == FG_GC &&
 		seg_freed == f2fs_usable_segs_in_sec(sbi, segno))
 		sec_freed++;
@@ -1835,7 +1838,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
-		do_garbage_collect(sbi, segno, &gc_list, FG_GC);
+		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true);
 		put_gc_inode(&gc_list);
 
 		if (!gc_only && get_valid_blocks(sbi, segno, true)) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 440634dfaa56..2190910c68b0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -504,7 +504,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	 */
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
 		down_write(&sbi->gc_lock);
-		f2fs_gc(sbi, false, false, NULL_SEGNO);
+		f2fs_gc(sbi, false, false, false, NULL_SEGNO);
 	}
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 30d5abef4361..78d9e54bc4f7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1869,7 +1869,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
 		down_write(&sbi->gc_lock);
-		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
+		err = f2fs_gc(sbi, true, false, false, NULL_SEGNO);
 		if (err == -ENODATA) {
 			err = 0;
 			break;
-- 
2.29.2

