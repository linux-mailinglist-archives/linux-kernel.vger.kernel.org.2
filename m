Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACA240D592
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbhIPJKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235462AbhIPJK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:10:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DA7C60F93;
        Thu, 16 Sep 2021 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783349;
        bh=97WnehG029XDtPsDQa1+PYmnlyuYrpfaBA6X7Pg/NQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=m2cm1xOdEqeL2YAbx1PmE8I1LCuZx7UdK9oUAABgSNzTkyWwj1Iy4McropjiGvOPh
         3+RAB92ikbTgpWjqHN0EGnYSTwN/HblSWTK/BIW2tSVBJ4Q2mm5915lOlCcuExqIyB
         /4dh9Ij0+mat7Rh5ZAl3MH065QkcS4EqsFfq/8c3k3WHaWgwaj8vutHGPYPS53rwwv
         h8mTs0+gCY0TFa9GpanANCVp0MpIwfV8ynJuMACUBHYf22SdQv33fncEOAiE7p1yib
         u7cuFjpCJDSDkxzvPluA0ygYskFy+Vr9o8LFFTCsK5EsGLIiB2DnG4HVzb0TanlGyL
         SRKcmmOXj4K3g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: introduce excess_dirty_threshold()
Date:   Thu, 16 Sep 2021 17:09:03 +0800
Message-Id: <20210916090903.18427-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables f2fs_balance_fs_bg() to check all metadatas' dirty
threshold rather than just checking node block's, so that checkpoint()
from background can be triggered more frequently to avoid heaping up
too much dirty metadatas.

Threshold value by default:
race with foreground ops	single type	global
No				16MB		24MB
Yes				24MB		36MB

In addtion, let f2fs_balance_fs_bg() be aware of roll-forward sapce
as well as fsync().

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to use f2fs_space_for_roll_forward() correctly pointed out
by Jaegeuk
 fs/f2fs/f2fs.h    |  3 +++
 fs/f2fs/node.h    |  5 -----
 fs/f2fs/segment.c | 23 +++++++++++++++++++++--
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 58311eda4ce9..2e26b9e95ac5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -561,6 +561,9 @@ enum {
 
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
 
+/* dirty segments threshold for triggering CP */
+#define DEFAULT_DIRTY_THRESHOLD		4
+
 /* for in-memory extent cache entry */
 #define F2FS_MIN_EXTENT_LEN	64	/* minimum extent length */
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index ff14a6e5ac1c..18b98cf0465b 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -138,11 +138,6 @@ static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
 	return NM_I(sbi)->nat_cnt[TOTAL_NAT] >= DEF_NAT_CACHE_THRESHOLD;
 }
 
-static inline bool excess_dirty_nodes(struct f2fs_sb_info *sbi)
-{
-	return get_pages(sbi, F2FS_DIRTY_NODES) >= sbi->blocks_per_seg * 8;
-}
-
 enum mem_type {
 	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES,	/* indicates the cached nat entry */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6cfbd62262f2..ceb20e91e125 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -529,6 +529,25 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	}
 }
 
+static inline bool excess_dirty_threshold(struct f2fs_sb_info *sbi)
+{
+	int factor = rwsem_is_locked(&sbi->cp_rwsem) ? 3 : 2;
+	unsigned int dents = get_pages(sbi, F2FS_DIRTY_DENTS);
+	unsigned int qdata = get_pages(sbi, F2FS_DIRTY_QDATA);
+	unsigned int nodes = get_pages(sbi, F2FS_DIRTY_NODES);
+	unsigned int meta = get_pages(sbi, F2FS_DIRTY_META);
+	unsigned int imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
+	unsigned int threshold = sbi->blocks_per_seg * factor *
+					DEFAULT_DIRTY_THRESHOLD;
+	unsigned int global_threshold = threshold * 3 / 2;
+
+	if (dents >= threshold || qdata >= threshold ||
+		nodes >= threshold || meta >= threshold ||
+		imeta >= threshold)
+		return true;
+	return dents + qdata + nodes + meta + imeta >  global_threshold;
+}
+
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 {
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
@@ -547,8 +566,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
-	if (excess_dirty_nats(sbi) || excess_dirty_nodes(sbi) ||
-		excess_prefree_segs(sbi))
+	if (excess_dirty_nats(sbi) || excess_dirty_threshold(sbi) ||
+		excess_prefree_segs(sbi) || !f2fs_space_for_roll_forward(sbi))
 		goto do_sync;
 
 	/* there is background inflight IO or foreground operation recently */
-- 
2.32.0

