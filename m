Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78590375131
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbhEFJCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:02:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17473 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhEFJCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:02:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FbSDB6l8vzkWwZ;
        Thu,  6 May 2021 16:58:34 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 17:01:00 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: fix to free compress page correctly
Date:   Thu, 6 May 2021 17:00:43 +0800
Message-ID: <20210506090043.39875-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In error path of f2fs_write_compressed_pages(), it needs to call
f2fs_compress_free_page() to release temporary page.

Fixes: 5e6bbde95982 ("f2fs: introduce mempool for {,de}compress intermediate page allocation")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d911dff24253..e15ada12d1e8 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1382,7 +1382,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	for (i = 0; i < cc->nr_cpages; i++) {
 		if (!cc->cpages[i])
 			continue;
-		f2fs_put_page(cc->cpages[i], 1);
+		f2fs_compress_free_page(cc->cpages[i]);
+		cc->cpages[i] = NULL;
 	}
 out_put_cic:
 	kmem_cache_free(cic_entry_slab, cic);
-- 
2.29.2

