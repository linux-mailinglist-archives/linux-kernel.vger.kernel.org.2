Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4E367F41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhDVLHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:07:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17813 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhDVLHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:07:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FQvgQ5F2DzBs9f;
        Thu, 22 Apr 2021 19:04:02 +0800 (CST)
Received: from DESKTOP-FKFNUOQ.china.huawei.com (10.67.101.50) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 22 Apr 2021 19:06:20 +0800
From:   lizhe <lizhe67@huawei.com>
To:     <nico@fluxnic.net>, <linux-kernel@vger.kernel.org>
CC:     <wangfangpeng1@huawei.com>, <zhongjubin@huawei.com>,
        <lizhe67@huawei.com>
Subject: [PATCH] cramfs: fix potential "unable to mount root fs" problem
Date:   Thu, 22 Apr 2021 19:06:19 +0800
Message-ID: <20210422110619.90196-1-lizhe67@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.50]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may encounter panic problem without "rootfstype=" options in
bootargs. The logs are listed below.

[0.551962] RAMDISK: squashfs filesystem found at block 0
[0.551977] RAMDISK: Loading 18117KiB [1 disk] into ram disk...
[0.719465] done.
[0.748379] VFS: Cannot open root device "ram0" or unknown-block(1,0): error -92
[0.748390] Please append a correct "root=" boot option; here are the available partitions:
[0.748408] 0100           65536 ram0
[0.748413]  (driver?)
[0.748430] 0101           65536 ram1
[0.748434]  (driver?)
[0.748450] 0102
[0.748454]  (driver?)
[0.748470] 0103           65536 ram3
[0.748475]  (driver?)
[0.748498] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
[0.847579] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0 #68
[0.847598] Call trace:
[0.847616]  dump_backtrace+0x0/0x1f8
[0.847627]  show_stack+0x30/0x40
[0.847638]  dump_stack+0xdc/0x13c
[0.847650]  panic+0x144/0x35c
[0.847665]  mount_block_root+0x2c0/0x36c
[0.847676]  mount_root+0x7c/0x90
[0.847686]  prepare_namespace+0x178/0x188
[0.847697]  kernel_init_freeable+0x220/0x28c
[0.847708]  kernel_init+0x1c/0xf8
[0.847719]  ret_from_fork+0x10/0x30

If we set CONFIG_CRAMFS_MTD and CONFIG_CRAMFS_BLOCKDEV to n,
CONFIG_CRAMFS to y, function cramfs_get_tree return -ENOPROTOOPT,
which breaks loops in function mount_block_root and we have no
chance to try other filesystem type. In my opinion, ENOPROTOOPT
is not an appropriate return value for cramfs mount function, so
change it to EINVAL.

Fixes: 99c18ce58 (cramfs: direct memory access support)
Signed-off-by: lizhe <lizhe67@huawei.com>
---
 fs/cramfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 2be6526..9942955 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -951,7 +951,7 @@ static const struct super_operations cramfs_ops = {
 
 static int cramfs_get_tree(struct fs_context *fc)
 {
-	int ret = -ENOPROTOOPT;
+	int ret = -EINVAL;
 
 	if (IS_ENABLED(CONFIG_CRAMFS_MTD)) {
 		ret = get_tree_mtd(fc, cramfs_mtd_fill_super);
-- 
2.7.4

