Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60142CA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbhJMUAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJMUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:00:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF4C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:58:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f8-20020a2585480000b02905937897e3daso4433528ybn.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=e4Wzc1td/2jTkgPD91rDF6K16+hzxl1aXnOtt/YvVvc=;
        b=NtLKcrsdYZSuPqK3naRr3DYY7lBOzLNEleZZ6RgFpj6crxruM5XrGlp38d4i11d+Nv
         A6sr+0V18vjtib2uYGDy+Z8UG9Icx7AcIIiKQX6WwmlNJRhI5rLHdrnjxbyOYtv0cHxi
         vq5jBFuTWQ6Y3it3R/1CdOM3DLCMUSuC8vIOfPpRB61AYzHBWnLVN/n0uxP1y3AI6KA5
         cBMGHozwwnog2x8jio7eEKocLW8NAO44Qyc1c3nbMHh1JvXftZSsHraKrt729HIeXK6o
         wDyx3ihRs+Atq4jaov3AMdLi7xp9blrXdK/xT0cZomEEnGfwpvIRSCkhpLDZzWras0r6
         7fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=e4Wzc1td/2jTkgPD91rDF6K16+hzxl1aXnOtt/YvVvc=;
        b=CzXEGc5Piw8k+gpPm0eC/qFsEVAtFmSwIrLepVNVW5Z7rAFTE8li3nE7pNewCLWuT1
         7rkzdfbceG9JE1m9WZA27XXkEXMl3D4wXk4ySaOyWo8AWiWgIHTUpUvLJiGclIuwIL32
         Kwk+epQsYqImhWhbwi2Kw7S+1R7FUwpKCA0o6jeLvuzLHg50O6bSozasYwCVg3eAGwEM
         zKJI9/P2jXD6ylojBHPpoQ61Ow+b4x25fKemh68nybW5ItOVWI0CBBkKwa+oy9GffQYT
         9DYLKnpoQRzNEdR56cFHBVuYRjcUH8luPVpdjvO2T9z6+I0UuZLwTlwejea2GO1Remfm
         /muw==
X-Gm-Message-State: AOAM532PK89mb3Vj4zcpmzM/HMCz8fGFzAuBY3i3cM8iQqHTMSiAYs3T
        aJDROspzXX9iU4j4Ari11IjItPbgRciOT/jtqQ==
X-Google-Smtp-Source: ABdhPJzs1MmpH7jpvDTOdBFWRmleyuyHnVssIvobfdyPEgkMxf7T2g0cX3GoETTuj9ARzzfrDG3D6A2DV6qHjs5Qvg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:cb5d:d61e:f106:3c70])
 (user=almasrymina job=sendgmr) by 2002:a25:2785:: with SMTP id
 n127mr1492100ybn.235.1634155108618; Wed, 13 Oct 2021 12:58:28 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:58:23 -0700
Message-Id: <20211013195825.3058275-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v7 1/2] mm, hugepages: add mremap() support for hugepage
 backed vma
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support mremap() for hugepage backed vma segment by simply repositioning
page table entries. The page table entries are repositioned to the new
virtual address on mremap().

Hugetlb mremap() support is of course generic; my motivating use case
is a library (hugepage_text), which reloads the ELF text of executables
in hugepages. This significantly increases the execution performance of
said executables.

Restricts the mremap operation on hugepages to up to the size of the
original mapping as the underlying hugetlb reservation is not yet
capable of handling remapping to a larger size.

During the mremap() operation we detect pmd_share'd mappings and we
unshare those during the mremap(). On access and fault the sharing is
established again.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: Ken Chen <kenchen@google.com>
Cc: Chris Kennelly <ckennelly@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Kirill Shutemov <kirill@shutemov.name>


---

Changes in v7:
- Addressed nits from Mike.
- Added reviewd-by Mike.

Changes in v6:
- Converted hugetlb_vma_shareable() to static only (fixes build warning).
- Removed huge_pmd_shared(). It's not needed since I removed the
BUG_ON(huge_pmd_shared) in v3.
- Removed *...* format for emphasis.
- Fixed mremap behavior to hugepage-align lengths but return error if
addresses are not hugepage aligned.

Changes in v5:
- Remove hugetlb_vma_shareable and huge_pmd_shared dummy definitions for
!CONFIG_HUGETLB_PAGE config, since they are not used and were causing
added warning and build errors.

