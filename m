Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E839AFD9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFDBeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:34:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3417 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhFDBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:34:17 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fx4tf6fclz6v2N;
        Fri,  4 Jun 2021 09:29:30 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 4 Jun 2021 09:32:29 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <ericvh@gmail.com>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
        <v9fs-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] 9p: Fix spelling mistakes
Date:   Fri, 4 Jun 2021 09:46:08 +0800
Message-ID: <20210604014608.2086576-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme760-chm.china.huawei.com (10.3.19.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some spelling mistakes in comments:
functon  ==> function
parallely  ==> parallelly
contians  ==> contains
incase  ==> in case
trasnport  ==> transport
creat  ==> create
assocated  ==> associated

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/9p/v9fs.c           | 2 +-
 fs/9p/vfs_addr.c       | 4 ++--
 fs/9p/vfs_dentry.c     | 2 +-
 fs/9p/vfs_file.c       | 4 ++--
 fs/9p/vfs_inode.c      | 4 ++--
 fs/9p/vfs_inode_dotl.c | 4 ++--
 fs/9p/vfs_super.c      | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index cdb99507ef33..c4a7b78adcb5 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -689,7 +689,7 @@ static int __init init_v9fs(void)
 {
 	int err;
 	pr_info("Installing v9fs 9p2000 file system support\n");
-	/* TODO: Setup list of registered trasnport modules */
+	/* TODO: Setup list of registered transport modules */
 
 	err = v9fs_cache_register();
 	if (err < 0) {
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index cce9ace651a2..c4dd6e8e3a80 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -2,7 +2,7 @@
 /*
  *  linux/fs/9p/vfs_addr.c
  *
- * This file contians vfs address (mmap) ops for 9P2000.
+ * This file contains vfs address (mmap) ops for 9P2000.
  *
  *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
@@ -139,7 +139,7 @@ static void v9fs_invalidate_page(struct page *page, unsigned int offset,
 {
 	/*
 	 * If called with zero offset, we should release
-	 * the private state assocated with the page
+	 * the private state associated with the page
 	 */
 	if (offset == 0 && length == PAGE_SIZE)
 		v9fs_fscache_invalidate_page(page);
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 4b4292123b3d..749238381343 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -2,7 +2,7 @@
 /*
  *  linux/fs/9p/vfs_dentry.c
  *
- * This file contians vfs dentry ops for the 9P2000 protocol.
+ * This file contains vfs dentry ops for the 9P2000 protocol.
  *
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 59c32c9b799f..51f22f8c6820 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -2,7 +2,7 @@
 /*
  *  linux/fs/9p/vfs_file.c
  *
- * This file contians vfs file ops for 9P2000.
+ * This file contains vfs file ops for 9P2000.
  *
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
@@ -223,7 +223,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 out_unlock:
 	/*
-	 * incase server returned error for lock request, revert
+	 * in case server returned error for lock request, revert
 	 * it locally
 	 */
 	if (res < 0 && fl->fl_type != F_UNLCK) {
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 795706520b5e..bbf93906c38f 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -505,7 +505,7 @@ static int v9fs_at_to_dotl_flags(int flags)
 }
 
 /**
- * v9fs_dec_count - helper functon to drop i_nlink.
+ * v9fs_dec_count - helper function to drop i_nlink.
  *
  * If a directory had nlink <= 2 (including . and ..), then we should not drop
  * the link count, which indicates the underlying exported fs doesn't maintain
@@ -778,7 +778,7 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
 	 * the new name. ie look up for a/b, while on server somebody
-	 * moved b under k and client parallely did a lookup for
+	 * moved b under k and client parallelly did a lookup for
 	 * k/b.
 	 */
 	res = d_splice_alias(inode, dentry);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index e1c0240b51c0..58a491b5f877 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -281,14 +281,14 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	/* Update mode based on ACL value */
 	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
 	if (err) {
-		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in creat %d\n",
+		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in create %d\n",
 			 err);
 		goto error;
 	}
 	err = p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_flags(flags),
 				    mode, gid, &qid);
 	if (err < 0) {
-		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in creat %d\n",
+		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in create %d\n",
 			 err);
 		goto error;
 	}
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 5fce6e30bc5a..50816e6fb4e2 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -2,7 +2,7 @@
 /*
  *  linux/fs/9p/vfs_super.c
  *
- * This file contians superblock ops for 9P2000. It is intended that
+ * This file contains superblock ops for 9P2000. It is intended that
  * you mount this file system on directories.
  *
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
-- 
2.25.1

