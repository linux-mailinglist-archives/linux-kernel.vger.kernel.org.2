Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F6232C94C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392454AbhCDBGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1453025AbhCDAln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:41:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7EF664F1B;
        Thu,  4 Mar 2021 00:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818442;
        bh=3MJl0BDel1L6exw16Y1B2gal5XDghE+ZauNs3XdBKXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXqsi1zie4rE09gIumXfnm3HCRMRtr2PlVHZaR7j63JWr8OYneOo8JFcx7tiGeCrG
         M/u1w/+XOWk0RnYVryyMIIHenxZTZRPivnwdF/KjZfSQLBupXFwg5EBgknFVZMk7gH
         tQb5IXaQM5S9A2Wv3tpsptYrK0t9iZGLoeqn3eIvO7Oc0X2xzDDVCDAXq7z+2ERtLg
         d2sIweRaZlg4qoL4sn8g91pxUe1HN5n9IgKzuT/NI7RaiTZfo3XLWq9L/K9SQxXe7D
         ZtaotK0GxjAkBTzk/qsPnShPcnEEp8ROIqhTeCav6d1bMIFmYfNUmvkS02o+EGr0NQ
         K4J9vRcyYUHrA==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 4/4] kcsan: Add missing license and copyright headers
Date:   Wed,  3 Mar 2021 16:40:40 -0800
Message-Id: <20210304004040.25074-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Adds missing license and/or copyright headers for KCSAN source files.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 3 +++
 include/linux/kcsan-checks.h      | 6 ++++++
 include/linux/kcsan.h             | 7 +++++++
 kernel/kcsan/atomic.h             | 5 +++++
 kernel/kcsan/core.c               | 5 +++++
 kernel/kcsan/debugfs.c            | 5 +++++
 kernel/kcsan/encoding.h           | 5 +++++
 kernel/kcsan/kcsan.h              | 3 ++-
 kernel/kcsan/report.c             | 5 +++++
 kernel/kcsan/selftest.c           | 5 +++++
 10 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index be7a0b0..d85ce23 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2019, Google LLC.
+
 The Kernel Concurrency Sanitizer (KCSAN)
 ========================================
 
diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index cf14840..9fd0ad8 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -1,4 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KCSAN access checks and modifiers. These can be used to explicitly check
+ * uninstrumented accesses, or change KCSAN checking behaviour of accesses.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _LINUX_KCSAN_CHECKS_H
 #define _LINUX_KCSAN_CHECKS_H
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 53340d8..fc266ec 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -1,4 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. Public interface and
+ * data structures to set up runtime. See kcsan-checks.h for explicit checks and
+ * modifiers. For more info please see Documentation/dev-tools/kcsan.rst.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _LINUX_KCSAN_H
 #define _LINUX_KCSAN_H
diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index 75fe701..530ae1b 100644
--- a/kernel/kcsan/atomic.h
+++ b/kernel/kcsan/atomic.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Rules for implicitly atomic memory accesses.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _KERNEL_KCSAN_ATOMIC_H
 #define _KERNEL_KCSAN_ATOMIC_H
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 23e7acb..45c821d 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN core runtime.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kcsan: " fmt
 
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 209ad8d..c1dd02f 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN debugfs interface.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kcsan: " fmt
 
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 7ee4055..170a2bb 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KCSAN watchpoint encoding.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _KERNEL_KCSAN_ENCODING_H
 #define _KERNEL_KCSAN_ENCODING_H
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 87ccdb3..9881099 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 /*
  * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
  * see Documentation/dev-tools/kcsan.rst.
+ *
+ * Copyright (C) 2019, Google LLC.
  */
 
 #ifndef _KERNEL_KCSAN_KCSAN_H
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index d3bf87e..13dce3c 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN reporting.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #include <linux/debug_locks.h>
 #include <linux/delay.h>
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 9014a3a..7f29cb0 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN short boot-time selftests.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kcsan: " fmt
 
-- 
2.9.5

