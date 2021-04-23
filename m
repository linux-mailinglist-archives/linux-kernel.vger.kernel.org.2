Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC601368CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhDWGKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:10:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17394 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWGKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:10:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FRP3J4vYDzlZ9B;
        Fri, 23 Apr 2021 14:07:56 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 23 Apr 2021 14:09:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: clean up left deprecated IO trace codes
Date:   Fri, 23 Apr 2021 14:09:38 +0800
Message-ID: <20210423060938.23020-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d5f7bc0064e0 ("f2fs: deprecate f2fs_trace_io") left some
dead codes, delete them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 6 ------
 fs/f2fs/f2fs.h     | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 9961d04d5ad8..38dbe123e410 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -78,12 +78,6 @@ bool f2fs_is_compressed_page(struct page *page)
 		return false;
 	if (IS_ATOMIC_WRITTEN_PAGE(page) || IS_DUMMY_WRITTEN_PAGE(page))
 		return false;
-	/*
-	 * page->private may be set with pid.
-	 * pid_max is enough to check if it is traced.
-	 */
-	if (IS_IO_TRACED_PAGE(page))
-		return false;
 
 	f2fs_bug_on(F2FS_M_SB(page->mapping),
 		*((u32 *)page_private(page)) != F2FS_COMPRESSED_PAGE_MAGIC);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 244dbb80e94d..40e126b33256 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1304,14 +1304,6 @@ enum {
 #define IS_DUMMY_WRITTEN_PAGE(page)			\
 		(page_private(page) == DUMMY_WRITTEN_PAGE)
 
-#ifdef CONFIG_F2FS_IO_TRACE
-#define IS_IO_TRACED_PAGE(page)			\
-		(page_private(page) > 0 &&		\
-		 page_private(page) < (unsigned long)PID_MAX_LIMIT)
-#else
-#define IS_IO_TRACED_PAGE(page) (0)
-#endif
-
 /* For compression */
 enum compress_algorithm_type {
 	COMPRESS_LZO,
-- 
2.29.2

