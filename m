Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B540863F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhIMIQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:16:14 -0400
Received: from foss.arm.com ([217.140.110.172]:54914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237987AbhIMIQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:16:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090D11042;
        Mon, 13 Sep 2021 01:14:50 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24CC53F5A1;
        Mon, 13 Sep 2021 01:14:48 -0700 (PDT)
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
Subject: [PATCH 5/5] kasan: Extend KASAN mode kernel parameter
Date:   Mon, 13 Sep 2021 09:14:24 +0100
Message-Id: <20210913081424.48613-6-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913081424.48613-1-vincenzo.frascino@arm.com>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
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
---
 Documentation/dev-tools/kasan.rst | 10 ++++++++--
 mm/kasan/hw_tags.c                | 27 ++++++++++++++++++++++-----
 mm/kasan/kasan.h                  |  5 +++++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 21dc03bc10a4..7f43e603bfbe 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -194,14 +194,20 @@ additional boot parameters that allow disabling KASAN or controlling features:
 
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
+  Asymmetric mode: a bad access is detected immediately when a tag
+  check fault occurs during a load operation and its detection is
+  delayed during a store operation. For the store operations the kernel
+  periodically checks the hardware and only reports tag faults during
+  these checks.
 
 - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
   traces collection (default: ``on``).
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
index 3639e7c8bb98..a8be62058d32 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -287,6 +287,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #ifndef arch_enable_tagging_async
 #define arch_enable_tagging_async()
 #endif
+#ifndef arch_enable_tagging_asymm
+#define arch_enable_tagging_asymm()
+#endif
 #ifndef arch_force_async_tag_fault
 #define arch_force_async_tag_fault()
 #endif
@@ -302,6 +305,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #define hw_enable_tagging_sync()		arch_enable_tagging_sync()
 #define hw_enable_tagging_async()		arch_enable_tagging_async()
+#define hw_enable_tagging_asymm()		arch_enable_tagging_asymm()
 #define hw_force_async_tag_fault()		arch_force_async_tag_fault()
 #define hw_get_random_tag()			arch_get_random_tag()
 #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
@@ -312,6 +316,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #define hw_enable_tagging_sync()
 #define hw_enable_tagging_async()
+#define hw_enable_tagging_asymm()
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
-- 
2.33.0

