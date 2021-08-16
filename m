Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0687A3ED1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhHPKXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:23:00 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:61228 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbhHPKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:22:42 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 729A0C40059;
        Mon, 16 Aug 2021 18:22:08 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: Use f2fs_bug_on instead of if condition followed by f2fs_bug_on
Date:   Mon, 16 Aug 2021 18:22:07 +0800
Message-Id: <20210816102207.277804-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIZHUpWS08dSkNIGR5LGE
        5KVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Kww4MT9NFxwJAjU5IQIp
        LioaCT1VSlVKTUlCSktCSElCS0NMVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQU5MQk83Bg++
X-HM-Tid: 0a7b4e7b9aecd996kuws729a0c40059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar:
    WARNING: Use BUG_ON instead of if condition followed by BUG.

Let's replace if (cond) f2fs_bug_on() with f2fs_bug_on().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/checkpoint.c |  6 ++----
 fs/f2fs/compress.c   |  3 +--
 fs/f2fs/data.c       |  6 ++----
 fs/f2fs/node.h       |  4 +---
 fs/f2fs/segment.c    |  5 ++---
 fs/f2fs/segment.h    | 10 ++++------
 6 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6c208108d69c..eebe5a80b842 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -475,8 +475,7 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 	e = radix_tree_lookup(&im->ino_root, ino);
 	if (!e) {
 		e = tmp;
-		if (unlikely(radix_tree_insert(&im->ino_root, ino, e)))
-			f2fs_bug_on(sbi, 1);
+		f2fs_bug_on(sbi, radix_tree_insert(&im->ino_root, ino, e));
 
 		memset(e, 0, sizeof(struct ino_entry));
 		e->ino = ino;
@@ -1369,8 +1368,7 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	memcpy(page_address(page), src, PAGE_SIZE);
 
 	set_page_dirty(page);
-	if (unlikely(!clear_page_dirty_for_io(page)))
-		f2fs_bug_on(sbi, 1);
+	f2fs_bug_on(sbi, !clear_page_dirty_for_io(page));
 
 	/* writeout cp pack 2 page */
 	err = __f2fs_write_meta_page(page, &wbc, FS_CP_META_IO);
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 455561826c7d..43362f43c3d2 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -160,8 +160,7 @@ void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page)
 {
 	unsigned int cluster_ofs;
 
-	if (!f2fs_cluster_can_merge_page(cc, page->index))
-		f2fs_bug_on(F2FS_I_SB(cc->inode), 1);
+	f2fs_bug_on(F2FS_I_SB(cc->inode), !f2fs_cluster_can_merge_page(cc, page->index));
 
 	cluster_ofs = offset_in_cluster(cc, page->index);
 	cc->rpages[cluster_ofs] = page;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d2cf48c5a2e4..4e85d5bcf1bc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -464,8 +464,7 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 			zero_user_segment(page, 0, PAGE_SIZE);
 			set_page_private_dummy(page);
 
-			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
-				f2fs_bug_on(sbi, 1);
+			f2fs_bug_on(sbi, bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE);
 		}
 		/*
 		 * In the NODE case, we lose next block address chain. So, we
@@ -727,8 +726,7 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
 	be->bio = bio;
 	bio_get(bio);
 
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
-		f2fs_bug_on(sbi, 1);
+	f2fs_bug_on(sbi, bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE);
 
 	down_write(&io->bio_list_lock);
 	list_add_tail(&be->list, &io->bio_list);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index ff14a6e5ac1c..4acf365771f4 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -191,9 +191,7 @@ static inline void get_nat_bitmap(struct f2fs_sb_info *sbi, void *addr)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
 #ifdef CONFIG_F2FS_CHECK_FS
-	if (memcmp(nm_i->nat_bitmap, nm_i->nat_bitmap_mir,
-						nm_i->bitmap_size))
-		f2fs_bug_on(sbi, 1);
+	f2fs_bug_on(sbi, memcmp(nm_i->nat_bitmap, nm_i->nat_bitmap_mir, nm_i->bitmap_size));
 #endif
 	memcpy(addr, nm_i->nat_bitmap, nm_i->bitmap_size);
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 15cc89eef28d..12f2a9bc15d7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4216,9 +4216,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 			se = get_seg_entry(sbi, segno);
 #ifdef CONFIG_F2FS_CHECK_FS
-			if (memcmp(se->cur_valid_map, se->cur_valid_map_mir,
-						SIT_VBLOCK_MAP_SIZE))
-				f2fs_bug_on(sbi, 1);
+			f2fs_bug_on(sbi, memcmp(se->cur_valid_map,
+				    se->cur_valid_map_mir, SIT_VBLOCK_MAP_SIZE));
 #endif
 
 			/* add discard candidates */
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 050230c70a53..c985b889572a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -518,9 +518,8 @@ static inline void get_sit_bitmap(struct f2fs_sb_info *sbi,
 	struct sit_info *sit_i = SIT_I(sbi);
 
 #ifdef CONFIG_F2FS_CHECK_FS
-	if (memcmp(sit_i->sit_bitmap, sit_i->sit_bitmap_mir,
-						sit_i->bitmap_size))
-		f2fs_bug_on(sbi, 1);
+	f2fs_bug_on(sbi, memcmp(sit_i->sit_bitmap, sit_i->sit_bitmap_mir,
+				sit_i->bitmap_size));
 #endif
 	memcpy(dst_addr, sit_i->sit_bitmap, sit_i->bitmap_size);
 }
@@ -762,9 +761,8 @@ static inline pgoff_t current_sit_addr(struct f2fs_sb_info *sbi,
 	check_seg_range(sbi, start);
 
 #ifdef CONFIG_F2FS_CHECK_FS
-	if (f2fs_test_bit(offset, sit_i->sit_bitmap) !=
-			f2fs_test_bit(offset, sit_i->sit_bitmap_mir))
-		f2fs_bug_on(sbi, 1);
+	f2fs_bug_on(sbi, f2fs_test_bit(offset, sit_i->sit_bitmap) !=
+		    f2fs_test_bit(offset, sit_i->sit_bitmap_mir));
 #endif
 
 	/* calculate sit block address */
-- 
2.32.0

