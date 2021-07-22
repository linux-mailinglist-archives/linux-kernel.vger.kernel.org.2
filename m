Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93FD3D1B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 03:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhGVBBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 21:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhGVBBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 21:01:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 476FB6101B;
        Thu, 22 Jul 2021 01:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626918111;
        bh=ct9/MD0KyC6CgG30CYpduAkxFNSxFsMpv6w8NfiZAz8=;
        h=From:To:Cc:Subject:Date:From;
        b=VlZ4UXJNmCG2pGZnuZJFiFRfeNTisTZIdwWWxE7okWsQw4KTLwCSV89w4nup/le+b
         wiq3WfOQh/pfwIfO/IZvlJsAQufhrYsCBatSa1r1AB8Y3DM4+05ApAtuWRD936VL/X
         c8Y2FWbBgergqJBwwP/8NhdoltEASJDhXkTAlFc1PN2c7eDYpSGvCXGVzbVFbY7UGP
         DMwQ0zJO/8zfCInb46/7Z0vDyXnNCOVE/dAMc83Vr8g4VE9PIX4hYWKURQBkktV7oz
         A/L6W0qF6+tVctTDBApOppTPZ5b2NMgVfEERdV/dercYGWZcPXjeufQ9g3Pw41mrkv
         fk4loN2lChAQw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: use rwlock instead of rwsem for journal
Date:   Wed, 21 Jul 2021 18:41:49 -0700
Message-Id: <20210722014149.525166-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tries to fix priority inversion in the below condition resulting in
long checkpoint delay.

f2fs_get_node_info()
 - nat_tree_lock
  -> sleep in journal_rwsem
                                     checkpoint
                                     - waiting for nat_tree_lock

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c    | 16 ++++++++--------
 fs/f2fs/segment.c | 22 +++++++++++-----------
 fs/f2fs/segment.h |  2 +-
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0be9e2d7120e..821a40e02fb4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -567,13 +567,13 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
 
 	/* Check current segment summary */
-	down_read(&curseg->journal_rwsem);
+	read_lock(&curseg->journal_rwlock);
 	i = f2fs_lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
 	if (i >= 0) {
 		ne = nat_in_journal(journal, i);
 		node_info_from_raw_nat(ni, &ne);
 	}
-	up_read(&curseg->journal_rwsem);
+	read_unlock(&curseg->journal_rwlock);
 	if (i >= 0) {
 		up_read(&nm_i->nat_tree_lock);
 		goto cache;
@@ -2338,7 +2338,7 @@ static void scan_curseg_cache(struct f2fs_sb_info *sbi)
 	struct f2fs_journal *journal = curseg->journal;
 	int i;
 
-	down_read(&curseg->journal_rwsem);
+	read_lock(&curseg->journal_rwlock);
 	for (i = 0; i < nats_in_cursum(journal); i++) {
 		block_t addr;
 		nid_t nid;
@@ -2350,7 +2350,7 @@ static void scan_curseg_cache(struct f2fs_sb_info *sbi)
 		else
 			remove_free_nid(sbi, nid);
 	}
-	up_read(&curseg->journal_rwsem);
+	read_unlock(&curseg->journal_rwlock);
 }
 
 static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
@@ -2799,7 +2799,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 	struct f2fs_journal *journal = curseg->journal;
 	int i;
 
-	down_write(&curseg->journal_rwsem);
+	write_lock(&curseg->journal_rwlock);
 	for (i = 0; i < nats_in_cursum(journal); i++) {
 		struct nat_entry *ne;
 		struct f2fs_nat_entry raw_ne;
@@ -2831,7 +2831,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 		__set_nat_cache_dirty(nm_i, ne);
 	}
 	update_nats_in_cursum(journal, -i);
