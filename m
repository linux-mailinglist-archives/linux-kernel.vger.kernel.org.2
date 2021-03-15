Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42A033B3C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCONVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:21:22 -0400
Received: from foss.arm.com ([217.140.110.172]:40018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhCONUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:20:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268641474;
        Mon, 15 Mar 2021 06:20:48 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B5B3F792;
        Mon, 15 Mar 2021 06:20:46 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v16 9/9] kasan, arm64: tests supports for HW_TAGS async mode
Date:   Mon, 15 Mar 2021 13:20:19 +0000
Message-Id: <20210315132019.33202-10-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315132019.33202-1-vincenzo.frascino@arm.com>
References: <20210315132019.33202-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

This change adds KASAN-KUnit tests support for the async HW_TAGS mode.

In async mode, tag fault aren't being generated synchronously when a
bad access happens, but are instead explicitly checked for by the kernel.

As each KASAN-KUnit test expect a fault to happen before the test is over,
check for faults as a part of the test handler.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/memory.h |  1 +
 lib/test_kasan.c                | 17 +++++++++++------
 mm/kasan/hw_tags.c              |  6 ++++++
 mm/kasan/kasan.h                |  6 ++++++
 mm/kasan/report.c               |  5 +++++
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index a07923eb33c5..7d0fd4f36e23 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -246,6 +246,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 #define arch_enable_tagging_sync()		mte_enable_kernel_sync()
 #define arch_enable_tagging_async()		mte_enable_kernel_async()
 #define arch_set_tagging_report_once(state)	mte_set_report_once(state)
+#define arch_force_async_tag_fault()		mte_check_tfsr_exit()
 #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
 #define arch_get_random_tag()			mte_get_random_tag()
 #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 929fbe06b154..0882d6c17e62 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -69,10 +69,10 @@ static void kasan_test_exit(struct kunit *test)
  * resource named "kasan_data". Do not use this name for KUnit resources
  * outside of KASAN tests.
  *
- * For hardware tag-based KASAN, when a tag fault happens, tag checking is
- * normally auto-disabled. When this happens, this test handler reenables
- * tag checking. As tag checking can be only disabled or enabled per CPU, this
- * handler disables migration (preemption).
+ * For hardware tag-based KASAN in sync mode, when a tag fault happens, tag
+ * checking is auto-disabled. When this happens, this test handler reenables
+ * tag checking. As tag checking can be only disabled or enabled per CPU,
+ * this handler disables migration (preemption).
  *
  * Since the compiler doesn't see that the expression can change the fail_data
  * fields, it can reorder or optimize away the accesses to those fields.
@@ -80,7 +80,8 @@ static void kasan_test_exit(struct kunit *test)
  * expression to prevent that.
  */
 #define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {		\
-	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))			\
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&			\
+	    !kasan_async_mode_enabled())			\
 		migrate_disable();				\
 	WRITE_ONCE(fail_data.report_expected, true);		\
 	WRITE_ONCE(fail_data.report_found, false);		\
@@ -92,10 +93,14 @@ static void kasan_test_exit(struct kunit *test)
 	barrier();						\
 	expression;						\
 	barrier();						\
+	if (kasan_async_mode_enabled())				\
+		kasan_force_async_fault();			\
+	barrier();						\
 	KUNIT_EXPECT_EQ(test,					\
 			READ_ONCE(fail_data.report_expected),	\
 			READ_ONCE(fail_data.report_found));	\
-	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {			\
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&			\
+	    !kasan_async_mode_enabled()) {			\
 		if (READ_ONCE(fail_data.report_found))		\
 			kasan_enable_tagging_sync();		\
 		migrate_enable();				\
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 1df4ce803861..4004388b4e4b 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -252,4 +252,10 @@ void kasan_enable_tagging_sync(void)
 }
 EXPORT_SYMBOL_GPL(kasan_enable_tagging_sync);
 
+void kasan_force_async_fault(void)
+{
+	hw_force_async_tag_fault();
+}
+EXPORT_SYMBOL_GPL(kasan_force_async_fault);
+
 #endif
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 56b155ddaf30..f34253e29b4a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -304,6 +304,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #ifndef arch_set_tagging_report_once
 #define arch_set_tagging_report_once(state)
 #endif
+#ifndef arch_force_async_tag_fault
+#define arch_force_async_tag_fault()
+#endif
 #ifndef arch_get_random_tag
 #define arch_get_random_tag()	(0xFF)
 #endif
@@ -318,6 +321,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define hw_enable_tagging_async()		arch_enable_tagging_async()
 #define hw_init_tags(max_tag)			arch_init_tags(max_tag)
 #define hw_set_tagging_report_once(state)	arch_set_tagging_report_once(state)
+#define hw_force_async_tag_fault()		arch_force_async_tag_fault()
 #define hw_get_random_tag()			arch_get_random_tag()
 #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
 #define hw_set_mem_tag_range(addr, size, tag, init) \
@@ -335,11 +339,13 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 void kasan_set_tagging_report_once(bool state);
 void kasan_enable_tagging_sync(void);
+void kasan_force_async_fault(void);
 
 #else /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
 
 static inline void kasan_set_tagging_report_once(bool state) { }
 static inline void kasan_enable_tagging_sync(void) { }
+static inline void kasan_force_async_fault(void) { }
 
 #endif /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
 
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8b0843a2cdd7..14bd51ea2348 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -366,6 +366,11 @@ void kasan_report_async(void)
 {
 	unsigned long flags;
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 	start_report(&flags);
 	pr_err("BUG: KASAN: invalid-access\n");
 	pr_err("Asynchronous mode enabled: no access details available\n");
-- 
2.30.2

