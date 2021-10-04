Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316ED421863
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhJDUZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:25:15 -0400
Received: from foss.arm.com ([217.140.110.172]:36062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236196AbhJDUZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:25:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82065113E;
        Mon,  4 Oct 2021 13:23:20 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F6253F70D;
        Mon,  4 Oct 2021 13:23:18 -0700 (PDT)
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
Subject: [PATCH v2 5/5] kasan: Extend KASAN mode kernel parameter
Date:   Mon,  4 Oct 2021 21:22:53 +0100
Message-Id: <20211004202253.27857-6-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211004202253.27857-1-vincenzo.frascino@arm.com>
References: <20211004202253.27857-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures supported by KASAN_HW_TAGS can provide an asymmetric mode
of execution. On an MTE enabled arm64 hw for example this can be
identified with the asymmetric tagging mode of execution. In particular,
when such a mode is present, the CPU triggers a fault on a tag mismatch
during a load operation and asynchronously updates a register when a tag
mismatch is detected during a store operation.

Extend the KASAN HW execution mode kernel command line parameter to
support asymmetric mode.

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/dev-tools/kasan.rst |  7 +++++--
 lib/test_kasan.c                  |  2 +-
 mm/kasan/hw_tags.c                | 27 ++++++++++++++++++++++-----
 mm/kasan/kasan.h                  | 22 +++++++++++++++++++---
 mm/kasan/report.c                 |  2 +-
 5 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 21dc03bc10a4..8089c559d339 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -194,14 +194,17 @@ additional boot parameters that allow disabling KASAN or controlling features:
 
 - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
 
-- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
-  synchronous or asynchronous mode of execution (default: ``sync``).
+- ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
+  is configured in synchronous, asynchronous or asymmetric mode of
+  execution (default: ``sync``).
   Synchronous mode: a bad access is detected immediately when a tag
   check fault occurs.
   Asynchronous mode: a bad access detection is delayed. When a tag check
   fault occurs, the information is stored in hardware (in the TFSR_EL1
   register for arm64). The kernel periodically checks the hardware and
   only reports tag faults during these checks.
+  Asymmetric mode: a bad access is detected synchronously on reads and
+  asynchronously on writes.
 
 - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
   traces collection (default: ``on``).
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 8835e0784578..ebed755ebf34 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -88,7 +88,7 @@ static void kasan_test_exit(struct kunit *test)
  */
 #define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {			\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&				\
-	    !kasan_async_mode_enabled())				\
+	    kasan_sync_fault_possible())				\
 		migrate_disable();					\
 	KUNIT_EXPECT_FALSE(test, READ_ONCE(fail_data.report_found));	\
 	barrier();							\
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 05d1e9460e2e..87eb7aa13918 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -29,6 +29,7 @@ enum kasan_arg_mode {
 	KASAN_ARG_MODE_DEFAULT,
 	KASAN_ARG_MODE_SYNC,
 	KASAN_ARG_MODE_ASYNC,
+	KASAN_ARG_MODE_ASYMM,
 };
 
 enum kasan_arg_stacktrace {
@@ -49,6 +50,10 @@ EXPORT_SYMBOL(kasan_flag_enabled);
 bool kasan_flag_async __ro_after_init;
 EXPORT_SYMBOL_GPL(kasan_flag_async);
 
+/* Whether the asymmetric mode is enabled. */
+bool kasan_flag_asymm __ro_after_init;
+EXPORT_SYMBOL_GPL(kasan_flag_asymm);
+
 /* Whether to collect alloc/free stack traces. */
 DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
 
@@ -69,7 +74,7 @@ static int __init early_kasan_flag(char *arg)
 }
 early_param("kasan", early_kasan_flag);
 
