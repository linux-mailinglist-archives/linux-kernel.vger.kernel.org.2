Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62834357308
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354811AbhDGRWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:22:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42337 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354793AbhDGRWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:22:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FFrn969YQzB09ZZ;
        Wed,  7 Apr 2021 19:22:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PikW_eHcrmVD; Wed,  7 Apr 2021 19:22:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FFrn954HBzB09ZS;
        Wed,  7 Apr 2021 19:22:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 586778B7B6;
        Wed,  7 Apr 2021 19:22:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AqWa6-IJJund; Wed,  7 Apr 2021 19:22:39 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DF428B75F;
        Wed,  7 Apr 2021 19:22:39 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D370D6799B; Wed,  7 Apr 2021 17:22:38 +0000 (UTC)
Message-Id: <fa3c3301ea0545028eef50270d00490aafab54bd.1617816138.git.christophe.leroy@csgroup.eu>
In-Reply-To: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
References: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 5/8] powerpc/mem: flush_dcache_icache_phys() is for HIGHMEM
 pages only
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  7 Apr 2021 17:22:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__flush_dcache_icache() is usable for non HIGHMEM pages on
every platform.

It is only for HIGHMEM pages that BOOKE needs kmap() and
BOOK3S needs flush_dcache_icache_phys().

So make flush_dcache_icache_phys() dependent on CONFIG_HIGHMEM and
call it only when it is a HIGHMEM page.

We could make flush_dcache_icache_phys() available at all time,
but as it is declared NOKPROBE_SYMBOL(), GCC doesn't optimise
it out when it is not used.

So define a stub for !CONFIG_HIGHMEM in order to remove the #ifdef in
flush_dcache_icache_page() and use IS_ENABLED() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mem.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d2c66827d9fd..9a5542f4de92 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -413,7 +413,7 @@ void flush_icache_range(unsigned long start, unsigned long stop)
 }
 EXPORT_SYMBOL(flush_icache_range);
 
-#if !defined(CONFIG_PPC_8xx) && !defined(CONFIG_PPC64)
+#ifdef CONFIG_HIGHMEM
 /**
  * flush_dcache_icache_phys() - Flush a page by it's physical address
  * @physaddr: the physical address of the page
@@ -452,7 +452,11 @@ static void flush_dcache_icache_phys(unsigned long physaddr)
 		: "ctr", "memory");
 }
 NOKPROBE_SYMBOL(flush_dcache_icache_phys)
-#endif // !defined(CONFIG_PPC_8xx) && !defined(CONFIG_PPC64)
+#else
+static void flush_dcache_icache_phys(unsigned long physaddr)
+{
+}
+#endif
 
 /*
  * This is called when a page has been modified by the kernel.
@@ -497,18 +501,15 @@ void flush_dcache_icache_page(struct page *page)
 	if (PageCompound(page))
 		return flush_dcache_icache_hugepage(page);
 
-#if defined(CONFIG_PPC_8xx) || defined(CONFIG_PPC64)
-	/* On 8xx there is no need to kmap since highmem is not supported */
-	__flush_dcache_icache(page_address(page));
-#else
-	if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
+	if (!PageHighMem(page)) {
+		__flush_dcache_icache(lowmem_page_address(page));
+	} else if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
 		void *start = kmap_atomic(page);
 		__flush_dcache_icache(start);
 		kunmap_atomic(start);
 	} else {
 		flush_dcache_icache_phys(page_to_phys(page));
 	}
-#endif
 }
 EXPORT_SYMBOL(flush_dcache_icache_page);
 
-- 
2.25.0

