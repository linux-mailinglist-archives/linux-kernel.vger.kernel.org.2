Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4B32794E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhCAIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:34:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:37812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhCAId3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:33:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C685AF5D;
        Mon,  1 Mar 2021 08:32:46 +0000 (UTC)
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
Subject: [PATCH v4 3/3] x86/vmemmap: Handle unpopulated sub-pmd ranges
Date:   Mon,  1 Mar 2021 09:32:30 +0100
Message-Id: <20210301083230.30924-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210301083230.30924-1-osalvador@suse.de>
References: <20210301083230.30924-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the size of a struct page is not multiple of 2MB, sections do
not span a PMD anymore and so when populating them some parts of the
PMD will remain unused.
Because of this, PMDs will be left behind when depopulating sections
since remove_pmd_table() thinks that those unused parts are still in
use.

Fix this by marking the unused parts with PAGE_UNUSED, so memchr_inv()
will do the right thing and will let us free the PMD when the last user
of it is gone.

This patch is based on a similar patch by David Hildenbrand:

https://lore.kernel.org/linux-mm/20200722094558.9828-9-david@redhat.com/
https://lore.kernel.org/linux-mm/20200722094558.9828-10-david@redhat.com/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 98 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 9ecb3c488ac8..7e8de63f02b3 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -871,7 +871,93 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return add_pages(nid, start_pfn, nr_pages, params);
 }
 
-#define PAGE_INUSE 0xFD
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define PAGE_UNUSED 0xFD
+
+/*
+ * The unused vmemmap range, which was not yet memset(PAGE_UNUSED) ranges
+ * from unused_pmd_start to next PMD_SIZE boundary.
+ */
+static unsigned long unused_pmd_start __meminitdata;
+
+static void __meminit vmemmap_flush_unused_pmd(void)
+{
+	if (!unused_pmd_start)
+		return;
+	/*
+	 * Clears (unused_pmd_start, PMD_END]
+	 */
+	memset((void *)unused_pmd_start, PAGE_UNUSED,
+	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
+	unused_pmd_start = 0;
+}
+
+/* Returns true if the PMD is completely unused and thus it can be freed */
+static bool __meminit vmemmap_unuse_sub_pmd(unsigned long addr, unsigned long end)
+{
+	unsigned long start = ALIGN_DOWN(addr, PMD_SIZE);
+
+	vmemmap_flush_unused_pmd();
+	memset((void *)addr, PAGE_UNUSED, end - addr);
+
+	return !memchr_inv((void *)start, PAGE_UNUSED, PMD_SIZE);
+}
+
+static void __meminit __vmemmap_use_sub_pmd(unsigned long start)
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
+static void __meminit vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+{
+	/*
+	 * We only optimize if the new used range directly follows the
+	 * previously unused range (esp., when populating consecutive sections).
+	 */
+	if (unused_pmd_start == start) {
+		if (likely(IS_ALIGNED(end, PMD_SIZE)))
+			unused_pmd_start = 0;
+		else
+			unused_pmd_start = end;
+		return;
+	}
+
+	vmemmap_flush_unused_pmd();
+	__vmemmap_use_sub_pmd(start);
+}
+
+static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
+{
+	vmemmap_flush_unused_pmd();
+
+	/*
+	 * Could be our memmap page is filled with PAGE_UNUSED already from a
+	 * previous remove.
+	 */
+	__vmemmap_use_sub_pmd(start);
+
+	/*
+	 * Mark the unused parts of the new memmap range
+	 */
+	if (!IS_ALIGNED(start, PMD_SIZE))
+		memset((void *)start, PAGE_UNUSED,
+		       start - ALIGN_DOWN(start, PMD_SIZE));
+	/*
+	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of
+	 * consecutive sections. Remember for the last added PMD the last
+	 * unused range in the populated PMD.
+	 */
+	if (!IS_ALIGNED(end, PMD_SIZE))
+		unused_pmd_start = end;
+}
+#endif
 
 static void __meminit free_pagetable(struct page *page, int order)
 {
@@ -1006,7 +1092,6 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 	unsigned long next, pages = 0;
 	pte_t *pte_base;
 	pmd_t *pmd;
-	void *page_addr;
 
 	pmd = pmd_start + pmd_index(addr);
 	for (; addr < end; addr = next, pmd++) {
@@ -1027,12 +1112,11 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 				spin_unlock(&init_mm.page_table_lock);
 				pages++;
 			} else {
-				/* If here, we are freeing vmemmap pages. */
-				memset((void *)addr, PAGE_INUSE, next - addr);
-
-				page_addr = page_address(pmd_page(*pmd));
-				if (!memchr_inv(page_addr, PAGE_INUSE,
-						PMD_SIZE)) {
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+				/*
+				 * Free the PMD if the whole range is unused.
+				 */
+				if (vmemmap_unuse_sub_pmd(addr, next)) {
 					free_hugepage_table(pmd_page(*pmd),
 							    altmap);
 
@@ -1040,6 +1124,7 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 					pmd_clear(pmd);
 					spin_unlock(&init_mm.page_table_lock);
 				}
+#endif
 			}
 
 			continue;
@@ -1492,11 +1577,16 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 
 				addr_end = addr + PMD_SIZE;
 				p_end = p + PMD_SIZE;
+
+				if (!IS_ALIGNED(addr, PMD_SIZE) ||
+				    !IS_ALIGNED(next, PMD_SIZE))
+					vmemmap_use_new_sub_pmd(addr, next);
 				continue;
 			} else if (altmap)
 				return -ENOMEM; /* no fallback */
 		} else if (pmd_large(*pmd)) {
 			vmemmap_verify((pte_t *)pmd, node, addr, next);
+			vmemmap_use_sub_pmd(addr, next);
 			continue;
 		}
 		if (vmemmap_populate_basepages(addr, next, node, NULL))
-- 
2.16.3

