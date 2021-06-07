Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3087739DD29
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFGNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:00:19 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:53998 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhFGNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:00:17 -0400
Received: by mail-qv1-f73.google.com with SMTP id b24-20020a0cb3d80000b02901e78b82d74aso13077324qvf.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LQ3tKh70kw7RBhOdaRUlWmTt0SET4qyIX4Ra2qoSZ0I=;
        b=lyslfoE3IZG7mY4cbiwFyArLp7+wR26KRCVQFIMP71WQXaU8zzbqsPQfiNHN+Q/wgO
         kIuZyDS6trS4ngizKUmYXmb4ofET/BLi5oA3LEmkByf51POF+6W1+/nk0ZEQ3vM8/C06
         M4Ag0FzubLzj1emrFBKRH7DGsXS3gG9OCXbJa/KYppB5WLB4WPQ/TyOEVNbr1RjAtnkl
         yy72zYxkTtTumF39owRtSX1gaG6jz9ome2tEny9Td5TcZvtDbFOzbNHdAsVTnmiqoXFM
         tepQ3qde6hY9mkVP7DkoTXqmzC3lpAF0gsvtBJBf6DRm0Rb1XZ3Rztzq384LNAf1yDXD
         SdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LQ3tKh70kw7RBhOdaRUlWmTt0SET4qyIX4Ra2qoSZ0I=;
        b=M0W+VM0AeqvVA4kfKB35uJSxStJ6wxI1DBqYcyi8tJIwKN7u2df/t1R3/SqmBd8/6b
         6OOU05sbk0nxPBcQX2cKbBJ6w+HR5iFOrI5EfrgaqzCYlBXV8hxK2fAg1G08sV6QIlk/
         TPUztHFGShi4vBWAEgFPlH2K5N+zcAoboBsghEKvtYYwNPNShGoWEp5Q6cfjRPjOmbew
         a0eItXc0hJvJJ2VTpXYKpKo6aDLCkoEZvfXGd9N/ziJaIqFAvcIZ6+6MhtC70hMdv4ZG
         dXGgiTxYsu0XVlko/cXl98clhGUtbC+F2W8kO1aot2nnRO9GTzZu5bLZSZz2S+PQz6ht
         Rmug==
X-Gm-Message-State: AOAM5328Z653V8/EHIN+Q50kt9o+y8skaICEQs0pcEEfSLWlK9K885hJ
        jvqitGZy8yz8orsC9KaOzGymEAAkIA==
X-Google-Smtp-Source: ABdhPJwLgHtad+zc+c8rI4H0QUHlhjFzsVwQdHWrJy/4NC8N9K8gLB/0gyVajpabu5HAGf7N8n4TG9FcOg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:2587:50:741c:6fde])
 (user=elver job=sendgmr) by 2002:a0c:ab52:: with SMTP id i18mr17507070qvb.23.1623070636590;
 Mon, 07 Jun 2021 05:57:16 -0700 (PDT)
Date:   Mon,  7 Jun 2021 14:56:51 +0200
In-Reply-To: <20210607125653.1388091-1-elver@google.com>
Message-Id: <20210607125653.1388091-6-elver@google.com>
Mime-Version: 1.0
References: <20210607125653.1388091-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 5/7] kcsan: Rework atomic.h into permissive.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, will@kernel.org,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 17f974213b88..9df98a48e69d 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -124,6 +124,14 @@ Kconfig options:
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
index 530ae1bda8e7..000000000000
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
index 906100923b88..439edb9dcbb1 100644
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
index 000000000000..f90e30800c11
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
index c76fbb3ee09e..26f03c754d39 100644
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
2.32.0.rc1.229.g3e70b5a671-goog

