Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5B34F752
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhCaDRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:17:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14970 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhCaDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:16:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9BJ557BLzyNPQ;
        Wed, 31 Mar 2021 11:14:45 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 11:16:43 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to restrict mount condition on readonly block device
Date:   Wed, 31 Mar 2021 11:16:32 +0800
Message-ID: <20210331031632.76800-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we mount an unclean f2fs image in a readonly block device, let's
make mount() succeed only when there is no recoverable data in that
image, otherwise after mount(), file fsyned won't be recovered as user
expected.

Fixes: 938a184265d7 ("f2fs: give a warning only for readonly partition")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 954b1fe97d67..14239e2b7ae7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3966,10 +3966,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		 * previous checkpoint was not done by clean system shutdown.
 		 */
 		if (f2fs_hw_is_readonly(sbi)) {
-			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))
-				f2fs_err(sbi, "Need to recover fsync data, but write access unavailable");
-			else
-				f2fs_info(sbi, "write access unavailable, skipping recovery");
+			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
+				err = f2fs_recover_fsync_data(sbi, true);
+				if (err > 0) {
+					err = -EROFS;
+					f2fs_err(sbi, "Need to recover fsync data, but "
+						"write access unavailable, please try "
+						"mount w/ disable_roll_forward or norecovery");
+				}
+				if (err < 0)
+					goto free_meta;
+			}
+			f2fs_info(sbi, "write access unavailable, skipping recovery");
 			goto reset_checkpoint;
 		}
 
-- 
2.29.2

