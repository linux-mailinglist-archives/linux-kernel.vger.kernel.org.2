Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D954630F420
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhBDNqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:46:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:56768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236402AbhBDNo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:44:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F967AC97;
        Thu,  4 Feb 2021 13:43:45 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 1/3] x86/vmemmap: Drop handling of 4K unaligned vmemmap range
Date:   Thu,  4 Feb 2021 14:43:23 +0100
Message-Id: <20210204134325.7237-2-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210204134325.7237-1-osalvador@suse.de>
References: <20210204134325.7237-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove_pte_table() is prepared to handle the case where either the
start or the end of the range is not PAGE aligned.
This cannot actually happen:

__populate_section_memmap enforces the range to be PMD aligned,
so as long as the size of the struct page remains multiple of 8,
the vmemmap range will be aligned to PAGE_SIZE.

Drop the dead code and place a VM_BUG_ON in vmemmap_{populate,free}
to catch nasty cases.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 48 ++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b5a3fa4033d3..b0e1d215c83e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -962,7 +962,6 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
 {
 	unsigned long next, pages = 0;
 	pte_t *pte;
-	void *page_addr;
 	phys_addr_t phys_addr;
 
 	pte = pte_start + pte_index(addr);
@@ -983,42 +982,15 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
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
+		if (!direct)
+			free_pagetable(pte_page(*pte), 0);
 
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
-
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
@@ -1197,6 +1169,9 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct,
 void __ref vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
+	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
+	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+
 	remove_pagetable(start, end, false, altmap);
 }
 
@@ -1556,6 +1531,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
+	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
+	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+
 	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
-- 
2.26.2

