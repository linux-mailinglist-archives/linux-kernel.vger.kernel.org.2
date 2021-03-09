Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C459332D74
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhCIRlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:41:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:50938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhCIRlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:41:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3908EAEC4;
        Tue,  9 Mar 2021 17:41:21 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 3/4] x86/vmemmap: Handle unpopulated sub-pmd ranges
Date:   Tue,  9 Mar 2021 18:41:12 +0100
Message-Id: <20210309174113.5597-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210309174113.5597-1-osalvador@suse.de>
References: <20210309174113.5597-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sizeof(struct page) is not a power of 2, sections do not span
a PMD anymore and so when populating them some parts of the PMD will
remain unused.
Because of this, PMDs will be left behind when depopulating sections
since remove_pmd_table() thinks that those unused parts are still in
use.

Fix this by marking the unused parts with PAGE_UNUSED, so memchr_inv()
will do the right thing and will let us free the PMD when the last user
of it is gone.

This patch is based on a similar patch by David Hildenbrand:

https://lore.kernel.org/linux-mm/20200722094558.9828-9-david@redhat.com/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 63 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 9ecb3c488ac8..3bb3988c7681 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -871,7 +871,50 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return add_pages(nid, start_pfn, nr_pages, params);
 }
 
-#define PAGE_INUSE 0xFD
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define PAGE_UNUSED 0xFD
+
+/* Returns true if the PMD is completely unused and thus it can be freed */
+static bool __meminit vmemmap_pmd_is_unused(unsigned long addr, unsigned long end)
+{
+	unsigned long start = ALIGN_DOWN(addr, PMD_SIZE);
+
+	memset((void *)addr, PAGE_UNUSED, end - addr);
+
+	return !memchr_inv((void *)start, PAGE_UNUSED, PMD_SIZE);
+}
+
+static void __meminit vmemmap_use_sub_pmd(unsigned long start)
+{
+	/*
+	 * As we expect to add in the same granularity as we remove, it's
+	 * sufficient to mark only some piece used to block the memmap page from
+	 * getting removed when removing some other adjacent memmap (just in
+	 * case the first memmap never gets initialized e.g., because the memory
+	 * block never gets onlined).
+	 */
+	memset((void *)start, 0, sizeof(struct page));
+}
+
+static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
+{
+	/*
+	 * Could be our memmap page is filled with PAGE_UNUSED already from a
+	 * previous remove. Make sure to reset it.
+	 */
+	vmemmap_use_sub_pmd(start);
+
+	/*
+	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
+	 */
+	if (!IS_ALIGNED(start, PMD_SIZE))
+	        memset((void *)start, PAGE_UNUSED,
+	               start - ALIGN_DOWN(start, PMD_SIZE));
+	if (!IS_ALIGNED(end, PMD_SIZE))
+		memset((void *)end, PAGE_UNUSED,
+		       ALIGN(end, PMD_SIZE) - end);
+}
+#endif
 
 static void __meminit free_pagetable(struct page *page, int order)
 {
@@ -1006,7 +1049,6 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 	unsigned long next, pages = 0;
 	pte_t *pte_base;
 	pmd_t *pmd;
-	void *page_addr;
 
 	pmd = pmd_start + pmd_index(addr);
 	for (; addr < end; addr = next, pmd++) {
@@ -1026,20 +1068,13 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 				pmd_clear(pmd);
 				spin_unlock(&init_mm.page_table_lock);
 				pages++;
-			} else {
-				/* If here, we are freeing vmemmap pages. */
-				memset((void *)addr, PAGE_INUSE, next - addr);
-
-				page_addr = page_address(pmd_page(*pmd));
-				if (!memchr_inv(page_addr, PAGE_INUSE,
-						PMD_SIZE)) {
+			} else if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
+				   vmemmap_pmd_is_unused(addr, next)) {
 					free_hugepage_table(pmd_page(*pmd),
 							    altmap);
-
 					spin_lock(&init_mm.page_table_lock);
 					pmd_clear(pmd);
 					spin_unlock(&init_mm.page_table_lock);
-				}
 			}
 
 			continue;
@@ -1492,11 +1527,17 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 
 				addr_end = addr + PMD_SIZE;
 				p_end = p + PMD_SIZE;
+
+				if (!IS_ALIGNED(addr, PMD_SIZE) ||
+				    !IS_ALIGNED(next, PMD_SIZE))
+					vmemmap_use_new_sub_pmd(addr, next);
+
 				continue;
 			} else if (altmap)
 				return -ENOMEM; /* no fallback */
 		} else if (pmd_large(*pmd)) {
 			vmemmap_verify((pte_t *)pmd, node, addr, next);
+			vmemmap_use_sub_pmd(addr);
 			continue;
 		}
 		if (vmemmap_populate_basepages(addr, next, node, NULL))
-- 
2.16.3

