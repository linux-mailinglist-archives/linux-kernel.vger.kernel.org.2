Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494E63D18B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhGUU1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhGUU1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:27:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5A4361402;
        Wed, 21 Jul 2021 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901694;
        bh=8icGOcq4vSYzPJeZObx2Gomq7xiN7iYx5kTuQalHcMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKsQ4Hl4/kyWzZUncq6/H3Zh18v53QsklXQr37B8WdNNok6Y50zHOWXNTBlIL3VYg
         YKL1jXf97nIqF9U44FRdq3tGv8vgtlWn0IFsHDo62/Kt6ZOPkDSuPqvgmhvScHvqHn
         jPTG2784DKUkx0hc8S1auBH9ryOZcVSJ5/krawe9H869EW2HBIz43w9M04iuXUaWiI
         Cr1L2z5aZb7PnkSxbv7zuXPAP3/tO+xzKNmIRsTWfyZFpKvPINtUDaT+tUiPPAkYup
         RozWSB6MKBLMhGGKTxXaduQ5QAgs0VYZqM4v13P3UNB9/ZVgnlkFmOFDBR6esDMdve
         SlrsFIdEaLdBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 66C4E5C0BF4; Wed, 21 Jul 2021 14:08:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 5/8] kcsan: Rework atomic.h into permissive.h
Date:   Wed, 21 Jul 2021 14:08:09 -0700
Message-Id: <20210721210812.844740-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Rework atomic.h into permissive.h to better reflect its purpose, and
introduce kcsan_ignore_address() and kcsan_ignore_data_race().

Introduce CONFIG_KCSAN_PERMISSIVE and update the stub functions in
preparation for subsequent changes.

As before, developers who choose to use KCSAN in "strict" mode will see
all data races and are not affected. Furthermore, by relying on the
value-change filter logic for kcsan_ignore_data_race(), even if the
permissive rules are enabled, the opt-outs in report.c:skip_report()
override them (such as for RCU-related functions by default).

The option CONFIG_KCSAN_PERMISSIVE is disabled by default, so that the
documented default behaviour of KCSAN does not change. Instead, like
CONFIG_KCSAN_IGNORE_ATOMICS, the option needs to be explicitly opted in.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst |  8 ++++++
 kernel/kcsan/atomic.h             | 23 ---------------
 kernel/kcsan/core.c               | 33 ++++++++++++++++------
 kernel/kcsan/permissive.h         | 47 +++++++++++++++++++++++++++++++
 lib/Kconfig.kcsan                 | 10 +++++++
 5 files changed, 89 insertions(+), 32 deletions(-)
 delete mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/permissive.h

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 69dc9c502ccc5..7db43c7c09b8c 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -127,6 +127,14 @@ Kconfig options:
   causes KCSAN to not report data races due to conflicts where the only plain
   accesses are aligned writes up to word size.
 
+* ``CONFIG_KCSAN_PERMISSIVE``: Enable additional permissive rules to ignore
+  certain classes of common data races. Unlike the above, the rules are more
+  complex involving value-change patterns, access type, and address. This
+  option depends on ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y``. For details
+  please see the ``kernel/kcsan/permissive.h``. Testers and maintainers that
+  only focus on reports from specific subsystems and not the whole kernel are
+  recommended to disable this option.
+
 To use the strictest possible rules, select ``CONFIG_KCSAN_STRICT=y``, which
 configures KCSAN to follow the Linux-kernel memory consistency model (LKMM) as
 closely as possible.
diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
deleted file mode 100644
index 530ae1bda8e75..0000000000000
--- a/kernel/kcsan/atomic.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Rules for implicitly atomic memory accesses.
- *
- * Copyright (C) 2019, Google LLC.
- */
-
-#ifndef _KERNEL_KCSAN_ATOMIC_H
-#define _KERNEL_KCSAN_ATOMIC_H
-
-#include <linux/types.h>
-
-/*
- * Special rules for certain memory where concurrent conflicting accesses are
- * common, however, the current convention is to not mark them; returns true if
- * access to @ptr should be considered atomic. Called from slow-path.
- */
-static bool kcsan_is_atomic_special(const volatile void *ptr)
-{
-	return false;
-}
-
-#endif /* _KERNEL_KCSAN_ATOMIC_H */
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 906100923b888..439edb9dcbb13 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -20,9 +20,9 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 
-#include "atomic.h"
 #include "encoding.h"
 #include "kcsan.h"
+#include "permissive.h"
 
 static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
 unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
