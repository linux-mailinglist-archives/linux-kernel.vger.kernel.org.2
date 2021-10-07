Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845354258E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbhJGRIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243147AbhJGRIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:08:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 108A161040;
        Thu,  7 Oct 2021 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633626382;
        bh=IlwiBKSKF0J3DbDUFfw/bsFkvLi8AFV9yMY1xoI+Kp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hescCMpc/ERoSWE5K51agw2v9J4GRX7Z4mmZBH3QoHmXIdI3H2EhbDyulGZ9Zmyfh
         cmsQLsskXGDdWhYlv82+GEuVBzzDiauXubsTf9GB7EQomRbxB+nh9NanZo/c51LLQj
         PN6PU4VxG17UaZqonipDtr8vfbUeHu5IPd7u5C7RWwy47mbFToX8P2sBjGsftiBfkS
         CL3EjvPoKGZltjSV0i06YEtoXVu6zzwjTzFiLVIaQXrgLX5bjZdw27T8nP7uUuSDkH
         ZICnxZ0XIss3oBo74jETa6L8ICp9Vae1pQ7mYJDFtpqhYkSaNOMFd31t0GMOzc6hcQ
         CIRJcqCYpJJFw==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs: get compression algorithms directly on mapping
Date:   Fri,  8 Oct 2021 01:06:03 +0800
Message-Id: <20211007170605.7062-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007170605.7062-1-xiang@kernel.org>
References: <20211007170605.7062-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Currently, z_erofs_map_blocks returns whether extents are compressed
or not, and the decompression frontend gets the specific algorithms
then.

It works but not quite well in many aspests, for example:
 - The decompression frontend has to deal with whether extents are
   compressed or not again and lookup the algorithms if compressed.
   It's duplicated and too detailed about the on-disk mapping.

 - A new secondary compression head will be introduced later so that
   each file can have 2 compression algorithms at most for different
   type of data. It could increase the complexity of the decompression
   frontend if still handled in this way;

 - A new readmore decompression strategy will be introduced to get
   better performance for much bigger pcluster and lzma, which needs
   the specific algorithm in advance as well.

Let's look up compression algorithms directly in z_erofs_map_blocks()
instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h          |  5 -----
 fs/erofs/internal.h          | 12 +++++++++---
 fs/erofs/zdata.c             | 12 ++++++------
 fs/erofs/zmap.c              | 19 ++++++++++---------
 include/trace/events/erofs.h |  2 +-
 5 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 3701c72bacb2..ad62d1b4d371 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -8,11 +8,6 @@
 
 #include "internal.h"
 
-enum {
-	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
-	Z_EROFS_COMPRESSION_RUNTIME_MAX
-};
-
 struct z_erofs_decompress_req {
 	struct super_block *sb;
 	struct page **in, **out;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9524e155b38f..48bfc6eb2b02 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -338,7 +338,7 @@ extern const struct address_space_operations z_erofs_aops;
  * of the corresponding uncompressed data in the file.
  */
 enum {
-	BH_Zipped = BH_PrivateStart,
+	BH_Encoded = BH_PrivateStart,
 	BH_FullMapped,
 };
 
@@ -346,8 +346,8 @@ enum {
 #define EROFS_MAP_MAPPED	(1 << BH_Mapped)
 /* Located in metadata (could be copied from bd_inode) */
 #define EROFS_MAP_META		(1 << BH_Meta)
-/* The extent has been compressed */
-#define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
+/* The extent is encoded */
+#define EROFS_MAP_ENCODED	(1 << BH_Encoded)
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
 
@@ -355,6 +355,7 @@ struct erofs_map_blocks {
 	erofs_off_t m_pa, m_la;
 	u64 m_plen, m_llen;
 
+	char m_algorithmformat;
 	unsigned int m_flags;
 
 	struct page *mpage;
@@ -368,6 +369,11 @@ struct erofs_map_blocks {
  */
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
 
+enum {
+	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
+	Z_EROFS_COMPRESSION_RUNTIME_MAX
+};
+
 /* zmap.c */
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 11c7a1aaebad..5c34ef66677f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -476,6 +476,11 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	struct erofs_workgroup *grp;
 	int err;
 
+	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+
 	/* no available pcluster, let's allocate one */
 	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
 	if (IS_ERR(pcl))
@@ -483,16 +488,11 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 
 	atomic_set(&pcl->obj.refcount, 1);
 	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
-
+	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
 		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
 			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);
 
-	if (map->m_flags & EROFS_MAP_ZIPPED)
-		pcl->algorithmformat = Z_EROFS_COMPRESSION_LZ4;
-	else
-		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
-
 	/* new pclusters should be claimed as type 1, primary and followed */
 	pcl->next = clt->owned_head;
 	clt->mode = COLLECT_PRIMARY_FOLLOWED;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7a6df35fdc91..9d9c26343dab 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -111,7 +111,7 @@ struct z_erofs_maprecorder {
 
 	unsigned long lcn;
 	/* compression extent information gathered */
-	u8  type;
+	u8  type, headtype;
 	u16 clusterofs;
 	u16 delta[2];
 	erofs_blk_t pblk, compressedlcs;
@@ -446,9 +446,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		}
 		return z_erofs_extent_lookback(m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-		map->m_flags &= ~EROFS_MAP_ZIPPED;
-		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		m->headtype = m->type;
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
 	default:
@@ -472,7 +471,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
 		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
-	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
+	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
 		map->m_plen = 1 << lclusterbits;
 		return 0;
@@ -609,16 +608,13 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	if (err)
 		goto unmap_out;
 
-	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
 	end = (m.lcn + 1ULL) << lclusterbits;
 
 	switch (m.type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-		if (endoff >= m.clusterofs)
-			map->m_flags &= ~EROFS_MAP_ZIPPED;
-		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		if (endoff >= m.clusterofs) {
+			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
 			break;
 		}
@@ -650,12 +646,17 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 
 	map->m_llen = end - map->m_la;
 	map->m_pa = blknr_to_addr(m.pblk);
-	map->m_flags |= EROFS_MAP_MAPPED;
+	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 
 	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 	if (err)
 		goto out;
 
+	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
+		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
+	else
+		map->m_algorithmformat = vi->z_algorithmtype[0];
+
 	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
 		err = z_erofs_get_extent_decompressedlen(&m);
 		if (!err)
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index db4f2cec8360..16ae7b666810 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -24,7 +24,7 @@ struct erofs_map_blocks;
 #define show_mflags(flags) __print_flags(flags, "",	\
 	{ EROFS_MAP_MAPPED,	"M" },			\
 	{ EROFS_MAP_META,	"I" },			\
-	{ EROFS_MAP_ZIPPED,	"Z" })
+	{ EROFS_MAP_ENCODED,	"E" })
 
 TRACE_EVENT(erofs_lookup,
 
-- 
2.20.1