-/* kasan.mode=sync/async */
+/* kasan.mode=sync/async/asymm */
 static int __init early_kasan_mode(char *arg)
 {
 	if (!arg)
@@ -79,6 +84,8 @@ static int __init early_kasan_mode(char *arg)
 		kasan_arg_mode = KASAN_ARG_MODE_SYNC;
 	else if (!strcmp(arg, "async"))
 		kasan_arg_mode = KASAN_ARG_MODE_ASYNC;
+	else if (!strcmp(arg, "asymm"))
+		kasan_arg_mode = KASAN_ARG_MODE_ASYMM;
 	else
 		return -EINVAL;
 
@@ -116,11 +123,13 @@ void kasan_init_hw_tags_cpu(void)
 		return;
 
 	/*
-	 * Enable async mode only when explicitly requested through
-	 * the command line.
+	 * Enable async or asymm modes only when explicitly requested
+	 * through the command line.
 	 */
 	if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
 		hw_enable_tagging_async();
+	else if (kasan_arg_mode == KASAN_ARG_MODE_ASYMM)
+		hw_enable_tagging_asymm();
 	else
 		hw_enable_tagging_sync();
 }
@@ -143,16 +152,24 @@ void __init kasan_init_hw_tags(void)
 	case KASAN_ARG_MODE_DEFAULT:
 		/*
 		 * Default to sync mode.
-		 * Do nothing, kasan_flag_async keeps its default value.
+		 * Do nothing, kasan_flag_async and kasan_flag_asymm keep
+		 * their default values.
 		 */
 		break;
 	case KASAN_ARG_MODE_SYNC:
-		/* Do nothing, kasan_flag_async keeps its default value. */
+		/*
+		 * Do nothing, kasan_flag_async and kasan_flag_asymm keep
+		 * their default values.
+		 */
 		break;
 	case KASAN_ARG_MODE_ASYNC:
 		/* Async mode enabled. */
 		kasan_flag_async = true;
 		break;
+	case KASAN_ARG_MODE_ASYMM:
+		/* Asymm mode enabled. */
+		kasan_flag_asymm = true;
+		break;
 	}
 
 	switch (kasan_arg_stacktrace) {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 3639e7c8bb98..1d331ce67dec 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -14,15 +14,21 @@
 
 DECLARE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
 extern bool kasan_flag_async __ro_after_init;
+extern bool kasan_flag_asymm __ro_after_init;
 
 static inline bool kasan_stack_collection_enabled(void)
 {
 	return static_branch_unlikely(&kasan_flag_stacktrace);
 }
 
-static inline bool kasan_async_mode_enabled(void)
+static inline bool kasan_async_fault_possible(void)
 {
-	return kasan_flag_async;
+	return kasan_flag_async | kasan_flag_asymm;
+}
+
+static inline bool kasan_sync_fault_possible(void)
+{
+	return !kasan_flag_async | kasan_flag_asymm;
 }
 #else
 
@@ -31,11 +37,16 @@ static inline bool kasan_stack_collection_enabled(void)
 	return true;
 }
 
-static inline bool kasan_async_mode_enabled(void)
+static inline bool kasan_async_fault_possible(void)
 {
 	return false;
 }
 
+static inline bool kasan_sync_fault_possible(void)
+{
+	return true;
+}
+
 #endif
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
@@ -287,6 +298,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #ifndef arch_enable_tagging_async
 #define arch_enable_tagging_async()
 #endif
+#ifndef arch_enable_tagging_asymm
+#define arch_enable_tagging_asymm()
+#endif
 #ifndef arch_force_async_tag_fault
 #define arch_force_async_tag_fault()
 #endif
@@ -302,6 +316,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #define hw_enable_tagging_sync()		arch_enable_tagging_sync()
 #define hw_enable_tagging_async()		arch_enable_tagging_async()
+#define hw_enable_tagging_asymm()		arch_enable_tagging_asymm()
 #define hw_force_async_tag_fault()		arch_force_async_tag_fault()
 #define hw_get_random_tag()			arch_get_random_tag()
 #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
@@ -312,6 +327,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #define hw_enable_tagging_sync()
 #define hw_enable_tagging_async()
+#define hw_enable_tagging_asymm()
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 884a950c7026..9da071ad930c 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -112,7 +112,7 @@ static void start_report(unsigned long *flags)
 
 static void end_report(unsigned long *flags, unsigned long addr)
 {
-	if (!kasan_async_mode_enabled())
+	if (!kasan_async_fault_possible())
 		trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
-- 
2.33.0

