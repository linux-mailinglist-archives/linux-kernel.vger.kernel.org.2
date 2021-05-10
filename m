Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675C9377F80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhEJJkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:40:06 -0400
Received: from foss.arm.com ([217.140.110.172]:50362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhEJJkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:40:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A78E113E;
        Mon, 10 May 2021 02:38:57 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58F233F73B;
        Mon, 10 May 2021 02:38:53 -0700 (PDT)
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
Subject: [PATCH 01/33] locking/atomic: make ARCH_ATOMIC a Kconfig symbol
Date:   Mon, 10 May 2021 10:37:21 +0100
Message-Id: <20210510093753.40683-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches will move architectures over to the ARCH_ATOMIC API,
after preparing the asm-generic atomic implementations to function with
or without ARCH_ATOMIC.

As some architectures use the asm-generic implementations exclusively
(and don't have a local atomic.h), and to avoid the risk that
ARCH_ATOMIC isn't defined in some cases we expect, let's make the
ARCH_ATOMIC macro a Kconfig symbol instead, so that we can guarantee it
is consistently available where needed.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/Kconfig                    | 3 +++
 arch/arm64/Kconfig              | 1 +
 arch/arm64/include/asm/atomic.h | 2 --
 arch/s390/Kconfig               | 1 +
 arch/s390/include/asm/atomic.h  | 2 --
 arch/um/Kconfig                 | 1 +
 arch/x86/Kconfig                | 1 +
 arch/x86/include/asm/atomic.h   | 2 --
 include/linux/atomic.h          | 2 +-
 9 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c45b770d3579..3fb3b12d4a95 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,6 +11,9 @@ source "arch/$(SRCARCH)/Kconfig"
 
 menu "General architecture-dependent options"
 
+config ARCH_ATOMIC
+	bool
+
 config CRASH_CORE
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d8566bbf9..62ab429d1f42 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,6 +9,7 @@ config ARM64
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
+	select ARCH_ATOMIC
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index b56a4b2bc248..c9979273d389 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -223,6 +223,4 @@ static __always_inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 
 #define arch_atomic64_dec_if_positive		arch_atomic64_dec_if_positive
 
-#define ARCH_ATOMIC
-
 #endif /* __ASM_ATOMIC_H */
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b4c7c34069f8..85374a36c69e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -58,6 +58,7 @@ config S390
 	# Note: keep this list sorted alphabetically
 	#
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
+	select ARCH_ATOMIC
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 7c93c6573524..7138d189cc42 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -147,6 +147,4 @@ ATOMIC64_OPS(xor)
 #define arch_atomic64_fetch_sub(_i, _v)  arch_atomic64_fetch_add(-(s64)(_i), _v)
 #define arch_atomic64_sub(_i, _v)	 arch_atomic64_add(-(s64)(_i), _v)
 
-#define ARCH_ATOMIC
-
 #endif /* __ARCH_S390_ATOMIC__  */
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 57cfd9a1c082..4370a9521ea4 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,7 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+	select ARCH_ATOMIC
 	select ARCH_EPHEMERAL_INODES
 	select ARCH_HAS_KCOV
 	select ARCH_NO_PREEMPT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..11a27563033d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -58,6 +58,7 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
+	select ARCH_ATOMIC
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index f732741ad7c7..5e754e895767 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -269,6 +269,4 @@ static __always_inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 # include <asm/atomic64_64.h>
 #endif
 
-#define ARCH_ATOMIC
-
 #endif /* _ASM_X86_ATOMIC_H */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 571a11008ab5..4f8d83f9e480 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -77,7 +77,7 @@
 	__ret;								\
 })
 
-#ifdef ARCH_ATOMIC
+#ifdef CONFIG_ARCH_ATOMIC
 #include <linux/atomic-arch-fallback.h>
 #include <asm-generic/atomic-instrumented.h>
 #else
-- 
2.11.0

