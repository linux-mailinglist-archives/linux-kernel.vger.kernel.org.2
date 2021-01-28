Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678BA307239
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhA1JEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:04:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11457 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhA1JDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:03:04 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRDyG4PPgzjDQy;
        Thu, 28 Jan 2021 17:02:46 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 17:03:38 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Yi Chen <chenyi77@huawei.com>,
        Daiyue Zhang <zhangdaiyue1@huawei.com>,
        Dehe Gu <gudehe@huawei.com>,
        Junchao Jiang <jiangjunchao1@huawei.com>,
        Ge Qiu <qiuge@huawei.com>
Subject: [PATCH] f2fs: fix to avoid inconsistent quota data
Date:   Thu, 28 Jan 2021 17:02:56 +0800
Message-ID: <20210128090256.73910-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Chen <chenyi77@huawei.com>

Occasionally, quota data may be corrupted detected by fsck:

Info: checkpoint state = 45 :  crc compacted_summary unmount
[QUOTA WARNING] Usage inconsistent for ID 0:actual (1543036928, 762) != expected (1543032832, 762)
[ASSERT] (fsck_chk_quota_files:1986)  --> Quota file is missing or invalid quota file content found.
[QUOTA WARNING] Usage inconsistent for ID 0:actual (1352478720, 344) != expected (1352474624, 344)
[ASSERT] (fsck_chk_quota_files:1986)  --> Quota file is missing or invalid quota file content found.

[FSCK] Unreachable nat entries                        [Ok..] [0x0]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Ok..] [0xdf299]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x2b01]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x2b01]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x2665]
[FSCK] free segment_count matched with CP             [Ok..] [0xcb04]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Fail]

The root cause is:
If we open file w/ readonly flag, disk quota info won't be initialized
for this file, however, following mmap() will force to convert inline
inode via f2fs_convert_inline_inode(), which may increase block usage
for this inode w/o updating quota data, it causes inconsistent disk quota
info.

The issue will happen in following stack:
open(file, O_RDONLY)
mmap(file)
- f2fs_convert_inline_inode
 - f2fs_convert_inline_page
  - f2fs_reserve_block
   - f2fs_reserve_new_block
    - f2fs_reserve_new_blocks
     - f2fs_i_blocks_write
      - dquot_claim_block
inode->i_blocks increase, but the dqb_curspace keep the size for the dquots
is NULL.

To fix this issue, let's call dquot_initialize() anyway in both
f2fs_truncate() and f2fs_convert_inline_inode() functions to avoid potential
inconsistent quota data issue.

Fixes: 0abd675e97e6 ("f2fs: support plain user/group quota")
Signed-off-by: Daiyue Zhang <zhangdaiyue1@huawei.com>
Signed-off-by: Dehe Gu <gudehe@huawei.com>
Signed-off-by: Junchao Jiang <jiangjunchao1@huawei.com>
Signed-off-by: Ge Qiu <qiuge@huawei.com>
Signed-off-by: Yi Chen <chenyi77@huawei.com>
---
 fs/f2fs/file.c   | 4 ++++
 fs/f2fs/inline.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7db27c81d034..00b2ce47fa37 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -771,6 +771,10 @@ int f2fs_truncate(struct inode *inode)
 		return -EIO;
 	}
 
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
 	/* we should check inline_data size */
 	if (!f2fs_may_inline_data(inode)) {
 		err = f2fs_convert_inline_inode(inode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 806ebabf5870..993caefcd2bb 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -192,6 +192,10 @@ int f2fs_convert_inline_inode(struct inode *inode)
 			f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
 		return 0;
 
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
 	page = f2fs_grab_cache_page(inode->i_mapping, 0, false);
 	if (!page)
 		return -ENOMEM;
-- 
2.29.2

