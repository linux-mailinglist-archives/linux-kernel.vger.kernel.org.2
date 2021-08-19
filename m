Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED85F3F0F88
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 02:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhHSAlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 20:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhHSAlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:41:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD3FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 17:40:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j21-20020a25d2150000b029057ac4b4e78fso4789754ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 17:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=XHh/if3cqFc8zMunaWaJpec+NDBSj9456RSvII6RsNU=;
        b=tl9Hk0dOpTaHmUIFyp0NqYVhC+ygk0eIQFSLGJ7DRwwIquhW17v70UlL3bsW+nB3Ey
         vYOM7Ni4rdOXKWfJxOSTv28wLKpEOJWWuxBeilq2Tn5oLkB/SsiOjJ91CaYae6lxIbj8
         i3OYqVcb0GrI7YS5meWWVBbCC07QIItngv3oNkRNgYSzevuscylFTU/W7giWirD63uzX
         eBYVb1OT4dRE89RebqnBSvv5XKM3TZrJ9w9jlJa7YmSAt2MnTZzBr40WaZgYBwPCxr3o
         ksp4I+uYIBg/XRal4geeNWmg4nzeGWmE10KITbB9bmuXjBCbWRZWIQ2BPZyaKLkimVJu
         Ew1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=XHh/if3cqFc8zMunaWaJpec+NDBSj9456RSvII6RsNU=;
        b=NzXELvdhJ2s0XFK+LapHjpRs84hgnn7xfi0JqxYYCjAgBGOs//KjZqr8WZ6//3tDOv
         RkQ7nGrTBqVq7+f6da1sC+2Oi+aAIs870lBtYMpQyQIFWbuuj7c16pYPmc7F+EN2y4kX
         8vQtf7noBJXi32WX/XHGAs9mO9r0bu2Gn894VVWqA+7ZeqComuC9YiZfoLXPxPwMgoFS
         YGvbVwISma7H9OI7Q+95X98sh7NtB+v3xCBOANzye1otli7RgkUc6VWcRzRX5IYzVDVc
         WA+uOIIyzRUzqYh/G5jmQ6fwUnR2lXYrokW5fEcro6hWgVktGOqz2qA2D52cZgmnmDO+
         iuuw==
X-Gm-Message-State: AOAM532n6lgFqb0Vx0qppJP71IdIE2xzZQnOKFzUqZp+VpjqTGksXO6A
        kEHBdRa7uU7WxBhfrVSClmYemAotJ3jUBtSajA==
X-Google-Smtp-Source: ABdhPJz5BUXMOZ9A8JwyfKNpzhHLnIwKDijViVCYI8L34x5ObUHeEA/rg6l4p2ZWJeYYgrKVkSr9U1Sd9hCYUCHVyA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:c56d:4854:9e72:932c])
 (user=almasrymina job=sendgmr) by 2002:a25:cf8a:: with SMTP id
 f132mr15757669ybg.387.1629333631793; Wed, 18 Aug 2021 17:40:31 -0700 (PDT)
Date:   Wed, 18 Aug 2021 17:40:25 -0700
Message-Id: <20210819004026.3639293-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 1/2] mm, hugepages: add mremap() support for hugepage
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
 include/linux/hugetlb.h |  27 +++++++++
 mm/hugetlb.c            | 131 +++++++++++++++++++++++++++++++++++++---
 mm/mremap.c             |  31 +++++++++-
 3 files changed, 178 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f7ca1a3870ea5..a017181abdce5 100644
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
@@ -190,6 +195,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 				unsigned long *addr, pte_t *ptep);
+int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
@@ -211,6 +217,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -218,6 +225,10 @@ static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
 {
 }
 
+static inline void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
+{
+}
+
 static inline unsigned long hugetlb_total_pages(void)
 {
 	return 0;
@@ -229,6 +240,11 @@ static inline struct address_space *hugetlb_page_mapping_lock_write(
 	return NULL;
 }
 
+static int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep)
+{
+	return 0;
+}
+
 static inline int huge_pmd_unshare(struct mm_struct *mm,
 					struct vm_area_struct *vma,
 					unsigned long *addr, pte_t *ptep)
@@ -265,6 +281,12 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
 	return 0;
 }
 
+#define move_hugetlb_page_tables(vma, new_vma, old_addr, new_addr, len)        \
+	({                                                                     \
+		BUG();                                                         \
+		0;                                                             \
+	})
+
 static inline void hugetlb_report_meminfo(struct seq_file *m)
 {
 }
@@ -402,6 +424,11 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 528947da65c8f..9cfaa9cd7abaf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1004,6 +1004,35 @@ void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
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
+	 * which copies *vma* into *new_vma* and unmaps *vma*. After the copy
+	 * operation both *new_vma* and *vma* share a reference to the resv_map
+	 * struct, and at that point *vma* is about to be unmapped. We don't
+	 * want to return the reservation to the pool at unmap of *vma* because
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
@@ -4429,6 +4458,82 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
+		 * value in old_arg.
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
 void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			    unsigned long start, unsigned long end,
 			    struct page *ref_page)
@@ -5900,7 +6005,7 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 {
 	unsigned long base = addr & PUD_MASK;
 	unsigned long end = base + PUD_SIZE;
@@ -5919,7 +6024,7 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
 #endif
-	return vma_shareable(vma, addr);
+	return hugetlb_vma_shareable(vma, addr);
 }
 
 /*
@@ -5959,12 +6064,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
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
@@ -6042,7 +6141,23 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	return 1;
 }
 
+int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep)
+{
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	BUG_ON(page_count(virt_to_page(ptep)) == 0);
+	if (page_count(virt_to_page(ptep)) == 1)
+		return 0;
+
+	return 1;
+}
+
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+static bool hugetlb_vma_shareable(struct vm_area_struct *vma,
+				  unsigned long addr)
+{
+	return false;
+}
+
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
 {
diff --git a/mm/mremap.c b/mm/mremap.c
index badfe17ade1f0..ad0a1b0940220 100644
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
@@ -642,6 +646,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		mremap_userfaultfd_prep(new_vma, uf);
 	}
 
+	if (is_vm_hugetlb_page(vma)) {
+		clear_vma_resv_huge_pages(vma);
+	}
+
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vma->vm_flags &= ~VM_ACCOUNT;
@@ -736,9 +744,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return ERR_PTR(-EINVAL);
 
-	if (is_vm_hugetlb_page(vma))
-		return ERR_PTR(-EINVAL);
-
 	/* We can't remap across vm area boundaries */
 	if (old_len > vma->vm_end - addr)
 		return ERR_PTR(-EFAULT);
@@ -949,6 +954,26 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 
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
+		if (old_len & ~huge_page_mask(h) ||
+		    new_len & ~huge_page_mask(h))
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
2.33.0.rc1.237.g0d66db33f3-goog

