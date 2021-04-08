Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB17135887B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhDHPbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:31:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12410 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhDHPan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FGQFK0HFqz9txf9;
        Thu,  8 Apr 2021 17:30:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lXprFdbGGVn2; Thu,  8 Apr 2021 17:30:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FGQFJ6gD9z9txf2;
        Thu,  8 Apr 2021 17:30:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DE278B7D5;
        Thu,  8 Apr 2021 17:30:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JAdTgvHRqjBc; Thu,  8 Apr 2021 17:30:30 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D2C08B7D1;
        Thu,  8 Apr 2021 17:30:30 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2B790679BA; Thu,  8 Apr 2021 15:30:30 +0000 (UTC)
Message-Id: <79ed5d7914f497cd5fcd681ca2f4d50a91719455.1617895813.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
References: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 6/9] powerpc/mem: flush_dcache_icache_phys() is for HIGHMEM
 pages only
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  8 Apr 2021 15:30:30 +0000 (UTC)
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
 arch/powerpc/mm/cacheflush.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/cacheflush.c b/arch/powerpc/mm/cacheflush.c
index 3268a3e55c3f..2d92cb6bc423 100644
--- a/arch/powerpc/mm/cacheflush.c
+++ b/arch/powerpc/mm/cacheflush.c
@@ -76,7 +76,7 @@ void flush_icache_range(unsigned long start, unsigned long stop)
 }
 EXPORT_SYMBOL(flush_icache_range);
 
-#if !defined(CONFIG_PPC_8xx) && !defined(CONFIG_PPC64)
+#ifdef CONFIG_HIGHMEM
 /**
  * flush_dcache_icache_phys() - Flush a page by it's physical address
  * @physaddr: the physical address of the page
@@ -115,7 +115,11 @@ static void flush_dcache_icache_phys(unsigned long physaddr)
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
@@ -185,18 +189,15 @@ void flush_dcache_icache_page(struct page *page)
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

