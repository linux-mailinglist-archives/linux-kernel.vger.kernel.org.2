Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E331F2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBRXNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:13:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhBRXNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613689926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4OLUk0Jy8zIZlRHoRelkknb6fgRUan1/BmpVqTVRpo=;
        b=FCPdN442UEwUOHDLFsw16hoK9IjZTwBNxB+L1dFMSFcAqTWgg9Zt8b51Sg57Bep272pTEz
        ESJvQYV/GtrM+VNcGaYd2T82a1dspBjFnOaRez4UGRkvbzuuQHYMHkNZpm/FJ98QHAmuza
        pTtdD0bl6joEFTPaptj1lnjVyzLfeAM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-g0hPl6afMDO-geT9xRkbzg-1; Thu, 18 Feb 2021 18:12:05 -0500
X-MC-Unique: g0hPl6afMDO-geT9xRkbzg-1
Received: by mail-qv1-f70.google.com with SMTP id u8so2119027qvm.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4OLUk0Jy8zIZlRHoRelkknb6fgRUan1/BmpVqTVRpo=;
        b=sC66cmcbqD3mWPN+REZk+bY0a+NklW+9gHnR4v2lr4fdS3lSeG9593ucdzQMkkhocW
         Agb/oqYf19xv7n9y0UO1m6Ki5b5fhxVJDK1wK1mo102Zl0D1QWuhNVPGo/kNmSLM/vwf
         3pMl1KPkw7Pw1heAXUSyabFmyUJyZJ8ocSi1l7fl5/GpXyqc7fBK2S3tZmGGNFmHiXqB
         QopjgPpJfbvEuJZhrAdqx3N9v2mlQ7rrk4cr8r1lYH6JaXWnK5X/me23aQ8bZBKaKePd
         86E/fsxwipyAuoYo/r5Vbtr8/aUQ8Q5Wv5wQMvsCTbNoTGWZTXMP6z1YlI0ZdL7JZPY2
         oUNg==
X-Gm-Message-State: AOAM532TlOxpJvrPBH+jlr6ISy23Guq/4haxlyXmzh6dmrgpsC9xeZUf
        KcC4zNPKoaji1kymX9MrWlm65bfzk+nX12l5VP/MzujgmgmOnYNCtOcn3NmiENo1Y7jmguexu75
        /X5bLfuJ7RLkmZ2cjvCLUPaAQ7uXZrZ+1sGNhm0GflvGdNgbexT3wZL2Nlc+9F1FtqIyO73D/LA
        ==
X-Received: by 2002:a05:620a:1d:: with SMTP id j29mr6700556qki.44.1613689924380;
        Thu, 18 Feb 2021 15:12:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNcCRt5mpNJEHZqxBiuceXrqWJT6w5UnTTmmRll9SNEnxh73o0Dd3vEIchpsfhphq0LTVt3A==
X-Received: by 2002:a05:620a:1d:: with SMTP id j29mr6700517qki.44.1613689924057;
        Thu, 18 Feb 2021 15:12:04 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id c191sm2078643qke.1.2021.02.18.15.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 15:12:03 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 2/4] hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled
Date:   Thu, 18 Feb 2021 18:12:02 -0500
Message-Id: <20210218231202.15426-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210218230633.15028-1-peterx@redhat.com>
References: <20210218230633.15028-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge pmd sharing could bring problem to userfaultfd.  The thing is that
userfaultfd is running its logic based on the special bits on page table
entries, however the huge pmd sharing could potentially share page table
entries for different address ranges.  That could cause issues on either:

  - When sharing huge pmd page tables for an uffd write protected range, the
    newly mapped huge pmd range will also be write protected unexpectedly, or,

  - When we try to write protect a range of huge pmd shared range, we'll first
    do huge_pmd_unshare() in hugetlb_change_protection(), however that also
    means the UFFDIO_WRITEPROTECT could be silently skipped for the shared
    region, which could lead to data loss.

Since at it, a few other things are done altogether:

  - Move want_pmd_share() from mm/hugetlb.c into linux/hugetlb.h, because
    that's definitely something that arch code would like to use too

  - ARM64 currently directly check against CONFIG_ARCH_WANT_HUGE_PMD_SHARE when
    trying to share huge pmd.  Switch to the want_pmd_share() helper.

Since at it, move vma_shareable() from huge_pmd_share() into want_pmd_share().

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/hugetlbpage.c   |  3 +--
 include/linux/hugetlb.h       |  2 ++
 include/linux/userfaultfd_k.h |  9 +++++++++
 mm/hugetlb.c                  | 20 ++++++++++++++------
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 6e3bcffe2837..58987a98e179 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -284,8 +284,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		ptep = pte_alloc_map(mm, pmdp, addr);
 	} else if (sz == PMD_SIZE) {
-		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
-		    pud_none(READ_ONCE(*pudp)))
+		if (want_pmd_share(vma, addr) && pud_none(READ_ONCE(*pudp)))
 			ptep = huge_pmd_share(mm, vma, addr, pudp);
 		else
 			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a6113fa6d21d..bc86f2f516e7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -950,4 +950,6 @@ static inline __init void hugetlb_cma_check(void)
 }
 #endif
 
+bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a8e5f3ea9bb2..c63ccdae3eab 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -52,6 +52,15 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return vma->vm_userfaultfd_ctx.ctx == vm_ctx.ctx;
 }
 
+/*
+ * Never enable huge pmd sharing on uffd-wp registered vmas, because uffd-wp
+ * protect information is per pgtable entry.
+ */
+static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_UFFD_WP;
+}
+
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_UFFD_MISSING;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07bb9bdc3282..8e8e2f3dfe06 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5292,6 +5292,18 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 	return false;
 }
 
+bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
+{
+#ifndef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+	return false;
+#endif
+#ifdef CONFIG_USERFAULTFD
+	if (uffd_disable_huge_pmd_share(vma))
+		return false;
+#endif
+	return vma_shareable(vma, addr);
+}
+
 /*
  * Determine if start,end range within vma could be mapped by shared pmd.
  * If yes, adjust start and end to cover range associated with possible
@@ -5346,9 +5358,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	if (!vma_shareable(vma, addr))
-		return (pte_t *)pmd_alloc(mm, pud, addr);
-
 	i_mmap_assert_locked(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
@@ -5412,7 +5421,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
 	return 1;
 }
-#define want_pmd_share()	(1)
+
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
 		      unsigned long addr, pud_t *pud)
@@ -5430,7 +5439,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
 }
-#define want_pmd_share()	(0)
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
@@ -5452,7 +5460,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			pte = (pte_t *)pud;
 		} else {
 			BUG_ON(sz != PMD_SIZE);
-			if (want_pmd_share() && pud_none(*pud))
+			if (want_pmd_share(vma, addr) && pud_none(*pud))
 				pte = huge_pmd_share(mm, vma, addr, pud);
 			else
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
-- 
2.26.2

