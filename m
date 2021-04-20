Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00902365A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhDTNd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:33:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45060 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232600AbhDTNdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:33:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FPl3z4k02z9vBKk;
        Tue, 20 Apr 2021 15:32:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kny706gwQGVr; Tue, 20 Apr 2021 15:32:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FPl3z3ndPz9vBKj;
        Tue, 20 Apr 2021 15:32:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C307A8B80A;
        Tue, 20 Apr 2021 15:32:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iymder7MgE1A; Tue, 20 Apr 2021 15:32:48 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A55A8B7ED;
        Tue, 20 Apr 2021 15:32:48 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2DA1A6770B; Tue, 20 Apr 2021 13:32:48 +0000 (UTC)
Message-Id: <0d51620eacf036d683d1a3c41328f69adb601dc0.1618925560.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/2] powerpc/64: Fix the definition of the fixmap area
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        chris.packham@alliedtelesis.co.nz
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 20 Apr 2021 13:32:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, the fixmap area is defined at the top of
the address space or just below KASAN.

This definition is not valid for PPC64.

For PPC64, use the top of the I/O space.

Because of circular dependencies, it is not possible to include
asm/fixmap.h in asm/book3s/64/pgtable.h , so define a fixed size
AREA at the top of the I/O space for fixmap and ensure during
build that the size is big enough.

Fixes: 265c3491c4bc ("powerpc: Add support for GENERIC_EARLY_IOREMAP")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 4 +++-
 arch/powerpc/include/asm/fixmap.h            | 9 +++++++++
 arch/powerpc/include/asm/nohash/64/pgtable.h | 5 ++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 0c89977ec10b..a666d561b44d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -7,6 +7,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/mmdebug.h>
 #include <linux/bug.h>
+#include <linux/sizes.h>
 #endif
 
 /*
@@ -324,7 +325,8 @@ extern unsigned long pci_io_base;
 #define  PHB_IO_END	(KERN_IO_START + FULL_IO_SIZE)
 #define IOREMAP_BASE	(PHB_IO_END)
 #define IOREMAP_START	(ioremap_bot)
-#define IOREMAP_END	(KERN_IO_END)
+#define IOREMAP_END	(KERN_IO_END - FIXADDR_SIZE)
+#define FIXADDR_SIZE	SZ_32M
 
 /* Advertise special mapping type for AGP */
 #define HAVE_PAGE_AGP
diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 8d03c16a3663..947b5b9c4424 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -23,12 +23,17 @@
 #include <asm/kmap_size.h>
 #endif
 
+#ifdef CONFIG_PPC64
+#define FIXADDR_TOP	(IOREMAP_END + FIXADDR_SIZE)
+#else
+#define FIXADDR_SIZE	0
 #ifdef CONFIG_KASAN
 #include <asm/kasan.h>
 #define FIXADDR_TOP	(KASAN_SHADOW_START - PAGE_SIZE)
 #else
 #define FIXADDR_TOP	((unsigned long)(-PAGE_SIZE))
 #endif
+#endif
 
 /*
  * Here we define all the compile-time 'special' virtual
@@ -50,6 +55,7 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
+#ifdef CONFIG_PPC32
 	/* reserve the top 128K for early debugging purposes */
 	FIX_EARLY_DEBUG_TOP = FIX_HOLE,
 	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+(ALIGN(SZ_128K, PAGE_SIZE)/PAGE_SIZE)-1,
@@ -72,6 +78,7 @@ enum fixed_addresses {
 		       FIX_IMMR_SIZE,
 #endif
 	/* FIX_PCIE_MCFG, */
+#endif /* CONFIG_PPC32 */
 	__end_of_permanent_fixed_addresses,
 
 #define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
@@ -98,6 +105,8 @@ enum fixed_addresses {
 static inline void __set_fixmap(enum fixed_addresses idx,
 				phys_addr_t phys, pgprot_t flags)
 {
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_PPC64) && __FIXADDR_SIZE > FIXADDR_SIZE);
+
 	if (__builtin_constant_p(idx))
 		BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
 	else if (WARN_ON(idx >= __end_of_fixed_addresses))
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 6cb8aa357191..57cd3892bfe0 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -6,6 +6,8 @@
  * the ppc64 non-hashed page table.
  */
 
+#include <linux/sizes.h>
+
 #include <asm/nohash/64/pgtable-4k.h>
 #include <asm/barrier.h>
 #include <asm/asm-const.h>
@@ -54,7 +56,8 @@
 #define  PHB_IO_END	(KERN_IO_START + FULL_IO_SIZE)
 #define IOREMAP_BASE	(PHB_IO_END)
 #define IOREMAP_START	(ioremap_bot)
-#define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
+#define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE - FIXADDR_SIZE)
+#define FIXADDR_SIZE	SZ_32M
 
 
 /*
-- 
2.25.0

