Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0686358877
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhDHPbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:31:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2238 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231995AbhDHPak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FGQFG0w2Cz9txf6;
        Thu,  8 Apr 2021 17:30:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VKW1_CQBERBC; Thu,  8 Apr 2021 17:30:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FGQFF6sg6z9txf2;
        Thu,  8 Apr 2021 17:30:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73A148B7D1;
        Thu,  8 Apr 2021 17:30:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2_8msCpD5GaA; Thu,  8 Apr 2021 17:30:27 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C8668B7D4;
        Thu,  8 Apr 2021 17:30:27 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1A1EF679BA; Thu,  8 Apr 2021 15:30:27 +0000 (UTC)
Message-Id: <742b6360ae4f344a1c6ecfadcf3b6645f443fa7a.1617895813.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
References: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 3/9] powerpc/mem: Remove address argument to
 flush_coherent_icache()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  8 Apr 2021 15:30:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_coherent_icache() can use any valid address as mentionned
by the comment.

Use PAGE_OFFSET as base address. This allows removing the
user access stuff.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/cacheflush.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/cacheflush.c b/arch/powerpc/mm/cacheflush.c
index 742d3e0fb12f..dc2d39da6f63 100644
--- a/arch/powerpc/mm/cacheflush.c
+++ b/arch/powerpc/mm/cacheflush.c
@@ -5,10 +5,9 @@
 
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
@@ -18,9 +17,7 @@ static inline bool flush_coherent_icache(unsigned long addr)
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
@@ -60,7 +57,7 @@ static void invalidate_icache_range(unsigned long start, unsigned long stop)
  */
 void flush_icache_range(unsigned long start, unsigned long stop)
 {
-	if (flush_coherent_icache(start))
+	if (flush_coherent_icache())
 		return;
 
 	clean_dcache_range(start, stop);
@@ -146,7 +143,7 @@ static void __flush_dcache_icache(void *p)
 {
 	unsigned long addr = (unsigned long)p;
 
-	if (flush_coherent_icache(addr))
+	if (flush_coherent_icache())
 		return;
 
 	clean_dcache_range(addr, addr + PAGE_SIZE);
@@ -200,7 +197,7 @@ void flush_dcache_icache_page(struct page *page)
 	} else {
 		unsigned long addr = page_to_pfn(page) << PAGE_SHIFT;
 
-		if (flush_coherent_icache(addr))
+		if (flush_coherent_icache())
 			return;
 		flush_dcache_icache_phys(addr);
 	}
-- 
2.25.0

