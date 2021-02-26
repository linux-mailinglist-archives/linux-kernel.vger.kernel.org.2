Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F051A325E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBZHVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:21:45 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13698 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBZHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:19:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6038a0ed0000>; Thu, 25 Feb 2021 23:19:09 -0800
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 07:19:07 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <jgg@nvidia.com>,
        <hch@infradead.org>, <daniel@ffwll.ch>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v3 5/8] mm: Device exclusive memory access
Date:   Fri, 26 Feb 2021 18:18:29 +1100
Message-ID: <20210226071832.31547-6-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210226071832.31547-1-apopple@nvidia.com>
References: <20210226071832.31547-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614323949; bh=LA4PXrGKN/jLxXF09fLagznZjXHUBiQjMkO7BWsfuVc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type:
         X-Originating-IP:X-ClientProxiedBy;
        b=okUPP2AB8JHCRP0nLw096XXAPMUyNAVmcdUwZrOJ6lhYJhVT/zeOPxrAxENRYEede
         lpGU6eQBIy9ZmM9ITndALG9+7YQ5oHQXYDhwJrV/GVtqqPIdv5frmhou7FQhAf0LgY
         9bl/J6vllwtxGaf2kwP4MfAhM/QzAmvRD5ebG+v4uwhVe2SXzpDcVp3HEDsti5+JQi
         4LO7/PPC/rArKjIhzDKYyoJQiBLmgpgEEWMxqWaCi38RRmXOLm0dp9UNbttJIroXa/
         EtZPEsZSdlrj9gJ4b1oz5V+FDCUrh+sj037dZNIZ3hL5jvtamZ3m0ZKMzwbeV1usVd
         uOiV0ZHDG8mEQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices require exclusive write access to shared virtual
memory (SVM) ranges to perform atomic operations on that memory. This
requires CPU page tables to be updated to deny access whilst atomic
operations are occurring.

In order to do this introduce a new swap entry
type (SWP_DEVICE_EXCLUSIVE). When a SVM range needs to be marked for
exclusive access by a device all page table mappings for the particular
range are replaced with device exclusive swap entries. This causes any
CPU access to the page to result in a fault.

Faults are resovled by replacing the faulting entry with the original
mapping. This results in MMU notifiers being called which a driver uses
to update access permissions such as revoking atomic access. After
notifiers have been called the device will no longer have exclusive
access to the region.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 Documentation/vm/hmm.rst |  15 ++++
 include/linux/rmap.h     |   3 +
 include/linux/swap.h     |   4 +-
 include/linux/swapops.h  |  44 ++++++++++-
 mm/hmm.c                 |   5 ++
 mm/memory.c              | 108 +++++++++++++++++++++++++-
 mm/mprotect.c            |   8 ++
 mm/page_vma_mapped.c     |   9 ++-
 mm/rmap.c                | 163 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 352 insertions(+), 7 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 09e28507f5b2..f526ac4d8798 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -405,6 +405,21 @@ between device driver specific code and shared common =
code:
=20
    The lock can now be released.
=20
+Exclusive access memory
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Not all devices support atomic access to system memory. To support atomic
+operations to a shared virtual memory page such a device needs access to t=
hat
+page which is exclusive of any userspace access from the CPU. The
+``make_device_exclusive_range()`` function can be used to make a memory ra=
nge
+inaccessible from userspace.
+
+This replaces all mappings for pages in the given range with special swap
+entries. Any attempt to access the swap entry results in a fault which is
+resovled by replacing the entry with the original mapping. A driver gets
+notified that the mapping has been changed by MMU notifiers, after which p=
oint
+it will no longer have exclusive access to the page.
+
 Memory cgroup (memcg) and rss accounting
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 77fa17de51d7..dad4014fda42 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -193,6 +193,9 @@ int page_referenced(struct page *, int is_locked,
 bool try_to_migrate(struct page *page, enum ttu_flags flags);
 bool try_to_unmap(struct page *, enum ttu_flags flags);
=20
+int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
+				unsigned long end, struct page **pages);
+
 /* Avoid racy checks */
 #define PVMW_SYNC		(1 << 0)
 /* Look for migarion entries rather than present PTEs */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 729c44e7c270..d83bcca0d14d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -63,9 +63,11 @@ static inline int current_is_kswapd(void)
  * to a special SWP_DEVICE_* entry.
  */
 #ifdef CONFIG_DEVICE_PRIVATE
