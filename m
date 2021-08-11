Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BED23E878B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 03:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhHKBLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 21:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhHKBLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:11:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB954C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 18:10:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d69-20020a25e6480000b02904f4a117bd74so765877ybh.17
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 18:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=Xt7CMQBJ8XYP9ZYv9Y9EWYdwWLpfsjn3j0g4k6OxdcM=;
        b=B1JIec+Hb19syEQKEeL4DVvEP84gt0F1zVR6bnuZNWeKqBU0xZhehlB+eNTvm50vZ+
         CmybxTBWKHsCsdJdSDZBz5GF1Z4ytWvA1pEfJSJzq9Kz7RfJDuUA+NBSAUfY69t6TgvK
         x/pHXxscRNcAMak0ShlhakZn7QQaBgqBLw5THRbqDYEoFhmSa0vo/MBLAx7wTakY8bvH
         izBNj4U4Ka+R11t5t9HHlHqOTPpUqWDl0fAVmReWuDRUNBB9Jd1xg0eQANC793RfrXz2
         uR1YQ6ERr2S5almFs1QyOQ+Sbrr8fmmpKCvYW1e7x7QmLruRRzf4S176wFdnYeawaX20
         3VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=Xt7CMQBJ8XYP9ZYv9Y9EWYdwWLpfsjn3j0g4k6OxdcM=;
        b=db7bGUzhT0E3RxIeElI2vo4lXV+A6BQKD9A5+jhe3sKqQwUjfcNFq8EIuwy+T4C/H0
         bS/FkyU/BtIe4bQdon9uV8YH6O4xXytEJCrxs9VR62xhYTrQ+6WuHtr3Qk6JzyGKjBS1
         NBxywtK3f20oRCpXVcldyX5MFg1zIWKDM599LsvemgdUDABQ4UdWHAvOsgQUnAxIHFW+
         i5Wcxz/6XVoHYqdCe+3S2ScjtFy+pJR3iBKMqU3thnUUIUSqdM/mjULLFG7s/vbLeJOT
         JIErbPnopgBiXWDkFKhNuAg7IgKnbldQDuMrK9lC9pff7w5R2R5E0ux3jWzrRNkKd+Tu
         O3Fw==
X-Gm-Message-State: AOAM5310p2p0r98wqnZLL3TqP892qe/MwBn21LZoRfnFXlUk+V+5HXGC
        KxlHlo9ozzKNSY5pERhRZ02HfU+RFDbcpRVoSw==
X-Google-Smtp-Source: ABdhPJxg9jwHtfufGRw9/fWt5C0vXH8KeEcCqpfGpT1s44Zt1WSuOYEMjjU/Y8n4j6ws+kuHdr85FbyA1Z0gZ1XYhg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:34db:32e2:2820:fc86])
 (user=almasrymina job=sendgmr) by 2002:a25:1e04:: with SMTP id
 e4mr2613157ybe.115.1628644259006; Tue, 10 Aug 2021 18:10:59 -0700 (PDT)
Date:   Tue, 10 Aug 2021 18:10:56 -0700
Message-Id: <20210811011056.770351-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2] mm, hugepages: add mremap() support for hugepage backed vma
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>
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

---

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
 include/linux/hugetlb.h                      |  24 +++
 mm/hugetlb.c                                 | 125 +++++++++++++-
 mm/mremap.c                                  |  30 +++-
 tools/testing/selftests/vm/.gitignore        |   1 +
 tools/testing/selftests/vm/Makefile          |   1 +
 tools/testing/selftests/vm/hugepage-mremap.c | 163 +++++++++++++++++++
 tools/testing/selftests/vm/userfaultfd.c     |   0
 7 files changed, 337 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/vm/hugepage-mremap.c
 mode change 100644 => 100755 tools/testing/selftests/vm/userfaultfd.c

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f7ca1a3870ea5..62da774802715 100644
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
@@ -190,6 +193,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 				unsigned long *addr, pte_t *ptep);
+int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
@@ -211,6 +215,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,

 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr);
