Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9299F30BD0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhBBL2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:28:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:33666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231341AbhBBLZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:25:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96DDAAD87;
        Tue,  2 Feb 2021 11:24:58 +0000 (UTC)
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
Subject: [PATCH 1/2] x86/vmemmap: Remove !PAGE_ALIGNED case in remove_pte_table
Date:   Tue,  2 Feb 2021 12:24:49 +0100
Message-Id: <20210202112450.11932-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210202112450.11932-1-osalvador@suse.de>
References: <20210202112450.11932-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove_pte_table() is prepared to handle the case where either the
start or the end of the range is not PAGE aligned.
This cannot actually happen:

__populate_section_memmap enforces the range to be PMD aligned,
so as long as the size of the struct page remains multiple of 8,
the vmemmap range will be aligned to PAGE_SIZE.

Drop the unneeded handling of such case and place a VM_BUG_ON in
vmemmap_{populate,free} to catch nasty cases.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 61 ++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b5a3fa4033d3..4cfa902ec861 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -962,7 +962,6 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
 {
 	unsigned long next, pages = 0;
 	pte_t *pte;
-	void *page_addr;
 	phys_addr_t phys_addr;
 
 	pte = pte_start + pte_index(addr);
@@ -983,42 +982,19 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
 		if (phys_addr < (phys_addr_t)0x40000000)
 			return;
 
-		if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
-			/*
-			 * Do not free direct mapping pages since they were
-			 * freed when offlining, or simplely not in use.
-			 */
-			if (!direct)
-				free_pagetable(pte_page(*pte), 0);
-
-			spin_lock(&init_mm.page_table_lock);
-			pte_clear(&init_mm, addr, pte);
-			spin_unlock(&init_mm.page_table_lock);
-
-			/* For non-direct mapping, pages means nothing. */
-			pages++;
-		} else {
-			/*
-			 * If we are here, we are freeing vmemmap pages since
-			 * direct mapped memory ranges to be freed are aligned.
-			 *
-			 * If we are not removing the whole page, it means
-			 * other page structs in this page are being used and
-			 * we canot remove them. So fill the unused page_structs
-			 * with 0xFD, and remove the page when it is wholly
-			 * filled with 0xFD.
-			 */
-			memset((void *)addr, PAGE_INUSE, next - addr);
+		/*
+		 * Do not free direct mapping pages since they were
+		 * freed when offlining, or simplely not in use.
+		 */
+		if (!direct)
+			free_pagetable(pte_page(*pte), 0);
 
-			page_addr = page_address(pte_page(*pte));
-			if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
-				free_pagetable(pte_page(*pte), 0);
+		spin_lock(&init_mm.page_table_lock);
+		pte_clear(&init_mm, addr, pte);
+		spin_unlock(&init_mm.page_table_lock);
 
-				spin_lock(&init_mm.page_table_lock);
-				pte_clear(&init_mm, addr, pte);
-				spin_unlock(&init_mm.page_table_lock);
-			}
-		}
+		/* For non-direct mapping, pages means nothing. */
+		pages++;
 	}
 
 	/* Call free_pte_table() in remove_pmd_table(). */
@@ -1197,6 +1173,12 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct,
 void __ref vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
+	/*
+	 * See comment in vmemmap_populate().
+	 */
+	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
+	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+
 	remove_pagetable(start, end, false, altmap);
 }
 
@@ -1556,6 +1538,15 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
+	/*
+	 * __populate_section_memmap enforces the range to be added to be
+	 * PMD aligned. Therefore we can be sure that, as long as the
+	 * struct page size is multiple of 8, the vmemmap range will be
+	 * PAGE aligned.
+	 */
+	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
+	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+
 	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
-- 
2.26.2

