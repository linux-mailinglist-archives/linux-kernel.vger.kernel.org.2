Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F05311766
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhBEXpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhBEORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:43 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664DC061222
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:47:17 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id c13so4129466lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PREZUncIqPTZICTNMYAhqfkQODhaZIF+0hFoo18paHE=;
        b=konF6v6BnN243u57JzN3b95VF77A0Qj1x+GlllUtiuD8VnfG6AL7oWEx03hrBfwRj8
         aYE1+nYx+DzgmpLmNYFC4bk1hHc+2drX7wYZY0+sbzyQVai8e5ZWESQ57O8F1XO3Fv6O
         A80n2LSxNhH5p14Cz9+YH0Sh1eL3HyDaJn+FVtAuQU8Xbu8iNidaUe7LCekS99pT+1hH
         Oou+pgF6FEv+zEFiwfwff+OOi0SNFMv97nl9nABkE7clP+7820Ppjz1MdS8a+Ewetltv
         HG/rue7AEX/E9aasLQ/JlhnWPPmj1ImsCgoBRb7fVjcCHtXw3ovNJFB74SuoOphoobHx
         g20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PREZUncIqPTZICTNMYAhqfkQODhaZIF+0hFoo18paHE=;
        b=XoHNSUMKErGBPZczYxTwXqav4UmbuV8jdx87w3Xsk+WATqur/rKYW/0Li3dQKAydQU
         +DSSfGfNEg1cbLZ6yI/2vr3X5+ggUfnnjNmqluQJXOGf1KLYk5LiHmMe+SOnVijrN49h
         ZLGu8Lh0BBAUftAxOsKPn0T7yYN/8BGuyY8BIj2zcn3RV4i9XZhskDALMfbl6PVXNwq9
         b03ArRUc4jvkvZ46kuycMR+9aCAYFz2eNW2ZbLpauNYGe3YTdQ5e4mPax+AMpcvCSTcO
         JfYNaqx7UMrl3UjMr2RoNDJI8JCfhhvP4HaaoJKhkOaKOiZ4v2k800fjHAfJgZiAnVZx
         hL2A==
X-Gm-Message-State: AOAM532g3PqJ/ER4LMV3Tqn5ylSMvzz7nLZsLCgi19U2qzXb8WEOtkzy
        KAMzvtQ25ra7sTOGPUh+Yu7QysmHiGnnq4F6
X-Google-Smtp-Source: ABdhPJxLyOBedtBSH56Km8M+KSKGSY+TJY33YcVxBP++XHc1sb/s8ursYOVubg9JIcGS4jhcauoOBzI04W3jHs91
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:8611:: with SMTP id
 o17mr4584420ejx.145.1612539582294; Fri, 05 Feb 2021 07:39:42 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:11 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <a3c23942ba4352fbacf537ec7b5607b7f5c3eaaa.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 10/12] arm64: kasan: simplify and inline MTE functions
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
index 8ad981069afb..13be3afc37ac 100644
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
 
 void mte_enable_kernel_sync(void);
 void mte_enable_kernel_async(void);
@@ -47,13 +95,14 @@ static inline u8 mte_get_mem_tag(void *addr)
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
 
 static inline void mte_enable_kernel_sync(void)
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 237bb2f7309d..43169b978cd3 100644
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
index 7763ac1f2917..8b27b70e1aac 100644
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

