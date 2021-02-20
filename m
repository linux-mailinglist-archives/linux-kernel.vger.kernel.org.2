Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7833204CE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBTJmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:42:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12932 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:41:45 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DjNhL3bQWzjPMf;
        Sat, 20 Feb 2021 17:39:46 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 17:40:53 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RFC] f2fs: fix to avoid selecting full segment w/ {AT,}SSR allocator
Date:   Sat, 20 Feb 2021 17:40:52 +0800
Message-ID: <20210220094052.64905-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cp disabling mode, there could be a condition
- target segment has 128 ckpt valid blocks
- GC migrates 128 valid blocks to other segment (segment is still in
dirty list)
- GC migrates 384 blocks to target segment (segment has 128 cp_vblocks
and 384 vblocks)
- If GC selects target segment via {AT,}SSR allocator, however there is
no free space in targe segment.

Fixes: 4354994f097d ("f2fs: checkpoint disabling")
Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/gc.c      | 17 +++++++++++++----
 fs/f2fs/segment.c | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ed7807103c8e..9c753eff0814 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3376,6 +3376,7 @@ block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi);
 int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
 void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
 int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
+bool segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 86ba8ed0b8a7..a1d8062cdace 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -392,10 +392,6 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
 		if (p->gc_mode == GC_AT &&
 			get_valid_blocks(sbi, segno, true) == 0)
 			return;
-
-		if (p->alloc_mode == AT_SSR &&
-			get_seg_entry(sbi, segno)->ckpt_valid_blocks == 0)
-			return;
 	}
 
 	for (i = 0; i < sbi->segs_per_sec; i++)
@@ -736,6 +732,19 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
 			goto next;
 
+		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+			/*
+			 * to avoid selecting candidate which has below valid
+			 * block distribution:
+			 * partial blocks are valid and all left ones are valid
+			 * in previous checkpoint.
+			 */
+			if (p.alloc_mode == SSR || p.alloc_mode == AT_SSR) {
+				if (!segment_has_free_slot(sbi, segno))
+					goto next;
+			}
+		}
+
 		if (is_atgc) {
 			add_victim_entry(sbi, &p, segno);
 			goto next;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2d5a82c4ca15..deaf57e13125 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2650,6 +2650,26 @@ static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
 		seg->next_blkoff++;
 }
 
+bool segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
+{
+	struct sit_info *sit = SIT_I(sbi);
+	struct seg_entry *se = get_seg_entry(sbi, segno);
+	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
+	unsigned long *target_map = SIT_I(sbi)->tmp_map;
+	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
+	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
+	int i, pos;
+
+	down_write(&sit->sentry_lock);
+	for (i = 0; i < entries; i++)
+		target_map[i] = ckpt_map[i] | cur_map[i];
+
+	pos = __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, 0);
+	up_write(&sit->sentry_lock);
+
+	return pos < sbi->blocks_per_seg;
+}
+
 /*
  * This function always allocates a used segment(from dirty seglist) by SSR
  * manner, so it should recover the existing segment information of valid blocks
-- 
2.29.2

