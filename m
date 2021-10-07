Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B494258E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbhJGRIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243077AbhJGRIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:08:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C522061040;
        Thu,  7 Oct 2021 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633626391;
        bh=BykqShL6jCxQA0iFSsFi2KEJuYVbKm2eowIiAaYRILc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+wlDaXlW4P77vv3vYFZRbT6ruoxjHtvGOydNhJBCQ9/Cr/9bUHTB/GMjriZ4ZBzL
         01QXUVnRPB3S7AIcF7BV17Z1/9jI9S2lY3pLsG5vF+BzThJzGC8k+KlwVTxZpNobhX
         kyB2egZBkYVUHIW/oM7gOHE4kYgG+dG10NmIEzTKi28olC8Gw1sjl0/T0AGTkXr3aK
         ilIF3Ou05msl9/zEm/VvWgHRu8BpSSHkUmFyK8gjv5RTfviruG4NxyN/NjgrZu5nVA
         kQgK3faDkVCW0hnKurMNUZ7AbONnVCH3SOp+Zd1oTm+thNkvyy6tAGv3tNS2stPiw/
         a2loo/fEaRLGQ==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs: introduce readmore decompression strategy
Date:   Fri,  8 Oct 2021 01:06:05 +0800
Message-Id: <20211007170605.7062-4-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007170605.7062-1-xiang@kernel.org>
References: <20211007170605.7062-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Previously, the requested read length is strictly followed by EROFS
decompression strategy. However, it's quite inefficient to apply
partial decompression if non-negligible data in big pclusters needs
to be handled, especially for the upcoming LZMA algorithm.

Let's decompress more for the cases above as what other fses did.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 16 ++++++++
 fs/erofs/zdata.c    | 94 ++++++++++++++++++++++++++++++++++++---------
 fs/erofs/zmap.c     |  4 +-
 3 files changed, 94 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 48bfc6eb2b02..e7378795a26c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -307,6 +307,19 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
 			      EROFS_I_DATALAYOUT_BITS);
 }
 
+/*
+ * Different from grab_cache_page_nowait(), reclaiming is never triggered
+ * when allocating new pages.
+ */
+static inline
+struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
+					  pgoff_t index)
+{
+	return pagecache_get_page(mapping, index,
+			FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
+			readahead_gfp_mask(mapping) & ~__GFP_RECLAIM);
+}
+
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
@@ -368,6 +381,8 @@ struct erofs_map_blocks {
  * approach instead if possible since it's more metadata lightweight.)
  */
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
+/* Used to map the whole extent if non-negligible data is already requested */
+#define EROFS_GET_BLOCKS_READMORE	0x0004
 
 enum {
 	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
@@ -375,6 +390,7 @@ enum {
 };
 
 /* zmap.c */
+#define Z_EROFS_LZ4_READMORE_THRESHOLD		(9 * EROFS_BLKSIZ)
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
 #ifdef CONFIG_EROFS_FS_ZIP
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5c34ef66677f..a1861a9acfd0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1377,6 +1377,67 @@ static void z_erofs_runqueue(struct super_block *sb,
 	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
 }
 
+static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
+				      struct readahead_control *rac,
+				      erofs_off_t end,
+				      struct list_head *pagepool,
+				      bool backmost)
+{
+	struct inode *const inode = f->inode;
+	struct erofs_map_blocks *const map = &f->map;
+	erofs_off_t cur;
+	int err;
+
+	if (backmost) {
+		map->m_la = end;
+		err = z_erofs_map_blocks_iter(inode, map,
+					      EROFS_GET_BLOCKS_READMORE);
+		if (err)
+			return;
+		end = round_up(end, PAGE_SIZE);
+
+		/* expend ra for the trailing edge if readahead */
+		if (rac) {
+			loff_t newstart = readahead_pos(rac);
+
+			readahead_expand(rac, newstart, end - newstart);
+			return;
+		}
+	} else {
+		end = round_up(map->m_la, PAGE_SIZE);
+
+		if (!map->m_llen)
+			return;
+	}
+
+	cur = map->m_la + map->m_llen - 1;
+	while (cur >= end) {
+		pgoff_t index = cur >> PAGE_SHIFT;
+		struct page *page;
+
+		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
+		if (!page)
+			goto skip;
+
+		if (PageUptodate(page)) {
+			unlock_page(page);
+			put_page(page);
+			goto skip;
+		}
+
+		err = z_erofs_do_read_page(f, page, pagepool);
+		if (err)
+			erofs_err(inode->i_sb,
+				  "readmore error at page %lu @ nid %llu",
+				  index, EROFS_I(inode)->nid);
+		put_page(page);
+skip:
+		if (cur < PAGE_SIZE)
+			break;
+		cur = (index << PAGE_SHIFT) - 1;
+	}
+}
+
 static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
@@ -1385,10 +1446,13 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	LIST_HEAD(pagepool);
 
 	trace_erofs_readpage(page, false);
-
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
+	z_erofs_pcluster_readmore(&f, NULL, f.headoffset + PAGE_SIZE - 1,
+				  &pagepool, true);
 	err = z_erofs_do_read_page(&f, page, &pagepool);
+	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
+
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
@@ -1409,29 +1473,20 @@ static void z_erofs_readahead(struct readahead_control *rac)
 {
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
-
-	unsigned int nr_pages = readahead_count(rac);
-	bool sync = (sbi->ctx.readahead_sync_decompress &&
-			nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
+	unsigned int nr_pages;
 	LIST_HEAD(pagepool);
 
-	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
-
 	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
-	while ((page = readahead_page(rac))) {
-		prefetchw(&page->flags);
-
-		/*
-		 * A pure asynchronous readahead is indicated if
-		 * a PG_readahead marked page is hitted at first.
-		 * Let's also do asynchronous decompression for this case.
-		 */
-		sync &= !(PageReadahead(page) && !head);
+	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
+				  readahead_length(rac) - 1, &pagepool, true);
+	nr_pages = readahead_count(rac);
+	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
+	while ((page = readahead_page(rac))) {
 		set_page_private(page, (unsigned long)head);
 		head = page;
 	}
@@ -1450,11 +1505,12 @@ static void z_erofs_readahead(struct readahead_control *rac)
 				  page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
-
+	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
 	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool, sync);
-
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
+			 sbi->ctx.readahead_sync_decompress &&
+			 nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a61cc7f55ef0..7f42a1c8a338 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -673,7 +673,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	else
 		map->m_algorithmformat = vi->z_algorithmtype[0];
 
-	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
+	if (flags & EROFS_GET_BLOCKS_FIEMAP ||
+	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
+	     map->m_llen >= Z_EROFS_LZ4_READMORE_THRESHOLD)) {
 		err = z_erofs_get_extent_decompressedlen(&m);
 		if (!err)
 			map->m_flags |= EROFS_MAP_FULL_MAPPED;
-- 
2.20.1

