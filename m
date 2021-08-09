Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5F3E3D47
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 02:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhHIAAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 20:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhHIAAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 20:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C976260F4B;
        Mon,  9 Aug 2021 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628467230;
        bh=6GmyMeH/66MixViZStdfX7kmbjQeFfFh68Zqm15t9hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1zcgHZaax22aaBerc+51BrMCUK8zc59jL9+DIcFxNW2jgHCOq7FAJoqStv5uWSJh
         HkMdi6leDvOs1VRExopJ4ywz3m9nj+RBR16EGjrYXekKAT2sgLmIFjcKbmLb2+fY0S
         7x+i5u27eeeipGHHydacmSLepVV/XfzFsVswmeCH3BfBU4CIKs6W191DjATCn2VDKa
         Em1uqrvo7z+k12OHGtvKTpbdL9d51wOUflYGlxyQJsKdxk13IHARl0vtw+DHtsVD3H
         egWclKrdDRi3TzSnDoWcO6hMmF7gAikmvSZT7JSORVtL+RzhUvHtx77qwkSCybw/5A
         WfoeZKKtSbhpw==
From:   vgupta@kernel.org
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Subject: [RFC 2/2] ARC: retire MMUv1 and MMUv2 support
Date:   Sun,  8 Aug 2021 17:00:25 -0700
Message-Id: <20210809000025.2348004-2-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809000025.2348004-1-vgupta@kernel.org>
References: <20210809000025.2348004-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

These were present in ancient ARC700 cores which don't seem to be
active in field anymore.

Removal helps cleanup code and remove the hack for
MMU_VER to MMU_V[3-4] conversion

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig                |  22 +----
 arch/arc/include/asm/mmu.h      |  22 +----
 arch/arc/include/asm/pgtable.h  |  26 +----
 arch/arc/include/asm/tlb-mmu1.h | 101 --------------------
 arch/arc/mm/cache.c             | 110 +++------------------
 arch/arc/mm/tlb.c               | 163 ++++----------------------------
 arch/arc/mm/tlbex.S             |  10 +-
 7 files changed, 42 insertions(+), 412 deletions(-)
 delete mode 100644 arch/arc/include/asm/tlb-mmu1.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 3015788a7094..0680b1de0fc3 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -265,32 +265,17 @@ config ARC_DCCM_BASE
 
 choice
 	prompt "MMU Version"
-	default ARC_MMU_V3 if ARC_CPU_770
-	default ARC_MMU_V4 if ARC_CPU_HS
-
-if ISA_ARCOMPACT
-
-config ARC_MMU_V1
-	bool "MMU v1"
-	help
-	  Orig ARC700 MMU
-
-config ARC_MMU_V2
-	bool "MMU v2"
-	help
-	  Fixed the deficiency of v1 - possible thrashing in memcpy scenario
-	  when 2 D-TLB and 1 I-TLB entries index into same 2way set.
+	default ARC_MMU_V3 if ISA_ARCOMPACT
+	default ARC_MMU_V4 if ISA_ARCV2
 
 config ARC_MMU_V3
 	bool "MMU v3"
-	depends on ARC_CPU_770
+	depends on ISA_ARCOMPACT
 	help
 	  Introduced with ARC700 4.10: New Features
 	  Variable Page size (1k-16k), var JTLB size 128 x (2 or 4)
 	  Shared Address Spaces (SASID)
 
-endif
-
 config ARC_MMU_V4
 	bool "MMU v4"
 	depends on ISA_ARCV2
@@ -309,7 +294,6 @@ config ARC_PAGE_SIZE_8K
 
 config ARC_PAGE_SIZE_16K
 	bool "16KB"
-	depends on ARC_MMU_V3 || ARC_MMU_V4
 
 config ARC_PAGE_SIZE_4K
 	bool "4KB"
diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index 26b731d32a2b..a81d1975866a 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -10,19 +10,10 @@
 #include <linux/threads.h>	/* NR_CPUS */
 #endif
 
