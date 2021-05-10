Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC94377F98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhEJJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:41:51 -0400
Received: from foss.arm.com ([217.140.110.172]:51048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhEJJls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:41:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F8B3147A;
        Mon, 10 May 2021 02:40:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9DF63F73B;
        Mon, 10 May 2021 02:40:39 -0700 (PDT)
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
Subject: [PATCH 11/33] locking/atomic: cmpxchg: make `generic` a prefix
Date:   Mon, 10 May 2021 10:37:31 +0100
Message-Id: <20210510093753.40683-12-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm-generic implementations of cmpxchg_local() and cmpxchg64_local()
use a `_generic` suffix to distinguish themselves from arch code or
wrappers used elsewhere.

Subsequent patches will add ARCH_ATOMIC support to these
implementations, and will distinguish more functions with a `generic`
portion. To align with how ARCH_ATOMIC uses an `arch_` prefix, it would
be helpful to use a `generic_` prefix rather than a `_generic` suffix.

In preparation for this, this patch renames the existing functions to
make `generic` a prefix rather than a suffix. There should be no
functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm/include/asm/cmpxchg.h      | 6 +++---
 arch/m68k/include/asm/cmpxchg.h     | 2 +-
 arch/mips/include/asm/cmpxchg.h     | 2 +-
 arch/parisc/include/asm/cmpxchg.h   | 4 ++--
 arch/powerpc/include/asm/cmpxchg.h  | 2 +-
 arch/sparc/include/asm/cmpxchg_32.h | 4 ++--
 arch/sparc/include/asm/cmpxchg_64.h | 2 +-
 arch/xtensa/include/asm/cmpxchg.h   | 6 +++---
 include/asm-generic/cmpxchg-local.h | 4 ++--
 include/asm-generic/cmpxchg.h       | 4 ++--
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 8b701f8e175c..06bd8cea861a 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -135,13 +135,13 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
  * them available.
  */
 #define cmpxchg_local(ptr, o, n) ({					\
-	(__typeof(*ptr))__cmpxchg_local_generic((ptr),			\
+	(__typeof(*ptr))__generic_cmpxchg_local((ptr),			\
 					        (unsigned long)(o),	\
 					        (unsigned long)(n),	\
 					        sizeof(*(ptr)));	\
 })
 
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 #include <asm-generic/cmpxchg.h>
 
@@ -224,7 +224,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 #ifdef CONFIG_CPU_V6	/* min ARCH == ARMv6 */
 	case 1:
 	case 2:
-		ret = __cmpxchg_local_generic(ptr, old, new, size);
+		ret = __generic_cmpxchg_local(ptr, old, new, size);
 		break;
 #endif
 	default:
diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index a4aa82021d3b..7629c9c1ed5b 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -80,7 +80,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 
 #include <asm-generic/cmpxchg-local.h>
 
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 extern unsigned long __invalid_cmpxchg_size(volatile void *,
 					    unsigned long, unsigned long, int);
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index ed8f3f3c4304..c7e0455d4d46 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -222,7 +222,7 @@ unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 #else
 
 # include <asm-generic/cmpxchg-local.h>
-# define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+# define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 # ifdef CONFIG_SMP
 
diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index 84ee232278a6..c2015654b684 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -98,7 +98,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 #endif
 	case 4:	return __cmpxchg_u32(ptr, old, new_);
 	default:
-		return __cmpxchg_local_generic(ptr, old, new_, size);
+		return __generic_cmpxchg_local(ptr, old, new_, size);
 	}
 }
 
@@ -116,7 +116,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	cmpxchg_local((ptr), (o), (n));					\
 })
 #else
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #endif
 
 #define cmpxchg64(ptr, o, n) __cmpxchg_u64(ptr, o, n)
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index cf091c4c22e5..69f52fdcf064 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -524,7 +524,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 })
 #else
 #include <asm-generic/cmpxchg-local.h>
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index a53d744d4212..86e3da1d973d 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -73,8 +73,8 @@ u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
  * them available.
  */
 #define cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
+	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))))
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 #endif /* __ARCH_SPARC_CMPXCHG__ */
diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 316faa0130ba..8915b577b92f 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -189,7 +189,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	case 4:
 	case 8:	return __cmpxchg(ptr, old, new, size);
 	default:
-		return __cmpxchg_local_generic(ptr, old, new, size);
+		return __generic_cmpxchg_local(ptr, old, new, size);
 	}
 
 	return old;
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index a175f8aec3fb..9c4d6e5316ce 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -97,7 +97,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 	default:
-		return __cmpxchg_local_generic(ptr, old, new, size);
+		return __generic_cmpxchg_local(ptr, old, new, size);
 	}
 
 	return old;
@@ -108,9 +108,9 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
  * them available.
  */
 #define cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
+	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))))
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #define cmpxchg64(ptr, o, n)    cmpxchg64_local((ptr), (o), (n))
 
 /*
diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
index f17f14f84d09..380cdc824e4b 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -12,7 +12,7 @@ extern unsigned long wrong_size_cmpxchg(volatile void *ptr)
  * Generic version of __cmpxchg_local (disables interrupts). Takes an unsigned
  * long parameter, supporting various types of architectures.
  */
-static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
+static inline unsigned long __generic_cmpxchg_local(volatile void *ptr,
 		unsigned long old, unsigned long new, int size)
 {
 	unsigned long flags, prev;
@@ -51,7 +51,7 @@ static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
 /*
  * Generic version of __cmpxchg64_local. Takes an u64 parameter.
  */
-static inline u64 __cmpxchg64_local_generic(volatile void *ptr,
+static inline u64 __generic_cmpxchg64_local(volatile void *ptr,
 		u64 old, u64 new)
 {
 	u64 prev;
diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index 9a24510cd8c1..b9d54c7afc52 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -94,13 +94,13 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 
 #ifndef cmpxchg_local
 #define cmpxchg_local(ptr, o, n) ({					       \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
+	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))));		       \
 })
 #endif
 
 #ifndef cmpxchg64_local
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #endif
 
 #define cmpxchg(ptr, o, n)	cmpxchg_local((ptr), (o), (n))
-- 
2.11.0

