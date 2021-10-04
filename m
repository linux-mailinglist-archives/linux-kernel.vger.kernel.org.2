Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E20420A5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhJDLwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:52:43 -0400
Received: from out1.migadu.com ([91.121.223.63]:60388 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJDLwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:52:42 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633348252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mRyXixtJ3RFnQyJNkqqmOeKF1zm9e3y/zEd/NLkN3uQ=;
        b=bpN/HGzUizbXOG3/YXPD/zhc3hNq+E3ggFh0ruFSegG351Yyip+VZlirYIR6AHCTQpbHHd
        M5XDK1M+NRBy/wm+BrSaYfITxwt4JTvgIPO3ZrnGO8RDHnjRTRM5UHzSHSkQS6n1UKKhSL
        9+Vsss4LrU4g6L8swWuWLwqg36tx5xk=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm, pagemap: expose hwpoison entry
Date:   Mon,  4 Oct 2021 20:50:01 +0900
Message-Id: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

A hwpoison entry is a non-present page table entry to report
memory error events to userspace. If we have an easy way to know
which processes have hwpoison entries, that might be useful for
user processes to take proper actions. But we don't have it now.
So make pagemap interface expose hwpoison entries to userspace.

Hwpoison entry for hugepage is also exposed by this patch. The below
example shows how pagemap is visible in the case where a memory error
hit a hugepage mapped to a process.

    $ ./page-types --no-summary --pid $PID --raw --list --addr 0x700000000+0x400
    voffset offset  len     flags
    700000000       12fa00  1       ___U_______Ma__H_G_________________f_______1
    700000001       12fa01  1ff     ___________Ma___TG_________________f_______1
    700000200       12f800  1       __________B________X_______________f______w_
    700000201       12f801  1       ___________________X_______________f______w_   // memory failure hit this page
    700000202       12f802  1fe     __________B________X_______________f______w_

The entries with both of "X" flag (hwpoison flag) and "w" flag (swap
flag) are considered as hwpoison entries.  So all pages in 2MB range
are inaccessible from the process.  We can get actual error location
by page-types in physical address mode.

    $ ./page-types --no-summary --addr 0x12f800+0x200 --raw --list
    offset  len     flags
    12f800  1       __________B_________________________________
    12f801  1       ___________________X________________________
    12f802  1fe     __________B_________________________________

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 fs/proc/task_mmu.c      | 41 ++++++++++++++++++++++++++++++++---------
 include/linux/swapops.h | 13 +++++++++++++
 tools/vm/page-types.c   |  7 ++++++-
 3 files changed, 51 insertions(+), 10 deletions(-)

diff --git v5.15-rc3/fs/proc/task_mmu.c v5.15-rc3_patched/fs/proc/task_mmu.c
index cf25be3e0321..bfc4772a58fb 100644
--- v5.15-rc3/fs/proc/task_mmu.c
+++ v5.15-rc3_patched/fs/proc/task_mmu.c
@@ -1298,6 +1298,7 @@ struct pagemapread {
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
 #define PM_UFFD_WP		BIT_ULL(57)
+#define PM_HWPOISON		BIT_ULL(60)
 #define PM_FILE			BIT_ULL(61)
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
@@ -1386,6 +1387,10 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_SWAP;
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
+		if (is_hwpoison_entry(entry)) {
+			page = hwpoison_entry_to_page(entry);
+			flags |= PM_HWPOISON;
+		}
 	}
 
 	if (page && !PageAnon(page))
@@ -1505,34 +1510,52 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	u64 flags = 0, frame = 0;
 	int err = 0;
 	pte_t pte;
+	struct page *page = NULL;
 
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
 	pte = huge_ptep_get(ptep);
 	if (pte_present(pte)) {
-		struct page *page = pte_page(pte);
-
-		if (!PageAnon(page))
-			flags |= PM_FILE;
-
-		if (page_mapcount(page) == 1)
-			flags |= PM_MMAP_EXCLUSIVE;
+		page = pte_page(pte);
 
 		flags |= PM_PRESENT;
 		if (pm->show_pfn)
 			frame = pte_pfn(pte) +
 				((addr & ~hmask) >> PAGE_SHIFT);
+	} else if (is_swap_pte(pte)) {
+		swp_entry_t entry = pte_to_swp_entry(pte);
+		unsigned long offset;
+
+		if (pm->show_pfn) {
+			offset = swp_offset(entry) +
+				((addr & ~hmask) >> PAGE_SHIFT);
+			frame = swp_type(entry) |
+				(offset << MAX_SWAPFILES_SHIFT);
+		}
+		flags |= PM_SWAP;
+		if (is_migration_entry(entry))
+			page = compound_head(pfn_swap_entry_to_page(entry));
+		if (is_hwpoison_entry(entry))
+			flags |= PM_HWPOISON;
 	}
 
+	if (page && !PageAnon(page))
+		flags |= PM_FILE;
+	if (page && page_mapcount(page) == 1)
+		flags |= PM_MMAP_EXCLUSIVE;
+
 	for (; addr != end; addr += PAGE_SIZE) {
 		pagemap_entry_t pme = make_pme(frame, flags);
 
 		err = add_to_pagemap(addr, &pme, pm);
 		if (err)
 			return err;
-		if (pm->show_pfn && (flags & PM_PRESENT))
-			frame++;
+		if (pm->show_pfn)
+			if (flags & PM_PRESENT)
+				frame++;
+			else if (flags & PM_SWAP)
+				frame += (1 << MAX_SWAPFILES_SHIFT);
 	}
 
 	cond_resched();
diff --git v5.15-rc3/include/linux/swapops.h v5.15-rc3_patched/include/linux/swapops.h
index d356ab4047f7..bb6141e5c069 100644
--- v5.15-rc3/include/linux/swapops.h
+++ v5.15-rc3_patched/include/linux/swapops.h
@@ -360,6 +360,14 @@ static inline unsigned long hwpoison_entry_to_pfn(swp_entry_t entry)
 	return swp_offset(entry);
 }
 
