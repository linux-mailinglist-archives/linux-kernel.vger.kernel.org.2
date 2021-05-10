Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887C3377F99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhEJJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:41:57 -0400
Received: from foss.arm.com ([217.140.110.172]:51108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhEJJl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:41:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61E151509;
        Mon, 10 May 2021 02:40:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 381F03F73B;
        Mon, 10 May 2021 02:40:48 -0700 (PDT)
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
Subject: [PATCH 12/33] locking/atomic: cmpxchg: support ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:32 +0100
Message-Id: <20210510093753.40683-13-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like all architectures to convert to ARCH_ATOMIC, as this will
enable functionality, and once all architectures are converted it will
be possible to make significant cleanups to the atomic headers.

A number of architectures use asm-generic/cmpxchg.h or
asm-generic/cmpxhg-local.h, and it's impractical to convert the headers
and all these architectures in one go. To make it possible to convert
them one-by-one, let's make the asm-generic implementation function as
either cmpxchg*() or arch_cmpxchg*() depending on whether ARCH_ATOMIC is
selected. To do this, the generic implementations are prefixed as
generic_cmpxchg_*(), and preprocessor definitions map
cmpxchg_*()/arch_cmpxchg_*() onto these as appropriate.

Once all users are moved over to ARCH_ATOMIC the ifdeffery in the header
can be simplified and/or removed entirely.

For existing users (none of which select ARCH_ATOMIC), there should be
no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/asm-generic/cmpxchg.h | 61 +++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index b9d54c7afc52..98c931199089 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -14,16 +14,14 @@
 #include <linux/types.h>
 #include <linux/irqflags.h>
 
-#ifndef xchg
-
 /*
  * This function doesn't exist, so you'll get a linker error if
  * something tries to do an invalidly-sized xchg().
  */
-extern void __xchg_called_with_bad_pointer(void);
+extern void __generic_xchg_called_with_bad_pointer(void);
 
 static inline
-unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
+unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
 {
 	unsigned long ret, flags;
 
@@ -75,35 +73,64 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 #endif /* CONFIG_64BIT */
 
 	default:
-		__xchg_called_with_bad_pointer();
+		__generic_xchg_called_with_bad_pointer();
 		return x;
 	}
 }
 
-#define xchg(ptr, x) ({							\
-	((__typeof__(*(ptr)))						\
-		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))));	\
+#define generic_xchg(ptr, x) ({							\
+	((__typeof__(*(ptr)))							\
+		__generic_xchg((unsigned long)(x), (ptr), sizeof(*(ptr))));	\
 })
 
-#endif /* xchg */
-
 /*
  * Atomic compare and exchange.
  */
 #include <asm-generic/cmpxchg-local.h>
 
-#ifndef cmpxchg_local
-#define cmpxchg_local(ptr, o, n) ({					       \
-	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
-			(unsigned long)(n), sizeof(*(ptr))));		       \
+#define generic_cmpxchg_local(ptr, o, n) ({					\
+	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),	\
+			(unsigned long)(n), sizeof(*(ptr))));			\
 })
+
+#define generic_cmpxchg64_local(ptr, o, n) \
+	__generic_cmpxchg64_local((ptr), (o), (n))
+
+
+#ifdef CONFIG_ARCH_ATOMIC
+
+#ifndef arch_xchg
+#define arch_xchg		generic_xchg
+#endif
+
+#ifndef arch_cmpxchg_local
+#define arch_cmpxchg_local	generic_cmpxchg_local
+#endif
+
+#ifndef arch_cmpxchg64_local
+#define arch_cmpxchg64_local	generic_cmpxchg64_local
+#endif
+
+#define arch_cmpxchg		arch_cmpxchg_local
+#define arch_cmpxchg64		arch_cmpxchg64_local
+
+#else /* CONFIG_ARCH_ATOMIC */
+
+#ifndef xchg
+#define xchg			generic_xchg
+#endif
+
+#ifndef cmpxchg_local
+#define cmpxchg_local		generic_cmpxchg_local
 #endif
 
 #ifndef cmpxchg64_local
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define cmpxchg64_local		generic_cmpxchg64_local
 #endif
 
-#define cmpxchg(ptr, o, n)	cmpxchg_local((ptr), (o), (n))
-#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
+#define cmpxchg			cmpxchg_local
+#define cmpxchg64		cmpxchg64_local
+
+#endif /* CONFIG_ARCH_ATOMIC */
 
 #endif /* __ASM_GENERIC_CMPXCHG_H */
-- 
2.11.0

