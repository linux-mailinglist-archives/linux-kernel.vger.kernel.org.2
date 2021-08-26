Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D33F863D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbhHZLRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:17:40 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15218 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhHZLRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:17:39 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GwKzM5hGwz19Vkw;
        Thu, 26 Aug 2021 19:16:15 +0800 (CST)
Received: from huawei.com (10.175.104.82) by dggeme766-chm.china.huawei.com
 (10.3.19.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 26
 Aug 2021 19:16:49 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <shaggy@kernel.org>
CC:     <jfs-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] jfs: Fix NULL pointer dereference in diFree
Date:   Thu, 26 Aug 2021 19:16:09 +0800
Message-ID: <20210826111609.2982685-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme766-chm.china.huawei.com (10.3.19.112)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a NULL pointer dereference report when doing fuzz test:

 jfs_mount: diMount failed w/rc = -5
 BUG: kernel NULL pointer dereference, address: 0000000000000004
 [...]
 RIP: 0010:diFree+0x5d/0xc70
 [...]
 jfs_evict_inode+0x136/0x180
 jfs_write_inode+0xc0/0xc0
 evict+0x102/0x1f0
 iput+0x220/0x2e0
 diFreeSpecial+0x44/0x70
 jfs_mount+0x1b1/0x460
 jfs_fill_super+0x1a5/0x460
 mount_bdev+0x1d7/0x220
 jfs_do_mount+0x39/0x50
 legacy_get_tree+0x2f/0x80
 vfs_get_tree+0x2f/0x100
 path_mount+0x8e8/0xc7
 do_mount+0x9e/0xc0
 __x64_sys_mount+0xc5/0x140
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Similar to commit 9d574f985fe3 ("jfs: fix GPF in diFree"),
diFreeSpecial(ipimap)->..->diFree() will be called if diMount(ipimap)
fails in jfs_mount(). This will result in a null pointer reference in
diFree() because the imap is not allocated in diFreeSpecial().

int diFree(struct inode *ip)
{
	...
	struct inomap *imap = JFS_IP(ipimap)->i_imap; // imap == NULL
	...
	if (iagno >= imap->im_nextiag) { // null pointer reference
	...
}

If diFreeSpecial(ipimap) in jfs_mount() fails, there is no need to
call diFree(), because diAlloc() is not called in the mount process.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/jfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 57ab424c05ff..e8303d47a4a4 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -146,12 +146,14 @@ void jfs_evict_inode(struct inode *inode)
 		dquot_initialize(inode);
 
 		if (JFS_IP(inode)->fileset == FILESYSTEM_I) {
+			struct inode *ipimap = JFS_SBI(inode->i_sb)->ipimap;
+
 			truncate_inode_pages_final(&inode->i_data);
 
 			if (test_cflag(COMMIT_Freewmap, inode))
 				jfs_free_zero_link(inode);
 
-			if (JFS_SBI(inode->i_sb)->ipimap)
+			if (ipimap && JFS_IP(ipimap)->i_imap)
 				diFree(inode);
 
 			/*
-- 
2.17.1