Changes in v4:
- Added addr, new_addr, old_len, and new_len hugepage alignment.

Changes in v3:
- Addressed review comments from Mike.
- Separated tests into their own patch.

Changes in v2:
- Re-wrote comment around clear_vma_resv_huge_pages() to make it clear
that the resv_map has been moved to the new VMA and why we need to clear it
from the current VMA.
- We detect huge_pmd_shared() pte's and unshare those rather than bug on
hugetlb_vma_shareable().
- This case now returns EFAULT:
if (!vma || vma->vm_start > addr)
	 goto out;
- Added kselftests for mremap() support.

---
 include/linux/hugetlb.h |  19 +++++++
 mm/hugetlb.c            | 111 +++++++++++++++++++++++++++++++++++++---
 mm/mremap.c             |  36 +++++++++++--
 3 files changed, 157 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebaba02706c87..44c2ab0dfa591 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -124,6 +124,7 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 void hugepage_put_subpool(struct hugepage_subpool *spool);

 void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
+void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
 int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
@@ -132,6 +133,10 @@ int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
 int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);

+int move_hugetlb_page_tables(struct vm_area_struct *vma,
+			     struct vm_area_struct *new_vma,
+			     unsigned long old_addr, unsigned long new_addr,
+			     unsigned long len);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, struct vm_area_struct **,
@@ -215,6 +220,10 @@ static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
 {
 }

+static inline void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
+{
+}
+
 static inline unsigned long hugetlb_total_pages(void)
 {
 	return 0;
@@ -262,6 +271,16 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
 	return 0;
 }

+static inline int move_hugetlb_page_tables(struct vm_area_struct *vma,
+					   struct vm_area_struct *new_vma,
+					   unsigned long old_addr,
+					   unsigned long new_addr,
+					   unsigned long len)
+{
+	BUG();
+	return 0;
+}
+
 static inline void hugetlb_report_meminfo(struct seq_file *m)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d2f4c25dd9fb..61168186024a8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1015,6 +1015,35 @@ void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
 		vma->vm_private_data = (void *)0;
 }

+/*
+ * Reset and decrement one ref on hugepage private reservation.
+ * Called with mm->mmap_sem writer semaphore held.
+ * This function should be only used by move_vma() and operate on
+ * same sized vma. It should never come here with last ref on the
+ * reservation.
+ */
+void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
+{
+	/*
+	 * Clear the old hugetlb private page reservation.
+	 * It has already been transferred to new_vma.
+	 *
+	 * During a mremap() operation of a hugetlb vma we call move_vma()
+	 * which copies vma into new_vma and unmaps vma. After the copy
+	 * operation both new_vma and vma share a reference to the resv_map
+	 * struct, and at that point vma is about to be unmapped. We don't
+	 * want to return the reservation to the pool at unmap of vma because
+	 * the reservation still lives on in new_vma, so simply decrement the
+	 * ref here and remove the resv_map reference from this vma.
+	 */
+	struct resv_map *reservations = vma_resv_map(vma);
+
+	if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
+		kref_put(&reservations->refs, resv_map_release);
+
+	reset_vma_resv_huge_pages(vma);
+}
+
 /* Returns true if the VMA has associated reserve pages */
 static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 {
@@ -4800,6 +4829,82 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	return ret;
 }

