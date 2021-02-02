Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4B30BD11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBBL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:29:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:33704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhBBLZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:25:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5CD6BB195;
        Tue,  2 Feb 2021 11:24:59 +0000 (UTC)
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
Subject: [PATCH 2/2] x86/vmemmap: Handle unpopulated sub-pmd ranges
Date:   Tue,  2 Feb 2021 12:24:50 +0100
Message-Id: <20210202112450.11932-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210202112450.11932-1-osalvador@suse.de>
References: <20210202112450.11932-1-osalvador@suse.de>
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
---
 arch/x86/mm/init_64.c | 87 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 4cfa902ec861..b239708e504e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -871,7 +871,72 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return add_pages(nid, start_pfn, nr_pages, params);
 }
 
-#define PAGE_INUSE 0xFD
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
+}
+
+static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
+{
+	vmemmap_flush_unused_pmd();
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
 
 static void __meminit free_pagetable(struct page *page, int order)
 {
@@ -1010,7 +1075,6 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 	unsigned long next, pages = 0;
 	pte_t *pte_base;
 	pmd_t *pmd;
-	void *page_addr;
 
 	pmd = pmd_start + pmd_index(addr);
 	for (; addr < end; addr = next, pmd++) {
@@ -1031,12 +1095,10 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 				spin_unlock(&init_mm.page_table_lock);
 				pages++;
 			} else {
-				/* If here, we are freeing vmemmap pages. */
-				memset((void *)addr, PAGE_INUSE, next - addr);
-
-				page_addr = page_address(pmd_page(*pmd));
-				if (!memchr_inv(page_addr, PAGE_INUSE,
-						PMD_SIZE)) {
+				/*
+				 * Free the PMD if the whole range is unused.
+				 */
+				if (vmemmap_unuse_sub_pmd(addr, next)) {
 					free_hugepage_table(pmd_page(*pmd),
 							    altmap);
 
@@ -1088,10 +1150,10 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 				pages++;
 			} else {
 				/* If here, we are freeing vmemmap pages. */
-				memset((void *)addr, PAGE_INUSE, next - addr);
+				memset((void *)addr, PAGE_UNUSED, next - addr);
 
 				page_addr = page_address(pud_page(*pud));
-				if (!memchr_inv(page_addr, PAGE_INUSE,
+				if (!memchr_inv(page_addr, PAGE_UNUSED,
 						PUD_SIZE)) {
 					free_pagetable(pud_page(*pud),
 						       get_order(PUD_SIZE));
@@ -1520,11 +1582,16 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 
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
2.26.2

