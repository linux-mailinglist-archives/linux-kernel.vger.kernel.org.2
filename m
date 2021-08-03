Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6DD3DEB15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhHCKkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235532AbhHCKkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23B7760F58;
        Tue,  3 Aug 2021 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627987198;
        bh=BYPyS4AlWi17PXRhXJnvrLUYWQwjf7I+Rji+oZ8bgA4=;
        h=From:To:Cc:Subject:Date:From;
        b=sfWFNqMa9PPSf5cTjYB0L5HGbhltwQoI0AkeLAF0rIBZ2zrU6cg7dLIThcarIvdFf
         dWNEF1j2y4oLTvbF8QRDeMBlw23/q/63k/+nxdY1D9CEvdhaCYD3+rRoj1/JIx0Mtf
         IoYiMIncusn0zciPu5/eEkSz4nRy2rcbMLQitRcBY8bipcllKlful4z1OJxxkmpjOf
         0zDDXPMzhBLU7FkL8DnJck0lyE14kRaRgSTxD+KU8R8MxzR/SxRXgu/u+Kkl01ZcUB
         9P07aIXn0swwWCKOJF81ViOIBPd3fhKRuz6j9QSu930dF2ywyNeAa8ja3S6DZfw+oo
         VhwiGYt+LcBRw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: compress: do sanity check on cluster
Date:   Tue,  3 Aug 2021 18:39:52 +0800
Message-Id: <20210803103952.737222-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds f2fs_sanity_check_cluster() to support doing
sanity check on cluster of compressed file, it will be triggered
from below two paths:

- __f2fs_cluster_blocks()
- f2fs_map_blocks(F2FS_GET_BLOCK_FIEMAP)

And it can detect below three kind of cluster insanity status.

C: COMPRESS_ADDR
N: NULL_ADDR or NEW_ADDR
V: valid blkaddr
*: any value

1. [*|C|*|*]
2. [C|*|C|*]
3. [C|N|N|V]

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/data.c     | 21 ++++++++++++------
 fs/f2fs/f2fs.h     |  1 +
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 455561826c7d..4aa166d3d9bf 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -898,6 +898,54 @@ static bool cluster_has_invalid_data(struct compress_ctx *cc)
 	return false;
 }
 
+bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	unsigned int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
+	bool compressed = dn->data_blkaddr == COMPRESS_ADDR;
+	int cluster_end = 0;
+	int i;
+	char *reason = "";
+
+	if (!compressed)
+		return false;
+
+	/* [..., COMPR_ADDR, ...] */
+	if (dn->ofs_in_node % cluster_size) {
+		reason = "[*|C|*|*]";
+		goto out;
+	}
+
+	for (i = 1; i < cluster_size; i++) {
+		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
+							dn->ofs_in_node + i);
+
+		/* [COMPR_ADDR, ..., COMPR_ADDR] */
+		if (blkaddr == COMPRESS_ADDR) {
+			reason = "[C|*|C|*]";
+			goto out;
+		}
+		if (compressed) {
+			if (!__is_valid_data_blkaddr(blkaddr)) {
+				if (!cluster_end)
+					cluster_end = i;
+				continue;
+			}
+			/* [COMPR_ADDR, NULL_ADDR or NEW_ADDR, valid_blkaddr] */
+			if (cluster_end) {
+				reason = "[C|N|N|V]";
+				goto out;
+			}
+		}
+	}
+	return false;
+out:
+	f2fs_warn(sbi, "access invalid cluster, ino:%lu, nid:%u, ofs_in_node:%u, reason:%s",
+			dn->inode->i_ino, dn->nid, dn->ofs_in_node, reason);
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	return true;
+}
+
 static int __f2fs_cluster_blocks(struct inode *inode,
 				unsigned int cluster_idx, bool compr)
 {
@@ -915,6 +963,11 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 		goto fail;
 	}
 
+	if (f2fs_sanity_check_cluster(&dn)) {
+		ret = -EFSCORRUPTED;
+		goto fail;
+	}
+
 	if (dn.data_blkaddr == COMPRESS_ADDR) {
 		int i;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 948083c88d17..75dda2035f68 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1558,13 +1558,20 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			}
 			if (flag == F2FS_GET_BLOCK_PRECACHE)
 				goto sync_out;
-			if (flag == F2FS_GET_BLOCK_FIEMAP &&
-						blkaddr == NULL_ADDR) {
-				if (map->m_next_pgofs)
-					*map->m_next_pgofs = pgofs + 1;
-				goto sync_out;
-			}
-			if (flag != F2FS_GET_BLOCK_FIEMAP) {
+			if (flag == F2FS_GET_BLOCK_FIEMAP) {
+				if (blkaddr == NULL_ADDR) {
+					if (map->m_next_pgofs)
+						*map->m_next_pgofs = pgofs + 1;
+					goto sync_out;
+				}
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+				if (f2fs_compressed_file(inode) &&
+					f2fs_sanity_check_cluster(&dn)) {
+					err = -EFSCORRUPTED;
+					goto sync_out;
+				}
+#endif
+			} else {
 				/* for defragment case */
 				if (map->m_next_pgofs)
 					*map->m_next_pgofs = pgofs + 1;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 20389b9b3eac..86d416ffad61 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4060,6 +4060,7 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
 							block_t blkaddr);
 bool f2fs_cluster_is_empty(struct compress_ctx *cc);
 bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
+bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
 void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
 int f2fs_write_multi_pages(struct compress_ctx *cc,
 						int *submitted,
-- 
2.22.1

