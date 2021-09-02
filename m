Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F263FEAB6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbhIBIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhIBIhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 04:37:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6F9C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=cXg0RPAi4zVo2Uc+njpoIh1CBP8OzRgqQYk/QIAnu7I=; t=1630571778; x=1631781378; 
        b=xtXz9o79cWDo1gHLWRiL7J/vn1cWV0bo8mrwvFBLJDZSoRi0eOLlIqI68B7MDTG5VO1btGcMJxw
        7TymHnpSgn7mb8ybJ20cL6NpR5xB5WfAkCgSmHlWNXVQ0+fhpzk7Vuh43odfN1VGs5t/LFjmgJ1gM
        0fiq9N8Bcpo0sAqoljjh985p38KwgXb5G0OcYGlyw6cA/t8AQtSwG1wLy9McMHD7LYAQkWuKlq5k1
        uU3GPdkITieGlO9yzJ1YyAbeL3ibo7rJxP0EkY0Grn+KkIA+Zh4tsCmL1qgBqu6WuE/ocxMwYt0eo
        4Hsiz6KpoNLs3sjQxYwmWFeHOAlxm8MKdxEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mLiCd-001X8h-Vi; Thu, 02 Sep 2021 10:36:08 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] um: don't use CONFIG_X86_{32,64} symbols on x86
Date:   Thu,  2 Sep 2021 10:36:05 +0200
Message-Id: <20210902103604.c750ebe53919.Icb5c49998c55b87c8584d46894c01b114ae2e661@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The CONFIG_X86_32 and CONFIG_X86_64 symbols are used by
both "real" x86 architecture builds and ARCH=um today.
However, clearly most people and places in the code are
treating it as the architecture Kconfig (technically
that's just CONFIG_X86) and use it to indicate that the
architecture is X86 in 32- or 64-bit flavour.

This has caused a fair amount of issues in the past,
for example drivers not building because use x86 macros
or similar under CONFIG_X86_{32,64} ifdef, and then we
find build reports and add "!UML" to their Kconfig etc.

However, this is error-prone and a kind of whack-a-mole
game, even with the build bots reporting things.

Additionally, it's rather confusing anyway that we have
two places in the Kconfig that define these two symbols
(arch/x86/Kconfig and arch/x86/um/Kconfig).

Rename CONFIG_X86_{32,64}  TO CONFIG_X86_{32,64}_UML in
arch/x86/um/Kconfig and adjust the code accordingly. A
git grep shows many uses across the tree, but most are
in arch/x86/ (where only arch/x86/um/ is relevant) and
various drivers that depend on X86/X86_64 already and
really should not be enabled on UML. A handful of cases
exist where we actually _do_ want both, e.g. lzodefs.h.

There's another class of uses (e.g. in netfilter) where
actually the code already has !UML checks, so we can
delete those now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - fix arch/x86/include/asm/vermagic.h
   (last-minute changes to Kconfig.cpu broke that)
---
 arch/um/include/asm/page.h          |  2 +-
 arch/x86/Kconfig.cpu                | 16 ++++++++--------
 arch/x86/include/asm/vermagic.h     |  2 +-
 arch/x86/um/Kconfig                 |  4 ++--
 arch/x86/um/Makefile                |  4 ++--
 arch/x86/um/asm/archparam.h         |  2 +-
 arch/x86/um/asm/barrier.h           |  6 +++---
 arch/x86/um/asm/checksum.h          |  2 +-
 arch/x86/um/asm/elf.h               |  2 +-
 arch/x86/um/asm/mm_context.h        |  2 +-
 arch/x86/um/asm/module.h            |  2 +-
 arch/x86/um/asm/processor.h         |  2 +-
 arch/x86/um/asm/ptrace.h            |  4 ++--
 arch/x86/um/asm/syscall.h           |  2 +-
 arch/x86/um/asm/vm-flags.h          |  2 +-
 arch/x86/um/os-Linux/Makefile       |  2 +-
 arch/x86/um/signal.c                | 20 ++++++++++----------
 drivers/misc/lkdtm/bugs.c           |  2 +-
 fs/afs/main.c                       |  4 ++--
 fs/ioctl.c                          |  4 ++--
 fs/xfs/xfs_ioctl32.h                |  2 +-
 include/linux/falloc.h              |  2 +-
 kernel/bpf/verifier.c               |  3 ++-
 kernel/sysctl.c                     |  2 +-
 kernel/trace/blktrace.c             |  4 ++--
 lib/crypto/Kconfig                  |  2 +-
 lib/lzo/lzodefs.h                   |  6 +++---
 net/netfilter/Makefile              |  2 --
 net/netfilter/nf_tables_api.c       |  2 +-
 net/netfilter/nft_lookup.c          |  2 +-
 net/netfilter/nft_set_pipapo.c      |  2 +-
 net/netfilter/nft_set_pipapo_avx2.h |  4 ++--
 security/Kconfig                    |  2 +-
 sound/core/control_compat.c         |  2 +-
 34 files changed, 61 insertions(+), 62 deletions(-)

diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 95af12e82a32..6e75a1b497e7 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -116,7 +116,7 @@ extern unsigned long uml_physmem;
 
 #endif	/* __ASSEMBLY__ */
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 #define __HAVE_ARCH_GATE_AREA 1
 #endif
 
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 814fe0d349b0..78929e1fd4f8 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -3,7 +3,7 @@
 choice
 	prompt "Processor family"
 	default M686 if X86_32
-	default GENERIC_CPU if X86_64
+	default GENERIC_CPU if X86_64 || X86_64_UML
 	help
 	  This is the processor type of your CPU. This information is
 	  used for optimizing purposes. In order to compile a kernel
@@ -260,7 +260,7 @@ config MVIAC7
 
 config MPSC
 	bool "Intel P4 / older Netburst based Xeon"
-	depends on X86_64
+	depends on X86_64 || X86_64_UML
 	help
 	  Optimize for Intel Pentium 4, Pentium D and older Nocona/Dempsey
 	  Xeon CPUs with Intel 64bit which is compatible with x86-64.
@@ -289,7 +289,7 @@ config MATOM
 
 config GENERIC_CPU
 	bool "Generic-x86-64"
-	depends on X86_64
+	depends on X86_64 || X86_64_UML
 	help
 	  Generic x86-64 CPU.
 	  Run equally well on all x86-64 CPUs.
@@ -359,26 +359,26 @@ config X86_USE_3DNOW
 #
 config X86_P6_NOP
 	def_bool y
-	depends on X86_64
+	depends on X86_64 || X86_64_UML
 	depends on (MCORE2 || MPENTIUM4 || MPSC)
 
 config X86_TSC
 	def_bool y
-	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MATOM) || X86_64
+	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MATOM) || X86_64 || X86_64_UML
 
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_PAE || X86_64 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586TSC || M586MMX || MATOM || MGEODE_LX || MGEODEGX1 || MK6 || MK7 || MK8
+	depends on X86_PAE || X86_64 || X86_64_UML || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586TSC || M586MMX || MATOM || MGEODE_LX || MGEODEGX1 || MK6 || MK7 || MK8
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
 config X86_CMOV
 	def_bool y
