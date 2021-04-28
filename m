Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0236E1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbhD1WwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240022AbhD1WwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619650279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OG28X1p0LN5qmWCjh+VmHMXYqZhJcXnpmOsWEKY5ICY=;
        b=L6teLlyQ/LOY/Z3k66Ua3y3gmAtYf8VPKRW4YzjEQU1lK/dMHNLiIeoByXOxtJ2fmwNniR
        U298oeSGcW5rHs1d/pZ0bSGLXa/uxSfVediZB3p8sZ3qTP+c2c0pzCXpO+REtJtK0lCDyk
        5RhRW07bsrUJne4nDk5vgo/GzDMuoXo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-2ssp_WPzPNW8klDQb_rhvw-1; Wed, 28 Apr 2021 18:51:17 -0400
X-MC-Unique: 2ssp_WPzPNW8klDQb_rhvw-1
Received: by mail-qv1-f72.google.com with SMTP id r18-20020a0ccc120000b02901a21aadacfcso27191380qvk.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OG28X1p0LN5qmWCjh+VmHMXYqZhJcXnpmOsWEKY5ICY=;
        b=XT+K8jaSdy+CSBORl+MLa3qL9W+REBhP41Dn/AAjGw7HSEJUgnlBdMueIgqXIrN85L
         dv3BDZoF1zaf0X5GHha7JiNyeCmX/zdcHLFiSHdUyN8IyU/8uDV4tvWub3CVRQfKm4YT
         J4UkV9kQanw0+uA1xRXujvoxQKbTegdoYuxZ9o2J0HtwVm5mu6zG5WMqQKV/qnRLYzkZ
         o/L70mYtHW9NOCrIIAQiqUJO8jVKNAryEkZ9wJO6aBh7HqwyrsLd8aQgnviEv2XGqgkl
         l5Lwj0HtaZSiwSR6CeKm6wxuqII7dK6klCJZHRllBdHXf9jZSMxmzuSOAY5xefYncpQA
         62gA==
X-Gm-Message-State: AOAM530PvS0/sRHoRZ40xLQBBzur3KIqVuWa153A0dD7JGT/yjmgLpGd
        cyPuhrb6mwZk1bigeRxWm/tKGbeJ1xIvs8LooCR9KG1SjI9S76tAvbSw1UPOUFKoga8S60rLhsb
        aMhH3NqdhnQQCq66/Re7YAYnH
X-Received: by 2002:a37:8ec4:: with SMTP id q187mr31300661qkd.381.1619650276834;
        Wed, 28 Apr 2021 15:51:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi99fErJAPLQ1t4NVfvD0N51OiO720CW6bMsxTi+DZzEyVg/1oxclKoH8kWI9KuoB0CouZNQ==
X-Received: by 2002:a37:8ec4:: with SMTP id q187mr31300646qkd.381.1619650276529;
        Wed, 28 Apr 2021 15:51:16 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 191sm897459qkk.31.2021.04.28.15.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:51:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 2/6] mm/userfaultfd: Fix uffd-wp special cases for fork()
Date:   Wed, 28 Apr 2021 18:50:26 -0400
Message-Id: <20210428225030.9708-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210428225030.9708-1-peterx@redhat.com>
References: <20210428225030.9708-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We tried to do something similar in b569a1760782 ("userfaultfd: wp: drop
_PAGE_UFFD_WP properly when fork") previously, but it's not doing it all
right..  A few fixes around the code path:

  1. We were referencing VM_UFFD_WP vm_flags on the _old_ vma rather than the
     new vma.  That's overlooked in b569a1760782, so it won't work as expected.
     Thanks to the recent rework on fork code (7a4830c380f3a8b3), we can easily
     get the new vma now, so switch the checks to that.

  2. Dropping the uffd-wp bit in copy_huge_pmd() could be wrong if the huge pmd
     is a migration huge pmd.  When it happens, instead of using pmd_uffd_wp(),
     we should use pmd_swp_uffd_wp(). The fix is simply to handle them separately.

  3. Forget to carry over uffd-wp bit for a write migration huge pmd entry.
     This also happens in copy_huge_pmd(), where we converted a write huge
     migration entry into a read one.

  4. In copy_nonpresent_pte(), drop uffd-wp if necessary for swap ptes.

  5. In copy_present_page() when COW is enforced when fork(), we also need to
     pass over the uffd-wp bit if VM_UFFD_WP is armed on the new vma, and when
     the pte to be copied has uffd-wp bit set.

Remove the comment in copy_present_pte() about this.  It won't help a huge lot
to only comment there, but comment everywhere would be an overkill.  Let's
assume the commit messages would help.

Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Fixes: b569a1760782f3da03ff718d61f74163dea599ff
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        | 23 ++++++++++-------------
 mm/memory.c             | 25 +++++++++++++------------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9626fda5efcea..60dad7c88d72b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -10,7 +10,7 @@
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
-		  struct vm_area_struct *vma);
+		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
 void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd);
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 22bf2d0fff79b..20a4569895254 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1014,7 +1014,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
-		  struct vm_area_struct *vma)
+		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
 	spinlock_t *dst_ptl, *src_ptl;
 	struct page *src_page;
