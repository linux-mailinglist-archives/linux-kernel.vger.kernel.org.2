Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003EE350C6B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhDACLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:11:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14658 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhDACLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:11:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9mnP6ZFDzmcfG;
        Thu,  1 Apr 2021 10:08:41 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 10:11:11 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid accessing invalid fio in f2fs_allocate_data_block()
Date:   Thu, 1 Apr 2021 10:10:57 +0800
Message-ID: <20210401021057.32984-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers may pass fio parameter with NULL value to f2fs_allocate_data_block(),
so we should make sure accessing fio's field after fio's validation check.

Fixes: f608c38c59c6 ("f2fs: clean up parameter of f2fs_allocate_data_block()")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c517e689a9a3..d076ae03b5dc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3417,9 +3417,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		f2fs_inode_chksum_set(sbi, page);
 	}
 
-	if (F2FS_IO_ALIGNED(sbi))
-		fio->retry = false;
-
 	if (fio) {
 		struct f2fs_bio_info *io;
 
@@ -3429,6 +3426,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		spin_lock(&io->io_lock);
 		list_add_tail(&fio->list, &io->io_list);
 		spin_unlock(&io->io_lock);
+
+		if (F2FS_IO_ALIGNED(sbi))
+			fio->retry = false;
 	}
 
 	mutex_unlock(&curseg->curseg_mutex);
-- 
2.29.2

