Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D08393701
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhE0UXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235528AbhE0UXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYVv4WAkRU7fRACps66Ocj6/XAOeYepv/px19tfG5cs=;
        b=XGzqc/L40y0JnZWTbM4IYPsfHjULGiChowZYfhvTJBTzLDawaQw5lznepnlrHsg7TRwejA
        sFSuZf+edMLcUaAmOaC1r6IjOhM1W1PgSXQLs7uFQ0FOWpET7iIe2Oj1WrYrsmZYZNZpyt
        i0F+CAZGeaRtGk2764kRiKoOV8OizYQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-MeaIILx_PrqSOlPofJTYyg-1; Thu, 27 May 2021 16:21:27 -0400
X-MC-Unique: MeaIILx_PrqSOlPofJTYyg-1
Received: by mail-qv1-f69.google.com with SMTP id fi6-20020a0562141a46b02901f064172b74so1045779qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QYVv4WAkRU7fRACps66Ocj6/XAOeYepv/px19tfG5cs=;
        b=jlhGo15MC2ubtmVKpkYkjDzHQ/w0ogJbZspkaMdgCZpvCkjabQzRcMlp+ZgNkYADA1
         6tCMijoOpbTSrKFJs9Hfe3N+b9fwvYGwqxs1/DNAUNZF2Wq+ZLqJJ9PXCjbIeD7DqlcL
         pwCBOfcVopO26icfBvnvc1DqstJV30atOigHd4Xw+ZzkSKK1zTQGlH8aWLDV7DPL7CJR
         +X6HNtD6hVDYgYDN4V37h/79t/BHJXh8H5VI3ZBKOZLqMNtXNZqf7CEMsLUqyzOMTnIR
         eG/nQGIiH22gE5XryjFMbes4Qxfqmei5iKeILxtVgSPv2sRIsKg5o7Of4Hs+0+9IbZkW
         LVaw==
X-Gm-Message-State: AOAM533ZSOZM3HRpeJwbYKbDX3McdkCg65vlLRnLM26GguhagHDNk3PF
        HBiz4z2MpoWsBmvnK8KLyNX4QN+ILIt2RHfrOH5i/4lYQfAWMCKQm7pbQCcdWDzg5tOy3SJ/URK
        6D28HXKoDA6/kmbKOMAHdJQrO
X-Received: by 2002:ac8:594a:: with SMTP id 10mr301464qtz.293.1622146886354;
        Thu, 27 May 2021 13:21:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7lqcECT8KPsmIK0r+r6dBmL5bSGmCLQ2KpX8k9jXbC/1IEeudtC3hjPjvAXnHx6Ajngv1fA==
X-Received: by 2002:ac8:594a:: with SMTP id 10mr301440qtz.293.1622146885908;
        Thu, 27 May 2021 13:21:25 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id i14sm2222461qkn.99.2021.05.27.13.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:21:25 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 06/27] shmem/userfaultfd: Handle uffd-wp special pte in page fault handler
Date:   Thu, 27 May 2021 16:21:22 -0400
Message-Id: <20210527202122.30739-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
 include/linux/userfaultfd_k.h | 12 +++++
 mm/memory.c                   | 88 +++++++++++++++++++++++++++++++----
 2 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 93f932b53a71..ca3f794d07e9 100644
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
diff --git a/mm/memory.c b/mm/memory.c
index 2b24af4616df..45a2f71e447a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3917,6 +3917,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool uffd_wp = pte_swp_uffd_wp_special(vmf->orig_pte);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->address != addr;
 	pte_t entry;
@@ -3929,6 +3930,8 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	if (unlikely(uffd_wp))
+		entry = pte_mkuffd_wp(pte_wrprotect(entry));
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -3996,8 +3999,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
@@ -4101,9 +4108,21 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
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
@@ -4111,12 +4130,10 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
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
@@ -4435,6 +4452,57 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
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
@@ -4509,7 +4577,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 
 	if (!pte_present(vmf->orig_pte))
-		return do_swap_page(vmf);
+		return do_swap_pte(vmf);
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
-- 
2.31.1

