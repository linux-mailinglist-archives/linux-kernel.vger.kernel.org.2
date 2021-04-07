Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C135730B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354833AbhDGRW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:22:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56479 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354805AbhDGRWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:22:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FFrnC60DfzB09Zc;
        Wed,  7 Apr 2021 19:22:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nrxjgkZZvQiS; Wed,  7 Apr 2021 19:22:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FFrnC4K5qzB09ZS;
        Wed,  7 Apr 2021 19:22:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 487718B7B6;
        Wed,  7 Apr 2021 19:22:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6g6sCUNW50XK; Wed,  7 Apr 2021 19:22:41 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 15C9B8B75F;
        Wed,  7 Apr 2021 19:22:41 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E92986799B; Wed,  7 Apr 2021 17:22:40 +0000 (UTC)
Message-Id: <a2d0e529c6cff34343244469f0321420f80f2bb7.1617816138.git.christophe.leroy@csgroup.eu>
In-Reply-To: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
References: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 7/8] powerpc/mem: Inline flush_dcache_page()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  7 Apr 2021 17:22:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_dcache_page() is only a few lines, it is worth
inlining.

ia64, csky, mips, openrisc and riscv have a similar
flush_dcache_page() and inline it.

On pmac32_defconfig, we get a small size reduction.
On ppc64_defconfig, we get a very small size increase.

In both case that's in the noise (less than 0.1%).

text		data	bss	dec		hex	filename
18991155	5934744	1497624	26423523	19330e3	vmlinux64.before
18994829	5936732	1497624	26429185	1934701	vmlinux64.after
9150963		2467502	 184548	11803013	 b41985	vmlinux32.before
9149689		2467302	 184548	11801539	 b413c3	vmlinux32.after

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/cacheflush.h | 14 +++++++++++++-
 arch/powerpc/mm/mem.c                 | 15 ---------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 9110489ea411..7564dd4fd12b 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -30,7 +30,19 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-extern void flush_dcache_page(struct page *page);
+/*
+ * This is called when a page has been modified by the kernel.
+ * It just marks the page as not i-cache clean.  We do the i-cache
+ * flush later when the page is given to a user process, if necessary.
+ */
+static inline void flush_dcache_page(struct page *page)
+{
+	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
+		return;
+	/* avoid an atomic op if possible */
+	if (test_bit(PG_dcache_clean, &page->flags))
+		clear_bit(PG_dcache_clean, &page->flags);
+}
 
 void flush_icache_range(unsigned long start, unsigned long stop);
 #define flush_icache_range flush_icache_range
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 460ab5000a3f..65b2205839fe 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -458,21 +458,6 @@ static void flush_dcache_icache_phys(unsigned long physaddr)
 }
 #endif
 
-/*
- * This is called when a page has been modified by the kernel.
- * It just marks the page as not i-cache clean.  We do the i-cache
- * flush later when the page is given to a user process, if necessary.
- */
-void flush_dcache_page(struct page *page)
-{
-	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
-		return;
-	/* avoid an atomic op if possible */
-	if (test_bit(PG_dcache_clean, &page->flags))
-		clear_bit(PG_dcache_clean, &page->flags);
-}
-EXPORT_SYMBOL(flush_dcache_page);
-
 static void __flush_dcache_icache(void *p);
 
 static void flush_dcache_icache_hugepage(struct page *page)
-- 
2.25.0