-#if defined(CONFIG_ARC_MMU_V1)
-#define CONFIG_ARC_MMU_VER 1
-#elif defined(CONFIG_ARC_MMU_V2)
-#define CONFIG_ARC_MMU_VER 2
-#elif defined(CONFIG_ARC_MMU_V3)
-#define CONFIG_ARC_MMU_VER 3
-#elif defined(CONFIG_ARC_MMU_V4)
-#define CONFIG_ARC_MMU_VER 4
-#endif
-
 /* MMU Management regs */
 #define ARC_REG_MMU_BCR		0x06f
-#if (CONFIG_ARC_MMU_VER < 4)
+
+#ifdef CONFIG_ARC_MMU_V3
 #define ARC_REG_TLBPD0		0x405
 #define ARC_REG_TLBPD1		0x406
 #define ARC_REG_TLBPD1HI	0	/* Dummy: allows code sharing with ARC700 */
@@ -52,7 +43,7 @@
 /* Error code if probe fails */
 #define TLB_LKUP_ERR		0x80000000
 
-#if (CONFIG_ARC_MMU_VER < 4)
+#ifdef CONFIG_ARC_MMU_V3
 #define TLB_DUP_ERR	(TLB_LKUP_ERR | 0x00000001)
 #else
 #define TLB_DUP_ERR	(TLB_LKUP_ERR | 0x40000000)
@@ -63,15 +54,10 @@
 #define TLBRead     0x2
 #define TLBGetIndex 0x3
 #define TLBProbe    0x4
-
-#if (CONFIG_ARC_MMU_VER >= 2)
 #define TLBWriteNI  0x5		/* write JTLB without inv uTLBs */
 #define TLBIVUTLB   0x6		/* explicitly inv uTLBs */
-#else
-#define TLBWriteNI  TLBWrite	/* Not present in hardware, fallback */
-#endif
 
-#if (CONFIG_ARC_MMU_VER >= 4)
+#ifdef CONFIG_ARC_MMU_V4
 #define TLBInsertEntry	0x7
 #define TLBDeleteEntry	0x8
 #endif
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 320cc0ae8a08..0c3e220bd2b4 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -35,7 +35,7 @@
 #include <linux/bits.h>
 #include <asm-generic/pgtable-nopmd.h>
 #include <asm/page.h>
-#include <asm/mmu.h>	/* to propagate CONFIG_ARC_MMU_VER <n> */
+#include <asm/mmu.h>
 
 /**************************************************************************
  * Page Table Flags
@@ -51,20 +51,6 @@
  *      (saves some bit shift ops in TLB Miss hdlrs)
  */
 
-#if (CONFIG_ARC_MMU_VER <= 2)
-
-#define _PAGE_ACCESSED      (1<<1)	/* Page is accessed (S) */
-#define _PAGE_CACHEABLE     (1<<2)	/* Page is cached (H) */
-#define _PAGE_EXECUTE       (1<<3)	/* Page has user execute perm (H) */
-#define _PAGE_WRITE         (1<<4)	/* Page has user write perm (H) */
-#define _PAGE_READ          (1<<5)	/* Page has user read perm (H) */
-#define _PAGE_DIRTY         (1<<6)	/* Page modified (dirty) (S) */
-#define _PAGE_SPECIAL       (1<<7)
-#define _PAGE_GLOBAL        (1<<8)	/* Page is global (H) */
-#define _PAGE_PRESENT       (1<<10)	/* TLB entry is valid (H) */
-
-#else	/* MMU v3 onwards */
-
 #define _PAGE_CACHEABLE     (1<<0)	/* Page is cached (H) */
 #define _PAGE_EXECUTE       (1<<1)	/* Page has user execute perm (H) */
 #define _PAGE_WRITE         (1<<2)	/* Page has user write perm (H) */
@@ -73,23 +59,15 @@
 #define _PAGE_DIRTY         (1<<5)	/* Page modified (dirty) (S) */
 #define _PAGE_SPECIAL       (1<<6)
 
-#if (CONFIG_ARC_MMU_VER >= 4)
-#define _PAGE_WTHRU         (1<<7)	/* Page cache mode write-thru (H) */
-#endif
-
 #define _PAGE_GLOBAL        (1<<8)	/* Page is global (H) */
 #define _PAGE_PRESENT       (1<<9)	/* TLB entry is valid (H) */
 
