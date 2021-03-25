Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1D3492F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCYNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:16:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13696 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhCYNQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:16:21 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5lsx5VStzpVLx;
        Thu, 25 Mar 2021 21:13:41 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 21:16:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>, <aquini@redhat.com>,
        <david@redhat.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 5/5] Revert "mm: migrate: skip shared exec THP for NUMA balancing"
Date:   Thu, 25 Mar 2021 09:15:24 -0400
Message-ID: <20210325131524.48181-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210325131524.48181-1-linmiaohe@huawei.com>
References: <20210325131524.48181-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c77c5cbafe549eb330e8909861a3e16cbda2c848.

Since commit c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA
balancing"), the NUMA balancing would skip shared exec transhuge page.
But this enhancement is not suitable for transhuge page. Because it's
required that page_mapcount() must be 1 due to no migration pte dance
is done here. On the other hand, the shared exec transhuge page will
leave the migrate_misplaced_page() with pte entry untouched and page
locked. Thus pagefault for NUMA will be triggered again and deadlock
occurs when we start waiting for the page lock held by ourselves.

Yang Shi said:

 "Thanks for catching this. By relooking the code I think the other
  important reason for removing this is
  migrate_misplaced_transhuge_page() actually can't see shared exec
  file THP at all since page_lock_anon_vma_read() is called before
  and if page is not anonymous page it will just restore the PMD
  without migrating anything.
  The pages for private mapped file vma may be anonymous pages due to
  COW but they can't be THP so it won't trigger THP numa fault at all. I
  think this is why no bug was reported. I overlooked this in the first
  place."

Reviewed-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c621c8f6fb7d..51190759e6dd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2105,17 +2105,6 @@ bool pmd_trans_migrating(pmd_t pmd)
 	return PageLocked(page);
 }
 
-static inline bool is_shared_exec_page(struct vm_area_struct *vma,
-				       struct page *page)
-{
-	if (page_mapcount(page) != 1 &&
-	    (page_is_file_lru(page) || vma_is_shmem(vma)) &&
-	    (vma->vm_flags & VM_EXEC))
-		return true;
-
-	return false;
-}
-
 /*
  * Attempt to migrate a misplaced page to the specified destination
  * node. Caller is expected to have an elevated reference count on
@@ -2133,7 +2122,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	 * Don't migrate file pages that are mapped in multiple processes
 	 * with execute permissions as they are probably shared libraries.
 	 */
-	if (is_shared_exec_page(vma, page))
+	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
+	    (vma->vm_flags & VM_EXEC))
 		goto out;
 
 	/*
@@ -2188,9 +2178,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	int page_lru = page_is_file_lru(page);
 	unsigned long start = address & HPAGE_PMD_MASK;
 
-	if (is_shared_exec_page(vma, page))
-		goto out;
-
 	new_page = alloc_pages_node(node,
 		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
 		HPAGE_PMD_ORDER);
@@ -2302,7 +2289,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 
 out_unlock:
 	unlock_page(page);
-out:
 	put_page(page);
 	return 0;
 }
-- 
2.19.1