-#define SWP_DEVICE_NUM 2
+#define SWP_DEVICE_NUM 4
 #define SWP_DEVICE_WRITE (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM=
)
 #define SWP_DEVICE_READ (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM+=
1)
+#define SWP_DEVICE_EXCLUSIVE_WRITE (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIG=
RATION_NUM+2)
+#define SWP_DEVICE_EXCLUSIVE_READ (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGR=
ATION_NUM+3)
 #else
 #define SWP_DEVICE_NUM 0
 #endif
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 256b9683b262..c17062dabaa1 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -120,6 +120,27 @@ static inline bool is_writable_device_private_entry(sw=
p_entry_t entry)
 {
 	return unlikely(swp_type(entry) =3D=3D SWP_DEVICE_WRITE);
 }
+
+static inline swp_entry_t make_readable_device_exclusive_entry(pgoff_t off=
set)
+{
+	return swp_entry(SWP_DEVICE_EXCLUSIVE_READ, offset);
+}
+
+static inline swp_entry_t make_writable_device_exclusive_entry(pgoff_t off=
set)
+{
+	return swp_entry(SWP_DEVICE_EXCLUSIVE_WRITE, offset);
+}
+
+static inline bool is_device_exclusive_entry(swp_entry_t entry)
+{
+	return swp_type(entry) =3D=3D SWP_DEVICE_EXCLUSIVE_READ ||
+		swp_type(entry) =3D=3D SWP_DEVICE_EXCLUSIVE_WRITE;
+}
+
+static inline bool is_writable_device_exclusive_entry(swp_entry_t entry)
+{
+	return unlikely(swp_type(entry) =3D=3D SWP_DEVICE_EXCLUSIVE_WRITE);
+}
 #else /* CONFIG_DEVICE_PRIVATE */
 static inline swp_entry_t make_readable_device_private_entry(pgoff_t offse=
t)
 {
@@ -140,6 +161,26 @@ static inline bool is_writable_device_private_entry(sw=
p_entry_t entry)
 {
 	return false;
 }
+
+static inline swp_entry_t make_readable_device_exclusive_entry(pgoff_t off=
set)
+{
+	return swp_entry(0, 0);
+}
+
+static inline swp_entry_t make_writable_device_exclusive_entry(pgoff_t off=
set)
+{
+	return swp_entry(0, 0);
+}
+
+static inline bool is_device_exclusive_entry(swp_entry_t entry)
+{
+	return false;
+}
+
+static inline bool is_writable_device_exclusive_entry(swp_entry_t entry)
+{
+	return false;
+}
 #endif /* CONFIG_DEVICE_PRIVATE */
=20
 #ifdef CONFIG_MIGRATION
@@ -201,7 +242,8 @@ static inline int is_writable_migration_entry(swp_entry=
_t entry)
=20
 static inline bool is_special_entry(swp_entry_t entry)
 {
-	return is_migration_entry(entry) || is_device_private_entry(entry);
+	return is_migration_entry(entry) || is_device_private_entry(entry) ||
+	       is_device_exclusive_entry(entry);
 }
=20
 struct page_vma_mapped_walk;
diff --git a/mm/hmm.c b/mm/hmm.c
index a1f9f268893d..55757fc8fc38 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -26,6 +26,8 @@
 #include <linux/mmu_notifier.h>
 #include <linux/memory_hotplug.h>
=20
+#include "internal.h"
+
 struct hmm_vma_walk {
 	struct hmm_range	*range;
 	unsigned long		last;
@@ -271,6 +273,9 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, uns=
igned long addr,
 		if (!non_swap_entry(entry))
 			goto fault;
=20
+		if (is_device_exclusive_entry(entry))
+			goto fault;
+
 		if (is_migration_entry(entry)) {
 			pte_unmap(ptep);
 			hmm_vma_walk->last =3D addr;
diff --git a/mm/memory.c b/mm/memory.c
index 4d17a92a938b..fdbaa64d9ff7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -73,6 +73,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/hmm.h>
=20
 #include <trace/events/kmem.h>
=20
@@ -769,6 +770,27 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct m=
m_struct *src_mm,
 				pte =3D pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
+	} else if (is_device_exclusive_entry(entry)) {
+		page =3D pfn_to_page(swp_offset(entry));
+
+		get_page(page);
+		rss[mm_counter(page)]++;
+
+		if (is_writable_device_exclusive_entry(entry) &&
+		    is_cow_mapping(vm_flags)) {
+			/*
+			 * COW mappings require pages in both
+			 * parent and child to be set to read.
+			 */
+			entry =3D make_readable_device_exclusive_entry(
+							swp_offset(entry));
+			pte =3D swp_entry_to_pte(entry);
+			if (pte_swp_soft_dirty(*src_pte))
+				pte =3D pte_swp_mksoft_dirty(pte);
+			if (pte_swp_uffd_wp(*src_pte))
+				pte =3D pte_swp_mkuffd_wp(pte);
+			set_pte_at(src_mm, addr, src_pte, pte);
+		}
 	}
 	set_pte_at(dst_mm, addr, dst_pte, pte);
 	return 0;
@@ -1275,7 +1297,8 @@ static unsigned long zap_pte_range(struct mmu_gather =
*tlb,
 		}
=20
 		entry =3D pte_to_swp_entry(ptent);
-		if (is_device_private_entry(entry)) {
+		if (is_device_private_entry(entry) ||
+		    is_device_exclusive_entry(entry)) {
 			struct page *page =3D pfn_to_page(swp_offset(entry));
=20
 			if (unlikely(details && details->check_mapping)) {
@@ -1291,7 +1314,10 @@ static unsigned long zap_pte_range(struct mmu_gather=
 *tlb,
=20
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
-			page_remove_rmap(page, false);
+
+			if (is_device_private_entry(entry))
+				page_remove_rmap(page, false);
+
 			put_page(page);
 			continue;
 		}
@@ -3245,6 +3271,81 @@ void unmap_mapping_range(struct address_space *mappi=
ng,
 }
 EXPORT_SYMBOL(unmap_mapping_range);
=20
+static void restore_exclusive_pte(struct vm_area_struct *vma,
+				  struct page *page, unsigned long address,
+				  pte_t *ptep)
+{
+	pte_t pte;
+	swp_entry_t entry;
+
+	pte =3D pte_mkold(mk_pte(page, READ_ONCE(vma->vm_page_prot)));
+	if (pte_swp_soft_dirty(*ptep))
+		pte =3D pte_mksoft_dirty(pte);
+
+	entry =3D pte_to_swp_entry(*ptep);
+	if (pte_swp_uffd_wp(*ptep))
+		pte =3D pte_mkuffd_wp(pte);
+	else if (is_writable_device_exclusive_entry(entry))
+		pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
+
+	set_pte_at(vma->vm_mm, address, ptep, pte);
+
+	/*
+	 * No need to take a page reference as one was already
+	 * created when the swap entry was made.
+	 */
+	if (PageAnon(page))
+		page_add_anon_rmap(page, vma, address, false);
+	else
+		page_add_file_rmap(page, false);
+
+	if (vma->vm_flags & VM_LOCKED)
+		mlock_vma_page(page);
+
+	/*
+	 * No need to invalidate - it was non-present before. However
+	 * secondary CPUs may have mappings that need invalidating.
+	 */
+	update_mmu_cache(vma, address, ptep);
+}
+
+/*
+ * Restore a potential device exclusive pte to a working pte entry
+ */
+static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
+{
+	struct page *page =3D vmf->page;
+	struct vm_area_struct *vma =3D vmf->vma;
+	struct page_vma_mapped_walk pvmw =3D {
+		.page =3D page,
+		.vma =3D vma,
+		.address =3D vmf->address,
+		.flags =3D PVMW_SYNC,
+	};
+	vm_fault_t ret =3D 0;
+	struct mmu_notifier_range range;
+
+	lock_page(page);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
+				vmf->address & PAGE_MASK,
+				(vmf->address & PAGE_MASK) + PAGE_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	while (page_vma_mapped_walk(&pvmw)) {
+		if (unlikely(!pte_same(*pvmw.pte, vmf->orig_pte))) {
+			page_vma_mapped_walk_done(&pvmw);
+			break;
+		}
+
+		restore_exclusive_pte(vma, page, pvmw.address, pvmw.pte);
+	}
+
+	unlock_page(page);
+
+	mmu_notifier_invalidate_range_end(&range);
+	return ret;
+}
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -3272,6 +3373,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (is_migration_entry(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
 					     vmf->address);
+		} else if (is_device_exclusive_entry(entry)) {
+			vmf->page =3D pfn_to_page(swp_offset(entry));
+			ret =3D remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
 			vmf->page =3D pfn_to_page(swp_offset(entry));
 			ret =3D vmf->page->pgmap->ops->migrate_to_ram(vmf);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index a6c757d87789..fc4a7622497f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -165,6 +165,14 @@ static unsigned long change_pte_range(struct vm_area_s=
truct *vma, pmd_t *pmd,
 				newpte =3D swp_entry_to_pte(entry);
 				if (pte_swp_uffd_wp(oldpte))
 					newpte =3D pte_swp_mkuffd_wp(newpte);
+			} else if (is_writable_device_exclusive_entry(entry)) {
+				entry =3D make_readable_device_exclusive_entry(
+							swp_offset(entry));
+				newpte =3D swp_entry_to_pte(entry);
+				if (pte_swp_soft_dirty(oldpte))
+					newpte =3D pte_swp_mksoft_dirty(newpte);
+				if (pte_swp_uffd_wp(oldpte))
+					newpte =3D pte_swp_mkuffd_wp(newpte);
 			} else {
 				newpte =3D oldpte;
 			}
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 34230d08556a..afba0905e71c 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -41,7 +41,8 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
=20
 				/* Handle un-addressable ZONE_DEVICE memory */
 				entry =3D pte_to_swp_entry(*pvmw->pte);
-				if (!is_device_private_entry(entry))
+				if (!is_device_private_entry(entry) &&
+				    !is_device_exclusive_entry(entry))
 					return false;
 			} else if (!pte_present(*pvmw->pte))
 				return false;
@@ -93,7 +94,8 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 			return false;
 		entry =3D pte_to_swp_entry(*pvmw->pte);
=20
-		if (!is_migration_entry(entry))
+		if (!is_migration_entry(entry) &&
+		    !is_device_exclusive_entry(entry))
 			return false;
=20
 		pfn =3D swp_offset(entry);
@@ -102,7 +104,8 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw=
)
=20
 		/* Handle un-addressable ZONE_DEVICE memory */
 		entry =3D pte_to_swp_entry(*pvmw->pte);
-		if (!is_device_private_entry(entry))
+		if (!is_device_private_entry(entry) &&
+		    !is_device_exclusive_entry(entry))
 			return false;
=20
 		pfn =3D swp_offset(entry);
diff --git a/mm/rmap.c b/mm/rmap.c
index 6e6e77de1459..1578c80aac27 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1997,6 +1997,169 @@ void try_to_munlock(struct page *page)
 	rmap_walk(page, &rwc);
 }
=20
+static bool try_to_protect_one(struct page *page, struct vm_area_struct *v=
ma,
+		     unsigned long address, void *arg)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct page_vma_mapped_walk pvmw =3D {
+		.page =3D page,
+		.vma =3D vma,
+		.address =3D address,
+	};
+	pte_t pteval;
+	struct page *subpage;
+	bool ret =3D true;
+	struct mmu_notifier_range range;
+	swp_entry_t entry;
+	pte_t swp_pte;
+
+	if (is_zone_device_page(page) && !is_device_private_page(page))
+		return true;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
+				address,
+				min(vma->vm_end, address + page_size(page)));
+	if (PageHuge(page)) {
+		/*
+		 * If sharing is possible, start and end will be adjusted
+		 * accordingly.
+		 */
+		adjust_range_if_pmd_sharing_possible(vma, &range.start,
+						     &range.end);
+	}
+	mmu_notifier_invalidate_range_start(&range);
+
+	while (page_vma_mapped_walk(&pvmw)) {
+		/* Unexpected PMD-mapped THP? */
+		VM_BUG_ON_PAGE(!pvmw.pte, page);
+
+		subpage =3D page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
+		address =3D pvmw.address;
+
+		/* Nuke the page table entry. */
+		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+		pteval =3D ptep_clear_flush(vma, address, pvmw.pte);
+
+		/* Move the dirty bit to the page. Now the pte is gone. */
+		if (pte_dirty(pteval))
+			set_page_dirty(page);
+
+		/* Update high watermark before we lower rss */
+		update_hiwater_rss(mm);
+
+		if (arch_unmap_one(mm, vma, address, pteval) < 0) {
+			set_pte_at(mm, address, pvmw.pte, pteval);
+			ret =3D false;
+			page_vma_mapped_walk_done(&pvmw);
+			break;
+		}
+
+		/*
+		 * Store the pfn of the page in a special migration
+		 * pte. do_swap_page() will wait until the migration
+		 * pte is removed and then restart fault handling.
+		 */
+		if (pte_write(pteval))
+			entry =3D make_writable_device_exclusive_entry(
+							page_to_pfn(subpage));
+		else
+			entry =3D make_readable_device_exclusive_entry(
+							page_to_pfn(subpage));
+		swp_pte =3D swp_entry_to_pte(entry);
+		if (pte_soft_dirty(pteval))
+			swp_pte =3D pte_swp_mksoft_dirty(swp_pte);
+		if (pte_uffd_wp(pteval))
+			swp_pte =3D pte_swp_mkuffd_wp(swp_pte);
+
+		/* Take a reference for the swap entry */
+		get_page(page);
+		set_pte_at(mm, address, pvmw.pte, swp_pte);
+
+		page_remove_rmap(subpage, PageHuge(page));
+		put_page(page);
+	}
+
+	mmu_notifier_invalidate_range_end(&range);
+
+	return ret;
+}
+
+/**
+ * try_to_protect - try to replace all page table mappings with swap entri=
es
+ * @page: the page to replace page table entries for
+ * @flags: action and flags
+ *
+ * Tries to remove all the page table entries which are mapping this page =
and
+ * replace them with special swap entries to grant a device exclusive acce=
ss to
+ * the page. Caller must hold the page lock.
+ *
+ * If is successful, return true. Otherwise, false.
+ */
+bool try_to_protect(struct page *page)
+{
+	struct rmap_walk_control rwc =3D {
+		.rmap_one =3D try_to_protect_one,
+		.done =3D page_mapcount_is_zero,
+		.anon_lock =3D page_lock_anon_vma_read,
+	};
+
+	/*
+	 * During exec, a temporary VMA is setup and later moved.
+	 * The VMA is moved under the anon_vma lock but not the
+	 * page tables leading to a race where migration cannot
+	 * find the migration ptes. Rather than increasing the
+	 * locking requirements of exec(), migration skips
+	 * temporary VMAs until after exec() completes.
+	 */
+	if (!PageKsm(page) && PageAnon(page))
+		rwc.invalid_vma =3D invalid_migration_vma;
+
+	rmap_walk(page, &rwc);
+
+	return !page_mapcount(page) ? true : false;
+}
+
+/**
+ * make_device_exclusive_range() - Mark a range for exclusive use by a dev=
ice
+ * @mm: mm_struct of assoicated target process
+ * @start: start of the region to mark for exclusive device access
+ * @end: end address of region
+ * @pages: returns the pages which were successfully mark for exclusive ac=
ces
+ *
+ * Returns: number of pages successfully marked for exclusive access
+ *
+ * This function finds the ptes mapping page(s) to the given address range=
 and
+ * replaces them with special swap entries preventing userspace CPU access=
. On
+ * fault these entries are replaced with the original mapping after callin=
g MMU
+ * notifiers.
+ */
+int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
+				unsigned long end, struct page **pages)
+{
+	long npages =3D (end - start) >> PAGE_SHIFT;
+	long i;
+
+	npages =3D get_user_pages_remote(mm, start, npages,
+				       FOLL_GET | FOLL_WRITE | FOLL_SPLIT_PMD,
+				       pages, NULL, NULL);
+	for (i =3D 0; i < npages; i++) {
+		if (!trylock_page(pages[i])) {
+			put_page(pages[i]);
+			pages[i] =3D NULL;
+			continue;
+		}
+
+		if (!try_to_protect(pages[i])) {
+			unlock_page(pages[i]);
+			put_page(pages[i]);
+			pages[i] =3D NULL;
+		}
+	}
+
+	return npages;
+}
+EXPORT_SYMBOL_GPL(make_device_exclusive_range);
+
 void __put_anon_vma(struct anon_vma *anon_vma)
 {
 	struct anon_vma *root =3D anon_vma->root;
--=20
2.20.1

