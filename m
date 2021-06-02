Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577AC398ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhFBPjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:39:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231204AbhFBPi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:38:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF7811FB;
        Wed,  2 Jun 2021 08:37:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 60EAA3F719;
        Wed,  2 Jun 2021 08:37:12 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] CFI: Move function_nocfi() into compiler.h
Date:   Wed,  2 Jun 2021 16:37:01 +0100
Message-Id: <20210602153701.35957-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the common definition of function_nocfi() is provided by
<linux/mm.h>, and architectures are expected to provide a definition in
<asm/memory.h>. Due to header dependencies, this can make it hard to use
function_nocfi() in low-level headers.

As function_nocfi() has no dependency on any mm code, nor on any memory
definitions, it doesn't need to live in <linux/mm.h> or <asm/memory.h>.
Generally, it would make more sense for it to live in
<linux/compiler.h>, where an architecture can override it in
<asm/compiler.h>.

Move the definitions accordingly.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/compiler.h | 16 ++++++++++++++++
 arch/arm64/include/asm/memory.h   | 16 ----------------
 include/linux/compiler.h          | 10 ++++++++++
 include/linux/mm.h                | 10 ----------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index 6fb2e6bcc392..dc3ea4080e2e 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -23,4 +23,20 @@
 #define __builtin_return_address(val)					\
 	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x) ({						\
+	void *addr;							\
+	asm("adrp %0, " __stringify(x) "\n\t"				\
+	    "add  %0, %0, :lo12:" __stringify(x)			\
+	    : "=r" (addr));						\
+	addr;								\
+})
+#endif
+
 #endif /* __ASM_COMPILER_H */
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 7b360960cc35..1a35a4473598 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -321,22 +321,6 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
-#ifdef CONFIG_CFI_CLANG
-/*
- * With CONFIG_CFI_CLANG, the compiler replaces function address
- * references with the address of the function's CFI jump table
- * entry. The function_nocfi macro always returns the address of the
- * actual function instead.
- */
-#define function_nocfi(x) ({						\
-	void *addr;							\
-	asm("adrp %0, " __stringify(x) "\n\t"				\
-	    "add  %0, %0, :lo12:" __stringify(x)			\
-	    : "=r" (addr));						\
-	addr;								\
-})
-#endif
-
 /*
  *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(x)	indicates whether a virtual address is valid
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index df5b405e6305..099e529a5d25 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -213,6 +213,16 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__v;								\
 })
 
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function addresses in
+ * instrumented C code with jump table addresses. Architectures that
+ * support CFI can define this macro to return the actual function address
+ * when needed.
+ */
+#ifndef function_nocfi
+#define function_nocfi(x) (x)
+#endif
+
 #endif /* __KERNEL__ */
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c274f75efcf9..b8c28b10f25d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -125,16 +125,6 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
 /*
- * With CONFIG_CFI_CLANG, the compiler replaces function addresses in
- * instrumented C code with jump table addresses. Architectures that
- * support CFI can define this macro to return the actual function address
- * when needed.
- */
-#ifndef function_nocfi
-#define function_nocfi(x) (x)
-#endif
-
-/*
  * To prevent common memory management code establishing
  * a zero page mapping on a read fault.
  * This macro should be defined within <asm/pgtable.h>.
-- 
2.11.0

