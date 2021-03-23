Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260FF34542A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhCWAuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230506AbhCWAt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDWZ3WcjzLBFN4Ysj1UCXP8mvHfkjlwVRvCaVc8sMRI=;
        b=dRx3nlP+Iv9wHo0cttmA5UPGX5VL0g+I+7HxasSrSnyO8JGVad2q0DXTwvD0bMjwZLYqMr
        0SXBaPhzrpx27ijpHj6VgOApyZtxN+EdWyiDs/j/eH8ABb700opsShKW4auycG/9O6aWbD
        cIUPVSuMq0Ghw6tR65bDU/vLJXj5Zrc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-XfXtY0BcPdeKNCM1Mdr6RA-1; Mon, 22 Mar 2021 20:49:25 -0400
X-MC-Unique: XfXtY0BcPdeKNCM1Mdr6RA-1
Received: by mail-qt1-f200.google.com with SMTP id l63so381022qtd.23
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDWZ3WcjzLBFN4Ysj1UCXP8mvHfkjlwVRvCaVc8sMRI=;
        b=kafN1fSYXSMnF2qPglm/zykwIr8hWscpPVARsZZT8YFrsLFZnoi4H5lPbS/8WTvfYg
         FSIKkiGB7yUF8Kb1gLNcpL9e0DpO9snP1zynWJQ2HKtk4IdfrCrQG9eK7G2FVroWeine
         Na0d6D0WtifItsNVR51V6ZFv9TGWFsdQCVoVfvr7uhoHUUEddpFcm3P2l8yz0ouZVQ7f
         y3RDn5Rzfjdo6DPqbW59fYVNK4xpY0km8QLK4BHfoz4TzCOxDBgrYUCp8aVx3ke1lOXB
         NxU2wSMQO4yMyxojRyS1oJnyQoP+YT/Zl5lhVCAToEnvU1jmXBBo9h1HUNEPS1ElReUq
         fNmA==
X-Gm-Message-State: AOAM530OH000PDUV/qwcdDybCRKb6Fzug5S5yGVzeUqkwXyshoLCI9V+
        7LbCQBZoauR4Eebh2u8HL2xF3c+PxQTk912a0c54ew3E8Lzs+h234yS7qde6slsWjKD4LWSroX3
        /1bFJipKu6fhDIy0SAM6T2g+gxWBrAw9fbQ4Vz0AgTHdycfy7TWLgLNlnuaPJ0daWZPgABFKI1w
        ==
X-Received: by 2002:ac8:5212:: with SMTP id r18mr2326366qtn.290.1616460563438;
        Mon, 22 Mar 2021 17:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygmCCy7L0hZsid2x69DTLeqwC012NMnR0C/+lqM+3H/VKhd03Jxq9vTuX6ffs2CJHo0ib0KA==
X-Received: by 2002:ac8:5212:: with SMTP id r18mr2326329qtn.290.1616460562949;
        Mon, 22 Mar 2021 17:49:22 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 05/23] shmem/userfaultfd: Handle uffd-wp special pte in page fault handler
Date:   Mon, 22 Mar 2021 20:48:54 -0400
Message-Id: <20210323004912.35132-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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

Because of this, the page fault handling is simplifed too by always assuming
it's a read fault when calling do_fault().  When it's a write fault, it'll
fault again when retry the page access, then do_wp_page() will handle the rest
of message generation and delivery to the userfaultfd.

Disable fault-around for such a special page fault, because the introduced new
flag (FAULT_FLAG_UFFD_WP) only applies to current pte rather than all the pages
around it.  Doing fault-around with the new flag could confuse all the rest of
pages when installing ptes from page cache when there's a cache hit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h            |   2 +
 include/linux/userfaultfd_k.h |  11 ++++
 mm/memory.c                   | 103 +++++++++++++++++++++++++++++++---
 3 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cb1e191da319..b78306eb7a63 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -441,6 +441,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_UFFD_WP: When install new page entries, set uffd-wp bit.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -471,6 +472,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE			0x80
 #define FAULT_FLAG_INSTRUCTION  		0x100
 #define FAULT_FLAG_INTERRUPTIBLE		0x200
+#define FAULT_FLAG_UFFD_WP			0x400
 
 /*
  * The default fault flags that should be used by most of the
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index bc733512c690..fefebe6e9656 100644
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
index 8c4ed1f9693c..b4ddba343abc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3775,6 +3775,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool uffd_wp = vmf->flags & FAULT_FLAG_UFFD_WP;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->address != addr;
 	pte_t entry;
@@ -3787,6 +3788,11 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	if (uffd_wp) {
+		/* This should only be triggered by a read fault */
+		WARN_ON_ONCE(write);
+		entry = pte_mkuffd_wp(pte_wrprotect(entry));
+	}
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -3816,6 +3822,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
  */
 vm_fault_t finish_fault(struct vm_fault *vmf)
 {
+	bool pte_stable, uffd_wp = vmf->flags & FAULT_FLAG_UFFD_WP;
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	vm_fault_t ret;
@@ -3854,8 +3861,14 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				      vmf->address, &vmf->ptl);
 	ret = 0;
+
+	if (unlikely(uffd_wp))
+		pte_stable = pte_swp_uffd_wp_special(*vmf->pte);
+	else
+		pte_stable = pte_none(*vmf->pte);
+
 	/* Re-check under ptl */
-	if (likely(pte_none(*vmf->pte)))
+	if (likely(pte_stable))
 		do_set_pte(vmf, page, vmf->address);
 	else
 		ret = VM_FAULT_NOPAGE;
@@ -3959,9 +3972,21 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
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
@@ -3969,12 +3994,10 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
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
@@ -4284,6 +4307,68 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
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
+	 * Tell all the rest of the fault code: we're handling a special pte,
+	 * always remember to arm the uffd-wp bit when intalling the new pte.
+	 */
+	vmf->flags |= FAULT_FLAG_UFFD_WP;
+
+	/*
+	 * Let's assume this is a read fault no matter what.  If it is a real
+	 * write access, it'll fault again into do_wp_page() where the message
+	 * will be generated before the thread yields itself.
+	 *
+	 * Ideally we can also handle write immediately before return, but this
+	 * should be a slow path already (pte unmapped), so be simple first.
+	 */
+	vmf->flags &= ~FAULT_FLAG_WRITE;
+
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
@@ -4358,7 +4443,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 
 	if (!pte_present(vmf->orig_pte))
-		return do_swap_page(vmf);
+		return do_swap_pte(vmf);
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
-- 
2.26.2

