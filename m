Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1316F31DD66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhBQQdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234155AbhBQQcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613579469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1HW5swS9ZOyvERvBufh4SMfymzI+ErI982WYqgv7a0=;
        b=HBlHjZqOq0C3tq7djp1vaUeWv67oS2p9WMink8cunugNKrOsabMhXnBK+PP73Biu48InP/
        0IPuU0btJH1GfQ+qCKfaWNc4n8scehWnNcAa2A3A2tlAJQzTLAQs6DqWcnuVcaG3hjYaUS
        XY0dyDQkzz1voZhi6cO3KMpfiCDb0dQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-NFqRLf0AOGWiJUfbvtpHOw-1; Wed, 17 Feb 2021 11:31:08 -0500
X-MC-Unique: NFqRLf0AOGWiJUfbvtpHOw-1
Received: by mail-qv1-f70.google.com with SMTP id er16so10276698qvb.22
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1HW5swS9ZOyvERvBufh4SMfymzI+ErI982WYqgv7a0=;
        b=Gu7vATLZPSZRFF1l+6EqHu6iGz2b//+CvK5q8r+cahQppoi9oIM/Ae3k4MHbALeNXb
         TSAd+uajK8Fg/4KSna2DKtmEhKfR2B5xomMRy5EvipA761YTLUZOeBBAbMzRDEocLP4R
         v200ExgCfmB3eNJrDqHrQ2pbdRlUW9oy2huPo9VVzwCpupgek6RbA8EDtp81SxSrZU0Q
         PNKr4ljX1Ric7/PjcmFY1y5jbApadXpKHZZzbSW7wuoIoCa3aWxan5L3h1VcmyRwSmXg
         ovBnf6xzTOI7ePBVI9JjdKTiP6DgSgHRs250uOX8Wc2LqRfIoVm3RnPWnKbjh0WHcdmX
         cTLw==
X-Gm-Message-State: AOAM532ueaWCgdqX3maEMa9k2iElOC1HIDDxoS74GSQhNGQ49e5tjflY
        7Swb8kJF8SL0T7muaPBs4c1rPXxmcPVy8A//EsCN2Uz3fc5arDtkdmrm2TySZ2f/JE+gf/bndXD
        VTNN5j5bhdZztB7d0jAjLDM8qb74J5/K2kKD4W+ba3v7bY55fZPn6ikK/PyZAf2g6smbVwhRDzQ
        ==
X-Received: by 2002:a05:620a:88f:: with SMTP id b15mr25963841qka.445.1613579467240;
        Wed, 17 Feb 2021 08:31:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6yJir8BfCh9ZGmOzmAyHa6uI/AAyLRzlhsDAnhQLoK8h1fNjp3S+IxZUTPXEvPmUnrB1h9w==
X-Received: by 2002:a05:620a:88f:: with SMTP id b15mr25963804qka.445.1613579466917;
        Wed, 17 Feb 2021 08:31:06 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z37sm399902qth.87.2021.02.17.08.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:31:06 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/4] hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled
Date:   Wed, 17 Feb 2021 11:31:00 -0500
Message-Id: <20210217163102.13436-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217163102.13436-1-peterx@redhat.com>
References: <20210217163102.13436-1-peterx@redhat.com>
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

