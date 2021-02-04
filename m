Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676B230D7EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhBCKsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:48:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:51654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232865AbhBCKsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:48:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A20DAF90;
        Wed,  3 Feb 2021 10:47:56 +0000 (UTC)
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
Subject: [PATCH v2 2/3] x86/vmemmap: Drop handling of 1GB vmemmap ranges
Date:   Wed,  3 Feb 2021 11:47:49 +0100
Message-Id: <20210203104750.23405-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210203104750.23405-1-osalvador@suse.de>
References: <20210203104750.23405-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never get to allocate 1GB pages when mapping the vmemmap range.
Drop the dead code both for the aligned and unaligned cases and leave
only the direct map handling.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b0e1d215c83e..28729c6b9775 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1062,7 +1062,6 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 	unsigned long next, pages = 0;
 	pmd_t *pmd_base;
 	pud_t *pud;
-	void *page_addr;
 
 	pud = pud_start + pud_index(addr);
 	for (; addr < end; addr = next, pud++) {
@@ -1072,32 +1071,10 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 			continue;
 
 		if (pud_large(*pud)) {
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
+			spin_lock(&init_mm.page_table_lock);
+			pud_clear(pud);
+			spin_unlock(&init_mm.page_table_lock);
+			pages++;
 			continue;
 		}
 
-- 
2.26.2

