Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C11377FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhEJJpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:45:53 -0400
Received: from foss.arm.com ([217.140.110.172]:52428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhEJJpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:45:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 439C21682;
        Mon, 10 May 2021 02:44:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 17C763F73B;
        Mon, 10 May 2021 02:44:40 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mark.rutland@arm.com, mattst88@gmail.com,
        monstr@monstr.eu, mpe@ellerman.id.au, nickhu@andestech.com,
        palmer@dabbelt.com, paulus@samba.org, paul.walmsley@sifive.com,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
Subject: [PATCH 32/33] locking/atomic: delete !ARCH_ATOMIC remnants
Date:   Mon, 10 May 2021 10:37:52 +0100
Message-Id: <20210510093753.40683-33-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all architectures implement ARCH_ATOMIC, we can make it
mandatory, removing the Kconfig symbol and logic for !ARCH_ATOMIC.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/Kconfig                    |    3 -
 arch/alpha/Kconfig              |    1 -
 arch/arc/Kconfig                |    1 -
 arch/arm/Kconfig                |    1 -
 arch/arm64/Kconfig              |    1 -
 arch/csky/Kconfig               |    1 -
 arch/h8300/Kconfig              |    1 -
 arch/hexagon/Kconfig            |    1 -
 arch/ia64/Kconfig               |    1 -
 arch/m68k/Kconfig               |    1 -
 arch/microblaze/Kconfig         |    1 -
 arch/mips/Kconfig               |    1 -
 arch/nds32/Kconfig              |    1 -
 arch/nios2/Kconfig              |    1 -
 arch/openrisc/Kconfig           |    1 -
 arch/parisc/Kconfig             |    1 -
 arch/powerpc/Kconfig            |    1 -
 arch/riscv/Kconfig              |    1 -
 arch/s390/Kconfig               |    1 -
 arch/sh/Kconfig                 |    1 -
 arch/sparc/Kconfig              |    1 -
 arch/um/Kconfig                 |    1 -
 arch/x86/Kconfig                |    1 -
 arch/xtensa/Kconfig             |    1 -
 include/asm-generic/atomic.h    |   44 +-
 include/asm-generic/atomic64.h  |   29 -
 include/asm-generic/cmpxchg.h   |   21 -
 include/linux/atomic-fallback.h | 2595 ---------------------------------------
 include/linux/atomic.h          |    4 -
 scripts/atomic/check-atomics.sh |    1 -
 scripts/atomic/gen-atomics.sh   |    1 -
 31 files changed, 3 insertions(+), 2718 deletions(-)
 delete mode 100644 include/linux/atomic-fallback.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 3fb3b12d4a95..c45b770d3579 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,9 +11,6 @@ source "arch/$(SRCARCH)/Kconfig"
 
 menu "General architecture-dependent options"
 
-config ARCH_ATOMIC
-	bool
-
 config CRASH_CORE
 	bool
 
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 7920fc2e2a2a..5998106faa60 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -2,7 +2,6 @@
 config ALPHA
 	bool
 	default y
-	select ARCH_ATOMIC
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 098ecc72d048..2d98501c0897 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,7 +6,6 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
-	select ARCH_ATOMIC
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7334a6643b9..24804f11302d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,7 +3,6 @@ config ARM
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 62ab429d1f42..9f1d8566bbf9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,7 +9,6 @@ config ARM64
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
-	select ARCH_ATOMIC
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3521f14bcd96..8de5b987edb9 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -2,7 +2,6 @@
 config CSKY
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index bdf05ad3206a..3e3e0f16f7e0 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -2,7 +2,6 @@
 config H8300
         def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select BINFMT_FLAT_OLD_ALWAYS_RAM
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 1368954ef679..44a409967af1 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -5,7 +5,6 @@ comment "Linux Kernel Configuration for Hexagon"
 config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
 	# Other pending projects/to-do items.
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index c5414dcd5d0d..279252e3e0f7 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -8,7 +8,6 @@ menu "Processor type and features"
 
 config IA64
 	bool
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index d1d91ac47f51..372e4e69c43a 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,7 +3,6 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 5a52922dc225..0660f47012bc 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -2,7 +2,6 @@
 config MICROBLAZE
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_NO_SWAP
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 55b4da96872f..ed51970c08e7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3,7 +3,6 @@ config MIPS
 	bool
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
-	select ARCH_ATOMIC
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 352913573aee..62313902d75d 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -7,7 +7,6 @@
 config NDS32
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 67dae88c5b53..c24955c81c92 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -2,7 +2,6 @@
 config NIOS2
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 8c50bc9674f5..591acc5990dc 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,7 +7,6 @@
 config OPENRISC
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index bfa120a4add1..bde9907bc5b2 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -2,7 +2,6 @@
 config PARISC
 	def_bool y
 	select ARCH_32BIT_OFF_T if !64BIT
-	select ARCH_ATOMIC
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d143c2b616f0..088dd2afcfe4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -118,7 +118,6 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
-	select ARCH_ATOMIC
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c59b9f4a9d62..a8ad8eb76120 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,7 +12,6 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	select ARCH_ATOMIC
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 85374a36c69e..b4c7c34069f8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -58,7 +58,6 @@ config S390
 	# Note: keep this list sorted alphabetically
 	#
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
-	select ARCH_ATOMIC
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d2925cbb6fa4..68129537e350 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,7 +2,6 @@
 config SUPERH
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && MMU
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
 	select ARCH_HAVE_CUSTOM_GPIO_H
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 46790083e918..164a5254c91c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,7 +13,6 @@ config 64BIT
 config SPARC
 	bool
 	default y
-	select ARCH_ATOMIC
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select DMA_OPS
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4370a9521ea4..57cfd9a1c082 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,7 +5,6 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
-	select ARCH_ATOMIC
 	select ARCH_EPHEMERAL_INODES
 	select ARCH_HAS_KCOV
 	select ARCH_NO_PREEMPT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 11a27563033d..0045e1b44190 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -58,7 +58,6 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
-	select ARCH_ATOMIC
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 39bb9bdae6b1..2332b2156993 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -2,7 +2,6 @@
 config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_DMA_PREP_COHERENT if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 649060fa0fe8..04b8be9f1a77 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -12,14 +12,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#ifdef CONFIG_ARCH_ATOMIC
-#define __ga_cmpxchg	arch_cmpxchg
-#define __ga_xchg	arch_xchg
-#else
-#define __ga_cmpxchg	cmpxchg
-#define __ga_xchg	xchg
-#endif
-
 #ifdef CONFIG_SMP
 
 /* we can build all atomic primitives from cmpxchg */
@@ -30,7 +22,7 @@ static inline void generic_atomic_##op(int i, atomic_t *v)		\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
+	while ((old = arch_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 }
 
@@ -40,7 +32,7 @@ static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
+	while ((old = arch_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
 	return c c_op i;						\
@@ -52,7 +44,7 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
+	while ((old = arch_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
 	return c;							\
@@ -120,11 +112,6 @@ ATOMIC_OP(xor, ^)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#undef __ga_cmpxchg
-#undef __ga_xchg
-
-#ifdef CONFIG_ARCH_ATOMIC
-
 #define arch_atomic_add_return			generic_atomic_add_return
 #define arch_atomic_sub_return			generic_atomic_sub_return
 
@@ -146,29 +133,4 @@ ATOMIC_OP(xor, ^)
 #define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
 #define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
 
-#else /* CONFIG_ARCH_ATOMIC */
-
-#define atomic_add_return		generic_atomic_add_return
-#define atomic_sub_return		generic_atomic_sub_return
-
-#define atomic_fetch_add		generic_atomic_fetch_add
-#define atomic_fetch_sub		generic_atomic_fetch_sub
-#define atomic_fetch_and		generic_atomic_fetch_and
-#define atomic_fetch_or			generic_atomic_fetch_or
-#define atomic_fetch_xor		generic_atomic_fetch_xor
-
-#define atomic_add			generic_atomic_add
-#define atomic_sub			generic_atomic_sub
-#define atomic_and			generic_atomic_and
-#define atomic_or			generic_atomic_or
-#define atomic_xor			generic_atomic_xor
-
-#define atomic_read(v)			READ_ONCE((v)->counter)
-#define atomic_set(v, i)		WRITE_ONCE(((v)->counter), (i))
-
-#define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
-#define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
-
-#endif /* CONFIG_ARCH_ATOMIC */
-
 #endif /* __ASM_GENERIC_ATOMIC_H */
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index c8c7d9fae820..100d24b02e52 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -49,8 +49,6 @@ extern s64 generic_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
 extern s64 generic_atomic64_xchg(atomic64_t *v, s64 new);
 extern s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
 
-#ifdef CONFIG_ARCH_ATOMIC
-
 #define arch_atomic64_read		generic_atomic64_read
 #define arch_atomic64_set		generic_atomic64_set
 #define arch_atomic64_set_release	generic_atomic64_set
@@ -74,31 +72,4 @@ extern s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
 #define arch_atomic64_xchg		generic_atomic64_xchg
 #define arch_atomic64_fetch_add_unless	generic_atomic64_fetch_add_unless
 
-#else /* CONFIG_ARCH_ATOMIC */
-
-#define atomic64_read			generic_atomic64_read
-#define atomic64_set			generic_atomic64_set
-#define atomic64_set_release		generic_atomic64_set
-
-#define atomic64_add			generic_atomic64_add
-#define atomic64_add_return		generic_atomic64_add_return
-#define atomic64_fetch_add		generic_atomic64_fetch_add
-#define atomic64_sub			generic_atomic64_sub
-#define atomic64_sub_return		generic_atomic64_sub_return
-#define atomic64_fetch_sub		generic_atomic64_fetch_sub
-
-#define atomic64_and			generic_atomic64_and
-#define atomic64_fetch_and		generic_atomic64_fetch_and
-#define atomic64_or			generic_atomic64_or
-#define atomic64_fetch_or		generic_atomic64_fetch_or
-#define atomic64_xor			generic_atomic64_xor
-#define atomic64_fetch_xor		generic_atomic64_fetch_xor
-
-#define atomic64_dec_if_positive	generic_atomic64_dec_if_positive
-#define atomic64_cmpxchg		generic_atomic64_cmpxchg
-#define atomic64_xchg			generic_atomic64_xchg
-#define atomic64_fetch_add_unless	generic_atomic64_fetch_add_unless
-
-#endif /* CONFIG_ARCH_ATOMIC */
-
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index 98c931199089..dca4419922a9 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -97,8 +97,6 @@ unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
 	__generic_cmpxchg64_local((ptr), (o), (n))
 
 
-#ifdef CONFIG_ARCH_ATOMIC
-
 #ifndef arch_xchg
 #define arch_xchg		generic_xchg
 #endif
@@ -114,23 +112,4 @@ unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
 #define arch_cmpxchg		arch_cmpxchg_local
 #define arch_cmpxchg64		arch_cmpxchg64_local
 
-#else /* CONFIG_ARCH_ATOMIC */
-
-#ifndef xchg
-#define xchg			generic_xchg
-#endif
-
-#ifndef cmpxchg_local
-#define cmpxchg_local		generic_cmpxchg_local
-#endif
-
-#ifndef cmpxchg64_local
-#define cmpxchg64_local		generic_cmpxchg64_local
-#endif
-
-#define cmpxchg			cmpxchg_local
-#define cmpxchg64		cmpxchg64_local
-
-#endif /* CONFIG_ARCH_ATOMIC */
-
 #endif /* __ASM_GENERIC_CMPXCHG_H */
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
deleted file mode 100644
index 2a3f55d98be9..000000000000
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 4f8d83f9e480..ed1d3ffd5b9d 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -77,12 +77,8 @@
 	__ret;								\
 })
 
-#ifdef CONFIG_ARCH_ATOMIC
 #include <linux/atomic-arch-fallback.h>
 #include <asm-generic/atomic-instrumented.h>
-#else
-#include <linux/atomic-fallback.h>
-#endif
 
 #include <asm-generic/atomic-long.h>
 
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index 82748d42ecc5..9c7fbd4bcbce 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -17,7 +17,6 @@ cat <<EOF |
 asm-generic/atomic-instrumented.h
 asm-generic/atomic-long.h
 linux/atomic-arch-fallback.h
-linux/atomic-fallback.h
 EOF
 while read header; do
 	OLDSUM="$(tail -n 1 ${LINUXDIR}/include/${header})"
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index d29e159ef489..f776a574224d 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -11,7 +11,6 @@ cat <<EOF |
 gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
 gen-atomic-long.sh              asm-generic/atomic-long.h
 gen-atomic-fallback.sh          linux/atomic-arch-fallback.h		arch_
-gen-atomic-fallback.sh          linux/atomic-fallback.h
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
-- 
2.11.0

