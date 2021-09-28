Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830C041B332
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbhI1PoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241759AbhI1PoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:44:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E433A61246;
        Tue, 28 Sep 2021 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843746;
        bh=v30E3C1Ib8Ks1FnFj9SAAvfmbdHtgvlHZK3Z2nhGTUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8kzqGfJ36X5OVdN/zEU7UA8Z0mTANPqkLXdyRIwfVH02+6IKtdkwy+hiqo8PZ1lh
         TAK/DKUegvVsr6tpHJKIN0NVEXb2uh8M0p8JoNTFL+RfEbptUwfSWQca4s5MvdFG3O
         6yESYzSZs6XIFL+OE+KsAaxhodtb4pYTm7yyMqcBFxA6BecZfqwpwP9Ebj1sjSDrLl
         7QfxmVy7+v65MDimUmRVvI7pOJQZ+U66QoGOpPoFlQ3jymWDzwMlXpPMGiLtkFVOFm
         zuT5Kq9l7BvyFIc4slk56bzFomXMuSihCCZLZyauS49V2i9+mwFX3lP6WXPfb8iIfi
         hbFdy4l8yqwxg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH 13/14] ARM: use .arch directives instead of assembler command line flags
Date:   Tue, 28 Sep 2021 17:41:42 +0200
Message-Id: <20210928154143.2106903-14-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928154143.2106903-1-arnd@kernel.org>
References: <20210928154143.2106903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

Similar to commit a6c30873ee4a ("ARM: 8989/1: use .fpu assembler
directives instead of assembler arguments").

GCC and GNU binutils support setting the "sub arch" via -march=,
-Wa,-march, target function attribute, and .arch assembler directive.

Clang's integrated assembler does not support -Wa,-march (and the logic
to overrule one when multiple of the above are used), and this can
cause annoying warnings such as:

clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]

Since most assembler is non-conditionally assembled with one sub arch
(modulo arch/arm/delay-loop.S which conditionally is assembled as armv4
based on CONFIG_ARCH_RPC, and arch/arm/mach-at91/pm-suspend.S which is
conditionally assembled as armv7-a based on CONFIG_CPU_V7), prefer the
.arch assembler directive.

Link: https://bugs.llvm.org/show_bug.cgi?id=48894
Link: https://github.com/ClangBuiltLinux/linux/issues/1195
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
[arnd] add a few more instances found in compile testing
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/Makefile  |  2 --
 arch/arm/common/Makefile           |  2 --
 arch/arm/common/mcpm_head.S        |  2 ++
 arch/arm/common/vlock.S            |  2 ++
 arch/arm/kernel/Makefile           |  2 --
 arch/arm/kernel/hyp-stub.S         |  2 ++
 arch/arm/kernel/swp_emulate.c      |  1 +
 arch/arm/lib/Makefile              |  4 ----
 arch/arm/lib/delay-loop.S          |  4 ++++
 arch/arm/mach-at91/Makefile        |  3 ---
 arch/arm/mach-at91/pm_suspend.S    |  4 ++++
 arch/arm/mach-imx/Makefile         |  3 ---
 arch/arm/mach-imx/headsmp.S        |  2 ++
 arch/arm/mach-imx/resume-imx6.S    |  2 ++
 arch/arm/mach-imx/suspend-imx6.S   |  2 ++
 arch/arm/mach-mvebu/Makefile       |  3 ---
 arch/arm/mach-mvebu/coherency_ll.S |  1 +
 arch/arm/mach-mvebu/pmsu.c         |  1 +
 arch/arm/mach-npcm/Makefile        |  2 --
 arch/arm/mach-npcm/headsmp.S       |  2 ++
 arch/arm/mm/Makefile               | 15 ---------------
 arch/arm/mm/abort-ev6.S            |  1 +
 arch/arm/mm/abort-ev7.S            |  1 +
 arch/arm/mm/cache-v6.S             |  2 ++
 arch/arm/mm/cache-v7.S             |  2 ++
 arch/arm/mm/cache-v7m.S            |  2 ++
 arch/arm/mm/copypage-feroceon.c    |  1 +
 arch/arm/mm/proc-v6.S              |  2 ++
 arch/arm/mm/proc-v7-2level.S       |  2 ++
 arch/arm/mm/proc-v7.S              |  2 ++
 arch/arm/mm/tlb-v6.S               |  2 ++
 arch/arm/mm/tlb-v7.S               |  2 ++
 drivers/memory/Makefile            |  2 --
 drivers/memory/ti-emif-sram-pm.S   |  1 +
 34 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 91265e7ff672..c5ee2b10f670 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -191,7 +191,5 @@ CFLAGS_font.o := -Dstatic=
 $(obj)/font.c: $(FONTC)
 	$(call cmd,shipped)
 
