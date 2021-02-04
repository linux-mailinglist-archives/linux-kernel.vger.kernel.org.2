Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F330FBAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbhBDShy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbhBDSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:35:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD666C061793
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:34:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v17so4164511ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s9r2ulxIVo+JxzRZfbGUdKJOP0/th7I3qsQK2fKA868=;
        b=wV+Hva7Qm6LmWtboJMy1O3oNDDp9+Ve3p0BFRSkoshlP4KJG6Pvq+kn2LJL+fXNz0H
         7Be7hCNSDbaTmGhW64WInTBmORgd0QNu3sU1mKpY0L8+8id+LYOX5eXOk3umYJ1Xe0JA
         S4YuMEO/342CuRpnjziXI81SaQS/YKnf6ibKDL5oBM5EJyHhJFroah7osop6dWo/lzEx
         6agFStDL6ZeCHk295SjxM/nC0hV8tAuhTDJ90CD8vJZLw+1EGbDMJTJpn4be4+UREWYa
         WOcBxClzEpU87vKEFl6J3wIo8cL88U+kEP43Otj+h35ibnJpTaCGn3XsX5Mtenym6CCo
         iW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s9r2ulxIVo+JxzRZfbGUdKJOP0/th7I3qsQK2fKA868=;
        b=c3jURp186CU246jx7uHx04mbugbkZj6oKCTPtUP3p2gU4/nOpFS3zgcZ7KDRD87kXs
         8Y7PNkDJkfkDIT/HDQJiup+C5aNy2gpcM/VhiajMVlzngAnQXex2AjA+jplRafrcC0n9
         R09ekXnBCv6KyiIYecBw9Hk7QNqCB72oDdUN0VuyPqtSH+VTmAv9uFqah0iv3l6JQEGD
         f1biaPaWtIPXCpvuqGCAaFv9MlR2B6LkZjCW/fD8GixYp3ZLXMwDAjff21uyDkMCRfJs
         PKaOaNzRLhuGMnsmguT3y63sGkYMNGiSqeTznxgRniE1DmGNN99O6ZghEu0V+9kmb+/9
         Z/2Q==
X-Gm-Message-State: AOAM532RMW7EgcXyBt684OL8DnAd0zLVawPRnEk/sUts+66ZD4P52yZS
        B7jFXRI58ZFJmGNuje/3+3UfvdKbVQXr+XrW9vTf
X-Google-Smtp-Source: ABdhPJx6wGFI4hlg9+bzkoNUY3w5U7WH/0NErIIYgtcvUJiTksoN103vNGBceqQZ7UuGL6uHIDxGzIj67AWdShq6BnyQ
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:b001:12c1:dc19:2089])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6cc6:: with SMTP id
 h189mr814735ybc.434.1612463688006; Thu, 04 Feb 2021 10:34:48 -0800 (PST)
Date:   Thu,  4 Feb 2021 10:34:25 -0800
In-Reply-To: <20210204183433.1431202-1-axelrasmussen@google.com>
Message-Id: <20210204183433.1431202-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210204183433.1431202-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 02/10] hugetlb/userfaultfd: Forbid huge pmd sharing when
 uffd enabled
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

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
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
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
index 92e8799edffd..f6d5939a6eb0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -948,4 +948,6 @@ static inline __init void hugetlb_cma_check(void)
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
index 3185631f61bc..588c4c28c44d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5251,6 +5251,18 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
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
@@ -5305,9 +5317,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	if (!vma_shareable(vma, addr))
-		return (pte_t *)pmd_alloc(mm, pud, addr);
-
 	i_mmap_assert_locked(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
@@ -5371,7 +5380,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
 	return 1;
 }
-#define want_pmd_share()	(1)
+
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
 		      unsigned long addr, pud_t *pud)
@@ -5389,7 +5398,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
 }
-#define want_pmd_share()	(0)
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
@@ -5411,7 +5419,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			pte = (pte_t *)pud;
 		} else {
 			BUG_ON(sz != PMD_SIZE);
-			if (want_pmd_share() && pud_none(*pud))
+			if (want_pmd_share(vma, addr) && pud_none(*pud))
 				pte = huge_pmd_share(mm, vma, addr, pud);
 			else
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
-- 
2.30.0.365.g02bc693789-goog

