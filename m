Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A9D3204BF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBTJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:36:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12930 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhBTJgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:36:47 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DjNZR21CWzjPMh;
        Sat, 20 Feb 2021 17:34:39 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 17:35:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix panic during f2fs_resize_fs()
Date:   Sat, 20 Feb 2021 17:35:41 +0800
Message-ID: <20210220093541.63899-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210220093541.63899-1-yuchao0@huawei.com>
References: <20210220093541.63899-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_resize_fs() hangs in below callstack with testcase:
- mkfs 16GB image & mount image
- dd 8GB fileA
- dd 8GB fileB
- sync
- rm fileA
- sync
- resize filesystem to 8GB

kernel BUG at segment.c:2484!
Call Trace:
 allocate_segment_by_default+0x92/0xf0 [f2fs]
 f2fs_allocate_data_block+0x44b/0x7e0 [f2fs]
 do_write_page+0x5a/0x110 [f2fs]
 f2fs_outplace_write_data+0x55/0x100 [f2fs]
 f2fs_do_write_data_page+0x392/0x850 [f2fs]
 move_data_page+0x233/0x320 [f2fs]
 do_garbage_collect+0x14d9/0x1660 [f2fs]
 free_segment_range+0x1f7/0x310 [f2fs]
 f2fs_resize_fs+0x118/0x330 [f2fs]
 __f2fs_ioctl+0x487/0x3680 [f2fs]
 __x64_sys_ioctl+0x8e/0xd0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The root cause is we forgot to check that whether we have enough space
in resized filesystem to store all valid blocks in before-resizing
filesystem, then allocator will run out-of-space during block migration
in free_segment_range().

Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b3af76340026..86ba8ed0b8a7 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1977,7 +1977,20 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 
 	/* stop CP to protect MAIN_SEC in free_segment_range */
 	f2fs_lock_op(sbi);
+
+	spin_lock(&sbi->stat_lock);
+	if (shrunk_blocks + valid_user_blocks(sbi) +
+		sbi->current_reserved_blocks + sbi->unusable_block_count +
+		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
+		err = -ENOSPC;
+	spin_unlock(&sbi->stat_lock);
+
+	if (err)
+		goto out_unlock;
+
 	err = free_segment_range(sbi, secs, true);
+
+out_unlock:
 	f2fs_unlock_op(sbi);
 	up_write(&sbi->gc_lock);
 	if (err)
-- 
2.29.2