-	depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || MATOM || MGEODE_LX)
+	depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || X86_64_UML || MATOM || MGEODE_LX)
 
 config X86_MINIMUM_CPU_FAMILY
 	int
-	default "64" if X86_64
+	default "64" if X86_64 || X86_64_UML
 	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
diff --git a/arch/x86/include/asm/vermagic.h b/arch/x86/include/asm/vermagic.h
index 75884d2cdec3..be5e55c7dd54 100644
--- a/arch/x86/include/asm/vermagic.h
+++ b/arch/x86/include/asm/vermagic.h
@@ -3,7 +3,7 @@
 #ifndef _ASM_VERMAGIC_H
 #define _ASM_VERMAGIC_H
 
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)
 /* X86_64 does not define MODULE_PROC_FAMILY */
 #elif defined CONFIG_M486SX
 #define MODULE_PROC_FAMILY "486SX "
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 95d26a69088b..d63d68de6a06 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -14,7 +14,7 @@ config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
 	default "$(SUBARCH)" != "i386"
 
-config X86_32
+config X86_32_UML
 	def_bool !64BIT
 	select ARCH_32BIT_OFF_T
 	select ARCH_WANT_IPC_PARSE_VERSION
@@ -23,7 +23,7 @@ config X86_32
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 
-config X86_64
+config X86_64_UML
 	def_bool 64BIT
 	select MODULES_USE_ELF_RELA
 
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 5ccb18290d71..9d170a3b4029 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
 #
 
