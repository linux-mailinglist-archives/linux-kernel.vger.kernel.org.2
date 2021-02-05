Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95B3311132
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhBERrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhBEPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:54:54 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D1C061797
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:15 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id 22so5765777qty.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ctAIK4J2ixb9MMoTkFb1CmODQtYX8ZOk4P8i8+csvVc=;
        b=UtIaRW9v2FSvyHZrpUGwpYFPoy1Ze5VquXJ1iz6uGvMo/Yw3T+rNU/+4YbDkUlgcIq
         274fCMAx2A4PaDOyqUrn25nxx5KgH4nJtCGILGIXDB7IGPccugIwm35XYXsTbH2RZ5qL
         Xh6vnLGD/n6sTDHX1FqMGfOjkDRmhl8iHZAEgI0GdyFS6YThdyLLB26YU/n80fKRBB4Y
         oZ+3gn7uO9Bkto02RB0j7H+iIyiqhKyLu22ZX506BzNEFtJaJBdwYBFL6Jtd0l158x7+
         P0QTYpuULqdO53c7LHJQFMlCv4ixKoDfWa/gYB5U2mcB3XPiTMgIoVDw/iHUwXo+hj/o
         l62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ctAIK4J2ixb9MMoTkFb1CmODQtYX8ZOk4P8i8+csvVc=;
        b=bntUyZa/WCLz35YPytNJRgh+iq570qW+nAsZYZ7mczIqxIMo3iplM0oiqxjRzmZnVt
         FAImAj6W9O1mwFRE5CH+Pf4hLPK20SHsl/sWQfW94TXUmurQvOZ7pQrXoVNMcV35H0jU
         5GiWEIyN0tlzGYSfr4gkZvEjpIGMhcpOV86sx8nPTvTih7WLRrbYVL/+k6RcNrGC23gt
         E+YDK84lSXlvadilfvQ/se5iPaw1Y5kkKsSFB+YnV8VdzpkqPrqHdeXQ6cj+pvYIlH9e
         VOLE2YIVA1MTTDATtDwwkqqoDgbgm9sb36usho81PjjWOP3Kh5ggbbctbOSv+6g6nKOk
         G58w==
X-Gm-Message-State: AOAM533X9BfDfm/XgJXOll2vazOGcKYv+TmbUAdRH578RJPAu+Oelmt7
        pUvN+CaybHlMWwo6avl7n04FS2ezUJ9pt3fI
X-Google-Smtp-Source: ABdhPJwuIuL8/TNu5L48K+zuPB2JexLrFAreY/Ud1v+kcNz0kgBSvMSCk88UCBtdnUXI55UOB3wRJDjTdqlNyCiC
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a0c:a819:: with SMTP id
 w25mr5283889qva.6.1612546515078; Fri, 05 Feb 2021 09:35:15 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:44 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <a26121b294fdf76e369cb7a74351d1c03a908930.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 10/13] arm64: kasan: simplify and inline MTE functions
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change provides a simpler implementation of mte_get_mem_tag(),
mte_get_random_tag(), and mte_set_mem_tag_range().

Simplifications include removing system_supports_mte() checks as these
functions are onlye called from KASAN runtime that had already checked
system_supports_mte(). Besides that, size and address alignment checks
are removed from mte_set_mem_tag_range(), as KASAN now does those.

This change also moves these functions into the asm/mte-kasan.h header
and implements mte_set_mem_tag_range() via inline assembly to avoid
unnecessary functions calls.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/cache.h     |  1 -
 arch/arm64/include/asm/kasan.h     |  1 +
 arch/arm64/include/asm/mte-def.h   |  2 +
 arch/arm64/include/asm/mte-kasan.h | 65 ++++++++++++++++++++++++++----
 arch/arm64/include/asm/mte.h       |  2 -
 arch/arm64/kernel/mte.c            | 46 ---------------------
 arch/arm64/lib/mte.S               | 16 --------
 7 files changed, 60 insertions(+), 73 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 77cbbe3625f2..a074459f8f2f 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -6,7 +6,6 @@
 #define __ASM_CACHE_H
 
 #include <asm/cputype.h>
-#include <asm/mte-kasan.h>
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index 0aaf9044cd6a..12d5f47f7dbe 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -6,6 +6,7 @@
 
 #include <linux/linkage.h>
 #include <asm/memory.h>
+#include <asm/mte-kasan.h>
 #include <asm/pgtable-types.h>
 
 #define arch_kasan_set_tag(addr, tag)	__tag_set(addr, tag)
diff --git a/arch/arm64/include/asm/mte-def.h b/arch/arm64/include/asm/mte-def.h
index 2d73a1612f09..cf241b0f0a42 100644
--- a/arch/arm64/include/asm/mte-def.h
+++ b/arch/arm64/include/asm/mte-def.h
@@ -11,4 +11,6 @@
 #define MTE_TAG_SIZE		4
 #define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
 
+#define __MTE_PREAMBLE		ARM64_ASM_PREAMBLE ".arch_extension memtag\n"
+
 #endif /* __ASM_MTE_DEF_H  */
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 3748d5bb88c0..3d58489228c0 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -11,11 +11,14 @@
 
 #include <linux/types.h>
 
