Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73E357305
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354807AbhDGRWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:22:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56479 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhDGRWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:22:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FFrn75YtczB09ZW;
        Wed,  7 Apr 2021 19:22:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id w9ppHJnEqjCw; Wed,  7 Apr 2021 19:22:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FFrn73Fl2zB09ZS;
        Wed,  7 Apr 2021 19:22:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F6B18B7B6;
        Wed,  7 Apr 2021 19:22:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8sskzgGAfOJD; Wed,  7 Apr 2021 19:22:37 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E9D248B75F;
        Wed,  7 Apr 2021 19:22:36 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C71496799B; Wed,  7 Apr 2021 17:22:36 +0000 (UTC)
Message-Id: <e1cd0925330cb0f263eafb61f7d63853a4b118e6.1617816138.git.christophe.leroy@csgroup.eu>
In-Reply-To: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
References: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 3/8] powerpc/mem: Call flush_coherent_icache() at higher
 level
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  7 Apr 2021 17:22:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_coherent_icache() doesn't need the address anymore,
so it can be called immediately when entering the public
functions and doesn't need to be disseminated among
lower level functions.

And use page_to_phys() instead of open coding the calculation
of phys address to call flush_dcache_icache_phys().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mem.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 19f807b87697..29ce215e491f 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -491,6 +491,8 @@ static void flush_dcache_icache_hugepage(struct page *page)
 
 void flush_dcache_icache_page(struct page *page)
 {
+	if (flush_coherent_icache())
+		return;
 
 	if (PageCompound(page))
 		return flush_dcache_icache_hugepage(page);
@@ -504,11 +506,7 @@ void flush_dcache_icache_page(struct page *page)
 		__flush_dcache_icache(start);
 		kunmap_atomic(start);
 	} else {
-		unsigned long addr = page_to_pfn(page) << PAGE_SHIFT;
-
-		if (flush_coherent_icache())
-			return;
-		flush_dcache_icache_phys(addr);
+		flush_dcache_icache_phys(page_to_phys(page));
 	}
 #endif
 }
@@ -525,9 +523,6 @@ static void __flush_dcache_icache(void *p)
 {
 	unsigned long addr = (unsigned long)p;
 
-	if (flush_coherent_icache())
-		return;
-
 	clean_dcache_range(addr, addr + PAGE_SIZE);
 
 	/*
-- 
2.25.0