-#if (CONFIG_ARC_MMU_VER >= 4)
+#ifdef CONFIG_ARC_MMU_V4
 #define _PAGE_HW_SZ         (1<<10)	/* Page Size indicator (H): 0 normal, 1 super */
 #endif
 
 #define _PAGE_SHARED_CODE   (1<<11)	/* Shared Code page with cmn vaddr
 					   usable for shared TLB entries (H) */
-
-#define _PAGE_UNUSED_BIT    (1<<12)
-#endif
-
 /* vmalloc permissions */
 #define _K_PAGE_PERMS  (_PAGE_EXECUTE | _PAGE_WRITE | _PAGE_READ | \
 			_PAGE_GLOBAL | _PAGE_PRESENT)
diff --git a/arch/arc/include/asm/tlb-mmu1.h b/arch/arc/include/asm/tlb-mmu1.h
deleted file mode 100644
index a3083b36f5f4..000000000000
--- a/arch/arc/include/asm/tlb-mmu1.h
+++ /dev/null
@@ -1,101 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- */
-
-#ifndef __ASM_TLB_MMU_V1_H__
-#define __ASM_TLB_MMU_V1_H__
-
-#include <asm/mmu.h>
-
-#if defined(__ASSEMBLY__) && (CONFIG_ARC_MMU_VER == 1)
-
-.macro TLB_WRITE_HEURISTICS
-
-#define JH_HACK1
-#undef JH_HACK2
-#undef JH_HACK3
-
-#ifdef JH_HACK3
-; Calculate set index for 2-way MMU
-; -avoiding use of GetIndex from MMU
-;   and its unpleasant LFSR pseudo-random sequence
-;
-; r1 = TLBPD0 from TLB_RELOAD above
-;
-; -- jh_ex_way_set not cleared on startup
-;    didn't want to change setup.c
-;    hence extra instruction to clean
-;
-; -- should be in cache since in same line
-;    as r0/r1 saves above
-;
-ld  r0,[jh_ex_way_sel]  ; victim pointer
-and r0,r0,1         ; clean
-xor.f   r0,r0,1         ; flip
-st  r0,[jh_ex_way_sel]  ; store back
-asr r0,r1,12        ; get set # <<1, note bit 12=R=0
-or.nz   r0,r0,1         ; set way bit
-and r0,r0,0xff      ; clean
-sr  r0,[ARC_REG_TLBINDEX]
-#endif
-
-#ifdef JH_HACK2
-; JH hack #2
-;  Faster than hack #1 in non-thrash case, but hard-coded for 2-way MMU
-;  Slower in thrash case (where it matters) because more code is executed
-;  Inefficient due to two-register paradigm of this miss handler
-;
-/* r1 = data TLBPD0 at this point */
-lr      r0,[eret]               /* instruction address */
-xor     r0,r0,r1                /* compare set #       */
-and.f   r0,r0,0x000fe000        /* 2-way MMU mask      */
-bne     88f                     /* not in same set - no need to probe */
-
-lr      r0,[eret]               /* instruction address */
-and     r0,r0,PAGE_MASK         /* VPN of instruction address */
-; lr  r1,[ARC_REG_TLBPD0]     /* Data VPN+ASID - already in r1 from TLB_RELOAD*/
-and     r1,r1,0xff              /* Data ASID */
-or      r0,r0,r1                /* Instruction address + Data ASID */
-
-lr      r1,[ARC_REG_TLBPD0]     /* save TLBPD0 containing data TLB*/
-sr      r0,[ARC_REG_TLBPD0]     /* write instruction address to TLBPD0 */
-sr      TLBProbe, [ARC_REG_TLBCOMMAND] /* Look for instruction */
-lr      r0,[ARC_REG_TLBINDEX]   /* r0 = index where instruction is, if at all */
-sr      r1,[ARC_REG_TLBPD0]     /* restore TLBPD0 */
-
-xor     r0,r0,1                 /* flip bottom bit of data index */
-b.d     89f
-sr      r0,[ARC_REG_TLBINDEX]   /* and put it back */
-88:
-sr  TLBGetIndex, [ARC_REG_TLBCOMMAND]
-89:
-#endif
-
-#ifdef JH_HACK1
-;
-; Always checks whether instruction will be kicked out by dtlb miss
-;
-mov_s   r3, r1                  ; save PD0 prepared by TLB_RELOAD in r3
-lr      r0,[eret]               /* instruction address */
-and     r0,r0,PAGE_MASK         /* VPN of instruction address */
-bmsk    r1,r3,7                 /* Data ASID, bits 7-0 */
-or_s    r0,r0,r1                /* Instruction address + Data ASID */
-
-sr      r0,[ARC_REG_TLBPD0]     /* write instruction address to TLBPD0 */
-sr      TLBProbe, [ARC_REG_TLBCOMMAND] /* Look for instruction */
-lr      r0,[ARC_REG_TLBINDEX]   /* r0 = index where instruction is, if at all */
-sr      r3,[ARC_REG_TLBPD0]     /* restore TLBPD0 */
-
-sr      TLBGetIndex, [ARC_REG_TLBCOMMAND]
-lr      r1,[ARC_REG_TLBINDEX]   /* r1 = index where MMU wants to put data */
-cmp     r0,r1                   /* if no match on indices, go around */
-xor.eq  r1,r1,1                 /* flip bottom bit of data index */
-sr      r1,[ARC_REG_TLBINDEX]   /* and put it back */
-#endif
-
-.endm
-
-#endif
-
-#endif
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index a2fbea3ee07c..0de1b87ba438 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -205,93 +205,24 @@ void read_decode_cache_bcr(void)
 #define OP_INV_IC	0x4
 
 /*
- *		I-Cache Aliasing in ARC700 VIPT caches (MMU v1-v3)
+ * Cache Flush programming model
  *
- * ARC VIPT I-cache uses vaddr to index into cache and paddr to match the tag.
- * The orig Cache Management Module "CDU" only required paddr to invalidate a
- * certain line since it sufficed as index in Non-Aliasing VIPT cache-geometry.
- * Infact for distinct V1,V2,P: all of {V1-P},{V2-P},{P-P} would end up fetching
- * the exact same line.
+ * ARC700 MMUv3 I$ and D$ are both VIPT and can potentially alias.
+ * Programming model requires both paddr and vaddr irrespecive of alising
+ * considerations:
+ *  - vaddr in {I,D}C_IV?L
+ *  - paddr in {I,D}C_PTAG
  *
- * However for larger Caches (way-size > page-size) - i.e. in Aliasing config,
- * paddr alone could not be used to correctly index the cache.
+ * In HS38x (MMUv4), D$ is PIPT, I$ is VIPT and can still alias.
+ * Programming model is different for alising vs. non-alising I$
+ *  - D$ / Non-alising I$: only paddr in {I,D}C_IV?L
+ *  - Alising I$: same as ARC700 above (so MMUv3 routine used for MMUv4 I$)
  *
- * ------------------
- * MMU v1/v2 (Fixed Page Size 8k)
- * ------------------
- * The solution was to provide CDU with these additonal vaddr bits. These
- * would be bits [x:13], x would depend on cache-geometry, 13 comes from
- * standard page size of 8k.
- * H/w folks chose [17:13] to be a future safe range, and moreso these 5 bits
- * of vaddr could easily be "stuffed" in the paddr as bits [4:0] since the
- * orig 5 bits of paddr were anyways ignored by CDU line ops, as they
- * represent the offset within cache-line. The adv of using this "clumsy"
- * interface for additional info was no new reg was needed in CDU programming
- * model.
- *
- * 17:13 represented the max num of bits passable, actual bits needed were
- * fewer, based on the num-of-aliases possible.
- * -for 2 alias possibility, only bit 13 needed (32K cache)
- * -for 4 alias possibility, bits 14:13 needed (64K cache)
- *
- * ------------------
- * MMU v3
- * ------------------
- * This ver of MMU supports variable page sizes (1k-16k): although Linux will
- * only support 8k (default), 16k and 4k.
- * However from hardware perspective, smaller page sizes aggravate aliasing
- * meaning more vaddr bits needed to disambiguate the cache-line-op ;
- * the existing scheme of piggybacking won't work for certain configurations.
- * Two new registers IC_PTAG and DC_PTAG inttoduced.
- * "tag" bits are provided in PTAG, index bits in existing IVIL/IVDL/FLDL regs
+ *  - If PAE40 is enabled, independent of aliasing considerations, the higher
+ *    bits needs to be written into PTAG_HI
  */
 
 static inline