-ifeq ($(CONFIG_X86_32),y)
+ifeq ($(CONFIG_X86_32_UML),y)
 	BITS := 32
 else
 	BITS := 64
@@ -15,7 +15,7 @@ obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
 	mem_$(BITS).o subarch.o os-$(OS)/
 
-ifeq ($(CONFIG_X86_32),y)
+ifeq ($(CONFIG_X86_32_UML),y)
 
 obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
diff --git a/arch/x86/um/asm/archparam.h b/arch/x86/um/asm/archparam.h
index c17cf68dda0f..0629d3c45c63 100644
--- a/arch/x86/um/asm/archparam.h
+++ b/arch/x86/um/asm/archparam.h
@@ -7,7 +7,7 @@
 #ifndef __UM_ARCHPARAM_H
 #define __UM_ARCHPARAM_H
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 
 #ifdef CONFIG_X86_PAE
 #define LAST_PKMAP 512
diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index 165be7f9a964..39df71069790 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -9,19 +9,19 @@
  * And yes, this is required on UP too when we're talking
  * to devices.
  */
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 
 #define mb()	alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
 #define rmb()	alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
 #define wmb()	alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
 
-#else /* CONFIG_X86_32 */
+#else /* CONFIG_X86_32_UML */
 
 #define mb()	asm volatile("mfence" : : : "memory")
 #define rmb()	asm volatile("lfence" : : : "memory")
 #define wmb()	asm volatile("sfence" : : : "memory")
 
-#endif /* CONFIG_X86_32 */
+#endif /* CONFIG_X86_32_UML */
 
 #include <asm-generic/barrier.h>
 
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index b07824500363..b76590a41a9a 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -110,7 +110,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	return (__force __sum16)sum;
 }
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 # include "checksum_32.h"
 #else
 # include "checksum_64.h"
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index dcaf3b38a9e0..58b420cc98b1 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -8,7 +8,7 @@
 #include <asm/user.h>
 #include <skas.h>
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 
 #define R_386_NONE	0
 #define R_386_32	1
diff --git a/arch/x86/um/asm/mm_context.h b/arch/x86/um/asm/mm_context.h
index 4a73d63e4760..448a27b8b6cc 100644
--- a/arch/x86/um/asm/mm_context.h
+++ b/arch/x86/um/asm/mm_context.h
@@ -59,7 +59,7 @@ typedef struct uml_ldt {
 	(info)->seg_not_present	== 1	&& \
 	(info)->useable		== 0	)
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_X86_64_UML
 #define LDT_empty(info) (_LDT_empty(info) && ((info)->lm == 0))
 #else
 #define LDT_empty(info) (_LDT_empty(info))
diff --git a/arch/x86/um/asm/module.h b/arch/x86/um/asm/module.h
index a3b061d66082..f87e855ac4f1 100644
--- a/arch/x86/um/asm/module.h
+++ b/arch/x86/um/asm/module.h
@@ -7,7 +7,7 @@ struct mod_arch_specific
 {
 };
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
index 478710384b34..2506d2cc9ce8 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -6,7 +6,7 @@
 /* include faultinfo structure */
 #include <sysdep/faultinfo.h>
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 # include "processor_32.h"
 #else
 # include "processor_64.h"
diff --git a/arch/x86/um/asm/ptrace.h b/arch/x86/um/asm/ptrace.h
index 83822fd42204..011030b46c29 100644
--- a/arch/x86/um/asm/ptrace.h
+++ b/arch/x86/um/asm/ptrace.h
@@ -3,7 +3,7 @@
 #define __UM_X86_PTRACE_H
 
 #include <linux/compiler.h>
-#ifndef CONFIG_X86_32
+#ifndef CONFIG_X86_32_UML
 #define __FRAME_OFFSETS /* Needed to get the R* macros */
 #endif
 #include <asm/ptrace-generic.h>
@@ -46,7 +46,7 @@ static inline long regs_return_value(struct pt_regs *regs)
  */
 struct user_desc;
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 
 extern int ptrace_get_thread_area(struct task_struct *child, int idx,
                                   struct user_desc __user *user_desc);