+#ifdef CONFIG_ARM64_MTE
+
 /*
- * The functions below are meant to be used only for the
- * KASAN_HW_TAGS interface defined in asm/memory.h.
+ * These functions are meant to be only used from KASAN runtime through
+ * the arch_*() interface defined in asm/memory.h.
+ * These functions don't include system_supports_mte() checks,
+ * as KASAN only calls them when MTE is supported and enabled.
  */
-#ifdef CONFIG_ARM64_MTE
 
 static inline u8 mte_get_ptr_tag(void *ptr)
 {
@@ -25,9 +28,54 @@ static inline u8 mte_get_ptr_tag(void *ptr)
 	return tag;
 }
 
-u8 mte_get_mem_tag(void *addr);
-u8 mte_get_random_tag(void);
-void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
+/* Get allocation tag for the address. */
+static inline u8 mte_get_mem_tag(void *addr)
+{
+	asm(__MTE_PREAMBLE "ldg %0, [%0]"
+		: "+r" (addr));
+
+	return mte_get_ptr_tag(addr);
+}
+
+/* Generate a random tag. */
+static inline u8 mte_get_random_tag(void)
+{
+	void *addr;
+
+	asm(__MTE_PREAMBLE "irg %0, %0"
+		: "+r" (addr));
+
+	return mte_get_ptr_tag(addr);
+}
+
+/*
+ * Assign allocation tags for a region of memory based on the pointer tag.
+ * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
+ * size must be non-zero and MTE_GRANULE_SIZE aligned.
+ */
+static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
+{
+	u64 curr, end;
+
+	if (!size)
+		return;
+
+	curr = (u64)__tag_set(addr, tag);
+	end = curr + size;
+
+	do {
+		/*
+		 * 'asm volatile' is required to prevent the compiler to move
+		 * the statement outside of the loop.
+		 */
+		asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
+			     :
+			     : "r" (curr)
+			     : "memory");
+
+		curr += MTE_GRANULE_SIZE;
+	} while (curr != end);
+}
 
 void mte_enable_kernel(void);
 void mte_init_tags(u64 max_tag);
@@ -46,13 +94,14 @@ static inline u8 mte_get_mem_tag(void *addr)
 {
 	return 0xFF;
 }
+
 static inline u8 mte_get_random_tag(void)
 {
 	return 0xFF;
 }
-static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
+
+static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 {
-	return addr;
 }
 
 static inline void mte_enable_kernel(void)
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index d02aff9f493d..9b557a457f24 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -8,8 +8,6 @@
 #include <asm/compiler.h>
 #include <asm/mte-def.h>
 
-#define __MTE_PREAMBLE		ARM64_ASM_PREAMBLE ".arch_extension memtag\n"
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitfield.h>
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index c63b3d7a3cd9..203108d51d40 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -19,7 +19,6 @@
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
-#include <asm/mte-kasan.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
@@ -88,51 +87,6 @@ int memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
-u8 mte_get_mem_tag(void *addr)
-{
-	if (!system_supports_mte())
-		return 0xFF;
-
-	asm(__MTE_PREAMBLE "ldg %0, [%0]"
-	    : "+r" (addr));
-
-	return mte_get_ptr_tag(addr);
-}
-
-u8 mte_get_random_tag(void)
-{
-	void *addr;
-
-	if (!system_supports_mte())
-		return 0xFF;
-
-	asm(__MTE_PREAMBLE "irg %0, %0"
-	    : "+r" (addr));
-
-	return mte_get_ptr_tag(addr);
-}
-
-void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
-{
-	void *ptr = addr;
-
-	if ((!system_supports_mte()) || (size == 0))
-		return addr;
-
-	/* Make sure that size is MTE granule aligned. */
-	WARN_ON(size & (MTE_GRANULE_SIZE - 1));
-
-	/* Make sure that the address is MTE granule aligned. */
-	WARN_ON((u64)addr & (MTE_GRANULE_SIZE - 1));
-
-	tag = 0xF0 | tag;
-	ptr = (void *)__tag_set(ptr, tag);
-
-	mte_assign_mem_tag_range(ptr, size);
-
-	return ptr;
-}
-
 void mte_init_tags(u64 max_tag)
 {
 	static bool gcr_kernel_excl_initialized;
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 9e1a12e10053..351537c12f36 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -149,19 +149,3 @@ SYM_FUNC_START(mte_restore_page_tags)
 
 	ret
 SYM_FUNC_END(mte_restore_page_tags)
-
-/*
- * Assign allocation tags for a region of memory based on the pointer tag
- *   x0 - source pointer
- *   x1 - size
- *
- * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
- * size must be non-zero and MTE_GRANULE_SIZE aligned.
- */
-SYM_FUNC_START(mte_assign_mem_tag_range)
-1:	stg	x0, [x0]
-	add	x0, x0, #MTE_GRANULE_SIZE
-	subs	x1, x1, #MTE_GRANULE_SIZE
-	b.gt	1b
-	ret
-SYM_FUNC_END(mte_assign_mem_tag_range)
-- 
2.30.0.365.g02bc693789-goog

