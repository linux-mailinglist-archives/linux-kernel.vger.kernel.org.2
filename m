Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E4333120
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhCIVl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:41:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:51254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232129AbhCIVlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:41:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF6CFB023;
        Tue,  9 Mar 2021 21:41:14 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 4/4] x86/vmemmap: Optimize for consecutive sections in partial populated PMDs
Date:   Tue,  9 Mar 2021 22:40:50 +0100
Message-Id: <20210309214050.4674-5-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210309214050.4674-1-osalvador@suse.de>
References: <20210309214050.4674-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can optimize in the case we are adding consecutive sections, so no
memset(PAGE_UNUSED) is needed.
In that case, let us keep track where the unused range of the previous
memory range begins, so we can compare it with start of the range to be
added.
If they are equal, we know sections are added consecutively.

For that purpose, let us introduce 'unused_pmd_start', which always holds
the beginning of the unused memory range.

In the case a section does not contiguously follow the previous one, we
know we can memset [unused_pmd_start, PMD_BOUNDARY) with PAGE_UNUSE.

This patch is based on a similar patch by David Hildenbrand:

https://lore.kernel.org/linux-mm/20200722094558.9828-10-david@redhat.com/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/mm/init_64.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index d93b36856ed3..13187a3debe9 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -829,17 +829,42 @@ void __init paging_init(void)
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 #define PAGE_UNUSED 0xFD
 
+/*
+ * The unused vmemmap range, which was not yet memset(PAGE_UNUSED), ranges
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
+#ifdef CONFIG_MEMORY_HOTPLUG
 /* Returns true if the PMD is completely unused and thus it can be freed */
 static bool __meminit vmemmap_pmd_is_unused(unsigned long addr, unsigned long end)
 {
 	unsigned long start = ALIGN_DOWN(addr, PMD_SIZE);
 
+	/*
+	 * Flush the unused range cache to ensure that memchr_inv() will work
+	 * for the whole range.
+	 */
+	vmemmap_flush_unused_pmd();
 	memset((void *)addr, PAGE_UNUSED, end - addr);
 
 	return !memchr_inv((void *)start, PAGE_UNUSED, PMD_SIZE);
 }
+#endif
 
-static void __meminit vmemmap_use_sub_pmd(unsigned long start)
+static void __meminit __vmemmap_use_sub_pmd(unsigned long start)
 {
 	/*
 	 * As we expect to add in the same granularity as we remove, it's
@@ -851,13 +876,38 @@ static void __meminit vmemmap_use_sub_pmd(unsigned long start)
 	memset((void *)start, 0, sizeof(struct page));
 }
 
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
+	/*
+	 * If the range does not contiguously follows previous one, make sure
+	 * to mark the unused range of the previous one so it can be removed.
+	 */
+	vmemmap_flush_unused_pmd();
+	__vmemmap_use_sub_pmd(start);
+}
+
+
 static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
 {
+	vmemmap_flush_unused_pmd();
+
 	/*
 	 * Could be our memmap page is filled with PAGE_UNUSED already from a
 	 * previous remove. Make sure to reset it.
 	 */
-	vmemmap_use_sub_pmd(start);
+	__vmemmap_use_sub_pmd(start);
 
 	/*
 	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
@@ -865,9 +915,14 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
 	if (!IS_ALIGNED(start, PMD_SIZE))
 		memset((void *)start, PAGE_UNUSED,
 		        start - ALIGN_DOWN(start, PMD_SIZE));
+
+	/*
+	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of
+	 * consecutive sections. Remember for the last added PMD where the
+	 * unused range begins.
+	 */
 	if (!IS_ALIGNED(end, PMD_SIZE))
-		memset((void *)end, PAGE_UNUSED,
-		        ALIGN(end, PMD_SIZE) - end);
+		unused_pmd_start = end;
 }
 #endif
 
@@ -1537,7 +1592,7 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 				return -ENOMEM; /* no fallback */
 		} else if (pmd_large(*pmd)) {
 			vmemmap_verify((pte_t *)pmd, node, addr, next);
-			vmemmap_use_sub_pmd(addr);
+			vmemmap_use_sub_pmd(addr, next);
 			continue;
 		}
 		if (vmemmap_populate_basepages(addr, next, node, NULL))
-- 
2.16.3