@@ -1023,7 +1023,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int ret = -ENOMEM;
 
 	/* Skip if can be re-fill on fault */
-	if (!vma_is_anonymous(vma))
+	if (!vma_is_anonymous(dst_vma))
 		return 0;
 
 	pgtable = pte_alloc_one(dst_mm);
@@ -1037,14 +1037,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-	/*
-	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
-	 * does not have the VM_UFFD_WP, which means that the uffd
-	 * fork event is not enabled.
-	 */
-	if (!(vma->vm_flags & VM_UFFD_WP))
-		pmd = pmd_clear_uffd_wp(pmd);
-
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 	if (unlikely(is_swap_pmd(pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(pmd);
@@ -1055,11 +1047,15 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			pmd = swp_entry_to_pmd(entry);
 			if (pmd_swp_soft_dirty(*src_pmd))
 				pmd = pmd_swp_mksoft_dirty(pmd);
+			if (pmd_swp_uffd_wp(*src_pmd))
+				pmd = pmd_swp_mkuffd_wp(pmd);
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
 		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(dst_mm);
 		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+		if (!userfaultfd_wp(dst_vma))
+			pmd = pmd_swp_clear_uffd_wp(pmd);
 		set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 		ret = 0;
 		goto out_unlock;
@@ -1095,11 +1091,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * best effort that the pinned pages won't be replaced by another
 	 * random page during the coming copy-on-write.
 	 */
-	if (unlikely(page_needs_cow_for_dma(vma, src_page))) {
+	if (unlikely(page_needs_cow_for_dma(src_vma, src_page))) {
 		pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
-		__split_huge_pmd(vma, src_pmd, addr, false, NULL);
+		__split_huge_pmd(src_vma, src_pmd, addr, false, NULL);
 		return -EAGAIN;
 	}
 
@@ -1109,8 +1105,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
-
 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
+	if (!userfaultfd_wp(dst_vma))
+		pmd = pmd_clear_uffd_wp(pmd);
 	pmd = pmd_mkold(pmd_wrprotect(pmd));
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
diff --git a/mm/memory.c b/mm/memory.c
index 045daf58608f7..a17a53a7dade6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -708,10 +708,10 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 static unsigned long
 copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr, int *rss)
+		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long addr, int *rss)
 {
-	unsigned long vm_flags = vma->vm_flags;
+	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(pte);
@@ -780,6 +780,8 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
 	}
+	if (!userfaultfd_wp(dst_vma))
+		pte = pte_swp_clear_uffd_wp(pte);
 	set_pte_at(dst_mm, addr, dst_pte, pte);
 	return 0;
 }
@@ -845,6 +847,9 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	/* All done, just insert the new page copy in the child */
 	pte = mk_pte(new_page, dst_vma->vm_page_prot);
 	pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
+	if (userfaultfd_pte_wp(dst_vma, *src_pte))
+		/* Uffd-wp needs to be delivered to dest pte as well */
+		pte = pte_wrprotect(pte_mkuffd_wp(pte));
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
 	return 0;
 }
@@ -894,12 +899,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 
-	/*
-	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
-	 * does not have the VM_UFFD_WP, which means that the uffd
-	 * fork event is not enabled.
-	 */
-	if (!(vm_flags & VM_UFFD_WP))
+	if (!userfaultfd_wp(dst_vma))
 		pte = pte_clear_uffd_wp(pte);
 
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
@@ -974,7 +974,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		if (unlikely(!pte_present(*src_pte))) {
 			entry.val = copy_nonpresent_pte(dst_mm, src_mm,
 							dst_pte, src_pte,
-							src_vma, addr, rss);
+							dst_vma, src_vma,
+							addr, rss);
 			if (entry.val)
 				break;
 			progress += 8;
@@ -1051,8 +1052,8 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			|| pmd_devmap(*src_pmd)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
-			err = copy_huge_pmd(dst_mm, src_mm,
-					    dst_pmd, src_pmd, addr, src_vma);
+			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
+					    addr, dst_vma, src_vma);
 			if (err == -ENOMEM)
 				return -ENOMEM;
 			if (!err)
-- 
2.26.2