@@ -353,6 +353,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 					    atomic_long_t *watchpoint,
 					    long encoded_watchpoint)
 {
+	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
 	struct kcsan_ctx *ctx = get_ctx();
 	unsigned long flags;
 	bool consumed;
@@ -374,6 +375,16 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	if (ctx->access_mask)
 		return;
 
+	/*
+	 * If the other thread does not want to ignore the access, and there was
+	 * a value change as a result of this thread's operation, we will still
+	 * generate a report of unknown origin.
+	 *
+	 * Use CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=n to filter.
+	 */
+	if (!is_assert && kcsan_ignore_address(ptr))
+		return;
+
 	/*
 	 * Consuming the watchpoint must be guarded by kcsan_is_enabled() to
 	 * avoid erroneously triggering reports if the context is disabled.
@@ -396,7 +407,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_REPORT_RACES]);
 	}
 
-	if ((type & KCSAN_ACCESS_ASSERT) != 0)
+	if (is_assert)
 		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 	else
 		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_DATA_RACES]);
@@ -427,12 +438,10 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 
 	/*
-	 * Special atomic rules: unlikely to be true, so we check them here in
-	 * the slow-path, and not in the fast-path in is_atomic(). Call after
-	 * kcsan_is_enabled(), as we may access memory that is not yet
-	 * initialized during early boot.
+	 * Check to-ignore addresses after kcsan_is_enabled(), as we may access
+	 * memory that is not yet initialized during early boot.
 	 */
-	if (!is_assert && kcsan_is_atomic_special(ptr))
+	if (!is_assert && kcsan_ignore_address(ptr))
 		goto out;
 
 	if (!check_encodable((unsigned long)ptr, size)) {
@@ -518,8 +527,14 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	if (access_mask)
 		diff &= access_mask;
 
-	/* Were we able to observe a value-change? */
-	if (diff != 0)
+	/*
+	 * Check if we observed a value change.
+	 *
+	 * Also check if the data race should be ignored (the rules depend on
+	 * non-zero diff); if it is to be ignored, the below rules for
+	 * KCSAN_VALUE_CHANGE_MAYBE apply.
+	 */
+	if (diff && !kcsan_ignore_data_race(size, type, old, new, diff))
 		value_change = KCSAN_VALUE_CHANGE_TRUE;
 
 	/* Check if this access raced with another. */
diff --git a/kernel/kcsan/permissive.h b/kernel/kcsan/permissive.h
new file mode 100644
index 0000000000000..f90e30800c11b
--- /dev/null
+++ b/kernel/kcsan/permissive.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Special rules for ignoring entire classes of data-racy memory accesses. None
+ * of the rules here imply that such data races are generally safe!
+ *
+ * All rules in this file can be configured via CONFIG_KCSAN_PERMISSIVE. Keep
+ * them separate from core code to make it easier to audit.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
+
+#ifndef _KERNEL_KCSAN_PERMISSIVE_H
+#define _KERNEL_KCSAN_PERMISSIVE_H
+
+#include <linux/types.h>
+
+/*
+ * Access ignore rules based on address.
+ */
+static __always_inline bool kcsan_ignore_address(const volatile void *ptr)
+{
+	if (!IS_ENABLED(CONFIG_KCSAN_PERMISSIVE))
+		return false;
+
+	return false;
+}
+
+/*
+ * Data race ignore rules based on access type and value change patterns.
+ */
+static bool
+kcsan_ignore_data_race(size_t size, int type, u64 old, u64 new, u64 diff)
+{
+	if (!IS_ENABLED(CONFIG_KCSAN_PERMISSIVE))
+		return false;
+
+	/*
+	 * Rules here are only for plain read accesses, so that we still report
+	 * data races between plain read-write accesses.
+	 */
+	if (type || size > sizeof(long))
+		return false;
+
+	return false;
+}
+
+#endif /* _KERNEL_KCSAN_PERMISSIVE_H */
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index c76fbb3ee09ec..26f03c754d39b 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -231,4 +231,14 @@ config KCSAN_IGNORE_ATOMICS
 	  due to two conflicting plain writes will be reported (aligned and
 	  unaligned, if CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n).
 
+config KCSAN_PERMISSIVE
+	bool "Enable all additional permissive rules"
+	depends on KCSAN_REPORT_VALUE_CHANGE_ONLY
+	help
+	  Enable additional permissive rules to ignore certain classes of data
+	  races (also see kernel/kcsan/permissive.h). None of the permissive
+	  rules imply that such data races are generally safe, but can be used
+	  to further reduce reported data races due to data-racy patterns
+	  common across the kernel.
+
 endif # KCSAN
-- 
2.31.1.189.g2e36527f23

