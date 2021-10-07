Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F273D4258E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbhJGRIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243201AbhJGRIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:08:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 629BB60F4C;
        Thu,  7 Oct 2021 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633626386;
        bh=JhdYffEiIUYU7A0SDKF8V5RTR941/34K0F9zKE1Tys0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roXe0dOEpbsV12IEftsC76dWpsbRVpdL7QHmlFuhXDKKGreygHhqBokesyw3oj2Z9
         ApbrJftARNg79C5yjRwgb8khTXWNmD/Jsa+I3I3jOmfm4Uql+dVlFo1EI01ZoZ6nMf
         xmDOjLWsTVag6LrPyx5oybeCBb30EZVChRwTyIWAezaEqRClVrbx3yvwUwCAPGv4pD
         L4scU5OUGT+pM3JYLtk/7wV+9ZkMKB/noECJ5B8oD3QUnTAP0frws3v0qiLPhYE1Xn
         63n2o1dmp3oQxUD/hyb3sV6EYdJ3a9Mme3vuUq04SaOq9XYT8S423e7lVAXxLBgNdw
         USMvpmZkWzyxQ==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs: introduce the secondary compression head
Date:   Fri,  8 Oct 2021 01:06:04 +0800
Message-Id: <20211007170605.7062-3-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007170605.7062-1-xiang@kernel.org>
References: <20211007170605.7062-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Previously, for each HEAD lcluster, it can be either HEAD or PLAIN
lcluster to indicate whether the whole pcluster is compressed or not.

In this patch, a new HEAD2 head type is introduced to specify another
compression algorithm other than the primary algorithm for each
compressed file, which can be used for upcoming LZMA compression and
LZ4 range dictionary compression for various data patterns.

It has been stayed in the EROFS roadmap for years. Complete it now!

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  8 +++++---
 fs/erofs/zmap.c     | 34 +++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b0b23f41abc3..f579c8c78fff 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -21,11 +21,13 @@
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
+#define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
-	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
+	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
+	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -314,9 +316,9 @@ struct z_erofs_map_header {
  */
 enum {
 	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
 	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
-	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,
 	Z_EROFS_VLE_CLUSTER_TYPE_MAX
 };
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9d9c26343dab..a61cc7f55ef0 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -69,11 +69,17 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err(sb, "unknown compression format %u for nid %llu, please upgrade kernel",
+		erofs_err(sb, "unknown HEAD1 format %u for nid %llu, please upgrade kernel",
 			  vi->z_algorithmtype[0], vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_done;
 	}
+	if (vi->z_algorithmtype[1] >= Z_EROFS_COMPRESSION_MAX) {
+		erofs_err(sb, "unknown HEAD2 format %u for nid %llu, please upgrade kernel",
+			  vi->z_algorithmtype[1], vi->nid);
+		err = -EOPNOTSUPP;
+		goto unmap_done;
+	}
 
 	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
 	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
@@ -189,7 +195,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
@@ -446,7 +453,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		}
 		return z_erofs_extent_lookback(m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
 		m->headtype = m->type;
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
@@ -470,13 +478,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	int err;
 
 	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 &&
+		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD2);
+	DBG_BUGON(m->type != m->headtype);
+
 	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1) &&
+	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
+	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) &&
+	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 		map->m_plen = 1 << lclusterbits;
 		return 0;
 	}
-
 	lcn = m->lcn + 1;
 	if (m->compressedlcs)
 		goto out;
@@ -498,7 +511,8 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	switch (m->type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
@@ -553,7 +567,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			DBG_BUGON(!m->delta[1] &&
 				  m->clusterofs != 1 << lclusterbits);
 		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
+			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 ||
+			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
 			/* go on until the next HEAD lcluster */
 			if (lcn != headlcn)
 				break;
@@ -612,7 +627,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 
 	switch (m.type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
-- 
2.20.1

