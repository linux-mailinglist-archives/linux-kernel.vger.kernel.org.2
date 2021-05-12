Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3A637B9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhELJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:54:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3733 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhELJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:54:23 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg94Y191RzqTV6;
        Wed, 12 May 2021 17:49:49 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:53:04 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: compress: clean up parameter of __f2fs_cluster_blocks()
Date:   Wed, 12 May 2021 17:52:57 +0800
Message-ID: <20210512095258.96918-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210512095258.96918-1-yuchao0@huawei.com>
References: <20210512095258.96918-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in order to reuse __f2fs_cluster_blocks(),
f2fs_is_compressed_cluster() assigned a compress_ctx type variable,
which is used to pass few parameters (cc.inode, cc.cluster_size,
cc.cluster_idx), it's wasteful to allocate such large space in stack.

Let's clean up parameters of __f2fs_cluster_blocks() to avoid that.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 8bb9e57a6db8..b6bd6862eef2 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -898,14 +898,17 @@ static bool cluster_has_invalid_data(struct compress_ctx *cc)
 	return false;
 }
 
-static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
+static int __f2fs_cluster_blocks(struct inode *inode,
+				unsigned int cluster_idx, bool compr)
 {
 	struct dnode_of_data dn;
+	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
+	unsigned int start_idx = cluster_idx <<
+				F2FS_I(inode)->i_log_cluster_size;
 	int ret;
 
-	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
-	ret = f2fs_get_dnode_of_data(&dn, start_idx_of_cluster(cc),
-							LOOKUP_NODE);
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	ret = f2fs_get_dnode_of_data(&dn, start_idx, LOOKUP_NODE);
 	if (ret) {
 		if (ret == -ENOENT)
 			ret = 0;
@@ -916,7 +919,7 @@ static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
 		int i;
 
 		ret = 1;
-		for (i = 1; i < cc->cluster_size; i++) {
+		for (i = 1; i < cluster_size; i++) {
 			block_t blkaddr;
 
 			blkaddr = data_blkaddr(dn.inode,
@@ -938,25 +941,15 @@ static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
 /* return # of compressed blocks in compressed cluster */
 static int f2fs_compressed_blocks(struct compress_ctx *cc)
 {
-	return __f2fs_cluster_blocks(cc, true);
+	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, true);
 }
 
 /* return # of valid blocks in compressed cluster */
-static int f2fs_cluster_blocks(struct compress_ctx *cc)
-{
-	return __f2fs_cluster_blocks(cc, false);
-}
-
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 {
-	struct compress_ctx cc = {
-		.inode = inode,
-		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
-		.cluster_size = F2FS_I(inode)->i_cluster_size,
-		.cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size,
-	};
-
-	return f2fs_cluster_blocks(&cc);
+	return __f2fs_cluster_blocks(inode,
+		index >> F2FS_I(inode)->i_log_cluster_size,
+		false);
 }
 
 static bool cluster_may_compress(struct compress_ctx *cc)
@@ -1007,7 +1000,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	bool prealloc;
 
 retry:
-	ret = f2fs_cluster_blocks(cc);
+	ret = f2fs_is_compressed_cluster(cc->inode, start_idx);
 	if (ret <= 0)
 		return ret;
 
-- 
2.29.2

