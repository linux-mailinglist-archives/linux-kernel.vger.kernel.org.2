Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4A312C53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhBHIxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:53:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhBHIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:47:43 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZ02y0pcwzlHGh;
        Mon,  8 Feb 2021 16:45:14 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Feb 2021
 16:46:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] hugetlbfs: Remove unneeded return value of hugetlb_vmtruncate()
Date:   Mon, 8 Feb 2021 03:46:37 -0500
Message-ID: <20210208084637.47789-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function hugetlb_vmtruncate() is guaranteed to always success since
commit 7aa91e104028 ("hugetlb: allow extending ftruncate on hugetlbfs").
So we should remove the unneeded return value which is always 0.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 394da2ab08ad..701c82c36138 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -567,7 +567,7 @@ static void hugetlbfs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
-static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
+static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 {
 	pgoff_t pgoff;
 	struct address_space *mapping = inode->i_mapping;
@@ -582,7 +582,6 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
 	i_mmap_unlock_write(mapping);
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
-	return 0;
 }
 
 static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
@@ -781,9 +780,7 @@ static int hugetlbfs_setattr(struct user_namespace *mnt_userns,
 		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
-		error = hugetlb_vmtruncate(inode, newsize);
-		if (error)
-			return error;
+		hugetlb_vmtruncate(inode, newsize);
 	}
 
 	setattr_copy(&init_user_ns, inode, attr);
-- 
2.19.1