+static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
+			  unsigned long new_addr, pte_t *src_pte)
+{
+	struct hstate *h = hstate_vma(vma);
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t *dst_pte, pte;
+	spinlock_t *src_ptl, *dst_ptl;
+
+	dst_pte = huge_pte_offset(mm, new_addr, huge_page_size(h));
+	dst_ptl = huge_pte_lock(h, mm, dst_pte);
+	src_ptl = huge_pte_lockptr(h, mm, src_pte);
+
+	/*
+	 * We don't have to worry about the ordering of src and dst ptlocks
+	 * because exclusive mmap_sem (or the i_mmap_lock) prevents deadlock.
+	 */
+	if (src_ptl != dst_ptl)
+		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+
+	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
+	set_huge_pte_at(mm, new_addr, dst_pte, pte);
+
+	if (src_ptl != dst_ptl)
+		spin_unlock(src_ptl);
+	spin_unlock(dst_ptl);
+}
+
+int move_hugetlb_page_tables(struct vm_area_struct *vma,
+			     struct vm_area_struct *new_vma,
+			     unsigned long old_addr, unsigned long new_addr,
+			     unsigned long len)
+{
+	struct hstate *h = hstate_vma(vma);
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	unsigned long sz = huge_page_size(h);
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long old_end = old_addr + len;
+	unsigned long old_addr_copy;
+	pte_t *src_pte, *dst_pte;
+	struct mmu_notifier_range range;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
+				old_end);
+	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
+	mmu_notifier_invalidate_range_start(&range);
+	/* Prevent race with file truncation */
+	i_mmap_lock_write(mapping);
+	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
+		src_pte = huge_pte_offset(mm, old_addr, sz);
+		if (!src_pte)
+			continue;
+		if (huge_pte_none(huge_ptep_get(src_pte)))
+			continue;
+
+		/* old_addr arg to huge_pmd_unshare() is a pointer and so the
+		 * arg may be modified. Pass a copy instead to preserve the
+		 * value in old_addr.
+		 */
+		old_addr_copy = old_addr;
+
+		if (huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte))
+			continue;
+
+		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
+		if (!dst_pte)
+			break;
+
+		move_huge_pte(vma, old_addr, new_addr, src_pte);
+	}
+	i_mmap_unlock_write(mapping);
+	flush_tlb_range(vma, old_end - len, old_end);
+	mmu_notifier_invalidate_range_end(&range);
+
+	return len + old_addr - old_end;
+}
+
 static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end,
 				   struct page *ref_page)
@@ -6339,12 +6444,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * sharing is possible.  For hugetlbfs, this prevents removal of any page
  * table entries associated with the address space.  This is important as we
  * are setting up sharing based on existing page table entries (mappings).
- *
- * NOTE: This routine is only called from huge_pte_alloc.  Some callers of
- * huge_pte_alloc know that sharing is not possible and do not take
- * i_mmap_rwsem as a performance optimization.  This is handled by the
- * if !vma_shareable check at the beginning of the routine. i_mmap_rwsem is
- * only required for subsequent processing.
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
diff --git a/mm/mremap.c b/mm/mremap.c
index c0b6c41b7b78f..002eec83e91e5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -489,6 +489,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	old_end = old_addr + len;
 	flush_cache_range(vma, old_addr, old_end);

+	if (is_vm_hugetlb_page(vma))
+		return move_hugetlb_page_tables(vma, new_vma, old_addr,
+						new_addr, len);
+
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				old_addr, old_end);
 	mmu_notifier_invalidate_range_start(&range);
@@ -646,6 +650,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		mremap_userfaultfd_prep(new_vma, uf);
 	}

+	if (is_vm_hugetlb_page(vma)) {
+		clear_vma_resv_huge_pages(vma);
+	}
+
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vma->vm_flags &= ~VM_ACCOUNT;
@@ -739,9 +747,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return ERR_PTR(-EINVAL);

-	if (is_vm_hugetlb_page(vma))
-		return ERR_PTR(-EINVAL);
-
 	/* We can't remap across vm area boundaries */
 	if (old_len > vma->vm_end - addr)
 		return ERR_PTR(-EFAULT);
@@ -937,6 +942,31 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,

 	if (mmap_write_lock_killable(current->mm))
 		return -EINTR;
+	vma = find_vma(mm, addr);
+	if (!vma || vma->vm_start > addr) {
+		ret = EFAULT;
+		goto out;
+	}
+
+	if (is_vm_hugetlb_page(vma)) {
+		struct hstate *h __maybe_unused = hstate_vma(vma);
+
+		old_len = ALIGN(old_len, huge_page_size(h));
+		new_len = ALIGN(new_len, huge_page_size(h));
+
+		/* addrs must be huge page aligned */
+		if (addr & ~huge_page_mask(h))
+			goto out;
+		if (new_addr & ~huge_page_mask(h))
+			goto out;
+
+		/*
+		 * Don't allow remap expansion, because the underlying hugetlb
+		 * reservation is not yet capable to handle split reservation.
+		 */
+		if (new_len > old_len)
+			goto out;
+	}

 	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
 		ret = mremap_to(addr, old_len, new_addr, new_len,
--
2.33.0.882.g93a45727a2-goog
