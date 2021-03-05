Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6C32E56A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCEJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:56:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13129 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhCEJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:56:30 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DsNPT1VkYz16G97;
        Fri,  5 Mar 2021 17:54:37 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 17:56:12 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to align to section for fallocate() on pinned file
Date:   Fri, 5 Mar 2021 17:56:01 +0800
Message-ID: <20210305095601.96591-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, fallocate() on a pinned file only allocates blocks which aligns
to segment rather than section, so GC may try to migrate pinned file's
block, and after several times of failure, pinned file's block could
be migrated to other place, however user won't be aware of such
condition, and then old obsolete block address may be readed/written
incorrectly.

To avoid such condition, let's try to allocate pinned file's blocks
with section alignment.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/segment.c | 34 ++++++++++++++++++++++++++--------
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 700ef46e4147..ff6c212bf2c5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3399,7 +3399,7 @@ void f2fs_get_new_segment(struct f2fs_sb_info *sbi,
 			unsigned int *newseg, bool new_sec, int dir);
 void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
-void f2fs_allocate_new_segment(struct f2fs_sb_info *sbi, int type);
+void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1863944f4073..1b70b56434e4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1666,7 +1666,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		down_write(&sbi->pin_sem);
 
 		f2fs_lock_op(sbi);
-		f2fs_allocate_new_segment(sbi, CURSEG_COLD_DATA_PINNED);
+		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED);
 		f2fs_unlock_op(sbi);
 
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b26217910b85..ff50e79d2bb7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2918,7 +2918,8 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 	up_read(&SM_I(sbi)->curseg_lock);
 }
 
-static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type)
+static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
+								bool new_sec)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int old_segno;
@@ -2926,10 +2927,22 @@ static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type)
 	if (!curseg->inited)
 		goto alloc;
 
-	if (!curseg->next_blkoff &&
-		!get_valid_blocks(sbi, curseg->segno, false) &&
-		!get_ckpt_valid_blocks(sbi, curseg->segno))
-		return;
+	if (curseg->next_blkoff ||
+		get_valid_blocks(sbi, curseg->segno, new_sec))
+		goto alloc;
+
+	if (new_sec) {
+		unsigned int segno = START_SEGNO(curseg->segno);
+		int i;
+
+		for (i = 0; i < sbi->segs_per_sec; i++, segno++) {
+			if (get_ckpt_valid_blocks(sbi, segno))
+				goto alloc;
+		}
+	} else {
+		if (!get_ckpt_valid_blocks(sbi, curseg->segno))
+			return;
+	}
 
 alloc:
 	old_segno = curseg->segno;
@@ -2937,10 +2950,15 @@ static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type)
 	locate_dirty_segment(sbi, old_segno);
 }
 
-void f2fs_allocate_new_segment(struct f2fs_sb_info *sbi, int type)
+static void __allocate_new_section(struct f2fs_sb_info *sbi, int type)
+{
+	__allocate_new_segment(sbi, type, true);
+}
+
+void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type)
 {
 	down_write(&SIT_I(sbi)->sentry_lock);
-	__allocate_new_segment(sbi, type);
+	__allocate_new_section(sbi, type);
 	up_write(&SIT_I(sbi)->sentry_lock);
 }
 
@@ -2950,7 +2968,7 @@ void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
 
 	down_write(&SIT_I(sbi)->sentry_lock);
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++)
-		__allocate_new_segment(sbi, i);
+		__allocate_new_segment(sbi, i, false);
 	up_write(&SIT_I(sbi)->sentry_lock);
 }
 
-- 
2.29.2