-AFLAGS_hyp-stub.o := -Wa,-march=armv7-a
-
 $(obj)/hyp-stub.S: $(srctree)/arch/$(SRCARCH)/kernel/hyp-stub.S
 	$(call cmd,shipped)
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 8cd574be94cf..6a42600fa4c5 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -14,7 +14,5 @@ obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_CPU_V7)		+= secure_cntvoff.o
 obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
 CFLAGS_REMOVE_mcpm_entry.o	= -pg
-AFLAGS_mcpm_head.o		:= -march=armv7-a
-AFLAGS_vlock.o			:= -march=armv7-a
 obj-$(CONFIG_BL_SWITCHER)	+= bL_switcher.o
 obj-$(CONFIG_BL_SWITCHER_DUMMY_IF) += bL_switcher_dummy_if.o
diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index 291d969bc719..299495c43dfd 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -15,6 +15,8 @@
 
 #include "vlock.h"
 
+.arch armv7-a
+
 .if MCPM_SYNC_CLUSTER_CPUS
 .error "cpus must be the first member of struct mcpm_sync_struct"
 .endif
diff --git a/arch/arm/common/vlock.S b/arch/arm/common/vlock.S
index f1c7fd44f1b1..1fa09c4697ed 100644
--- a/arch/arm/common/vlock.S
+++ b/arch/arm/common/vlock.S
@@ -12,6 +12,8 @@
 #include <linux/linkage.h>
 #include "vlock.h"
 
+.arch armv7-a
+
 /* Select different code if voting flags  can fit in a single word. */
 #if VLOCK_VOTING_SIZE > 4
 #define FEW(x...)
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ae295a3bcfef..714752f5402a 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -70,7 +70,6 @@ obj-$(CONFIG_HAVE_TCM)		+= tcm.o
 obj-$(CONFIG_OF)		+= devtree.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
-CFLAGS_swp_emulate.o		:= -Wa,-march=armv7-a
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 
 obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
@@ -99,7 +98,6 @@ CFLAGS_head-inflate-data.o := $(call cc-option,-Wframe-larger-than=10240)
 obj-$(CONFIG_XIP_DEFLATED_DATA) += head-inflate-data.o
 
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
-AFLAGS_hyp-stub.o		:=-Wa,-march=armv7-a
 ifeq ($(CONFIG_ARM_PSCI),y)
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index b699b22a4db1..3a506b9095a5 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -9,6 +9,8 @@
 #include <asm/assembler.h>
 #include <asm/virt.h>
 
+.arch armv7-a
+
 #ifndef ZIMAGE
 /*
  * For the kernel proper, we need to find out the CPU boot mode long after
diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index 6166ba38bf99..8f2f218029c9 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -34,6 +34,7 @@
  */
 #define __user_swpX_asm(data, addr, res, temp, B)		\
 	__asm__ __volatile__(					\
+	".arch armv7-a\n"					\
 	"0:	ldrex"B"	%2, [%3]\n"			\
 	"1:	strex"B"	%0, %1, [%3]\n"			\
 	"	cmp		%0, #0\n"			\
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 6d2ba454f25b..42fb75c06647 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -36,10 +36,6 @@ else
   lib-y	+= io-readsw-armv4.o io-writesw-armv4.o
 endif
 
-ifeq ($(CONFIG_ARCH_RPC),y)
-  AFLAGS_delay-loop.o		+= -march=armv4
-endif
-
 $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
diff --git a/arch/arm/lib/delay-loop.S b/arch/arm/lib/delay-loop.S
index 3ccade0f8130..3ac05177d097 100644
--- a/arch/arm/lib/delay-loop.S
+++ b/arch/arm/lib/delay-loop.S
@@ -8,6 +8,10 @@
 #include <asm/assembler.h>
 #include <asm/delay.h>
 
+#ifdef CONFIG_ARCH_RPC
+		.arch	armv4
+#endif
+
 		.text
 
 .LC0:		.word	loops_per_jiffy
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 522b680b6446..e7a47fa03626 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -14,9 +14,6 @@ obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
 # Power Management
 obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o
 
-ifeq ($(CONFIG_CPU_V7),y)
-AFLAGS_pm_suspend.o := -march=armv7-a
-endif
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
 endif
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index cbd61a3bcab1..8d7b6377399c 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -12,6 +12,10 @@
 #include "pm.h"
 #include "pm_data-offsets.h"
 
+#ifdef CONFIG_CPU_V7
+.arch armv7-a
+#endif
+
 #define	SRAMC_SELF_FRESH_ACTIVE		0x01
 #define	SRAMC_SELF_FRESH_EXIT		0x00
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index d1506ef7a537..95509d8ad9d5 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
 obj-$(CONFIG_HAVE_IMX_SRC) += src.o
 ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_IMX7D_CA7)$(CONFIG_SOC_LS1021A),)
