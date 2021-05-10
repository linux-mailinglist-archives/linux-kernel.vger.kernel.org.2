Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7208A377F67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhEJJbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:31:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2752 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhEJJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:31:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FdwgX4FhTzqV24;
        Mon, 10 May 2021 17:27:20 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 17:30:34 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: compress: fix race condition of overwrite vs truncate
Date:   Mon, 10 May 2021 17:30:31 +0800
Message-ID: <20210510093032.35466-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510093032.35466-1-yuchao0@huawei.com>
References: <20210510093032.35466-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pos_fsstress testcase complains a panic as belew:

------------[ cut here ]------------
kernel BUG at fs/f2fs/compress.c:1082!
invalid opcode: 0000 [#1] SMP PTI
CPU: 4 PID: 2753477 Comm: kworker/u16:2 Tainted: G           OE     5.12.0-rc1-custom #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Workqueue: writeback wb_workfn (flush-252:16)
RIP: 0010:prepare_compress_overwrite+0x4c0/0x760 [f2fs]
Call Trace:
 f2fs_prepare_compress_overwrite+0x5f/0x80 [f2fs]
 f2fs_write_cache_pages+0x468/0x8a0 [f2fs]
 f2fs_write_data_pages+0x2a4/0x2f0 [f2fs]
 do_writepages+0x38/0xc0
 __writeback_single_inode+0x44/0x2a0
 writeback_sb_inodes+0x223/0x4d0
 __writeback_inodes_wb+0x56/0xf0
 wb_writeback+0x1dd/0x290
 wb_workfn+0x309/0x500
 process_one_work+0x220/0x3c0
 worker_thread+0x53/0x420
 kthread+0x12f/0x150
 ret_from_fork+0x22/0x30

The root cause is truncate() may race with overwrite as below,
so that one reference count left in page can not guarantee the
page attaching in mapping tree all the time, after truncation,
later find_lock_page() may return NULL pointer.

- prepare_compress_overwrite
 - f2fs_pagecache_get_page
 - unlock_page
					- f2fs_setattr
					 - truncate_setsize
					  - truncate_inode_page
					   - delete_from_page_cache
 - find_lock_page

Fix this by avoiding referencing updated page.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d5cb0ba9a0e1..340815cd0887 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -118,19 +118,6 @@ static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
 	f2fs_drop_rpages(cc, len, true);
 }
 
-static void f2fs_put_rpages_mapping(struct address_space *mapping,
-				pgoff_t start, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		struct page *page = find_get_page(mapping, start + i);
-
-		put_page(page);
-		put_page(page);
-	}
-}
-
 static void f2fs_put_rpages_wbc(struct compress_ctx *cc,
 		struct writeback_control *wbc, bool redirty, int unlock)
 {
@@ -1040,7 +1027,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		}
 
 		if (PageUptodate(page))
-			unlock_page(page);
+			f2fs_put_page(page, 1);
 		else
 			f2fs_compress_ctx_add_page(cc, page);
 	}
@@ -1050,32 +1037,34 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
 					&last_block_in_bio, false, true);
+		f2fs_put_rpages(cc);
 		f2fs_destroy_compress_ctx(cc);
 		if (ret)
-			goto release_pages;
+			goto out;
 		if (bio)
 			f2fs_submit_bio(sbi, bio, DATA);
 
 		ret = f2fs_init_compress_ctx(cc);
 		if (ret)
-			goto release_pages;
+			goto out;
 	}
 
 	for (i = 0; i < cc->cluster_size; i++) {
 		f2fs_bug_on(sbi, cc->rpages[i]);
 
 		page = find_lock_page(mapping, start_idx + i);
-		f2fs_bug_on(sbi, !page);
+		if (!page) {
+			/* page can be truncated */
+			goto release_and_retry;
+		}
 
 		f2fs_wait_on_page_writeback(page, DATA, true, true);
-
 		f2fs_compress_ctx_add_page(cc, page);
-		f2fs_put_page(page, 0);
 
 		if (!PageUptodate(page)) {
+release_and_retry:
+			f2fs_put_rpages(cc);
 			f2fs_unlock_rpages(cc, i + 1);
-			f2fs_put_rpages_mapping(mapping, start_idx,
-					cc->cluster_size);
 			f2fs_destroy_compress_ctx(cc);
 			goto retry;
 		}
@@ -1108,10 +1097,10 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	}
 
 unlock_pages:
+	f2fs_put_rpages(cc);
 	f2fs_unlock_rpages(cc, i);
-release_pages:
-	f2fs_put_rpages_mapping(mapping, start_idx, i);
 	f2fs_destroy_compress_ctx(cc);
+out:
 	return ret;
 }
 
-- 
2.29.2

