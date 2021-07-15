Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100C63CADAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhGOURy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240406AbhGOURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9euKlRGsYS/Ufg0cVKfpbt0dLo3uk8zl6ETzBChaz4=;
        b=TNKUNgXKIrw5kl6z+LfvL/pxy4D8DR5/U1qhT6BCC0OJlFIOZiApB2YcXK9s3HqVVsio8n
        P6PUHcuaJHMZdsdpXxeo8+MYRElLxFBN1v5ZS/EZHXBzv9a1ElLxhRZxoe+ektoFGl/kIo
        vP1vtZgb+5kLfbg/sDUJnektt02i6Rg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-yWMf_hWsMnCeLaBYqQb4dA-1; Thu, 15 Jul 2021 16:14:38 -0400
X-MC-Unique: yWMf_hWsMnCeLaBYqQb4dA-1
Received: by mail-qk1-f198.google.com with SMTP id bi3-20020a05620a3183b02903b55bbe1ef9so4671895qkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9euKlRGsYS/Ufg0cVKfpbt0dLo3uk8zl6ETzBChaz4=;
        b=GgmiYxCJJMd7s8Wzn2/Ou9YDYNH+gUJWagKBZZq/KaNKhjAKo6A43tmllhIdR+0jl/
         VROJVyqIQVVn+L/b9nS1NL4fHiHsv6K6bFLeKRD0Y3akbdnSeXI5oej5WQnl9Q9SkHU8
         IPdstJcP/LLVOITvgSmk/zz3px6alpkCNafuNc7VanUZcfodGYzBbUhLddgnsLz7M986
         z/DBIgvHupYz8LmoXjcdy/Ga4kfWUVARxsUUmlxo6d75fwqE6Q37g9LXyxeORb6PK5qJ
         +gwBqnMd0cu30JlTfvYf1gaPjX+FThYpFmRxUOH5QYKB5y4tymDa7IQvy6EXC6QLRFoV
         cQyg==
X-Gm-Message-State: AOAM532ucqUsHv2VPhnzE3gXYyrgAwGsSjiNaSJVMc5tqSfa+KtlQZ81
        ajj8uRsaxRYghcgTmByGiopLn1vECDEttq5qyGUJY6GIw36Qviqs5b017wqxiSi/1VgrZnS7EcD
        PKnqceSQygztgejqPu5w3Z7DB
X-Received: by 2002:a05:620a:1aa9:: with SMTP id bl41mr5909409qkb.161.1626380077791;
        Thu, 15 Jul 2021 13:14:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGks1mczDtLrE5l95Y83pqJYMo/gPJAZ/qUj6crhaRKJXILpdNGMPwVT1D+Lu61v38FTnwbg==
X-Received: by 2002:a05:620a:1aa9:: with SMTP id bl41mr5909378qkb.161.1626380077507;
        Thu, 15 Jul 2021 13:14:37 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm2915206qka.114.2021.07.15.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:14:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>, peterx@redhat.com
Subject: [PATCH v5 06/26] shmem/userfaultfd: Handle uffd-wp special pte in page fault handler
Date:   Thu, 15 Jul 2021 16:14:02 -0400
Message-Id: <20210715201422.211004-7-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memories are prone to unmap/swap so the ptes are always unstable.
This could lead to userfaultfd-wp information got lost when unmapped or swapped
out on such types of memory, for example, shmem.  To keep such an information
persistent, we will start to use the newly introduced swap-like special ptes to
replace a null pte when those ptes were removed.

Prepare this by handling such a special pte first before it is applied in the
general page fault handler.

The handling of this special pte page fault is similar to missing fault, but it
should happen after the pte missing logic since the special pte is designed to
be a swap-like pte.  Meanwhile it should be handled before do_swap_page() so
that the swap core logic won't be confused to see such an illegal swap pte.

This is a slow path of uffd-wp handling, because unmap of wr-protected shmem
ptes should be rare.  So far it should only trigger in two conditions:

  (1) When trying to punch holes in shmem_fallocate(), there will be a
      pre-unmap optimization before evicting the page.  That will create
      unmapped shmem ptes with wr-protected pages covered.

  (2) Swapping out of shmem pages

Because of this, the page fault handling is simplifed too by not sending the
wr-protect message in the 1st page fault, instead the page will be installed
read-only, so the message will be generated until the next write, which will
trigger the do_wp_page() path of general uffd-wp handling.