diff --git a/arch/x86/um/asm/syscall.h b/arch/x86/um/asm/syscall.h
index 56a2f0913e3c..a5bdfd50c94f 100644
--- a/arch/x86/um/asm/syscall.h
+++ b/arch/x86/um/asm/syscall.h
@@ -11,7 +11,7 @@ typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
 
 static inline int syscall_get_arch(struct task_struct *task)
 {
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 	return AUDIT_ARCH_I386;
 #else
 	return AUDIT_ARCH_X86_64;
diff --git a/arch/x86/um/asm/vm-flags.h b/arch/x86/um/asm/vm-flags.h
index df7a3896f5dd..5b63a4e5a12a 100644
--- a/arch/x86/um/asm/vm-flags.h
+++ b/arch/x86/um/asm/vm-flags.h
@@ -7,7 +7,7 @@
 #ifndef __VM_FLAGS_X86_H
 #define __VM_FLAGS_X86_H
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
index 253bfb8cb702..11922e8ca4d6 100644
--- a/arch/x86/um/os-Linux/Makefile
+++ b/arch/x86/um/os-Linux/Makefile
@@ -5,7 +5,7 @@
 
 obj-y = registers.o task_size.o mcontext.o
 
-obj-$(CONFIG_X86_32) += tls.o
+obj-$(CONFIG_X86_32_UML) += tls.o
 obj-$(CONFIG_64BIT) += prctl.o
 
 USER_OBJS := $(obj-y)
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 7c11c9e5d7ea..0eec3645af34 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -14,7 +14,7 @@
 #include <frame_kern.h>
 #include <skas.h>
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 
 /*
  * FPU tag word conversions.
@@ -165,7 +165,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 
 #define GETREG(regno, regname) regs->regs.gp[HOST_##regno] = sc.regname
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 	GETREG(GS, gs);
 	GETREG(FS, fs);
 	GETREG(ES, es);
@@ -181,7 +181,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 	GETREG(AX, ax);
 	GETREG(IP, ip);
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_X86_64_UML
 	GETREG(R8, r8);
 	GETREG(R9, r9);
 	GETREG(R10, r10);
@@ -194,14 +194,14 @@ static int copy_sc_from_user(struct pt_regs *regs,
 
 	GETREG(CS, cs);
 	GETREG(EFLAGS, flags);
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 	GETREG(SS, ss);
 #endif
 
 #undef GETREG
 
 	pid = userspace_pid[current_thread_info()->cpu];
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 	if (have_fpx_regs) {
 		struct user_fxsr_struct fpx;
 
@@ -244,7 +244,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 
 #define PUTREG(regno, regname) sc.regname = regs->regs.gp[HOST_##regno]
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 	PUTREG(GS, gs);
 	PUTREG(FS, fs);
 	PUTREG(ES, es);
@@ -258,7 +258,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	PUTREG(DX, dx);
 	PUTREG(CX, cx);
 	PUTREG(AX, ax);
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_X86_64_UML
 	PUTREG(R8, r8);
 	PUTREG(R9, r9);
 	PUTREG(R10, r10);
@@ -275,7 +275,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	PUTREG(IP, ip);
 	PUTREG(CS, cs);
 	PUTREG(EFLAGS, flags);
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 	PUTREG(SP, sp_at_signal);
 	PUTREG(SS, ss);
 #endif
@@ -289,7 +289,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 
 	pid = userspace_pid[current_thread_info()->cpu];
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 	if (have_fpx_regs) {
 		struct user_fxsr_struct fpx;
 
@@ -322,7 +322,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	return 0;
 }
 
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_X86_32_UML
 static int copy_ucontext_to_user(struct ucontext __user *uc,
 				 struct _xstate __user *fp, sigset_t *set,
 				 unsigned long sp)
diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 88c218a9f8b3..99cbee3fe4d7 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -366,7 +366,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 void lkdtm_UNSET_SMEP(void)
 {
-#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
+#if IS_ENABLED(CONFIG_X86_64)
 #define MOV_CR4_DEPTH	64
 	void (*direct_write_cr4)(unsigned long val);
 	unsigned char *insn;
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 179004b15566..df2d3d19a45c 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -33,13 +33,13 @@ static struct proc_dir_entry *afs_proc_symlink;
 
 #if defined(CONFIG_ALPHA)
 const char afs_init_sysname[] = "alpha_linux26";
-#elif defined(CONFIG_X86_64)
+#elif defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)
 const char afs_init_sysname[] = "amd64_linux26";
 #elif defined(CONFIG_ARM)
 const char afs_init_sysname[] = "arm_linux26";
 #elif defined(CONFIG_ARM64)
 const char afs_init_sysname[] = "aarch64_linux26";
-#elif defined(CONFIG_X86_32)
+#elif defined(CONFIG_X86_32) || defined(CONFIG_X86_32_UML)
 const char afs_init_sysname[] = "i386_linux26";
 #elif defined(CONFIG_IA64)
 const char afs_init_sysname[] = "ia64_linux26";
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1e2204fa9963..47e5a9f4b03f 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -499,7 +499,7 @@ static int ioctl_preallocate(struct file *filp, int mode, void __user *argp)
 }
 
 /* on ia32 l_start is on a 32-bit boundary */
-#if defined CONFIG_COMPAT && defined(CONFIG_X86_64)
+#if defined CONFIG_COMPAT && (defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML))
 /* just account for different alignment */
 static int compat_ioctl_preallocate(struct file *file, int mode,
 				    struct space_resv_32 __user *argp)
@@ -1126,7 +1126,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 		error = ioctl_file_clone(f.file, arg, 0, 0, 0);
 		break;
 
-#if defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)
 	/* these get messy on amd64 due to alignment differences */
 	case FS_IOC_RESVSP_32:
 	case FS_IOC_RESVSP64_32:
diff --git a/fs/xfs/xfs_ioctl32.h b/fs/xfs/xfs_ioctl32.h
index 9929482bf358..fa772e44318f 100644
--- a/fs/xfs/xfs_ioctl32.h
+++ b/fs/xfs/xfs_ioctl32.h
@@ -22,7 +22,7 @@
 /*
  * On intel, even if sizes match, alignment and/or padding may differ.
  */
-#if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
+#if defined(CONFIG_IA64) || defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)
 #define BROKEN_X86_ALIGNMENT
 #define __compat_packed __attribute__((packed))
 #else
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index f3f0b97b1675..9810fa6926d2 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -33,7 +33,7 @@ struct space_resv {
 					 FALLOC_FL_UNSHARE_RANGE)
 
 /* on ia32 l_start is on a 32-bit boundary */
-#if defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)
 struct space_resv_32 {
 	__s16		l_type;
 	__s16		l_whence;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f9bda5476ea5..3baeab40e63c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5124,7 +5124,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 
 static bool allow_tail_call_in_subprogs(struct bpf_verifier_env *env)
 {
-	return env->prog->jit_requested && IS_ENABLED(CONFIG_X86_64);
+	return env->prog->jit_requested &&
+	       (IS_ENABLED(CONFIG_X86_64) || IS_ENABLED(CONFIG_X86_64_UML));
 }
 
 static int check_map_func_compatibility(struct bpf_verifier_env *env,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 272f4a272f8c..fd97a545c94a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3043,7 +3043,7 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= numa_zonelist_order_handler,
 	},
 #endif
-#if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
+#if defined(CONFIG_X86_32) || \
    (defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL))
 	{
 		.procname	= "vdso_enabled",
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c221e4c3f625..522e315d9e6c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -611,7 +611,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 }
 EXPORT_SYMBOL_GPL(blk_trace_setup);
 
-#if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
+#if defined(CONFIG_COMPAT) && (defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML))
 static int compat_blk_trace_setup(struct request_queue *q, char *name,
 				  dev_t dev, struct block_device *bdev,
 				  char __user *arg)
@@ -729,7 +729,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 		bdevname(bdev, b);
 		ret = __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
-#if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
+#if defined(CONFIG_COMPAT) && (defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML))
 	case BLKTRACESETUP32:
 		bdevname(bdev, b);
 		ret = compat_blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 14c032de276e..340bbaacc611 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -90,7 +90,7 @@ config CRYPTO_LIB_DES
 config CRYPTO_LIB_POLY1305_RSIZE
 	int
 	default 2 if MIPS
-	default 11 if X86_64
+	default 11 if X86_64 || X86_64_UML
 	default 9 if ARM || ARM64
 	default 1
 
diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index b60851fcf6ce..5f8c522388fe 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -21,7 +21,7 @@
 
 #define COPY4(dst, src)	\
 		put_unaligned(get_unaligned((const u32 *)(src)), (u32 *)(dst))
-#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
+#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64) || defined(CONFIG_X86_64_UML)
 #define COPY8(dst, src)	\
 		put_unaligned(get_unaligned((const u64 *)(src)), (u64 *)(dst))
 #else
@@ -31,11 +31,11 @@
 
 #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
 #error "conflicting endian definitions"
-#elif defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
+#elif defined(CONFIG_X86_64) || defined(CONFIG_ARM64) || defined(CONFIG_X86_64_UML)
 #define LZO_USE_CTZ64	1
 #define LZO_USE_CTZ32	1
 #define LZO_FAST_64BIT_MEMORY_ACCESS
-#elif defined(CONFIG_X86) || defined(CONFIG_PPC)
+#elif defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_X86_32_UML)
 #define LZO_USE_CTZ32	1
 #elif defined(CONFIG_ARM) && (__LINUX_ARM_ARCH__ >= 5)
 #define LZO_USE_CTZ32	1
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 049890e00a3d..6ec964f26b92 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -80,10 +80,8 @@ nf_tables-objs := nf_tables_core.o nf_tables_api.o nft_chain_filter.o \
 		  nft_set_pipapo.o
 
 ifdef CONFIG_X86_64
-ifndef CONFIG_UML
 nf_tables-objs += nft_set_pipapo_avx2.o
 endif
-endif
 
 obj-$(CONFIG_NF_TABLES)		+= nf_tables.o
 obj-$(CONFIG_NFT_COMPAT)	+= nft_compat.o
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 081437dd75b7..ae7678a36c10 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3557,7 +3557,7 @@ static const struct nft_set_type *nft_set_types[] = {
 	&nft_set_rhash_type,
 	&nft_set_bitmap_type,
 	&nft_set_rbtree_type,
-#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+#ifdef CONFIG_X86_64
 	&nft_set_pipapo_avx2_type,
 #endif
 	&nft_set_pipapo_type,
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 90becbf5bff3..ec9225b274bb 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -40,7 +40,7 @@ bool nft_set_do_lookup(const struct net *net, const struct nft_set *set,
 
 	if (set->ops == &nft_set_pipapo_type.ops)
 		return nft_pipapo_lookup(net, set, key, ext);
-#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+#ifdef CONFIG_X86_64
 	if (set->ops == &nft_set_pipapo_avx2_type.ops)
 		return nft_pipapo_avx2_lookup(net, set, key, ext);
 #endif
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index dce866d93fee..a35e212ae553 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2207,7 +2207,7 @@ const struct nft_set_type nft_set_pipapo_type = {
 	},
 };
 
-#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+#ifdef CONFIG_X86_64
 const struct nft_set_type nft_set_pipapo_avx2_type = {
 	.features	= NFT_SET_INTERVAL | NFT_SET_MAP | NFT_SET_OBJECT |
 			  NFT_SET_TIMEOUT,
diff --git a/net/netfilter/nft_set_pipapo_avx2.h b/net/netfilter/nft_set_pipapo_avx2.h
index dbb6aaca8a7a..87c5beb2c295 100644
--- a/net/netfilter/nft_set_pipapo_avx2.h
+++ b/net/netfilter/nft_set_pipapo_avx2.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef _NFT_SET_PIPAPO_AVX2_H
 
-#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+#ifdef CONFIG_X86_64
 #include <asm/fpu/xstate.h>
 #define NFT_PIPAPO_ALIGN	(XSAVE_YMM_SIZE / BITS_PER_BYTE)
 
 bool nft_pipapo_avx2_estimate(const struct nft_set_desc *desc, u32 features,
 			      struct nft_set_estimate *est);
-#endif /* defined(CONFIG_X86_64) && !defined(CONFIG_UML) */
+#endif /* CONFIG_X86_64 */
 
 #endif /* _NFT_SET_PIPAPO_AVX2_H */
diff --git a/security/Kconfig b/security/Kconfig
index 0ced7fd33e4d..a4877b1df57f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -57,7 +57,7 @@ config SECURITY_NETWORK
 config PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
 	default y
-	depends on (X86_64 || X86_PAE) && !UML
+	depends on X86_64 || X86_PAE
 	help
 	  This feature reduces the number of hardware side channels by
 	  ensuring that the majority of kernel addresses are not mapped
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 470dabc60aa0..c31618d559c1 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -143,7 +143,7 @@ struct snd_ctl_elem_value32 {
         union {
 		s32 integer[128];
 		unsigned char data[512];
-#ifndef CONFIG_X86_64
+#if !defined(CONFIG_X86_64) && !defined(CONFIG_X86_64_UML)
 		s64 integer64[64];
 #endif
         } value;
-- 
2.31.1