-	up_write(&curseg->journal_rwsem);
+	write_unlock(&curseg->journal_rwlock);
 }
 
 static void __adjust_nat_entry_set(struct nat_entry_set *nes,
@@ -2906,7 +2906,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		to_journal = false;
 
 	if (to_journal) {
-		down_write(&curseg->journal_rwsem);
+		write_lock(&curseg->journal_rwlock);
 	} else {
 		page = get_next_nat_page(sbi, start_nid);
 		if (IS_ERR(page))
@@ -2946,7 +2946,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	}
 
 	if (to_journal) {
-		up_write(&curseg->journal_rwsem);
+		write_unlock(&curseg->journal_rwlock);
 	} else {
 		__update_nat_bits(sbi, start_nid, page);
 		f2fs_put_page(page, 1);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f9b7fb785e1d..c397c1c271ec 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2442,9 +2442,9 @@ static void write_current_sum_page(struct f2fs_sb_info *sbi,
 
 	mutex_lock(&curseg->curseg_mutex);
 
-	down_read(&curseg->journal_rwsem);
+	read_lock(&curseg->journal_rwlock);
 	memcpy(&dst->journal, curseg->journal, SUM_JOURNAL_SIZE);
-	up_read(&curseg->journal_rwsem);
+	read_unlock(&curseg->journal_rwlock);
 
 	memcpy(dst->entries, src->entries, SUM_ENTRY_SIZE);
 	memcpy(&dst->footer, &src->footer, SUM_FOOTER_SIZE);
@@ -3876,9 +3876,9 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	mutex_lock(&curseg->curseg_mutex);
 
 	/* update journal info */
-	down_write(&curseg->journal_rwsem);
+	write_lock(&curseg->journal_rwlock);
 	memcpy(curseg->journal, &sum->journal, SUM_JOURNAL_SIZE);
-	up_write(&curseg->journal_rwsem);
+	write_unlock(&curseg->journal_rwlock);
 
 	memcpy(curseg->sum_blk->entries, sum->entries, SUM_ENTRY_SIZE);
 	memcpy(&curseg->sum_blk->footer, &sum->footer, SUM_FOOTER_SIZE);
@@ -4136,7 +4136,7 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 	struct f2fs_journal *journal = curseg->journal;
 	int i;
 
-	down_write(&curseg->journal_rwsem);
+	write_lock(&curseg->journal_rwlock);
 	for (i = 0; i < sits_in_cursum(journal); i++) {
 		unsigned int segno;
 		bool dirtied;
@@ -4148,7 +4148,7 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 			add_sit_entry(segno, &SM_I(sbi)->sit_entry_set);
 	}
 	update_sits_in_cursum(journal, -i);
-	up_write(&curseg->journal_rwsem);
+	write_unlock(&curseg->journal_rwlock);
 }
 
 /*
@@ -4204,7 +4204,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			to_journal = false;
 
 		if (to_journal) {
-			down_write(&curseg->journal_rwsem);
+			write_lock(&curseg->journal_rwlock);
 		} else {
 			page = get_next_sit_page(sbi, start_segno);
 			raw_sit = page_address(page);
@@ -4251,7 +4251,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		}
 
 		if (to_journal)
-			up_write(&curseg->journal_rwsem);
+			write_unlock(&curseg->journal_rwlock);
 		else
 			f2fs_put_page(page, 1);
 
@@ -4432,7 +4432,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 		array[i].sum_blk = f2fs_kzalloc(sbi, PAGE_SIZE, GFP_KERNEL);
 		if (!array[i].sum_blk)
 			return -ENOMEM;
-		init_rwsem(&array[i].journal_rwsem);
+		rwlock_init(&array[i].journal_rwlock);
 		array[i].journal = f2fs_kzalloc(sbi,
 				sizeof(struct f2fs_journal), GFP_KERNEL);
 		if (!array[i].journal)
@@ -4509,7 +4509,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 		start_blk += readed;
 	} while (start_blk < sit_blk_cnt);
 
-	down_read(&curseg->journal_rwsem);
+	read_lock(&curseg->journal_rwlock);
 	for (i = 0; i < sits_in_cursum(journal); i++) {
 		unsigned int old_valid_blocks;
 
@@ -4551,7 +4551,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 							old_valid_blocks;
 		}
 	}
-	up_read(&curseg->journal_rwsem);
+	read_unlock(&curseg->journal_rwlock);
 
 	if (!err && total_node_blocks != valid_node_count(sbi)) {
 		f2fs_err(sbi, "SIT is corrupted node# %u vs %u",
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 050230c70a53..afb9041dc2e6 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -306,7 +306,7 @@ struct victim_selection {
 struct curseg_info {
 	struct mutex curseg_mutex;		/* lock for consistency */
 	struct f2fs_summary_block *sum_blk;	/* cached summary block */
-	struct rw_semaphore journal_rwsem;	/* protect journal area */
+	rwlock_t journal_rwlock;		/* protect journal area */
 	struct f2fs_journal *journal;		/* cached journal info */
 	unsigned char alloc_type;		/* current allocation type */
 	unsigned short seg_type;		/* segment type like CURSEG_XXX_TYPE */
-- 
2.32.0.402.g57bb445576-goog