-void __cache_line_loop_v2(phys_addr_t paddr, unsigned long vaddr,
-			  unsigned long sz, const int op, const int full_page)
-{
-	unsigned int aux_cmd;
-	int num_lines;
-
-	if (op == OP_INV_IC) {
-		aux_cmd = ARC_REG_IC_IVIL;
-	} else {
-		/* d$ cmd: INV (discard or wback-n-discard) OR FLUSH (wback) */
-		aux_cmd = op & OP_INV ? ARC_REG_DC_IVDL : ARC_REG_DC_FLDL;
-	}
-
-	/* Ensure we properly floor/ceil the non-line aligned/sized requests
-	 * and have @paddr - aligned to cache line and integral @num_lines.
-	 * This however can be avoided for page sized since:
-	 *  -@paddr will be cache-line aligned already (being page aligned)
-	 *  -@sz will be integral multiple of line size (being page sized).
-	 */
-	if (!full_page) {
-		sz += paddr & ~CACHE_LINE_MASK;
-		paddr &= CACHE_LINE_MASK;
-		vaddr &= CACHE_LINE_MASK;
-	}
-
-	num_lines = DIV_ROUND_UP(sz, L1_CACHE_BYTES);
-
-	/* MMUv2 and before: paddr contains stuffed vaddrs bits */
-	paddr |= (vaddr >> PAGE_SHIFT) & 0x1F;
-
-	while (num_lines-- > 0) {
-		write_aux_reg(aux_cmd, paddr);
-		paddr += L1_CACHE_BYTES;
-	}
-}
-
-/*
- * For ARC700 MMUv3 I-cache and D-cache flushes
- *  - ARC700 programming model requires paddr and vaddr be passed in seperate
- *    AUX registers (*_IV*L and *_PTAG respectively) irrespective of whether the
- *    caches actually alias or not.
- * -  For HS38, only the aliasing I-cache configuration uses the PTAG reg
- *    (non aliasing I-cache version doesn't; while D-cache can't possibly alias)
- */
-static inline
 void __cache_line_loop_v3(phys_addr_t paddr, unsigned long vaddr,
 			  unsigned long sz, const int op, const int full_page)
 {
@@ -350,17 +281,6 @@ void __cache_line_loop_v3(phys_addr_t paddr, unsigned long vaddr,
 #ifndef USE_RGN_FLSH
 
 /*
- * In HS38x (MMU v4), I-cache is VIPT (can alias), D-cache is PIPT
- * Here's how cache ops are implemented
- *
- *  - D-cache: only paddr needed (in DC_IVDL/DC_FLDL)
- *  - I-cache Non Aliasing: Despite VIPT, only paddr needed (in IC_IVIL)
- *  - I-cache Aliasing: Both vaddr and paddr needed (in IC_IVIL, IC_PTAG
- *    respectively, similar to MMU v3 programming model, hence
- *    __cache_line_loop_v3() is used)
- *
- * If PAE40 is enabled, independent of aliasing considerations, the higher bits
- * needs to be written into PTAG_HI
  */
 static inline
 void __cache_line_loop_v4(phys_addr_t paddr, unsigned long vaddr,
@@ -460,11 +380,9 @@ void __cache_line_loop_v4(phys_addr_t paddr, unsigned long vaddr,
 
 #endif
 
-#if (CONFIG_ARC_MMU_VER < 3)
-#define __cache_line_loop	__cache_line_loop_v2
-#elif (CONFIG_ARC_MMU_VER == 3)
+#ifdef CONFIG_ARC_MMU_V3
 #define __cache_line_loop	__cache_line_loop_v3
-#elif (CONFIG_ARC_MMU_VER > 3)
+#else
 #define __cache_line_loop	__cache_line_loop_v4
 #endif
 
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 9c7c68247289..8696829d37c0 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -1,51 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * TLB Management (flush/create/diagnostics) for ARC700
+ * TLB Management (flush/create/diagnostics) for MMUv3 and MMUv4
  *
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  *
- * vineetg: Aug 2011
- *  -Reintroduce duplicate PD fixup - some customer chips still have the issue
- *
- * vineetg: May 2011
- *  -No need to flush_cache_page( ) for each call to update_mmu_cache()
- *   some of the LMBench tests improved amazingly
- *      = page-fault thrice as fast (75 usec to 28 usec)
- *      = mmap twice as fast (9.6 msec to 4.6 msec),
- *      = fork (5.3 msec to 3.7 msec)
- *
- * vineetg: April 2011 :
- *  -MMU v3: PD{0,1} bits layout changed: They don't overlap anymore,
- *      helps avoid a shift when preparing PD0 from PTE
- *
- * vineetg: April 2011 : Preparing for MMU V3
- *  -MMU v2/v3 BCRs decoded differently
- *  -Remove TLB_SIZE hardcoding as it's variable now: 256 or 512
- *  -tlb_entry_erase( ) can be void
- *  -local_flush_tlb_range( ):
- *      = need not "ceil" @end
- *      = walks MMU only if range spans < 32 entries, as opposed to 256
- *
- * Vineetg: Sept 10th 2008
- *  -Changes related to MMU v2 (Rel 4.8)
- *
- * Vineetg: Aug 29th 2008
- *  -In TLB Flush operations (Metal Fix MMU) there is a explicit command to
- *    flush Micro-TLBS. If TLB Index Reg is invalid prior to TLBIVUTLB cmd,
- *    it fails. Thus need to load it with ANY valid value before invoking
- *    TLBIVUTLB cmd
- *
- * Vineetg: Aug 21th 2008:
- *  -Reduced the duration of IRQ lockouts in TLB Flush routines
- *  -Multiple copies of TLB erase code separated into a "single" function
- *  -In TLB Flush routines, interrupt disabling moved UP to retrieve ASID
- *       in interrupt-safe region.
- *
- * Vineetg: April 23rd Bug #93131
- *    Problem: tlb_flush_kernel_range() doesn't do anything if the range to
- *              flush is more than the size of TLB itself.
- *
- * Rahul Trivedi : Codito Technologies 2004
  */
 
 #include <linux/module.h>
@@ -57,47 +15,6 @@
 #include <asm/mmu_context.h>
 #include <asm/mmu.h>
 
-/*			Need for ARC MMU v2
- *
- * ARC700 MMU-v1 had a Joint-TLB for Code and Data and is 2 way set-assoc.
- * For a memcpy operation with 3 players (src/dst/code) such that all 3 pages
- * map into same set, there would be contention for the 2 ways causing severe
- * Thrashing.
- *
- * Although J-TLB is 2 way set assoc, ARC700 caches J-TLB into uTLBS which has
- * much higher associativity. u-D-TLB is 8 ways, u-I-TLB is 4 ways.
- * Given this, the thrashing problem should never happen because once the 3
- * J-TLB entries are created (even though 3rd will knock out one of the prev
- * two), the u-D-TLB and u-I-TLB will have what is required to accomplish memcpy
- *
- * Yet we still see the Thrashing because a J-TLB Write cause flush of u-TLBs.
- * This is a simple design for keeping them in sync. So what do we do?
- * The solution which James came up was pretty neat. It utilised the assoc
- * of uTLBs by not invalidating always but only when absolutely necessary.
- *
- * - Existing TLB commands work as before
- * - New command (TLBWriteNI) for TLB write without clearing uTLBs
- * - New command (TLBIVUTLB) to invalidate uTLBs.
- *
- * The uTLBs need only be invalidated when pages are being removed from the
- * OS page table. If a 'victim' TLB entry is being overwritten in the main TLB
- * as a result of a miss, the removed entry is still allowed to exist in the
- * uTLBs as it is still valid and present in the OS page table. This allows the
- * full associativity of the uTLBs to hide the limited associativity of the main
- * TLB.
- *
- * During a miss handler, the new "TLBWriteNI" command is used to load
- * entries without clearing the uTLBs.
- *
- * When the OS page table is updated, TLB entries that may be associated with a
- * removed page are removed (flushed) from the TLB using TLBWrite. In this
- * circumstance, the uTLBs must also be cleared. This is done by using the
- * existing TLBWrite command. An explicit IVUTLB is also required for those
- * corner cases when TLBWrite was not executed at all because the corresp
- * J-TLB entry got evicted/replaced.
- */
-
-
 /* A copy of the ASID from the PID reg is kept in asid_cache */
 DEFINE_PER_CPU(unsigned int, asid_cache) = MM_CTXT_FIRST_CYCLE;
 
@@ -120,32 +37,10 @@ static inline void __tlb_entry_erase(void)
 
 static void utlb_invalidate(void)
 {
-#if (CONFIG_ARC_MMU_VER >= 2)
-
-#if (CONFIG_ARC_MMU_VER == 2)
-	/* MMU v2 introduced the uTLB Flush command.
-	 * There was however an obscure hardware bug, where uTLB flush would
-	 * fail when a prior probe for J-TLB (both totally unrelated) would
-	 * return lkup err - because the entry didn't exist in MMU.
-	 * The Workaround was to set Index reg with some valid value, prior to
-	 * flush. This was fixed in MMU v3
-	 */
-	unsigned int idx;
-
-	/* make sure INDEX Reg is valid */
-	idx = read_aux_reg(ARC_REG_TLBINDEX);
-
-	/* If not write some dummy val */
-	if (unlikely(idx & TLB_LKUP_ERR))
-		write_aux_reg(ARC_REG_TLBINDEX, 0xa);
-#endif
-
 	write_aux_reg(ARC_REG_TLBCOMMAND, TLBIVUTLB);
-#endif
-
 }
 
-#if (CONFIG_ARC_MMU_VER < 4)
+#ifdef CONFIG_ARC_MMU_V3
 
 static inline unsigned int tlb_entry_lkup(unsigned long vaddr_n_asid)
 {
@@ -206,7 +101,7 @@ static void tlb_entry_insert(unsigned int pd0, pte_t pd1)
 	write_aux_reg(ARC_REG_TLBCOMMAND, TLBWrite);
 }
 
-#else	/* CONFIG_ARC_MMU_VER >= 4) */
+#else	/* MMUv4 */
 
 static void tlb_entry_erase(unsigned int vaddr_n_asid)
 {
@@ -706,14 +601,6 @@ void read_decode_mmu_bcr(void)
 {
 	struct cpuinfo_arc_mmu *mmu = &cpuinfo_arc700[smp_processor_id()].mmu;
 	unsigned int tmp;
-	struct bcr_mmu_1_2 {
-#ifdef CONFIG_CPU_BIG_ENDIAN
-		unsigned int ver:8, ways:4, sets:4, u_itlb:8, u_dtlb:8;
-#else
-		unsigned int u_dtlb:8, u_itlb:8, sets:4, ways:4, ver:8;
-#endif
-	} *mmu2;
-
 	struct bcr_mmu_3 {
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	unsigned int ver:8, ways:4, sets:4, res:3, sasid:1, pg_sz:4,
@@ -738,23 +625,14 @@ void read_decode_mmu_bcr(void)
 	tmp = read_aux_reg(ARC_REG_MMU_BCR);
 	mmu->ver = (tmp >> 24);
 
-	if (is_isa_arcompact()) {
-		if (mmu->ver <= 2) {
-			mmu2 = (struct bcr_mmu_1_2 *)&tmp;
-			mmu->pg_sz_k = TO_KB(0x2000);
-			mmu->sets = 1 << mmu2->sets;
-			mmu->ways = 1 << mmu2->ways;
-			mmu->u_dtlb = mmu2->u_dtlb;
-			mmu->u_itlb = mmu2->u_itlb;
-		} else {
-			mmu3 = (struct bcr_mmu_3 *)&tmp;
-			mmu->pg_sz_k = 1 << (mmu3->pg_sz - 1);
-			mmu->sets = 1 << mmu3->sets;
-			mmu->ways = 1 << mmu3->ways;
-			mmu->u_dtlb = mmu3->u_dtlb;
-			mmu->u_itlb = mmu3->u_itlb;
-			mmu->sasid = mmu3->sasid;
-		}
+	if (is_isa_arcompact() && mmu->ver == 3) {
+		mmu3 = (struct bcr_mmu_3 *)&tmp;
+		mmu->pg_sz_k = 1 << (mmu3->pg_sz - 1);
+		mmu->sets = 1 << mmu3->sets;
+		mmu->ways = 1 << mmu3->ways;
+		mmu->u_dtlb = mmu3->u_dtlb;
+		mmu->u_itlb = mmu3->u_itlb;
+		mmu->sasid = mmu3->sasid;
 	} else {
 		mmu4 = (struct bcr_mmu_4 *)&tmp;
 		mmu->pg_sz_k = 1 << (mmu4->sz0 - 1);
@@ -815,22 +693,17 @@ void arc_mmu_init(void)
 
 	/*
 	 * Ensure that MMU features assumed by kernel exist in hardware.
-	 * For older ARC700 cpus, it has to be exact match, since the MMU
-	 * revisions were not backwards compatible (MMUv3 TLB layout changed
-	 * so even if kernel for v2 didn't use any new cmds of v3, it would
-	 * still not work.
-	 * For HS cpus, MMUv4 was baseline and v5 is backwards compatible
-	 * (will run older software).
+	 *  - For older ARC700 cpus, only v3 supported
+	 *  - For HS cpus, v4 was baseline and v5 is backwards compatible
+	 *    (will run older software).
 	 */
-	if (is_isa_arcompact() && mmu->ver == CONFIG_ARC_MMU_VER)
+	if (is_isa_arcompact() && mmu->ver == 3)
 		compat = 1;
-	else if (is_isa_arcv2() && mmu->ver >= CONFIG_ARC_MMU_VER)
+	else if (is_isa_arcv2() && mmu->ver >= 4)
 		compat = 1;
 
-	if (!compat) {
-		panic("MMU ver %d doesn't match kernel built for %d...\n",
-		      mmu->ver, CONFIG_ARC_MMU_VER);
-	}
+	if (!compat)
+		panic("MMU ver %d doesn't match kernel built for\n", mmu->ver);
 
 	if (mmu->pg_sz_k != TO_KB(PAGE_SIZE))
 		panic("MMU pg size != PAGE_SIZE (%luk)\n", TO_KB(PAGE_SIZE));
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index 062fae46c3f8..96c3a5de9dd4 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -39,7 +39,6 @@
 #include <asm/arcregs.h>
 #include <asm/cache.h>
 #include <asm/processor.h>
-#include <asm/tlb-mmu1.h>
 
 #ifdef CONFIG_ISA_ARCOMPACT
 ;-----------------------------------------------------------------
@@ -279,7 +278,7 @@ ex_saved_reg1:
 ; Commit the TLB entry into MMU
 
 .macro COMMIT_ENTRY_TO_MMU
-#if (CONFIG_ARC_MMU_VER < 4)
+#ifdef CONFIG_ARC_MMU_V3
 
 	/* Get free TLB slot: Set = computed from vaddr, way = random */
 	sr  TLBGetIndex, [ARC_REG_TLBCOMMAND]
@@ -375,13 +374,6 @@ ENTRY(EV_TLBMissD)
 
 	CONV_PTE_TO_TLB
 
-#if (CONFIG_ARC_MMU_VER == 1)
-	; MMU with 2 way set assoc J-TLB, needs some help in pathetic case of
-	; memcpy where 3 parties contend for 2 ways, ensuing a livelock.
-	; But only for old MMU or one with Metal Fix
-	TLB_WRITE_HEURISTICS
-#endif
-
 	COMMIT_ENTRY_TO_MMU
 	TLBMISS_RESTORE_REGS
 EV_TLBMissD_fast_ret:	; additional label for VDK OS-kit instrumentation
-- 
2.25.1

