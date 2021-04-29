Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA51736EB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhD2N1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:27:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17071 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhD2N1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:27:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FWGSL10b5z16N7r;
        Thu, 29 Apr 2021 21:24:34 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 29 Apr 2021
 21:26:57 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 3/5] mm/huge_memory.c: add missing read-only THP checking in transparent_hugepage_enabled()
Date:   Thu, 29 Apr 2021 21:26:46 +0800
Message-ID: <20210429132648.305447-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210429132648.305447-1-linmiaohe@huawei.com>
References: <20210429132648.305447-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
(non-shmem) FS"), read-only THP file mapping is supported. But it
forgot to add checking for it in transparent_hugepage_enabled().
To fix it, we add checking for read-only THP file mapping and also
introduce helper transhuge_vma_enabled() to check whether thp is
enabled for specified vma to reduce duplicated code.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/huge_mm.h | 21 +++++++++++++++++----
 mm/huge_memory.c        |  6 ++++++
 mm/khugepaged.c         |  4 +---
 mm/shmem.c              |  3 +--
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0a526f211fec..f460b74619fc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -115,6 +115,16 @@ extern struct kobj_attribute shmem_enabled_attr;
 
 extern unsigned long transparent_hugepage_flags;
 
+static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
+					  unsigned long vm_flags)
+{
+	/* Explicitly disabled through madvise. */
+	if ((vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+		return false;
+	return true;
+}
+
 /*
  * to be used on vmas which are known to support THP.
  * Use transparent_hugepage_enabled otherwise
@@ -128,15 +138,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
 		return false;
 
-	if (vma->vm_flags & VM_NOHUGEPAGE)
+	if (!transhuge_vma_enabled(vma, vma->vm_flags))
 		return false;
 
 	if (vma_is_temporary_stack(vma))
 		return false;
 
-	if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return false;
-
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
 		return true;
 
@@ -362,6 +369,12 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 	return false;
 }
 
+static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
+					  unsigned long vm_flags)
+{
+	return false;
+}
+
 static inline void prep_transhuge_page(struct page *page) {}
 
 static inline bool is_transparent_hugepage(struct page *page)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 76ca1eb2a223..e24a96de2e37 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -68,12 +68,18 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 	/* The addr is used to check if the vma size fits */
 	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
 
+	if (!transhuge_vma_enabled(vma, vma->vm_flags))
+		return false;
 	if (!transhuge_vma_suitable(vma, addr))
 		return false;
 	if (vma_is_anonymous(vma))
 		return __transparent_hugepage_enabled(vma);
 	if (vma_is_shmem(vma))
 		return shmem_huge_enabled(vma);
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
+	    !inode_is_open_for_write(vma->vm_file->f_inode) &&
+	    (vma->vm_flags & VM_EXEC))
+		return true;
 
 	return false;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6c0185fdd815..d97b20fad6e8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -442,9 +442,7 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
 static bool hugepage_vma_check(struct vm_area_struct *vma,
 			       unsigned long vm_flags)
 {
-	/* Explicitly disabled through madvise. */
-	if ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+	if (!transhuge_vma_enabled(vma, vm_flags))
 		return false;
 
 	/* Enabled via shmem mount options or sysfs settings. */
diff --git a/mm/shmem.c b/mm/shmem.c
index a08cedefbfaa..1dcbec313c70 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4032,8 +4032,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
 	loff_t i_size;
 	pgoff_t off;
 
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+	if (!transhuge_vma_enabled(vma, vma->vm_flags))
 		return false;
 	if (shmem_huge == SHMEM_HUGE_FORCE)
 		return true;
-- 
2.23.0

