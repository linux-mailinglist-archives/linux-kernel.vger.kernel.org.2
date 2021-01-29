Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9B308CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhA2Suc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:50:32 -0500
Received: from foss.arm.com ([217.140.110.172]:53004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232498AbhA2SuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:50:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D8541509;
        Fri, 29 Jan 2021 10:49:19 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86B5A3F885;
        Fri, 29 Jan 2021 10:49:17 -0800 (PST)
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
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v10 2/4] kasan: Add KASAN mode kernel parameter
Date:   Fri, 29 Jan 2021 18:49:03 +0000
Message-Id: <20210129184905.29760-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129184905.29760-1-vincenzo.frascino@arm.com>
References: <20210129184905.29760-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures supported by KASAN_HW_TAGS can provide a sync or async mode
of execution. On an MTE enabled arm64 hw for example this can be identified
with the synchronous or asynchronous tagging mode of execution.
In synchronous mode, an exception is triggered if a tag check fault occurs.
In asynchronous mode, if a tag check fault occurs, the TFSR_EL1 register is
updated asynchronously. The kernel checks the corresponding bits
periodically.

KASAN requires a specific kernel command line parameter to make use of this
hw features.

Add KASAN HW execution mode kernel command line parameter.

Note: This patch adds the kasan.mode kernel parameter and the
sync/async kernel command line options to enable the described features.

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/dev-tools/kasan.rst |  9 +++++++++
 lib/test_kasan.c                  |  2 +-
 mm/kasan/hw_tags.c                | 32 ++++++++++++++++++++++++++++++-
 mm/kasan/kasan.h                  |  6 ++++--
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index e022b7506e37..e3dca4d1f2a7 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -161,6 +161,15 @@ particular KASAN features.
 
 - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
 
+- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
+  synchronous or asynchronous mode of execution (default: ``sync``).
+  Synchronous mode: a bad access is detected immediately when a tag
+  check fault occurs.
+  Asynchronous mode: a bad access detection is delayed. When a tag check
+  fault occurs, the information is stored in hardware (in the TFSR_EL1
+  register for arm64). The kernel periodically checks the hardware and
+  only reports tag faults during these checks.
+
 - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
   traces collection (default: ``on`` for ``CONFIG_DEBUG_KERNEL=y``, otherwise
   ``off``).
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index d16ec9e66806..7285dcf9fcc1 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -97,7 +97,7 @@ static void kasan_test_exit(struct kunit *test)
 			READ_ONCE(fail_data.report_found));	\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {			\
 		if (READ_ONCE(fail_data.report_found))		\
-			hw_enable_tagging();			\
+			hw_enable_tagging_sync();		\
 		migrate_enable();				\
 	}							\
 } while (0)
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index e529428e7a11..308a879a3798 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -25,6 +25,12 @@ enum kasan_arg {
 	KASAN_ARG_ON,
 };
 
+enum kasan_arg_mode {
+	KASAN_ARG_MODE_DEFAULT,
+	KASAN_ARG_MODE_SYNC,
+	KASAN_ARG_MODE_ASYNC,
+};
+
 enum kasan_arg_stacktrace {
 	KASAN_ARG_STACKTRACE_DEFAULT,
 	KASAN_ARG_STACKTRACE_OFF,
@@ -38,6 +44,7 @@ enum kasan_arg_fault {
 };
 
 static enum kasan_arg kasan_arg __ro_after_init;
+static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
 static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
 
@@ -68,6 +75,21 @@ static int __init early_kasan_flag(char *arg)
 }
 early_param("kasan", early_kasan_flag);
 
+/* kasan.mode=sync/async */
+static int __init early_kasan_mode(char *arg)
+{
+	/* If arg is not set the default mode is sync */
+	if ((!arg) || !strcmp(arg, "sync"))
+		kasan_arg_mode = KASAN_ARG_MODE_SYNC;
+	else if (!strcmp(arg, "async"))
+		kasan_arg_mode = KASAN_ARG_MODE_ASYNC;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.mode", early_kasan_mode);
+
 /* kasan.stacktrace=off/on */
 static int __init early_kasan_flag_stacktrace(char *arg)
 {
@@ -115,7 +137,15 @@ void kasan_init_hw_tags_cpu(void)
 		return;
 
 	hw_init_tags(KASAN_TAG_MAX);
-	hw_enable_tagging();
+
+	/*
+	 * Enable async mode only when explicitly requested through
+	 * the command line.
+	 */
+	if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
+		hw_enable_tagging_async();
+	else
+		hw_enable_tagging_sync();
 }
 
 /* kasan_init_hw_tags() is called once on boot CPU. */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 11c6e3650468..07d5cddf727c 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -294,7 +294,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
 #endif
 
-#define hw_enable_tagging()			arch_enable_tagging()
+#define hw_enable_tagging_sync()		arch_enable_tagging_sync()
+#define hw_enable_tagging_async()		arch_enable_tagging_async()
 #define hw_init_tags(max_tag)			arch_init_tags(max_tag)
 #define hw_set_tagging_report_once(state)	arch_set_tagging_report_once(state)
 #define hw_get_random_tag()			arch_get_random_tag()
@@ -303,7 +304,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #else /* CONFIG_KASAN_HW_TAGS */
 
-#define hw_enable_tagging()
+#define hw_enable_tagging_sync()
+#define hw_enable_tagging_async()
 #define hw_set_tagging_report_once(state)
 
 #endif /* CONFIG_KASAN_HW_TAGS */
-- 
2.30.0

