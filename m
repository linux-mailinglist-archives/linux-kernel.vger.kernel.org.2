Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12A334401F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVLry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:47:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14423 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCVLro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:47:44 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F3t4F71BPzkdG0;
        Mon, 22 Mar 2021 19:46:05 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 19:47:32 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to check ckpt blocks of section in get_victim_by_default()
Date:   Mon, 22 Mar 2021 19:47:20 +0800
Message-ID: <20210322114720.71007-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In image which enables large section, if we disable checkpoint, during
background GC, it needs to check whether there is checkpointed data in
selected victim section, rather than segment, fix this.

Fixes: 4354994f097d ("f2fs: checkpoint disabling")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c      |  4 ++--
 fs/f2fs/segment.c | 18 ++++--------------
 fs/f2fs/segment.h | 15 ++++++++++++++-
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 318840c69b74..a73db53deb05 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -726,8 +726,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			goto next;
 		/* Don't touch checkpointed data */
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
-					get_ckpt_valid_blocks(sbi, segno) &&
-					p.alloc_mode == LFS))
+				get_ckpt_valid_blocks(sbi, segno, true) &&
+				p.alloc_mode == LFS))
 			goto next;
 		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
 			goto next;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 81fe335b860e..788aa0f2250e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -865,7 +865,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_lock(&dirty_i->seglist_lock);
 
 	valid_blocks = get_valid_blocks(sbi, segno, false);
-	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno);
+	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno, false);
 
 	if (valid_blocks == 0 && (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) ||
 		ckpt_valid_blocks == usable_blocks)) {
@@ -950,7 +950,7 @@ static unsigned int get_free_segment(struct f2fs_sb_info *sbi)
 	for_each_set_bit(segno, dirty_i->dirty_segmap[DIRTY], MAIN_SEGS(sbi)) {
 		if (get_valid_blocks(sbi, segno, false))
 			continue;
-		if (get_ckpt_valid_blocks(sbi, segno))
+		if (get_ckpt_valid_blocks(sbi, segno, false))
 			continue;
 		mutex_unlock(&dirty_i->seglist_lock);
 		return segno;
@@ -2933,18 +2933,8 @@ static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 		get_valid_blocks(sbi, curseg->segno, new_sec))
 		goto alloc;
 
-	if (new_sec) {
-		unsigned int segno = START_SEGNO(curseg->segno);
-		int i;
-
-		for (i = 0; i < sbi->segs_per_sec; i++, segno++) {
-			if (get_ckpt_valid_blocks(sbi, segno))
-				goto alloc;
-		}
-	} else {
-		if (!get_ckpt_valid_blocks(sbi, curseg->segno))
-			return;
-	}
+	if (!get_ckpt_valid_blocks(sbi, curseg->segno, new_sec))
+		return;
 
 alloc:
 	old_segno = curseg->segno;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 144980b62f9e..0b4b3796faaa 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -359,8 +359,21 @@ static inline unsigned int get_valid_blocks(struct f2fs_sb_info *sbi,
 }
 
 static inline unsigned int get_ckpt_valid_blocks(struct f2fs_sb_info *sbi,
-				unsigned int segno)
+				unsigned int segno, bool use_section)
 {
+	if (use_section && __is_large_section(sbi)) {
+		unsigned int start_segno = START_SEGNO(segno);
+		unsigned int blocks = 0;
+		int i;
+
+		for (i = 0; i < sbi->segs_per_sec; i++, start_segno++) {
+			struct seg_entry *se = get_seg_entry(sbi, start_segno);
+
+			blocks += se->ckpt_valid_blocks;
+		}
+		return blocks;
+	}
+
 	return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 }
 
-- 
2.29.2

