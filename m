Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C303760D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhEGHEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:04:22 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:58997 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232997AbhEGHET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:04:19 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fc1cf160Yz9sZT;
        Fri,  7 May 2021 09:03:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9IOecJUEDgjb; Fri,  7 May 2021 09:03:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fc1cd743Tz9sZQ;
        Fri,  7 May 2021 09:03:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CD87A8B81A;
        Fri,  7 May 2021 09:03:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id plfkGV4mlhz1; Fri,  7 May 2021 09:03:13 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B82A8B81E;
        Fri,  7 May 2021 09:03:13 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1EEC164909; Fri,  7 May 2021 07:03:13 +0000 (UTC)
Message-Id: <ff4b7df776b318c054743560d89aed8eb8f5b090.1620370984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <9c5f23642ac5900c8e83da795afac7041bf87cf6.1620370984.git.christophe.leroy@csgroup.eu>
References: <9c5f23642ac5900c8e83da795afac7041bf87cf6.1620370984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/5] powerpc/nohash: Convert set_context() to C
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  7 May 2021 07:03:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc8xx already has set_context() in C.

Other ones have it in assembly. The only thing it does is to
write the context id into SPRN_PID.

Do it in C.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mmu_context.h |  1 -
 arch/powerpc/kernel/head_40x.S         |  7 -------
 arch/powerpc/kernel/head_44x.S         |  5 -----
 arch/powerpc/kernel/head_fsl_booke.S   |  5 -----
 arch/powerpc/mm/nohash/8xx.c           | 25 -------------------------
 arch/powerpc/mm/nohash/mmu_context.c   | 24 ++++++++++++++++++++++++
 arch/powerpc/mm/nohash/tlb_low.S       |  5 -----
 7 files changed, 24 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 4bc45d3ed8b0..ef6df2681582 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -57,7 +57,6 @@ static inline bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 static inline void mm_iommu_init(struct mm_struct *mm) { }
 #endif
 extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
-extern void set_context(unsigned long id, pgd_t *pgd);
 
 #ifdef CONFIG_PPC_BOOK3S_64
 extern void radix__switch_mmu_context(struct mm_struct *prev,
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 7ef1bbc23bed..2717aa860cae 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -702,13 +702,6 @@ _GLOBAL(abort)
         oris    r13,r13,DBCR0_RST_SYSTEM@h
         mtspr   SPRN_DBCR0,r13
 
-_GLOBAL(set_context)
-	sync
-	mtspr	SPRN_PID,r3
-	isync				/* Need an isync to flush shadow */
-					/* TLBs after changing PID */
-	blr
-
 /* We put a few things here that have to be page-aligned. This stuff
  * goes at the beginning of the data segment, which is page-aligned.
  */
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 57509d90e409..c5bec6a9864b 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -780,11 +780,6 @@ _GLOBAL(__fixup_440A_mcheck)
 	sync
 	blr
 
-_GLOBAL(set_context)
-	mtspr	SPRN_PID,r3
-	isync			/* Force context change */
-	blr
-
 /*
  * Init CPU state. This is called at boot time or for secondary CPUs
  * to setup initial TLB entries, setup IVORs, etc...
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 590f34cc5bb2..ab718fd5e2a2 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -985,11 +985,6 @@ _GLOBAL(abort)
 	mtspr	SPRN_DBCR0,r13
 	isync
 
-_GLOBAL(set_context)
-	mtspr	SPRN_PID,r3
-	isync			/* Force context change */
-	blr
-
 #ifdef CONFIG_SMP
 /* When we get here, r24 needs to hold the CPU # */
 	.globl __secondary_start
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index f749acba5473..65e4c8b92657 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -212,31 +212,6 @@ void __init setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	memblock_set_current_limit(min_t(u64, first_memblock_size, SZ_32M));
 }
 
-/*
- * Set up to use a given MMU context.
- * id is context number, pgd is PGD pointer.
- *
- * We place the physical address of the new task page directory loaded
- * into the MMU base register, and set the ASID compare register with
- * the new "context."
- */
-void set_context(unsigned long id, pgd_t *pgd)
-{
-	s16 offset = (s16)(__pa(swapper_pg_dir));
-
-	/* Register M_TWB will contain base address of level 1 table minus the
-	 * lower part of the kernel PGDIR base address, so that all accesses to
-	 * level 1 table are done relative to lower part of kernel PGDIR base
-	 * address.
-	 */
-	mtspr(SPRN_M_TWB, __pa(pgd) - offset);
-
-	/* Update context */
-	mtspr(SPRN_M_CASID, id - 1);
-	/* sync */
-	mb();
-}
-
 #ifdef CONFIG_PPC_KUEP
 void __init setup_kuep(bool disabled)
 {
diff --git a/arch/powerpc/mm/nohash/mmu_context.c b/arch/powerpc/mm/nohash/mmu_context.c
index 5d9758e1d95f..111e47a44612 100644
--- a/arch/powerpc/mm/nohash/mmu_context.c
+++ b/arch/powerpc/mm/nohash/mmu_context.c
@@ -258,6 +258,30 @@ static void context_check_map(void)
 static void context_check_map(void) { }
 #endif
 
+static void set_context(unsigned long id, pgd_t *pgd)
+{
+	if (IS_ENABLED(CONFIG_PPC_8xx)) {
+		s16 offset = (s16)(__pa(swapper_pg_dir));
+
+		/* Register M_TWB will contain base address of level 1 table minus the
+		 * lower part of the kernel PGDIR base address, so that all accesses to
+		 * level 1 table are done relative to lower part of kernel PGDIR base
+		 * address.
+		 */
+		mtspr(SPRN_M_TWB, __pa(pgd) - offset);
+
+		/* Update context */
+		mtspr(SPRN_M_CASID, id - 1);
+		/* sync */
+		mb();
+	} else {
+		if (IS_ENABLED(CONFIG_40x))
+			mb(); 	/* sync */
+		mtspr(SPRN_PID, id);
+		isync();
+	}
+}
+
 void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
diff --git a/arch/powerpc/mm/nohash/tlb_low.S b/arch/powerpc/mm/nohash/tlb_low.S
index b3d0f0127828..4613bf8e9aae 100644
--- a/arch/powerpc/mm/nohash/tlb_low.S
+++ b/arch/powerpc/mm/nohash/tlb_low.S
@@ -360,11 +360,6 @@ _GLOBAL(_tlbivax_bcast)
 	sync
 	wrtee	r10
 	blr
-
-_GLOBAL(set_context)
-	mtspr	SPRN_PID,r3
-	isync			/* Force context change */
-	blr
 #else
 #error Unsupported processor type !
 #endif
-- 
2.25.0

