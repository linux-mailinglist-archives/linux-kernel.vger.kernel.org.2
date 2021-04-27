Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119E036BDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhD0DI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:08:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16491 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhD0DI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:08:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FTmph64zqzvTF3;
        Tue, 27 Apr 2021 11:05:16 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 27 Apr 2021 11:07:34 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: compress: remove unneed check condition
Date:   Tue, 27 Apr 2021 11:07:30 +0800
Message-ID: <20210427030730.90331-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes as below:
- remove unneeded check condition in __cluster_may_compress()
- rename __cluster_may_compress() to cluster_has_invalid_data() for
better readability
- add cp_error check in f2fs_write_compressed_pages() like we did
in f2fs_write_single_data_page()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rename function for better readability
- add cp_error check in f2fs_write_compressed_pages()
 fs/f2fs/compress.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 6e46a00c1930..53f78befed8f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -888,9 +888,8 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
 	return is_page_in_cluster(cc, index);
 }
 
-static bool __cluster_may_compress(struct compress_ctx *cc)
+static bool cluster_has_invalid_data(struct compress_ctx *cc)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	loff_t i_size = i_size_read(cc->inode);
 	unsigned nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE);
 	int i;
@@ -898,18 +897,13 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
 	for (i = 0; i < cc->cluster_size; i++) {
 		struct page *page = cc->rpages[i];
 
-		f2fs_bug_on(sbi, !page);
-
-		if (unlikely(f2fs_cp_error(sbi)))
-			return false;
-		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-			return false;
+		f2fs_bug_on(F2FS_I_SB(cc->inode), !page);
 
 		/* beyond EOF */
 		if (page->index >= nr_pages)
-			return false;
+			return true;
 	}
-	return true;
+	return false;
 }
 
 static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
@@ -985,7 +979,7 @@ static bool cluster_may_compress(struct compress_ctx *cc)
 		return false;
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(cc->inode))))
 		return false;
-	return __cluster_may_compress(cc);
+	return !cluster_has_invalid_data(cc);
 }
 
 static void set_cluster_writeback(struct compress_ctx *cc)
@@ -1232,6 +1226,12 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
+	/* we should bypass data pages to proceed the kworkder jobs */
+	if (unlikely(f2fs_cp_error(sbi))) {
+		mapping_set_error(cc->rpages[0]->mapping, -EIO);
+		goto out_free;
+	}
+
 	if (IS_NOQUOTA(inode)) {
 		/*
 		 * We need to wait for node_write to avoid block allocation during
-- 
2.29.2

