Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4199A327769
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhCAGMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:12:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13013 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhCAGMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:12:13 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dpqbq0pGBzjTh9;
        Mon,  1 Mar 2021 14:09:43 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 14:11:12 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <chao@kernel.org>, Daiyue Zhang <zhangdaiyue1@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        "Christoph Hellwig" <hch@lst.de>, Yi Chen <chenyi77@huawei.com>,
        Ge Qiu <qiuge@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] configfs: Fix use-after-free issue in __configfs_open_file
Date:   Mon, 1 Mar 2021 14:10:53 +0800
Message-ID: <20210301061053.105377-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daiyue Zhang <zhangdaiyue1@huawei.com>

Commit b0841eefd969 ("configfs: provide exclusion between IO and removals")
uses ->frag_dead to mark the fragment state, thus no bothering with extra
refcount on config_item when opening a file. The configfs_get_config_item
was removed in __configfs_open_file, but not with config_item_put. So the
refcount on config_item will lost its balance, causing use-after-free
issues in some occasions like this:

Test:
1. Mount configfs on /config with read-only items:
drwxrwx--- 289 root   root            0 2021-04-01 11:55 /config
drwxr-xr-x   2 root   root            0 2021-04-01 11:54 /config/a
--w--w--w-   1 root   root         4096 2021-04-01 11:53 /config/a/1.txt
......

2. Then run:
for file in /config
do
echo $file
grep -R 'key' $file
done

3. __configfs_open_file will be called in parallel, the first one
got called will do:
if (file->f_mode & FMODE_READ) {
	if (!(inode->i_mode & S_IRUGO))
		goto out_put_module;
			config_item_put(buffer->item);
				kref_put()
					package_details_release()
						kfree()

the other one will run into use-after-free issues like this:
BUG: KASAN: use-after-free in __configfs_open_file+0x1bc/0x3b0
Read of size 8 at addr fffffff155f02480 by task grep/13096
CPU: 0 PID: 13096 Comm: grep VIP: 00 Tainted: G        W       4.14.116-kasan #1
TGID: 13096 Comm: grep
Call trace:
dump_stack+0x118/0x160
kasan_report+0x22c/0x294
__asan_load8+0x80/0x88
__configfs_open_file+0x1bc/0x3b0
configfs_open_file+0x28/0x34
do_dentry_open+0x2cc/0x5c0
vfs_open+0x80/0xe0
path_openat+0xd8c/0x2988
do_filp_open+0x1c4/0x2fc
do_sys_open+0x23c/0x404
SyS_openat+0x38/0x48

Allocated by task 2138:
kasan_kmalloc+0xe0/0x1ac
kmem_cache_alloc_trace+0x334/0x394
packages_make_item+0x4c/0x180
configfs_mkdir+0x358/0x740
vfs_mkdir2+0x1bc/0x2e8
SyS_mkdirat+0x154/0x23c
el0_svc_naked+0x34/0x38

Freed by task 13096:
kasan_slab_free+0xb8/0x194
kfree+0x13c/0x910
package_details_release+0x524/0x56c
kref_put+0xc4/0x104
config_item_put+0x24/0x34
__configfs_open_file+0x35c/0x3b0
configfs_open_file+0x28/0x34
do_dentry_open+0x2cc/0x5c0
vfs_open+0x80/0xe0
path_openat+0xd8c/0x2988
do_filp_open+0x1c4/0x2fc
do_sys_open+0x23c/0x404
SyS_openat+0x38/0x48
el0_svc_naked+0x34/0x38

To fix this issue, remove the config_item_put in
__configfs_open_file to balance the refcount of config_item.

Fixes: b0841eefd969 ("configfs: provide exclusion between IO and removals")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daiyue Zhang <zhangdaiyue1@huawei.com>
Signed-off-by: Yi Chen <chenyi77@huawei.com>
Signed-off-by: Ge Qiu <qiuge@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fs/configfs/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 1f0270229d7b..da8351d1e455 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -378,7 +378,7 @@ static int __configfs_open_file(struct inode *inode, struct file *file, int type
 
 	attr = to_attr(dentry);
 	if (!attr)
-		goto out_put_item;
+		goto out_free_buffer;
 
 	if (type & CONFIGFS_ITEM_BIN_ATTR) {
 		buffer->bin_attr = to_bin_attr(dentry);
@@ -391,7 +391,7 @@ static int __configfs_open_file(struct inode *inode, struct file *file, int type
 	/* Grab the module reference for this attribute if we have one */
 	error = -ENODEV;
 	if (!try_module_get(buffer->owner))
-		goto out_put_item;
+		goto out_free_buffer;
 
 	error = -EACCES;
 	if (!buffer->item->ci_type)
@@ -435,8 +435,6 @@ static int __configfs_open_file(struct inode *inode, struct file *file, int type
 
 out_put_module:
 	module_put(buffer->owner);
-out_put_item:
-	config_item_put(buffer->item);
 out_free_buffer:
 	up_read(&frag->frag_sem);
 	kfree(buffer);
-- 
2.29.2

