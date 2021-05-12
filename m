Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7580537B9AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhELJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:54:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3734 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:54:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg94X6dhbzqTTw;
        Wed, 12 May 2021 17:49:48 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:53:04 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: compress: remove unneeded preallocation
Date:   Wed, 12 May 2021 17:52:58 +0800
Message-ID: <20210512095258.96918-3-yuchao0@huawei.com>
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

We will reserve iblocks for compression saved, so during compressed
cluster overwrite, we don't need to preallocate blocks for later
write.

In addition, it adds a bug_on to detect wrong reserved iblock number
in __f2fs_cluster_blocks().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 26 ++------------------------
 fs/f2fs/file.c     |  4 ----
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b6bd6862eef2..25e785e0d9fc 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -932,6 +932,8 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 					ret++;
 			}
 		}
+
+		f2fs_bug_on(F2FS_I_SB(inode), !compr && ret != cluster_size);
 	}
 fail:
 	f2fs_put_dnode(&dn);
@@ -992,21 +994,16 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	struct address_space *mapping = cc->inode->i_mapping;
 	struct page *page;
-	struct dnode_of_data dn;
 	sector_t last_block_in_bio;
 	unsigned fgp_flag = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t start_idx = start_idx_of_cluster(cc);
 	int i, ret;
-	bool prealloc;
 
 retry:
 	ret = f2fs_is_compressed_cluster(cc->inode, start_idx);
 	if (ret <= 0)
 		return ret;
 
-	/* compressed case */
-	prealloc = (ret < cc->cluster_size);
-
 	ret = f2fs_init_compress_ctx(cc);
 	if (ret)
 		return ret;
@@ -1064,25 +1061,6 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		}
 	}
 
-	if (prealloc) {
-		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
-
-		set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
-
-		for (i = cc->cluster_size - 1; i > 0; i--) {
-			ret = f2fs_get_block(&dn, start_idx + i);
-			if (ret) {
-				i = cc->cluster_size;
-				break;
-			}
-
-			if (dn.data_blkaddr != NEW_ADDR)
-				break;
-		}
-
-		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
-	}
-
 	if (likely(!ret)) {
 		*fsdata = cc->rpages;
 		*pagep = cc->rpages[offset_in_cluster(cc, index)];
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9241e8e3ffff..1dd69c88be36 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -85,10 +85,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 			err = ret;
 			goto err;
 		} else if (ret) {
-			if (ret < F2FS_I(inode)->i_cluster_size) {
-				err = -EAGAIN;
-				goto err;
-			}
 			need_alloc = false;
 		}
 	}
-- 
2.29.2

