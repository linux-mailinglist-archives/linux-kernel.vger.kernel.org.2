Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A0C358878
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhDHPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:31:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11431 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhDHPak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FGQFH1Mpzz9txf7;
        Thu,  8 Apr 2021 17:30:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bixdd4THtti4; Thu,  8 Apr 2021 17:30:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FGQFH0RpNz9txf2;
        Thu,  8 Apr 2021 17:30:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 94F9A8B7D4;
        Thu,  8 Apr 2021 17:30:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NymC662j49z3; Thu,  8 Apr 2021 17:30:28 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4376D8B7D1;
        Thu,  8 Apr 2021 17:30:28 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 20E97679BA; Thu,  8 Apr 2021 15:30:28 +0000 (UTC)
Message-Id: <5f063986e325d2efdd404b8f8c5f4bcbd4eb11a6.1617895813.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
References: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 4/9] powerpc/mem: Call flush_coherent_icache() at higher
 level
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  8 Apr 2021 15:30:28 +0000 (UTC)
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
 arch/powerpc/mm/cacheflush.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/cacheflush.c b/arch/powerpc/mm/cacheflush.c
index dc2d39da6f63..811045c50d82 100644
--- a/arch/powerpc/mm/cacheflush.c
+++ b/arch/powerpc/mm/cacheflush.c
@@ -143,9 +143,6 @@ static void __flush_dcache_icache(void *p)
 {
 	unsigned long addr = (unsigned long)p;
 
-	if (flush_coherent_icache())
-		return;
-
 	clean_dcache_range(addr, addr + PAGE_SIZE);
 
 	/*
@@ -182,6 +179,8 @@ static void flush_dcache_icache_hugepage(struct page *page)
 
 void flush_dcache_icache_page(struct page *page)
 {
+	if (flush_coherent_icache())
+		return;
 
 	if (PageCompound(page))
 		return flush_dcache_icache_hugepage(page);
@@ -195,11 +194,7 @@ void flush_dcache_icache_page(struct page *page)
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
-- 
2.25.0