+static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
+{
+	struct page *p = pfn_to_page(swp_offset(entry));
+
+	WARN_ON(!PageHWPoison(p));
+	return p;
+}
+
 static inline void num_poisoned_pages_inc(void)
 {
 	atomic_long_inc(&num_poisoned_pages);
@@ -382,6 +390,11 @@ static inline int is_hwpoison_entry(swp_entry_t swp)
 	return 0;
 }
 
+static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
+{
+	return NULL;
+}
+
 static inline void num_poisoned_pages_inc(void)
 {
 }
diff --git v5.15-rc3/tools/vm/page-types.c v5.15-rc3_patched/tools/vm/page-types.c
index b1ed76d9a979..483e417fda41 100644
--- v5.15-rc3/tools/vm/page-types.c
+++ v5.15-rc3_patched/tools/vm/page-types.c
@@ -53,6 +53,7 @@
 #define PM_SWAP_OFFSET(x)	(((x) & PM_PFRAME_MASK) >> MAX_SWAPFILES_SHIFT)
 #define PM_SOFT_DIRTY		(1ULL << 55)
 #define PM_MMAP_EXCLUSIVE	(1ULL << 56)
+#define PM_HWPOISON		(1ULL << 60)
 #define PM_FILE			(1ULL << 61)
 #define PM_SWAP			(1ULL << 62)
 #define PM_PRESENT		(1ULL << 63)
@@ -311,6 +312,8 @@ static unsigned long pagemap_pfn(uint64_t val)
 
 	if (val & PM_PRESENT)
 		pfn = PM_PFRAME(val);
+	else if (val & PM_SWAP)
+		pfn = PM_SWAP_OFFSET(val);
 	else
 		pfn = 0;
 
@@ -492,6 +495,8 @@ static uint64_t expand_overloaded_flags(uint64_t flags, uint64_t pme)
 		flags |= BIT(FILE);
 	if (pme & PM_SWAP)
 		flags |= BIT(SWAP);
+	if (pme & PM_HWPOISON)
+		flags |= BIT(HWPOISON);
 	if (pme & PM_MMAP_EXCLUSIVE)
 		flags |= BIT(MMAP_EXCLUSIVE);
 
@@ -742,7 +747,7 @@ static void walk_vma(unsigned long index, unsigned long count)
 			pfn = pagemap_pfn(buf[i]);
 			if (pfn)
 				walk_pfn(index + i, pfn, 1, buf[i]);
-			if (buf[i] & PM_SWAP)
+			else if (buf[i] & PM_SWAP)
 				walk_swap(index + i, buf[i]);
 		}
 
-- 
2.25.1

