Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C8836C945
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbhD0QYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237539AbhD0QOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2JkGq2vO8wj3u4HClWKqDzaqtOjDoD0JZSILmTLsRU=;
        b=bnJiEX/juZjNnNS7/iwS2kZDcLSTuv8pPLSqUGKjMxup0uW9RYDGFwximZuct2YYfJkgK7
        NRgEvSArevITTRIum8zOFRRLIRztRGZ//4X1BUAONyq9VStkWhwAIKr7zYeJhkhBWnZRKP
        vEEQEjjziSAAMEhYWXs1LFbxeQCRdI0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-Mp7SFS10PL64IKDk1z-CJg-1; Tue, 27 Apr 2021 12:13:30 -0400
X-MC-Unique: Mp7SFS10PL64IKDk1z-CJg-1
Received: by mail-qv1-f71.google.com with SMTP id i3-20020a0c9c830000b02901bb3405e50aso4161323qvf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2JkGq2vO8wj3u4HClWKqDzaqtOjDoD0JZSILmTLsRU=;
        b=IJCuRkmDq6vpxXxASC6BWKn4d1Eeeo8GHTkGU5e4eCMpDCmx+rErs0qsQTNJAUlrRs
         oUSlkI6Z85VF7XgYZffqlGzkjtRffwsPXrKlzmg79DbcfBHaZLbdzDR8tWFKDBAySUuZ
         r7uMhJTVuWHWVDPQybLF7kIgwsPI3wY9HL/tqni7cqzM4aZOJTnPYgEIoDF3Xibz8E6l
         3i3i7t0oVqn+e/bNkmTJa4knRT+wz/5MuKw6cmvjR9UCgURUvOyt66oJW25XmW0HCKiW
         SEFkfsnA50eSSdZzPbFlS9vqVbMTKw149JFFqPsr9BbVXrLacAflrFGrNoUeC5AE/Xwg
         YkXg==
X-Gm-Message-State: AOAM533MiBqd0bYI3wzX4a5m/UBbgGJVDhmzw8s+11zVbpEsm2bbTiTY
        xrqtUTbCMZ82zEzIvqS8lFs/6UOAsgvmn+FdFD0XBIpE1mdm4tEDGhkxbXPMCvUNVxnFA5i2/il
        Nhif7KhJjK9IU1EVRyb+P9WxI
X-Received: by 2002:a37:b685:: with SMTP id g127mr6501911qkf.42.1619540009581;
        Tue, 27 Apr 2021 09:13:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx5mLIHNqVmAY+l6qskoKTYPSrLswCa0ymj3l43bBwGXFObHOSp0TR6zVhhrJneunIDW/6Kg==
X-Received: by 2002:a37:b685:: with SMTP id g127mr6501882qkf.42.1619540009216;
        Tue, 27 Apr 2021 09:13:29 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 05/24] shmem/userfaultfd: Handle uffd-wp special pte in page fault handler
Date:   Tue, 27 Apr 2021 12:12:58 -0400
Message-Id: <20210427161317.50682-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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

Prepare this by handling such a special pte first before it is applied.  Here
a new fault flag FAULT_FLAG_UFFD_WP is introduced.  When this flag is set, it
means the current fault is to resolve a page access (either read or write) to
the uffd-wp special pte.

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
read-only, so the message will be generated until the next do_wp_page() call.

Disable fault-around for such a special page fault, because the introduced new
flag (FAULT_FLAG_UFFD_WP) only applies to current pte rather than all the pages
around it.  Doing fault-around with the new flag could confuse all the rest of
pages when installing ptes from page cache when there's a cache hit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 11 +++++
 mm/memory.c                   | 80 ++++++++++++++++++++++++++++++++---
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index bc733512c6905..fefebe6e96560 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -89,6 +89,17 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
+/*
+ * Don't do fault around for FAULT_FLAG_UFFD_WP because it means we want to
+ * recover a previously wr-protected pte.  This flag is a per-pte information,
+ * so it could confuse all the pages around the current page when faulted in.
+ * Similar reason for MINOR mode faults.
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
index 235857ccfaa11..02db41bad3340 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3786,6 +3786,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool uffd_wp = pte_swp_uffd_wp_special(vmf->orig_pte);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->address != addr;
 	pte_t entry;
@@ -3798,6 +3799,8 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	if (unlikely(uffd_wp))
+		entry = pte_mkuffd_wp(pte_wrprotect(entry));
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -3865,8 +3868,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
@@ -3970,9 +3977,21 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
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
@@ -3980,7 +3999,7 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * if page by the offset is not ready to be mapped (cold cache or
 	 * something).
 	 */
-	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
+	if (should_fault_around(vmf)) {
 		ret = do_fault_around(vmf);
 		if (ret)
 			return ret;
@@ -4293,6 +4312,57 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
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
@@ -4367,7 +4437,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 
 	if (!pte_present(vmf->orig_pte))
-		return do_swap_page(vmf);
+		return do_swap_pte(vmf);
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
-- 
2.26.2