+

 #else /* !CONFIG_HUGETLB_PAGE */

@@ -218,6 +224,10 @@ static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
 {
 }

+static inline void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
+{
+}
+
 static inline unsigned long hugetlb_total_pages(void)
 {
 	return 0;
@@ -229,6 +239,10 @@ static inline struct address_space *hugetlb_page_mapping_lock_write(
 	return NULL;
 }

+static int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep) {
+	return 0;
+}
+
 static inline int huge_pmd_unshare(struct mm_struct *mm,
 					struct vm_area_struct *vma,
 					unsigned long *addr, pte_t *ptep)
@@ -265,6 +279,12 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
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
@@ -402,6 +422,10 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,

 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }

+bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr) {
+	return 0;
+}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 528947da65c8f..aac3308037ae4 100644
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
@@ -4429,6 +4458,79 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
+	/* Shared pmd's need to be unshared, not moved, and we should never
+	 * reach here.
+	 */
+	BUG_ON(huge_pmd_shared(vma, src_pte));
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
+}
+
+int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long old_addr,
+			     unsigned long new_addr, unsigned long len)
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
+		old_addr_copy = old_addr;
+
+		if(huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte))
+			continue;
+
+		dst_pte = huge_pte_alloc(mm, vma, new_addr, sz);
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
@@ -5900,7 +6002,7 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }

-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 {
 	unsigned long base = addr & PUD_MASK;
 	unsigned long end = base + PUD_SIZE;
@@ -5919,7 +6021,7 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
 #endif
-	return vma_shareable(vma, addr);
+	return hugetlb_vma_shareable(vma, addr);
 }

 /*
@@ -5963,8 +6065,8 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * NOTE: This routine is only called from huge_pte_alloc.  Some callers of
  * huge_pte_alloc know that sharing is not possible and do not take
  * i_mmap_rwsem as a performance optimization.  This is handled by the
- * if !vma_shareable check at the beginning of the routine. i_mmap_rwsem is
- * only required for subsequent processing.
+ * if !hugetlb_vma_shareable check at the beginning of the routine. i_mmap_rwsem
+ * is only required for subsequent processing.
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
@@ -6042,7 +6144,22 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
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
+static bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+{
+	return false;
+}
+
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
 {
diff --git a/mm/mremap.c b/mm/mremap.c
index badfe17ade1f0..5f3a7f9362865 100644
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
@@ -642,6 +645,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		mremap_userfaultfd_prep(new_vma, uf);
 	}

+	if (is_vm_hugetlb_page(vma)) {
+		clear_vma_resv_huge_pages(vma);
+	}
+
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vma->vm_flags &= ~VM_ACCOUNT;
@@ -736,9 +743,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return ERR_PTR(-EINVAL);

-	if (is_vm_hugetlb_page(vma))
-		return ERR_PTR(-EINVAL);
-
 	/* We can't remap across vm area boundaries */
 	if (old_len > vma->vm_end - addr)
 		return ERR_PTR(-EFAULT);
@@ -949,6 +953,26 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,

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
+				new_len & ~huge_page_mask(h))
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
diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index b02eac613fdda..2e7e86e852828 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 hugepage-mmap
+hugepage-mremap
 hugepage-shm
 khugepaged
 map_hugetlb
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index d9605bd10f2de..1607322a112c9 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -29,6 +29,7 @@ TEST_GEN_FILES = compaction_test
 TEST_GEN_FILES += gup_test
 TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugepage-mmap
+TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
 TEST_GEN_FILES += khugepaged
 TEST_GEN_FILES += madv_populate
diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
new file mode 100644
index 0000000000000..b55052d4eadc9
--- /dev/null
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * hugepage-mremap:
+ *
+ * Example of remapping huge page memory in a user application using the
+ * mremap system call.  Before running this application, make sure that the
+ * administrator has mounted the hugetlbfs filesystem (on some directory
+ * like /mnt) using the command mount -t hugetlbfs nodev /mnt. In this
+ * example, the app is requesting memory of size 10MB that is backed by
+ * huge pages.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <fcntl.h> /* Definition of O_* constants */
+#include <sys/syscall.h> /* Definition of SYS_* constants */
+#include <unistd.h>
+#include <linux/userfaultfd.h>
+#include <sys/ioctl.h>
+
+#define LENGTH (1UL * 1024 * 1024 * 1024)
+
+#define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
+#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
+
+static void check_bytes(char *addr)
+{
+	printf("First hex is %x\n", *((unsigned int *)addr));
+}
+
+static void write_bytes(char *addr)
+{
+	unsigned long i;
+
+	for (i = 0; i < LENGTH; i++) {
+		*(addr + i) = (char)i;
+	}
+}
+
+static int read_bytes(char *addr)
+{
+	unsigned long i;
+
+	check_bytes(addr);
+	for (i = 0; i < LENGTH; i++)
+		if (*(addr + i) != (char)i) {
+			printf("Mismatch at %lu\n", i);
+			return 1;
+		}
+	return 0;
+}
+
+static int register_region_with_uffd(char *addr, size_t len)
+{
+	long uffd; /* userfaultfd file descriptor */
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+	int s;
+
+	/* Create and enable userfaultfd object. */
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd == -1) {
+		perror("userfaultfd");
+		exit(1);
+	}
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
+		perror("ioctl-UFFDIO_API");
+		exit(1);
+	}
+
+	/* Create a private anonymous mapping. The memory will be
+	   demand-zero paged--that is, not yet allocated. When we
+	   actually touch the memory, it will be allocated via
+	   the userfaultfd. */
+
+	addr = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	printf("Address returned by mmap() = %p\n", addr);
+
+	/* Register the memory range of the mapping we just created for
+	   handling by the userfaultfd object. In mode, we request to track
+	   missing pages (i.e., pages that have not yet been faulted in). */
+
+	uffdio_register.range.start = (unsigned long)addr;
+	uffdio_register.range.len = len;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
+		perror("ioctl-UFFDIO_REGISTER");
+		exit(1);
+	}
+}
+
+int main(void)
+{
+	int ret = 0;
+
+	int fd = open("/mnt/huge/test", O_CREAT | O_RDWR, 0755);
+	if (fd < 0) {
+		perror("Open failed");
+		exit(1);
+	}
+
+	/* mmap to a PUD aligned address to hopefully trigger pmd sharing. */
+	unsigned long suggested_addr = 0x7eaa40000000;
+	void *haddr = mmap((void *)suggested_addr, LENGTH, PROTECTION,
+			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
+	printf("Returned address is %p\n", haddr);
+	if (haddr == MAP_FAILED) {
+		perror("mmap1");
+		exit(1);
+	}
+
+	/* mmap again to a dummy address to hopefully trigger pmd sharing. */
+	suggested_addr = 0x7daa40000000;
+	void *daddr = mmap((void *)suggested_addr, LENGTH, PROTECTION,
+			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
+	printf("Returned address is %p\n", daddr);
+	if (haddr == MAP_FAILED) {
+		perror("mmap3");
+		exit(1);
+	}
+
+	suggested_addr = 0x7faa40000000;
+	void *vaddr = mmap((void*)suggested_addr, LENGTH, PROTECTION, FLAGS, -1, 0);
+	printf("Returned address is %p\n", vaddr);
+	if (vaddr == MAP_FAILED) {
+		perror("mmap2");
+		exit(1);
+	}
+
+	register_region_with_uffd(haddr, LENGTH);
+
+	void *addr = mremap(haddr, LENGTH, LENGTH,
+			MREMAP_MAYMOVE | MREMAP_FIXED, vaddr);
+	if (addr == MAP_FAILED) {
+		perror("mremap");
+		exit(1);
+	}
+
+	printf("Returned address is %p\n", addr);
+	check_bytes(addr);
+	write_bytes(addr);
+	ret = read_bytes(addr);
+
+	munmap(addr, LENGTH);
+
+	return ret;
+}
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
old mode 100644
new mode 100755
--
2.32.0.605.g8dce9f2422-goog
