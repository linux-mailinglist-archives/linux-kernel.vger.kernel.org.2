Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F1B3DC0D9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhG3WPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhG3WPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:15:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A894C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:15:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w200-20020a25c7d10000b02905585436b530so12045960ybe.21
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=LU5DBdfWbcb7nq9Hpjh9AB6SsnxaUwrgsobOqLYPM9o=;
        b=XpXwBkjGlVd2d6XL3s1SwLhwX8JZVK/cIvIbDFd3yRnmsGMBWKV8TuZpR0HUdQgXnU
         iJku5j3MvE5vmpW5QtBm45oQLb3xIvvX1uDHFvWv4VSw8nv96esBAsAF+Vagm8rLf/Ur
         Lk2WJIBDh/sCMPKcDjiiEmEkw9Nl108PBzM/SHCHl13YB5kSXKtRQGdfsuoMkb9xOF+j
         /vIHapRP1+NZ4FgJU7HzaHuXc9rwpBk5ILuL9tZbhJYGKlbSI94xBhsCF/vdwVgctge4
         StTqwvLN6o3c0IVSplYxXw9kh7/2lxtoZ1cco9qjSBPG5aAT5PPOAZZydmxMhk2jPoEQ
         Xwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=LU5DBdfWbcb7nq9Hpjh9AB6SsnxaUwrgsobOqLYPM9o=;
        b=NEwPbSQMtAHnamCJuDXYivCo2n/u+auhwRsn9DpepF1Up9JSBs/zoLif8tjZYeTKVv
         rFHcudZXuTlstaCEX8Sdh5gA0JvTy6I2Df6FLIOm5r8/YR9sAA8trzyq1Qdm21nbXOlV
         QKEAnFZ9h2v1prJHMG5yTdeEINH44AO+rf7QYjlijUp2uhqpI8MJClLK6FJYMAsN12I1
         hX4gtUPQSdyimhrq2fKUXoWGaUkMoDavSSTI5drEbp3g8491NPv6/ztya9qAkJ2eQC9k
         tt/Ks/iEiHPkXJKoeARdAmOTeJ3Dus0zlc11XflTgNhH8DhskFKaoZzXVbl9Z3AX0exw
         Dpig==
X-Gm-Message-State: AOAM5306xyhGvzOAr5T1JzV2OLqGwh3jb4WNoo0ZCMg+PmR8FuxyPNn4
        JwO8lsGm4KO52aOyje4M7XLtd+FZPlYHqq0/cw==
X-Google-Smtp-Source: ABdhPJxe1XYsmM6riS+UPT68QnUlgiHQqg3WENQUZg+apcfgwViegTCzjryTSQLvJ8lc2lb5AY9O5HG6KBsLJh2l9A==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:3576:2dfb:a2a7:68b7])
 (user=almasrymina job=sendgmr) by 2002:a25:2ac2:: with SMTP id
 q185mr2013749ybq.66.1627683335290; Fri, 30 Jul 2021 15:15:35 -0700 (PDT)
Date:   Fri, 30 Jul 2021 15:15:22 -0700
Message-Id: <20210730221522.524256-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v1] mm, hugepages: add mremap() support for hugepage backed vma
From:   Mina Almasry <almasrymina@google.com>
Cc:     Ken Chen <kenchen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ken Chen <kenchen@google.com>

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

Tested with a simple mmap/mremap test case, roughly:

void* haddr = mmap(NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC,
		MAP_ANONYMOUS | MAP_SHARED, -1, 0);

void* taddr = mmap(NULL, size, PROT_NONE,
		MAP_HUGETLB | MAP_ANONYMOUS | MAP_SHARED, -1, 0);

void* raddr = mremap(haddr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, taddr);

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: Ken Chen <kenchen@google.com>
Cc: Chris Kennelly <ckennelly@google.com>

---
 include/linux/hugetlb.h | 13 ++++++
 mm/hugetlb.c            | 89 +++++++++++++++++++++++++++++++++++++++++
 mm/mremap.c             | 75 ++++++++++++++++++++++++++++++++--
 3 files changed, 174 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f7ca1a3870ea5..685a289b58401 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -124,6 +124,7 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 void hugepage_put_subpool(struct hugepage_subpool *spool);

 void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
+void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
 int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
@@ -132,6 +133,8 @@ int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
 int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);

+int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long old_addr,
+			     unsigned long new_addr, unsigned long len);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, struct vm_area_struct **,
@@ -218,6 +221,10 @@ static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
 {
 }

+static inline void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
+{
+}
+
 static inline unsigned long hugetlb_total_pages(void)
 {
 	return 0;
@@ -265,6 +272,12 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
 	return 0;
 }

+#define move_hugetlb_page_tables(vma, old_addr, new_addr, len)                 \
+	({                                                                     \
+		BUG();                                                         \
+		0;                                                             \
+	})
+
 static inline void hugetlb_report_meminfo(struct seq_file *m)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 528947da65c8f..bd26b00caf3cf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1004,6 +1004,23 @@ void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
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
@@ -4429,6 +4446,73 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	return ret;
 }

