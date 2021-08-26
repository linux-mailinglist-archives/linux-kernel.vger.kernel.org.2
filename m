Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96B03F8049
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhHZCEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237930AbhHZCEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E96460F5C;
        Thu, 26 Aug 2021 02:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629943403;
        bh=/e7s8OHhSJWB06eMdrxjfFecme8EyMtS8cI5Ew9WuX8=;
        h=From:To:Cc:Subject:Date:From;
        b=HGtn92z8/PNNaHuSsUgeUxMJW3B2l3O6tP4it/rTNaT+8/vh7vhX/gCluuViBGrWZ
         5cOpf0EtXLqcgP0dBbIETMTVwYQnTzobh5EtSx6ZKjUtxzPyXiuE28xgzBf7MBKFZ9
         2yezHlTcuW6FE0tfKn2a5AlyZms+SUXHHQLS0a4K/IIfQl6rafM0l2mt+MLJ+h92ba
         RsODULdl7FvrKhm8VbR5tpGNsv/MgHOZa4a/4cIueRn9dKkRSKBtxCEuuENy6i9hQl
         6LnskCM/yOzp5BFgO5IJjFcijj0fxT56XnMFKvyCv9IpLImC930kIag7G85fEeQZJF
         Cg4OaJaXFZGfw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix unexpected ENOENT comes from f2fs_map_blocks()
Date:   Thu, 26 Aug 2021 10:03:15 +0800
Message-Id: <20210826020315.9032-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In below path, it will return ENOENT if filesystem is shutdown:

- f2fs_map_blocks
 - f2fs_get_dnode_of_data
  - f2fs_get_node_page
   - __get_node_page
    - read_node_page
     - is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)
       return -ENOENT
 - force return value from ENOENT to 0

It should be fine for read case, since it indicates a hole condition,
and caller could use .m_next_pgofs to skip the hole and continue the
lookup.

However it may cause confusing for write case, since leaving a hole
there, and said nothing was wrong doesn't help.

There is at least one case from dax_iomap_actor() will complain that,
so fix this in prior to supporting dax in f2fs.

xfstest generic/388 reports below warning:

ubuntu godown: xfstests-induced forced shutdown of /mnt/scratch_f2fs:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 485833 at fs/dax.c:1127 dax_iomap_actor+0x339/0x370
Call Trace:
 iomap_apply+0x1c4/0x7b0
 ? dax_iomap_rw+0x1c0/0x1c0
 dax_iomap_rw+0xad/0x1c0
 ? dax_iomap_rw+0x1c0/0x1c0
 f2fs_file_write_iter+0x5ab/0x970 [f2fs]
 do_iter_readv_writev+0x273/0x2e0
 do_iter_write+0xab/0x1f0
 vfs_iter_write+0x21/0x40
 iter_file_splice_write+0x287/0x540
 do_splice+0x37c/0xa60
 __x64_sys_splice+0x15f/0x3a0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

ubuntu godown: xfstests-induced forced shutdown of /mnt/scratch_f2fs:
------------[ cut here ]------------
RIP: 0010:dax_iomap_pte_fault.isra.0+0x72e/0x14a0
Call Trace:
 dax_iomap_fault+0x44/0x70
 f2fs_dax_huge_fault+0x155/0x400 [f2fs]
 f2fs_dax_fault+0x18/0x30 [f2fs]
 __do_fault+0x4e/0x120
 do_fault+0x3cf/0x7a0
 __handle_mm_fault+0xa8c/0xf20
 ? find_held_lock+0x39/0xd0
 handle_mm_fault+0x1b6/0x480
 do_user_addr_fault+0x320/0xcd0
 ? rcu_read_lock_sched_held+0x67/0xc0
 exc_page_fault+0x77/0x3f0
 ? asm_exc_page_fault+0x8/0x30
 asm_exc_page_fault+0x1e/0x30

Fixes: 83a3bfdb5a8a ("f2fs: indicate shutdown f2fs to allow unmount successfully")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5e4120b92f59..8e8824605f83 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1504,7 +1504,21 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	if (err) {
 		if (flag == F2FS_GET_BLOCK_BMAP)
 			map->m_pblk = 0;
+
 		if (err == -ENOENT) {
+			/*
+			 * There is one exceptional case that read_node_page()
+			 * may return -ENOENT due to filesystem has been
+			 * shutdown or cp_error, so force to convert error
+			 * number to EIO for such case.
+			 */
+			if (map->m_may_create &&
+				(is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
+				f2fs_cp_error(sbi))) {
+				err = -EIO;
+				goto unlock_out;
+			}
+
 			err = 0;
 			if (map->m_next_pgofs)
 				*map->m_next_pgofs =
-- 
2.32.0

