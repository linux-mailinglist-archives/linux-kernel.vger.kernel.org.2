Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24E83457E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCWGmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:42:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14064 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhCWGmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:42:05 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4MD52N5yzNq8r;
        Tue, 23 Mar 2021 14:39:33 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 14:41:56 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] Revert "f2fs: give a warning only for readonly partition"
Date:   Tue, 23 Mar 2021 14:41:55 +0800
Message-ID: <20210323064155.12582-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 938a184265d75ea474f1c6fe1da96a5196163789.

Because that commit fails generic/050 testcase which expect failure
during mount a recoverable readonly partition.

Fixes: 938a184265d7 ("f2fs: give a warning only for readonly partition")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b48281642e98..2b78ee11f093 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3952,10 +3952,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		 * previous checkpoint was not done by clean system shutdown.
 		 */
 		if (f2fs_hw_is_readonly(sbi)) {
-			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))
+			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
+				err = -EROFS;
 				f2fs_err(sbi, "Need to recover fsync data, but write access unavailable");
-			else
-				f2fs_info(sbi, "write access unavailable, skipping recovery");
+				goto free_meta;
+			}
+			f2fs_info(sbi, "write access unavailable, skipping recovery");
 			goto reset_checkpoint;
 		}
 
-- 
2.29.2

