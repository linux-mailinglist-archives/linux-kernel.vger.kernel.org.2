Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3003CF9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhGTLzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 07:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhGTLzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:55:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E88561208;
        Tue, 20 Jul 2021 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626784545;
        bh=GwfGyRUEV46aABYr56ARFGrKLvcz5cJwUqbzXNrCfU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNFULBFnBBsoQZHf3uR8j5jS4Oan/It40bN3jPeuE1c4CoxSyECi6FnI8p2zzSfUx
         2DXJN2GQoG9pUBbAodh3nbqSutzkTKpdDDWobN1con2cOJ/kPoxkefwsaGgRydEHih
         H6t/+FrDA7TCHw6aJC7SaMMEOcmp5bDjoIrSoBRTSgMYambXQoJhfGBOPCafJnX9i5
         G4lgUUtTZ7kSjcDppqp0IEoKZ2QvE6WUFF6tnT6eEQraL6rJZVshLpZEQ3h9J4LWdn
         ozRHgtziZ2Kg4QcpvWpniYjiO4uJgJNUtYroViktmRiKrQ5amMGy9ImJtMgFsPlz8i
         zHDm4p556oOgw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"
Date:   Tue, 20 Jul 2021 13:35:12 +0100
Message-Id: <20210720123512.8740-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720123512.8740-1-will@kernel.org>
References: <20210720123512.8740-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

This reverts commit c742199a014de23ee92055c2473d91fe5561ffdf.

c742199a014d ("mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge")
breaks arm64 in at least two ways for configurations where PUD or PMD
folding occur:

  1. We no longer install huge-vmap mappings and silently fall back to
     page-granular entries, despite being able to install block entries
     at what is effectively the PGD level.

  2. If the linear map is backed with block mappings, these will now
     silently fail to be created in alloc_init_pud(), causing a panic
     early during boot.

The pgtable selftests caught this, although a fix has not been
forthcoming and Christophe is AWOL at the moment, so just revert the
change for now to get a working -rc3 on which we can queue patches for
5.15.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/linux-arm-kernel/CAMuHMdXShORDox-xxaeUfDW3wx2PeggFSqhVSHVZNKCGK-y_vQ@mail.gmail.com/
Link: https://lore.kernel.org/r/20210717160118.9855-1-jonathan@marek.ca
Fixes: c742199a014d ("mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/mm/mmu.c     | 20 ++++++++------------
 arch/x86/mm/pgtable.c   | 34 +++++++++++++++-------------------
 include/linux/pgtable.h | 26 +-------------------------
 3 files changed, 24 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d74586508448..9ff0de1b2b93 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1339,7 +1339,6 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-#if CONFIG_PGTABLE_LEVELS > 3
 int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), mk_pud_sect_prot(prot));
@@ -1354,16 +1353,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 	return 1;
 }
 
-int pud_clear_huge(pud_t *pudp)
-{
-	if (!pud_sect(READ_ONCE(*pudp)))
-		return 0;
-	pud_clear(pudp);
-	return 1;
-}
-#endif
-
-#if CONFIG_PGTABLE_LEVELS > 2
 int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), mk_pmd_sect_prot(prot));
@@ -1378,6 +1367,14 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 	return 1;
 }
 
+int pud_clear_huge(pud_t *pudp)
+{
+	if (!pud_sect(READ_ONCE(*pudp)))
+		return 0;
+	pud_clear(pudp);
+	return 1;
+}
+
 int pmd_clear_huge(pmd_t *pmdp)
 {
 	if (!pmd_sect(READ_ONCE(*pmdp)))
@@ -1385,7 +1382,6 @@ int pmd_clear_huge(pmd_t *pmdp)
 	pmd_clear(pmdp);
 	return 1;
 }
-#endif
 
 int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 {
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3364fe62b903..3481b35cb4ec 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -682,7 +682,6 @@ int p4d_clear_huge(p4d_t *p4d)
 }
 #endif
 
-#if CONFIG_PGTABLE_LEVELS > 3
 /**
  * pud_set_huge - setup kernel PUD mapping
  *
@@ -721,23 +720,6 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	return 1;
 }
 
-/**
- * pud_clear_huge - clear kernel PUD mapping when it is set
- *
- * Returns 1 on success and 0 on failure (no PUD map is found).
- */
-int pud_clear_huge(pud_t *pud)
-{
-	if (pud_large(*pud)) {
-		pud_clear(pud);
-		return 1;
-	}
-
-	return 0;
-}
-#endif
-
-#if CONFIG_PGTABLE_LEVELS > 2
 /**
  * pmd_set_huge - setup kernel PMD mapping
  *
@@ -768,6 +750,21 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 	return 1;
 }
 
+/**
+ * pud_clear_huge - clear kernel PUD mapping when it is set
+ *
+ * Returns 1 on success and 0 on failure (no PUD map is found).
+ */
+int pud_clear_huge(pud_t *pud)
+{
+	if (pud_large(*pud)) {
+		pud_clear(pud);
+		return 1;
+	}
+
+	return 0;
+}
+
 /**
  * pmd_clear_huge - clear kernel PMD mapping when it is set
  *
@@ -782,7 +779,6 @@ int pmd_clear_huge(pmd_t *pmd)
 
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_X86_64
 /**
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index d147480cdefc..e24d2c992b11 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1397,34 +1397,10 @@ static inline int p4d_clear_huge(p4d_t *p4d)
 }
 #endif /* !__PAGETABLE_P4D_FOLDED */
 
-#ifndef __PAGETABLE_PUD_FOLDED
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
-int pud_clear_huge(pud_t *pud);
-#else
-static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
-{
-	return 0;
-}
-static inline int pud_clear_huge(pud_t *pud)
-{
-	return 0;
-}
-#endif /* !__PAGETABLE_PUD_FOLDED */
-
-#ifndef __PAGETABLE_PMD_FOLDED
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
+int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
-#else
-static inline int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
-{
-	return 0;
-}
-static inline int pmd_clear_huge(pmd_t *pmd)
-{
-	return 0;
-}
-#endif /* !__PAGETABLE_PMD_FOLDED */
-
 int p4d_free_pud_page(p4d_t *p4d, unsigned long addr);
 int pud_free_pmd_page(pud_t *pud, unsigned long addr);
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
-- 
2.32.0.402.g57bb445576-goog

