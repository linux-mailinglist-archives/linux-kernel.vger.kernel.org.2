Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4F35DB2D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbhDMJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:31:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17324 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241815AbhDMJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:31:23 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKKzd53L2zB06w;
        Tue, 13 Apr 2021 17:28:45 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 17:30:54 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Yi Chen <chenyi77@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Ge Qiu <qiuge@huawei.com>, Dehe Gu <gudehe@huawei.com>
Subject: [PATCH] f2fs: fix to avoid NULL pointer dereference
Date:   Tue, 13 Apr 2021 17:30:50 +0800
Message-ID: <20210413093050.25201-1-yuchao0@huawei.com>
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

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
pc : f2fs_put_page+0x1c/0x26c
lr : __revoke_inmem_pages+0x544/0x75c
f2fs_put_page+0x1c/0x26c
__revoke_inmem_pages+0x544/0x75c
__f2fs_commit_inmem_pages+0x364/0x3c0
f2fs_commit_inmem_pages+0xc8/0x1a0
f2fs_ioc_commit_atomic_write+0xa4/0x15c
f2fs_ioctl+0x5b0/0x1574
file_ioctl+0x154/0x320
do_vfs_ioctl+0x164/0x740
__arm64_sys_ioctl+0x78/0xa4
el0_svc_common+0xbc/0x1d0
el0_svc_handler+0x74/0x98
el0_svc+0x8/0xc

In f2fs_put_page, we access page->mapping is NULL.
The root cause is:
In some cases, the page refcount and ATOMIC_WRITTEN_PAGE
flag miss set for page-priavte flag has been set.
We add f2fs_bug_on like this:

f2fs_register_inmem_page()
{
	...
	f2fs_set_page_private(page, ATOMIC_WRITTEN_PAGE);

	f2fs_bug_on(F2FS_I_SB(inode), !IS_ATOMIC_WRITTEN_PAGE(page));
	...
}

The bug on stack follow link this:
PC is at f2fs_register_inmem_page+0x238/0x2b4
LR is at f2fs_register_inmem_page+0x2a8/0x2b4
f2fs_register_inmem_page+0x238/0x2b4
f2fs_set_data_page_dirty+0x104/0x164
set_page_dirty+0x78/0xc8
f2fs_write_end+0x1b4/0x444
generic_perform_write+0x144/0x1cc
__generic_file_write_iter+0xc4/0x174
f2fs_file_write_iter+0x2c0/0x350
__vfs_write+0x104/0x134
vfs_write+0xe8/0x19c
SyS_pwrite64+0x78/0xb8

To fix this issue, let's add page refcount add page-priavte flag.
The page-private flag is not cleared and needs further analysis.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Ge Qiu <qiuge@huawei.com>
Signed-off-by: Dehe Gu <gudehe@huawei.com>
Signed-off-by: Yi Chen <chenyi77@huawei.com>
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0cb1ca88d4aa..d6c6c13feb43 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -186,7 +186,10 @@ void f2fs_register_inmem_page(struct inode *inode, struct page *page)
 {
 	struct inmem_pages *new;
 
-	f2fs_set_page_private(page, ATOMIC_WRITTEN_PAGE);
+	if (PagePrivate(page))
+		set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
+	else
+		f2fs_set_page_private(page, ATOMIC_WRITTEN_PAGE);
 
 	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
 
-- 
2.29.2

