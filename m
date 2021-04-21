Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316D3366381
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 04:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhDUCBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 22:01:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17383 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhDUCBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 22:01:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FQ3cS2hvbzlYhn;
        Wed, 21 Apr 2021 09:58:32 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 10:00:20 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: avoid using native allocate_segment_by_default()
Date:   Wed, 21 Apr 2021 09:54:55 +0800
Message-ID: <20210421015455.18165-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we did for other cases, in fix_curseg_write_pointer(), let's
use wrapped f2fs_allocate_new_section() instead of native
allocate_segment_by_default(), by this way, it fixes to cover
segment allocation with curseg_lock and sentry_lock.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- call wrapped function f2fs_allocate_new_section()
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/segment.c | 18 ++++++++++--------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 87d734f5589d..20f78281e9f0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3396,7 +3396,7 @@ void f2fs_get_new_segment(struct f2fs_sb_info *sbi,
 			unsigned int *newseg, bool new_sec, int dir);
 void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
-void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type);
+void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d697c8900fa7..af7230fb9c1f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1664,7 +1664,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		down_write(&sbi->pin_sem);
 
 		f2fs_lock_op(sbi);
-		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED);
+		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
 		f2fs_unlock_op(sbi);
 
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6e740ecf0814..efd1e57384b9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2933,7 +2933,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 }
 
 static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
-								bool new_sec)
+						bool new_sec, bool force)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int old_segno;
@@ -2941,7 +2941,7 @@ static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 	if (!curseg->inited)
 		goto alloc;
 
-	if (curseg->next_blkoff ||
+	if (force || curseg->next_blkoff ||
 		get_valid_blocks(sbi, curseg->segno, new_sec))
 		goto alloc;
 
@@ -2953,16 +2953,17 @@ static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 	locate_dirty_segment(sbi, old_segno);
 }
 
-static void __allocate_new_section(struct f2fs_sb_info *sbi, int type)
+static void __allocate_new_section(struct f2fs_sb_info *sbi,
+						int type, bool force)
 {
-	__allocate_new_segment(sbi, type, true);
+	__allocate_new_segment(sbi, type, true, force);
 }
 
-void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type)
+void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force)
 {
 	down_read(&SM_I(sbi)->curseg_lock);
 	down_write(&SIT_I(sbi)->sentry_lock);
-	__allocate_new_section(sbi, type);
+	__allocate_new_section(sbi, type, force);
 	up_write(&SIT_I(sbi)->sentry_lock);
 	up_read(&SM_I(sbi)->curseg_lock);
 }
@@ -2974,7 +2975,7 @@ void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
 	down_read(&SM_I(sbi)->curseg_lock);
 	down_write(&SIT_I(sbi)->sentry_lock);
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++)
-		__allocate_new_segment(sbi, i, false);
+		__allocate_new_segment(sbi, i, false, false);
 	up_write(&SIT_I(sbi)->sentry_lock);
 	up_read(&SM_I(sbi)->curseg_lock);
 }
@@ -4844,7 +4845,8 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 
 	f2fs_notice(sbi, "Assign new section to curseg[%d]: "
 		    "curseg[0x%x,0x%x]", type, cs->segno, cs->next_blkoff);
-	allocate_segment_by_default(sbi, type, true);
+
+	f2fs_allocate_new_section(sbi, type, true);
 
 	/* check consistency of the zone curseg pointed to */
 	if (check_zone_write_pointer(sbi, zbd, &zone))
-- 
2.29.2

