Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9D4241CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbhJFPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:50:12 -0400
Received: from foss.arm.com ([217.140.110.172]:41572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239309AbhJFPuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:50:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85F5BED1;
        Wed,  6 Oct 2021 08:48:10 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A53DC3F70D;
        Wed,  6 Oct 2021 08:48:08 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     vincenzo.frascino@arm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 4/5] arm64: mte: Add asymmetric mode support
Date:   Wed,  6 Oct 2021 16:47:50 +0100
Message-Id: <20211006154751.4463-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006154751.4463-1-vincenzo.frascino@arm.com>
References: <20211006154751.4463-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MTE provides an asymmetric mode for detecting tag exceptions. In
particular, when such a mode is present, the CPU triggers a fault
on a tag mismatch during a load operation and asynchronously updates
a register when a tag mismatch is detected during a store operation.

Add support for MTE asymmetric mode.

Note: If the CPU does not support MTE asymmetric mode the kernel falls
back on synchronous mode which is the default for kasan=on.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/memory.h    |  1 +
 arch/arm64/include/asm/mte-kasan.h |  5 ++++
 arch/arm64/include/asm/mte.h       |  8 +++---
 arch/arm64/include/asm/uaccess.h   |  4 +--
 arch/arm64/kernel/mte.c            | 43 +++++++++++++++++++++++++-----
 5 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f1745a843414..1b9a1e242612 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -243,6 +243,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 #ifdef CONFIG_KASAN_HW_TAGS
 #define arch_enable_tagging_sync()		mte_enable_kernel_sync()
 #define arch_enable_tagging_async()		mte_enable_kernel_async()
+#define arch_enable_tagging_asymm()		mte_enable_kernel_asymm()
 #define arch_force_async_tag_fault()		mte_check_tfsr_exit()
 #define arch_get_random_tag()			mte_get_random_tag()
 #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 22420e1f8c03..478b9bcf69ad 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -130,6 +130,7 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag,
 
 void mte_enable_kernel_sync(void);
 void mte_enable_kernel_async(void);
+void mte_enable_kernel_asymm(void);
 
 #else /* CONFIG_ARM64_MTE */
 
@@ -161,6 +162,10 @@ static inline void mte_enable_kernel_async(void)
 {
 }
 
+static inline void mte_enable_kernel_asymm(void)
+{
+}
+
 #endif /* CONFIG_ARM64_MTE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 02511650cffe..075539f5f1c8 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -88,11 +88,11 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
 
 #ifdef CONFIG_KASAN_HW_TAGS
 /* Whether the MTE asynchronous mode is enabled. */
-DECLARE_STATIC_KEY_FALSE(mte_async_mode);
+DECLARE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
 
-static inline bool system_uses_mte_async_mode(void)
+static inline bool system_uses_mte_async_or_asymm_mode(void)
 {
-	return static_branch_unlikely(&mte_async_mode);
+	return static_branch_unlikely(&mte_async_or_asymm_mode);
 }
 
 void mte_check_tfsr_el1(void);
@@ -121,7 +121,7 @@ static inline void mte_check_tfsr_exit(void)
 	mte_check_tfsr_el1();
 }
 #else
-static inline bool system_uses_mte_async_mode(void)
+static inline bool system_uses_mte_async_or_asymm_mode(void)
 {
 	return false;
 }
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 190b494e22ab..315354047d69 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -196,13 +196,13 @@ static inline void __uaccess_enable_tco(void)
  */
 static inline void __uaccess_disable_tco_async(void)
 {
-	if (system_uses_mte_async_mode())
+	if (system_uses_mte_async_or_asymm_mode())
 		 __uaccess_disable_tco();
 }
 
 static inline void __uaccess_enable_tco_async(void)
 {
-	if (system_uses_mte_async_mode())
+	if (system_uses_mte_async_or_asymm_mode())
 		__uaccess_enable_tco();
 }
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index e5e801bc5312..d7da4e3924c4 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -26,9 +26,14 @@
 static DEFINE_PER_CPU_READ_MOSTLY(u64, mte_tcf_preferred);
 
 #ifdef CONFIG_KASAN_HW_TAGS
-/* Whether the MTE asynchronous mode is enabled. */
-DEFINE_STATIC_KEY_FALSE(mte_async_mode);
-EXPORT_SYMBOL_GPL(mte_async_mode);
+/*
+ * The MTE asynchronous and asymmetric mode have the same
+ * behavior for the store operations.
+ *
+ * Whether the MTE asynchronous or asymmetric mode is enabled.
+ */
+DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
+EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
 #endif
 
 static void mte_sync_page_tags(struct page *page, pte_t old_pte,
@@ -116,7 +121,7 @@ void mte_enable_kernel_sync(void)
 	 * Make sure we enter this function when no PE has set
 	 * async mode previously.
 	 */
-	WARN_ONCE(system_uses_mte_async_mode(),
+	WARN_ONCE(system_uses_mte_async_or_asymm_mode(),
 			"MTE async mode enabled system wide!");
 
 	__mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
@@ -134,8 +139,34 @@ void mte_enable_kernel_async(void)
 	 * mode in between sync and async, this strategy needs
 	 * to be reviewed.
 	 */
-	if (!system_uses_mte_async_mode())
-		static_branch_enable(&mte_async_mode);
+	if (!system_uses_mte_async_or_asymm_mode())
+		static_branch_enable(&mte_async_or_asymm_mode);
+}
+
+void mte_enable_kernel_asymm(void)
+{
+	if (cpus_have_cap(ARM64_MTE_ASYMM)) {
+		__mte_enable_kernel("asymmetric", SCTLR_ELx_TCF_ASYMM);
+
+		/*
+		 * MTE asymm mode behaves as async mode for store
+		 * operations. The mode is set system wide by the
+		 * first PE that executes this function.
+		 *
+		 * Note: If in future KASAN acquires a runtime switching
+		 * mode in between sync and async, this strategy needs
+		 * to be reviewed.
+		 */
+		if (!system_uses_mte_async_or_asymm_mode())
+			static_branch_enable(&mte_async_or_asymm_mode);
+	} else {
+		/*
+		 * If the CPU does not support MTE asymmetric mode the
+		 * kernel falls back on synchronous mode which is the
+		 * default for kasan=on.
+		 */
+		mte_enable_kernel_sync();
+	}
 }
 #endif
 
-- 
2.33.0

