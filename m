Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD5F377FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhEJJmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:42:49 -0400
Received: from foss.arm.com ([217.140.110.172]:51368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhEJJmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:42:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F5DF152D;
        Mon, 10 May 2021 02:41:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 233273F73B;
        Mon, 10 May 2021 02:41:12 -0700 (PDT)
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
Subject: [PATCH 16/33] locking/atomic: csky: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:36 +0100
Message-Id: <20210510093753.40683-17-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates csky to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/csky/Kconfig               | 1 +
 arch/csky/include/asm/cmpxchg.h | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 8de5b987edb9..3521f14bcd96 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -2,6 +2,7 @@
 config CSKY
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index dabc8e46ce7b..d1bef11f8dc9 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -31,7 +31,7 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define xchg_relaxed(ptr, x) \
+#define arch_xchg_relaxed(ptr, x) \
 		(__xchg_relaxed((x), (ptr), sizeof(*(ptr))))
 
 #define __cmpxchg_relaxed(ptr, old, new, size)			\
@@ -61,14 +61,14 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define cmpxchg_relaxed(ptr, o, n) \
+#define arch_cmpxchg_relaxed(ptr, o, n) \
 	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 
-#define cmpxchg(ptr, o, n) 					\
+#define arch_cmpxchg(ptr, o, n) 				\
 ({								\
 	__typeof__(*(ptr)) __ret;				\
 	__smp_release_fence();					\
-	__ret = cmpxchg_relaxed(ptr, o, n);			\
+	__ret = arch_cmpxchg_relaxed(ptr, o, n);		\
 	__smp_acquire_fence();					\
 	__ret;							\
 })
-- 
2.11.0

