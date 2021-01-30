Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA1E30935B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhA3J2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:28:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11646 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhA3JZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:25:02 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DSTJZ6ktqz161F3;
        Sat, 30 Jan 2021 17:22:54 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Sat, 30 Jan 2021
 17:24:00 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] hugetlbfs: fix some comment typos
Date:   Sat, 30 Jan 2021 04:23:51 -0500
Message-ID: <20210130092351.28072-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos reserv to reserve, minimim to minimum. No functional change
intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 40a9795f250a..db6504b5e89f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -442,15 +442,15 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
  *
  * truncation is indicated by end of range being LLONG_MAX
  *	In this case, we first scan the range and release found pages.
- *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserv
+ *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
  *	maps and global counts.  Page faults can not race with truncation
  *	in this routine.  hugetlb_no_page() holds i_mmap_rwsem and prevents
  *	page faults in the truncated range by checking i_size.  i_size is
  *	modified while holding i_mmap_rwsem.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
- *	Only when releasing a page is the associated region/reserv map
- *	deleted.  The region/reserv map for ranges without associated
+ *	Only when releasing a page is the associated region/reserve map
+ *	deleted.  The region/reserve map for ranges without associated
  *	pages are not modified.  Page faults can race with hole punch.
  *	This is indicated if we find a mapped page.
  * Note: If the passed end of range value is beyond the end of file, but
@@ -1347,7 +1347,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/*
 	 * Allocate and initialize subpool if maximum or minimum size is
-	 * specified.  Any needed reservations (for minimim size) are taken
+	 * specified.  Any needed reservations (for minimum size) are taken
 	 * taken when the subpool is created.
 	 */
 	if (ctx->max_hpages != -1 || ctx->min_hpages != -1) {
-- 
2.19.1

