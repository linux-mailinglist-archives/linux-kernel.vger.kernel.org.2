Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8129C357301
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354776AbhDGRWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:22:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17180 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhDGRWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:22:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FFrn64GKszB09ZV;
        Wed,  7 Apr 2021 19:22:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4TY1E5y3UCLq; Wed,  7 Apr 2021 19:22:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FFrn63WHDzB09ZS;
        Wed,  7 Apr 2021 19:22:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29C918B75F;
        Wed,  7 Apr 2021 19:22:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZEZHxdG3ue1X; Wed,  7 Apr 2021 19:22:36 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E7EBE8B7B6;
        Wed,  7 Apr 2021 19:22:35 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C03D66799B; Wed,  7 Apr 2021 17:22:35 +0000 (UTC)
Message-Id: <8cbdcfc4446154bd3323cc68827f114aa9bbc5e7.1617816138.git.christophe.leroy@csgroup.eu>
In-Reply-To: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
References: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/8] powerpc/mem: Remove address argument to
 flush_coherent_icache()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  7 Apr 2021 17:22:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_coherent_icache() can use any valid address as mentionned
by the comment.

Use PAGE_OFFSET as base address. This allows removing the
user access stuff.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mem.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index ce6c81ce4362..19f807b87697 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -342,10 +342,9 @@ void free_initmem(void)
 
 /**
  * flush_coherent_icache() - if a CPU has a coherent icache, flush it
- * @addr: The base address to use (can be any valid address, the whole cache will be flushed)
  * Return true if the cache was flushed, false otherwise
  */
-static inline bool flush_coherent_icache(unsigned long addr)
+static inline bool flush_coherent_icache(void)
 {
 	/*
 	 * For a snooping icache, we still need a dummy icbi to purge all the
@@ -355,9 +354,7 @@ static inline bool flush_coherent_icache(unsigned long addr)
 	 */
 	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
 		mb(); /* sync */
-		allow_read_from_user((const void __user *)addr, L1_CACHE_BYTES);
-		icbi((void *)addr);
-		prevent_read_from_user((const void __user *)addr, L1_CACHE_BYTES);
+		icbi((void *)PAGE_OFFSET);
 		mb(); /* sync */
 		isync();
 		return true;
@@ -397,7 +394,7 @@ static void invalidate_icache_range(unsigned long start, unsigned long stop)
  */
 void flush_icache_range(unsigned long start, unsigned long stop)
 {
-	if (flush_coherent_icache(start))
+	if (flush_coherent_icache())
 		return;
 
 	clean_dcache_range(start, stop);
@@ -509,7 +506,7 @@ void flush_dcache_icache_page(struct page *page)
 	} else {
 		unsigned long addr = page_to_pfn(page) << PAGE_SHIFT;
 
-		if (flush_coherent_icache(addr))
+		if (flush_coherent_icache())
 			return;
 		flush_dcache_icache_phys(addr);
 	}
@@ -528,7 +525,7 @@ static void __flush_dcache_icache(void *p)
 {
 	unsigned long addr = (unsigned long)p;
 
-	if (flush_coherent_icache(addr))
+	if (flush_coherent_icache())
 		return;
 
 	clean_dcache_range(addr, addr + PAGE_SIZE);
-- 
2.25.0

