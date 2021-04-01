Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61874350D1E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhDADat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233392AbhDADaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:30:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB416610D0;
        Thu,  1 Apr 2021 03:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617247813;
        bh=e3ltakU8Qa1bsgU6gEhQQ7DHA82eXpVVBXlX6iVuWfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oV7GUgfiYqSQDBcF5B3e4xuyBkT5cZjTxoCUc6L6y4OYcntWfYbVnxYO6ughE+jPA
         i/qOmawmF56JrJjARGiPjuJeitU4844iDzyy7aR70sksXJjSz45chuiET2JRE5fkp5
         r+51OLItYm1ymEQ+Wpf6Py5YBFJv/9XpJfs+qFOyTjG+UolDDKmlrMxUdNGc0VHQ2P
         aixxcO4AGap0Zx4Aj/tfqeKZk6cgyQ4FVxITsGD1QDKQAMEN+FzjdG/sQGf0WqL94g
         LQy9KIppQI/kd4oGxiJxhjbNZWy/dgfD8Iges4KkUrlG83XxdNA9KPbNzMKglw33lR
         b4ieqSw6te5TQ==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 05/10] erofs: add big physical cluster definition
Date:   Thu,  1 Apr 2021 11:29:49 +0800
Message-Id: <20210401032954.20555-6-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Big pcluster indicates the size of compressed data for each physical
pcluster is no longer fixed as block size, but could be more than 1
block (more accurately, 1 logical pcluster)

When big pcluster feature is enabled for head0/1, delta0 of the 1st
non-head lcluster index will keep block count of this pcluster in
lcluster size instead of 1. Or, the compressed size of pcluster
should be 1 lcluster if pcluster has no non-head lcluster index.

Also note that BIG_PCLUSTER feature reuses COMPR_CFGS feature since
it depends on COMPR_CFGS and will be released together.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/erofs_fs.h | 19 +++++++++++++++----
 fs/erofs/internal.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 76777673eb63..ecc3a0ea0bc4 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -19,6 +19,7 @@
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
+#define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
 
 #define EROFS_SB_EXTSLOT_SIZE	16
@@ -214,17 +215,20 @@ enum {
 /* 14 bytes (+ length field = 16 bytes) */
 struct z_erofs_lz4_cfgs {
 	__le16 max_distance;
-	u8 reserved[12];
+	__le16 max_pclusterblks;
+	u8 reserved[10];
 } __packed;
 
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
+ * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
+ * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  */
-#define Z_EROFS_ADVISE_COMPACTED_2B_BIT         0
-
-#define Z_EROFS_ADVISE_COMPACTED_2B     (1 << Z_EROFS_ADVISE_COMPACTED_2B_BIT)
+#define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
+#define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
+#define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 
 struct z_erofs_map_header {
 	__le32	h_reserved1;
@@ -279,6 +283,13 @@ enum {
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
 
+/*
+ * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
+ * compressed block count of a compressed extent (in logical clusters, aka.
+ * block count of a pcluster).
+ */
+#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
+
 struct z_erofs_vle_decompressed_index {
 	__le16 di_advise;
 	/* where to decompress in the head cluster */
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 06c294929069..c4b3938a7e56 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -230,6 +230,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
+EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
-- 
2.20.1