+static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr);
+
+static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
+			  unsigned long new_addr, pte_t *src_pte)
+{
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct hstate *h = hstate_vma(vma);
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t *dst_pte, pte;
+	spinlock_t *src_ptl, *dst_ptl;
+
+	/* Shared pagetables need more thought here if we re-enable them */
+	BUG_ON(vma_shareable(vma, old_addr));
+
+	/* Prevent race with file truncation */
+	i_mmap_lock_write(mapping);
+
+	dst_pte = huge_pte_offset(mm, new_addr, huge_page_size(h));
+	dst_ptl = huge_pte_lock(h, mm, dst_pte);
+	src_ptl = huge_pte_lockptr(h, mm, src_pte);
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
+	i_mmap_unlock_write(mapping);
+}
+
+int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long old_addr,
+			     unsigned long new_addr, unsigned long len)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned long sz = huge_page_size(h);
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long old_end = old_addr + len;
+	pte_t *src_pte, *dst_pte;
+	struct mmu_notifier_range range;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
+				old_end);
+	mmu_notifier_invalidate_range_start(&range);
+	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
+		src_pte = huge_pte_offset(mm, old_addr, sz);
+		if (!src_pte)
+			continue;
+		if (huge_pte_none(huge_ptep_get(src_pte)))
+			continue;
+		dst_pte = huge_pte_alloc(mm, vma, new_addr, sz);
+		if (!dst_pte)
+			break;
+
+		move_huge_pte(vma, old_addr, new_addr, src_pte);
+	}
+	flush_tlb_range(vma, old_end - len, old_end);
+	mmu_notifier_invalidate_range_end(&range);
+
+	return len + old_addr - old_end;
+}
+
 void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			    unsigned long start, unsigned long end,
 			    struct page *ref_page)
@@ -6043,6 +6127,11 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 }

 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+{
+	return false;
+}
+
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
 {
diff --git a/mm/mremap.c b/mm/mremap.c
index badfe17ade1f0..3c0ee2bb9c439 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -489,6 +489,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	old_end = old_addr + len;
 	flush_cache_range(vma, old_addr, old_end);

+	if (is_vm_hugetlb_page(vma))
+		return move_hugetlb_page_tables(vma, old_addr, new_addr, len);
+
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				old_addr, old_end);
 	mmu_notifier_invalidate_range_start(&range);
@@ -642,6 +645,57 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		mremap_userfaultfd_prep(new_vma, uf);
 	}

+	if (is_vm_hugetlb_page(vma)) {
+		/*
+		 * Clear the old hugetlb private page reservation.
+		 * It has already been transferred to new_vma.
+		 *
+		 * The reservation tracking for hugetlb private mapping is
+		 * done in two places:
+		 * 1. implicit vma size, e.g. vma->vm_end - vma->vm_start
+		 * 2. tracking of hugepages that has been faulted in already,
+		 *    this is done via a linked list hanging off
+		 *    vma_resv_map(vma).
+		 *
+		 * Each hugepage vma also has hugepage specific vm_ops method
+		 * and there is an imbalance in the open() and close method.
+		 *
+		 * In the open method (hugetlb_vm_op_open), a ref count is
+		 * obtained on the structure that tracks faulted in pages.
+		 *
+		 * In the close method, it unconditionally returns pending
+		 * reservation on the vma as well as release a kref count and
+		 * calls release function upon last reference.
+		 *
+		 * Because of this unbalanced operation in the open/close
+		 * method, this code runs into trouble in the mremap() path:
+		 * copy_vma will copy the pointer to the reservation structure,
+		 * then calls vma->vm_ops->open() method, which only increments
+		 * ref count on the tracking structure and does not do actual
+		 * reservation.  In the same code sequence from move_vma(), the
+		 * close() method is called as a result of cleaning up original
+		 * vma segment from a call to do_munmap().  At this stage, the
+		 * tracking and reservation is out of balance, e.g. the
+		 * reservation is returned, however there is an active ref on
+		 * the tracking structure.
+		 *
+		 * When the remap'ed vma unmaps (either implicit at process
+		 * exit or explicit munmap), the reservation will be returned
+		 * again because hugetlb_vm_op_close calculate pending
+		 * reservation unconditionally based on size of vma.  This
+		 * cause h->resv_huge_pages. to underflow and no more hugepages
+		 * can be allocated to application in certain situation.
+		 *
+		 * We need to reset and clear the tracking reservation, such
+		 * that we don't prematurely returns hugepage reservation at
+		 * mremap time.  The reservation should only be returned at
+		 * munmap() time.  This is totally undesired, however, we
+		 * don't want to re-factor hugepage reservation code at this
+		 * stage for prod kernel. Resetting is the least risky method.
+		 */
+		clear_vma_resv_huge_pages(vma);
+	}
+
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vma->vm_flags &= ~VM_ACCOUNT;
@@ -736,9 +790,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return ERR_PTR(-EINVAL);

-	if (is_vm_hugetlb_page(vma))
-		return ERR_PTR(-EINVAL);
-
 	/* We can't remap across vm area boundaries */
 	if (old_len > vma->vm_end - addr)
 		return ERR_PTR(-EFAULT);
@@ -949,6 +1000,24 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,

 	if (mmap_write_lock_killable(current->mm))
 		return -EINTR;
+	vma = find_vma(mm, addr);
+	if (!vma || vma->vm_start > addr)
+		goto out;
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
2.32.0.554.ge1b32706d8-goog