-AFLAGS_headsmp.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 endif
@@ -50,12 +49,10 @@ obj-$(CONFIG_SOC_IMX7D_CM4) += mach-imx7d-cm4.o
 obj-$(CONFIG_SOC_IMX7ULP) += mach-imx7ulp.o pm-imx7ulp.o
 
 ifeq ($(CONFIG_SUSPEND),y)
-AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
 obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
 endif
 ifeq ($(CONFIG_ARM_CPU_SUSPEND),y)
-AFLAGS_resume-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6) += resume-imx6.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index fcba58be8e79..5f9c7b48ae80 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -8,6 +8,8 @@
 #include <linux/init.h>
 #include <asm/assembler.h>
 
+.arch armv7-a
+
 diag_reg_offset:
 	.word	g_diag_reg - .
 
diff --git a/arch/arm/mach-imx/resume-imx6.S b/arch/arm/mach-imx/resume-imx6.S
index 5bd1ba7ef15b..2c0c5c771251 100644
--- a/arch/arm/mach-imx/resume-imx6.S
+++ b/arch/arm/mach-imx/resume-imx6.S
@@ -9,6 +9,8 @@
 #include <asm/hardware/cache-l2x0.h>
 #include "hardware.h"
 
+.arch armv7-a
+
 /*
  * The following code must assume it is running from physical address
  * where absolute virtual addresses to the data section have to be
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index e06f946b75b9..63ccc2d0e920 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -9,6 +9,8 @@
 #include <asm/hardware/cache-l2x0.h>
 #include "hardware.h"
 
+.arch armv7-a
+
 /*
  * ==================== low level suspend ====================
  *
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index cb106899dd7c..9b9fddb69958 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-orion/include
 
-AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
-CFLAGS_pmsu.o			:= -march=armv7-a
-
 obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index a3a64bf97250..25197290632d 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -23,6 +23,7 @@
 #include <asm/assembler.h>
 #include <asm/cp15.h>
 
+	.arch armv7-a
 	.text
 /*
  * Returns the coherency base address in r1 (r0 is untouched), or 0 if
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 73d5d72dfc3e..9a77cc3a10bd 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -294,6 +294,7 @@ int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 
 	/* Test the CR_C bit and set it if it was cleared */
 	asm volatile(
+	".arch	armv7-a\n\t"
 	"mrc	p15, 0, r0, c1, c0, 0 \n\t"
 	"tst	r0, %0 \n\t"
 	"orreq	r0, r0, #(1 << 2) \n\t"
diff --git a/arch/arm/mach-npcm/Makefile b/arch/arm/mach-npcm/Makefile
index 8d61fcd42fb1..ac83e1caf2ee 100644
--- a/arch/arm/mach-npcm/Makefile
+++ b/arch/arm/mach-npcm/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-AFLAGS_headsmp.o		+= -march=armv7-a
-
 obj-$(CONFIG_ARCH_WPCM450)	+= wpcm450.o
 obj-$(CONFIG_ARCH_NPCM7XX)	+= npcm7xx.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-npcm/headsmp.S b/arch/arm/mach-npcm/headsmp.S
index c083fe09a07b..84d2b6daaf0b 100644
--- a/arch/arm/mach-npcm/headsmp.S
+++ b/arch/arm/mach-npcm/headsmp.S
@@ -6,6 +6,8 @@
 #include <linux/init.h>
 #include <asm/assembler.h>
 
+.arch armv7-a
+
 /*
  * The boot ROM does not start secondary CPUs in SVC mode, so we need to do that
  * here.
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 3510503bc5e6..71b858c9b10c 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -33,9 +33,6 @@ obj-$(CONFIG_CPU_ABRT_EV5TJ)	+= abort-ev5tj.o
 obj-$(CONFIG_CPU_ABRT_EV6)	+= abort-ev6.o
 obj-$(CONFIG_CPU_ABRT_EV7)	+= abort-ev7.o
 
-AFLAGS_abort-ev6.o	:=-Wa,-march=armv6k
-AFLAGS_abort-ev7.o	:=-Wa,-march=armv7-a
-
 obj-$(CONFIG_CPU_PABRT_LEGACY)	+= pabort-legacy.o
 obj-$(CONFIG_CPU_PABRT_V6)	+= pabort-v6.o
 obj-$(CONFIG_CPU_PABRT_V7)	+= pabort-v7.o
@@ -49,10 +46,6 @@ obj-$(CONFIG_CPU_CACHE_FA)	+= cache-fa.o
 obj-$(CONFIG_CPU_CACHE_NOP)	+= cache-nop.o
 obj-$(CONFIG_CPU_CACHE_V7M)	+= cache-v7m.o
 
-AFLAGS_cache-v6.o	:=-Wa,-march=armv6
-AFLAGS_cache-v7.o	:=-Wa,-march=armv7-a
-AFLAGS_cache-v7m.o	:=-Wa,-march=armv7-m
-
 obj-$(CONFIG_CPU_COPY_V4WT)	+= copypage-v4wt.o
 obj-$(CONFIG_CPU_COPY_V4WB)	+= copypage-v4wb.o
 obj-$(CONFIG_CPU_COPY_FEROCEON)	+= copypage-feroceon.o
@@ -62,8 +55,6 @@ obj-$(CONFIG_CPU_XSCALE)	+= copypage-xscale.o
 obj-$(CONFIG_CPU_XSC3)		+= copypage-xsc3.o
 obj-$(CONFIG_CPU_COPY_FA)	+= copypage-fa.o
 
-CFLAGS_copypage-feroceon.o := -march=armv5te
-
 obj-$(CONFIG_CPU_TLB_V4WT)	+= tlb-v4.o
 obj-$(CONFIG_CPU_TLB_V4WB)	+= tlb-v4wb.o
 obj-$(CONFIG_CPU_TLB_V4WBI)	+= tlb-v4wbi.o
@@ -72,9 +63,6 @@ obj-$(CONFIG_CPU_TLB_V6)	+= tlb-v6.o
 obj-$(CONFIG_CPU_TLB_V7)	+= tlb-v7.o
 obj-$(CONFIG_CPU_TLB_FA)	+= tlb-fa.o
 
-AFLAGS_tlb-v6.o		:=-Wa,-march=armv6
-AFLAGS_tlb-v7.o		:=-Wa,-march=armv7-a
-
 obj-$(CONFIG_CPU_ARM7TDMI)	+= proc-arm7tdmi.o
 obj-$(CONFIG_CPU_ARM720T)	+= proc-arm720.o
 obj-$(CONFIG_CPU_ARM740T)	+= proc-arm740.o
@@ -101,9 +89,6 @@ obj-$(CONFIG_CPU_V6K)		+= proc-v6.o
 obj-$(CONFIG_CPU_V7)		+= proc-v7.o proc-v7-bugs.o
 obj-$(CONFIG_CPU_V7M)		+= proc-v7m.o
 
-AFLAGS_proc-v6.o	:=-Wa,-march=armv6
-AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
-
 obj-$(CONFIG_OUTER_CACHE)	+= l2c-common.o
 obj-$(CONFIG_CACHE_B15_RAC)	+= cache-b15-rac.o
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index c58bf8b43fea..836dc1299243 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -16,6 +16,7 @@
  * abort here if the I-TLB and D-TLB aren't seeing the same
  * picture.  Unfortunately, this does happen.  We live with it.
  */
+	.arch	armv6k
 	.align	5
 ENTRY(v6_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index f81bceacc660..53fb41c24774 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -12,6 +12,7 @@
  *
  * Purpose : obtain information about current aborted instruction.
  */
+	.arch	armv7-a
 	.align	5
 ENTRY(v7_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index f0f65eb073e4..250c83bf7158 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -19,6 +19,8 @@
 #define D_CACHE_LINE_SIZE	32
 #define BTB_FLUSH_SIZE		8
 
+.arch armv6
+
 /*
  *	v6_flush_icache_all()
  *
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 830bbfb26ca5..29ec2952fe3a 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -16,6 +16,8 @@
 
 #include "proc-macros.S"
 
+.arch armv7-a
+
 #ifdef CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND
 .globl icache_size
 	.data
diff --git a/arch/arm/mm/cache-v7m.S b/arch/arm/mm/cache-v7m.S
index 1bc3a0a50753..eb60b5e5e2ad 100644
--- a/arch/arm/mm/cache-v7m.S
+++ b/arch/arm/mm/cache-v7m.S
@@ -18,6 +18,8 @@
 
 #include "proc-macros.S"
 
+.arch armv7-m
+
 /* Generic V7M read/write macros for memory mapped cache operations */
 .macro v7m_cache_read, rt, reg
 	movw	\rt, #:lower16:BASEADDR_V7M_SCB + \reg
diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
index 064b19e63571..5fc8ef1e665f 100644
--- a/arch/arm/mm/copypage-feroceon.c
+++ b/arch/arm/mm/copypage-feroceon.c
@@ -15,6 +15,7 @@ static void feroceon_copy_user_page(void *kto, const void *kfrom)
 	int tmp;
 
 	asm volatile ("\
+.arch	armv5te					\n\
 1:	ldmia	%1!, {r2 - r7, ip, lr}		\n\
 	pld	[%1, #0]			\n\
 	pld	[%1, #32]			\n\
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index a0618f3e6836..203dff89ab1a 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -32,6 +32,8 @@
 #define TTB_FLAGS_SMP	TTB_RGN_WBWA|TTB_S
 #define PMD_FLAGS_SMP	PMD_SECT_WBWA|PMD_SECT_S
 
+.arch armv6
+
 ENTRY(cpu_v6_proc_init)
 	ret	lr
 
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 5db029c8f987..0a3083ad19c2 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -24,6 +24,8 @@
 #define TTB_FLAGS_SMP	TTB_IRGN_WBWA|TTB_S|TTB_NOS|TTB_RGN_OC_WBWA
 #define PMD_FLAGS_SMP	PMD_SECT_WBWA|PMD_SECT_S
 
+.arch armv7-a
+
 /*
  *	cpu_v7_switch_mm(pgd_phys, tsk)
  *
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 26d726a08a34..6b4ef9539b68 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -24,6 +24,8 @@
 #include "proc-v7-2level.S"
 #endif
 
+.arch armv7-a
+
 ENTRY(cpu_v7_proc_init)
 	ret	lr
 ENDPROC(cpu_v7_proc_init)
diff --git a/arch/arm/mm/tlb-v6.S b/arch/arm/mm/tlb-v6.S
index 74f4b383afe3..1d91e49b2c2d 100644
--- a/arch/arm/mm/tlb-v6.S
+++ b/arch/arm/mm/tlb-v6.S
@@ -17,6 +17,8 @@
 
 #define HARVARD_TLB
 
+.arch armv6
+
 /*
  *	v6wbi_flush_user_tlb_range(start, end, vma)
  *
diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index 87bf4ab17721..35fd6d4f0d03 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -16,6 +16,8 @@
 #include <asm/tlbflush.h>
 #include "proc-macros.S"
 
+.arch armv7-a
+
 /*
  *	v7wbi_flush_user_tlb_range(start, end, vma)
  *
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index bc7663ed1c25..d1388a748872 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -32,8 +32,6 @@ obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
 
 ti-emif-sram-objs		:= ti-emif-pm.o ti-emif-sram-pm.o
 
-AFLAGS_ti-emif-sram-pm.o	:=-Wa,-march=armv7-a
-
 $(obj)/ti-emif-sram-pm.o: $(obj)/ti-emif-asm-offsets.h
 
 $(obj)/ti-emif-asm-offsets.h: $(obj)/emif-asm-offsets.s FORCE
diff --git a/drivers/memory/ti-emif-sram-pm.S b/drivers/memory/ti-emif-sram-pm.S
index d1c83bd5b98e..af2feb251303 100644
--- a/drivers/memory/ti-emif-sram-pm.S
+++ b/drivers/memory/ti-emif-sram-pm.S
@@ -36,6 +36,7 @@
 
 	.arm
 	.align 3
+	.arch armv7-a
 
 ENTRY(ti_emif_sram)
 
-- 
2.29.2

