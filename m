Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30E33311F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhCIVlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:41:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:51254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhCIVlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:41:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D2B0AFC1;
        Tue,  9 Mar 2021 21:41:13 +0000 (UTC)
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
Subject: [PATCH v6 2/4] x86/vmemmap: Drop handling of 1GB vmemmap ranges
Date:   Tue,  9 Mar 2021 22:40:48 +0100
Message-Id: <20210309214050.4674-3-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210309214050.4674-1-osalvador@suse.de>
References: <20210309214050.4674-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no code to allocate 1GB pages when mapping the vmemmap range
as this might waste some memory and requires more complexity which
is not really worth.
Drop the dead code both for the aligned and unaligned cases and leave
only the direct map handling.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/mm/init_64.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b0e1d215c83e..9ecb3c488ac8 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1062,7 +1062,6 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 	unsigned long next, pages = 0;
 	pmd_t *pmd_base;
 	pud_t *pud;
-	void *page_addr;
 
 	pud = pud_start + pud_index(addr);
 	for (; addr < end; addr = next, pud++) {
@@ -1071,33 +1070,13 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 		if (!pud_present(*pud))
 			continue;
 
-		if (pud_large(*pud)) {
-			if (IS_ALIGNED(addr, PUD_SIZE) &&
-			    IS_ALIGNED(next, PUD_SIZE)) {
-				if (!direct)
-					free_pagetable(pud_page(*pud),
-						       get_order(PUD_SIZE));
-
-				spin_lock(&init_mm.page_table_lock);
-				pud_clear(pud);
-				spin_unlock(&init_mm.page_table_lock);
-				pages++;
-			} else {
-				/* If here, we are freeing vmemmap pages. */
-				memset((void *)addr, PAGE_INUSE, next - addr);
-
-				page_addr = page_address(pud_page(*pud));
-				if (!memchr_inv(page_addr, PAGE_INUSE,
-						PUD_SIZE)) {
-					free_pagetable(pud_page(*pud),
-						       get_order(PUD_SIZE));
-
-					spin_lock(&init_mm.page_table_lock);
-					pud_clear(pud);
-					spin_unlock(&init_mm.page_table_lock);
-				}
-			}
-
+		if (pud_large(*pud) &&
+		    IS_ALIGNED(addr, PUD_SIZE) &&
+		    IS_ALIGNED(next, PUD_SIZE)) {
+			spin_lock(&init_mm.page_table_lock);
+			pud_clear(pud);
+			spin_unlock(&init_mm.page_table_lock);
+			pages++;
 			continue;
 		}
 
-- 
2.16.3

