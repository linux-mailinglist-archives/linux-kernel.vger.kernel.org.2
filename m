Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F1835887D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhDHPb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:31:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17481 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232055AbhDHPaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FGQFN2s1tz9txf2;
        Thu,  8 Apr 2021 17:30:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pEdBiU3HbjFY; Thu,  8 Apr 2021 17:30:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FGQFN1z0Dz9txfD;
        Thu,  8 Apr 2021 17:30:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A87AB8B7D6;
        Thu,  8 Apr 2021 17:30:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nh5wg_E2XZCY; Thu,  8 Apr 2021 17:30:33 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 67E3F8B7D4;
        Thu,  8 Apr 2021 17:30:33 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 43C03679BA; Thu,  8 Apr 2021 15:30:33 +0000 (UTC)
Message-Id: <b6a880ea0ec7886b51edbb4979c188be549231c0.1617895813.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
References: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 9/9] powerpc/mem: Use kmap_local_page() in flushing
 functions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  8 Apr 2021 15:30:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flushing functions don't rely on preemption being disabled, so
use kmap_local_page() instead of kmap_atomic().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/cacheflush.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/cacheflush.c b/arch/powerpc/mm/cacheflush.c
index d9eafa077c09..63363787e000 100644
--- a/arch/powerpc/mm/cacheflush.c
+++ b/arch/powerpc/mm/cacheflush.c
@@ -152,16 +152,16 @@ static void flush_dcache_icache_hugepage(struct page *page)
 {
 	int i;
 	int nr = compound_nr(page);
-	void *start;
 
 	if (!PageHighMem(page)) {
 		for (i = 0; i < nr; i++)
 			__flush_dcache_icache(lowmem_page_address(page + i));
 	} else {
 		for (i = 0; i < nr; i++) {
-			start = kmap_atomic(page+i);
+			void *start = kmap_local_page(page + i);
+
 			__flush_dcache_icache(start);
-			kunmap_atomic(start);
+			kunmap_local(start);
 		}
 	}
 }
@@ -177,9 +177,10 @@ void flush_dcache_icache_page(struct page *page)
 	if (!PageHighMem(page)) {
 		__flush_dcache_icache(lowmem_page_address(page));
 	} else if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
-		void *start = kmap_atomic(page);
+		void *start = kmap_local_page(page);
+
 		__flush_dcache_icache(start);
-		kunmap_atomic(start);
+		kunmap_local(start);
 	} else {
 		flush_dcache_icache_phys(page_to_phys(page));
 	}
@@ -225,9 +226,9 @@ void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
 void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			     unsigned long addr, int len)
 {
-	unsigned long maddr;
+	void *maddr;
 
-	maddr = (unsigned long) kmap(page) + (addr & ~PAGE_MASK);
-	flush_icache_range(maddr, maddr + len);
-	kunmap(page);
+	maddr = kmap_local_page(page) + (addr & ~PAGE_MASK);
+	flush_icache_range((unsigned long)maddr, (unsigned long)maddr + len);
+	kunmap_local(maddr);
 }
-- 
2.25.0