Disable fault-around for all uffd-wp registered ranges for extra safety, and
clean the code up a bit after we introduced MINOR fault.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 17 +++++++
 mm/memory.c                   | 88 +++++++++++++++++++++++++++++++----
 2 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index bb5a72a2b07a..92606d95b005 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -94,6 +94,18 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
+/*
+ * Don't do fault around for either WP or MINOR registered uffd range.  For
+ * MINOR registered range, fault around will be a total disaster and ptes can
+ * be installed without notifications; for WP it should mostly be fine as long
+ * as the fault around checks for pte_none() before the installation, however
+ * to be super safe we just forbid it.
+ */
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
+}
+
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_UFFD_MISSING;
@@ -259,6 +271,11 @@ static inline bool pte_swp_uffd_wp_special(pte_t pte)
 	return false;
 }
 
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 #endif /* _LINUX_USERFAULTFD_K_H */
diff --git a/mm/memory.c b/mm/memory.c
index 998a4f9a3744..ba8033ca6682 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3964,6 +3964,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool uffd_wp = pte_swp_uffd_wp_special(vmf->orig_pte);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->address != addr;
 	pte_t entry;
@@ -3978,6 +3979,8 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	if (unlikely(uffd_wp))
+		entry = pte_mkuffd_wp(pte_wrprotect(entry));
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -4045,8 +4048,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				      vmf->address, &vmf->ptl);
 	ret = 0;
-	/* Re-check under ptl */
-	if (likely(pte_none(*vmf->pte)))
+
+	/*
+	 * Re-check under ptl.  Note: this will cover both none pte and
+	 * uffd-wp-special swap pte
+	 */
+	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 		do_set_pte(vmf, page, vmf->address);
 	else
 		ret = VM_FAULT_NOPAGE;
@@ -4150,9 +4157,21 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
 }
 
+/* Return true if we should do read fault-around, false otherwise */
+static inline bool should_fault_around(struct vm_fault *vmf)
+{
+	/* No ->map_pages?  No way to fault around... */
+	if (!vmf->vma->vm_ops->map_pages)
+		return false;
+
+	if (uffd_disable_fault_around(vmf->vma))
+		return false;
+
+	return fault_around_bytes >> PAGE_SHIFT > 1;
+}
+
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 
 	/*
@@ -4160,12 +4179,10 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * if page by the offset is not ready to be mapped (cold cache or
 	 * something).
 	 */
-	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
-		if (likely(!userfaultfd_minor(vmf->vma))) {
-			ret = do_fault_around(vmf);
-			if (ret)
-				return ret;
-		}
+	if (should_fault_around(vmf)) {
+		ret = do_fault_around(vmf);
+		if (ret)
+			return ret;
 	}
 
 	ret = __do_fault(vmf);
@@ -4484,6 +4501,57 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 	return VM_FAULT_FALLBACK;
 }
 
+static vm_fault_t uffd_wp_clear_special(struct vm_fault *vmf)
+{
+	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	/*
+	 * Be careful so that we will only recover a special uffd-wp pte into a
+	 * none pte.  Otherwise it means the pte could have changed, so retry.
+	 */
+	if (pte_swp_uffd_wp_special(*vmf->pte))
+		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
+}
+
+/*
+ * This is actually a page-missing access, but with uffd-wp special pte
+ * installed.  It means this pte was wr-protected before being unmapped.
+ */
+static vm_fault_t uffd_wp_handle_special(struct vm_fault *vmf)
+{
+	/* Careful!  vmf->pte unmapped after return */
+	if (!pte_unmap_same(vmf))
+		return 0;
+
+	/*
+	 * Just in case there're leftover special ptes even after the region
+	 * got unregistered - we can simply clear them.
+	 */
+	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
+		return uffd_wp_clear_special(vmf);
+
+	/*
+	 * Here we share most code with do_fault(), in which we can identify
+	 * whether this is "none pte fault" or "uffd-wp-special fault" by
+	 * checking the vmf->orig_pte.
+	 */
+	return do_fault(vmf);
+}
+
+static vm_fault_t do_swap_pte(struct vm_fault *vmf)
+{
+	/*
+	 * We need to handle special swap ptes before handling ptes that
+	 * contain swap entries, always.
+	 */
+	if (unlikely(pte_swp_uffd_wp_special(vmf->orig_pte)))
+		return uffd_wp_handle_special(vmf);
+
+	return do_swap_page(vmf);
+}
+
 /*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
@@ -4558,7 +4626,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 
 	if (!pte_present(vmf->orig_pte))
-		return do_swap_page(vmf);
+		return do_swap_pte(vmf);
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
-- 
2.31.1

