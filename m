Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02EF3FD475
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbhIAHeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242556AbhIAHeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:34:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9B0E61053;
        Wed,  1 Sep 2021 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630481607;
        bh=oVGW2LLKuSUoG6VqtTOQRtvJs9Oj6W5e/WXkqgv1p48=;
        h=From:To:Cc:Subject:Date:From;
        b=UByV8Mv+AkKXy8nUpooF1l85Nds35ZYIfmlkX0/FMg8NaRfaTogefjTKXmQHgXeK5
         JoBzZhB/wJEHZxgbcFy4t8iEzSY9mRcXHA22TzTzwFCYNuDAOvRUKyMgPt/ZttkL89
         h4TJ6xKWD5kB8ESndJTbT468xUmiomKGBUIsEnxkTB2092VScKhv8rqvqNW6okXqdD
         uRVvlPpUXN0D7PPMlILkPK93lMtDsk0V3zDnJEhDPXfYJOmrG0yhBlBmz/r97/Of7B
         YudtnVT+RT7CIQ+4I74718h/tBTAlAh8lYctcVoA1hTiJ9u/G5Vo6gqmxNKuZONdrQ
         Ik+EVN6je3CgQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: introduce excess_dirty_threshold()
Date:   Wed,  1 Sep 2021 15:32:32 +0800
Message-Id: <20210901073232.109355-1-chao@kernel.org>
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
 fs/f2fs/f2fs.h    |  3 +++
 fs/f2fs/node.h    |  5 -----
 fs/f2fs/segment.c | 23 +++++++++++++++++++++--
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6c5e75f86da4..5ae2ca6dba96 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -562,6 +562,9 @@ enum {
 
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
index 7358342652ec..ffd148429a9d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -535,6 +535,25 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
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
@@ -553,8 +572,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
-	if (excess_dirty_nats(sbi) || excess_dirty_nodes(sbi) ||
-		excess_prefree_segs(sbi))
+	if (excess_dirty_nats(sbi) || excess_dirty_threshold(sbi) ||
+		excess_prefree_segs(sbi) || f2fs_space_for_roll_forward(sbi))
 		goto do_sync;
 
 	/* there is background inflight IO or foreground operation recently */
-- 
2.32.0

