Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA51358577
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhDHOA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:00:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16847 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhDHOA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:00:56 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGNCC1GrHz9wsX;
        Thu,  8 Apr 2021 21:58:31 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.175) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 22:00:36 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Lu Jialin <lujialin4@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Xiang Yang <xiangyang3@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Cui GaoSheng <cuigaosheng1@huawei.com>,
        Gong Ruiqi <gongruiqi1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH -next] mm: Fix typos in comments
Date:   Thu, 8 Apr 2021 22:00:27 +0800
Message-ID: <20210408140027.60623-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

succed -> succeed in mm/hugetlb.c
wil -> will in mm/mempolicy.c
wit -> with in mm/page_alloc.c
Retruns -> Returns in mm/page_vma_mapped.c
confict -> conflict in mm/secretmem.c
No functionality changed.

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
---
 mm/hugetlb.c         | 2 +-
 mm/mempolicy.c       | 2 +-
 mm/page_alloc.c      | 2 +-
 mm/page_vma_mapped.c | 2 +-
 mm/secretmem.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c22111f3da20..e414534e1fc4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2304,7 +2304,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	} else if (!HPageFreed(old_page)) {
 		/*
 		 * Page's refcount is 0 but it has not been enqueued in the
-		 * freelist yet. Race window is small, so we can succed here if
+		 * freelist yet. Race window is small, so we can succeed here if
 		 * we retry.
 		 */
 		spin_unlock(&hugetlb_lock);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5690513c5668..d79fa299b70c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -994,7 +994,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		if (flags & MPOL_F_ADDR) {
 			/*
 			 * Take a refcount on the mpol, lookup_node()
-			 * wil drop the mmap_lock, so after calling
+			 * will drop the mmap_lock, so after calling
 			 * lookup_node() only "pol" remains valid, "vma"
 			 * is stale.
 			 */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 604dcd69397b..b457cc316009 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4173,7 +4173,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 }
 
 /*
- * Maximum number of compaction retries wit a progress before OOM
+ * Maximum number of compaction retries with a progress before OOM
  * killer is consider as the only way to move forward.
  */
 #define MAX_COMPACT_RETRIES 16
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 86e3a3688d59..2cf01d933f13 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -134,7 +134,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
  * regardless of which page table level the page is mapped at. @pvmw->pmd is
  * NULL.
  *
- * Retruns false if there are no more page table entries for the page in
+ * Returns false if there are no more page table entries for the page in
  * the vma. @pvmw->ptl is unlocked and @pvmw->pte is unmapped.
  *
  * If you need to stop the walk before page_vma_mapped_walk() returned false,
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 3b1ba3991964..38e22c45e482 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -204,7 +204,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	struct file *file;
 	int fd, err;
 
-	/* make sure local flags do not confict with global fcntl.h */
+	/* make sure local flags do not conflict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
 
 	if (!secretmem_enable)
-- 
2.17.1

