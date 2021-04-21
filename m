Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7987D36697F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhDUKwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhDUKwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:52:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC56C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:52:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z8-20020a2566480000b02904e0f6f67f42so15505145ybm.15
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OxgBhA98k3tGthKxuSN/4brjg9G3Dacp3flVNK8rvYo=;
        b=kZCrucRDppiGDBPjAXIIXIo0MxE4/IyqxJJhXwKZnRZitxeGk0n/gU50Zw9DaWrpD+
         dIpvk0jbhDyEE//vafgmDxLrgr2YyYm66YH+SiaJKfmQozMx5XcaeO5hf4eWzECEKjp0
         DelqluZ8nf+mHKY0XVzdVwGk8ty9BSH78j0/6K/wFDufY5AfFSbPeh8A4xraPkTh886n
         9Z4kUhLBAsqyKAVGsv02WcAeZV3sEBGaDgqRuEJcNLLQHQPf3JIiEw3lCSUgcKZvdDXG
         xeUD6XPpxzPQXIngH07/btqdDuRqSxVDtooRU6+D+Q1pVBCH9B7GNwaUSnOrJcrjCtc4
         Zjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OxgBhA98k3tGthKxuSN/4brjg9G3Dacp3flVNK8rvYo=;
        b=eNxszgfgKn0noVfFkqLfOWc0CLJAmikyl/hTc1T/62Sw0l9UFVZIcokP6V22YNl2Vi
         wknoZY99tIC8oqI97aYHjXMwcd8DdNS5y36iGmowuZ6FmkxUdlm80wMzrNgMfT2Py9C5
         S6AvxQBKkxM+iZ2cgAtq8z+2jATxhGSAAv5nX1DxfmUdviPQzAeykmHIEvq1JT0v8WeB
         yqiX1JtLNc7s3HIrwOHYESzDE3Rr3NWRp7Bda0p7bHs+8YFYvUvDdtIwrDJTJqn2UyFF
         9vr9Twz+Kwn2BR9uhUY4gr/exlYaQ8aR0xnD4Punjfe9NpTqAU3NdgOoFeBrxLaTeec+
         PO1A==
X-Gm-Message-State: AOAM5333ZFggrvkq30HvdrdIGDyS4j6H9oIsliDTl6h6/KD2FuUw8SDi
        ytnFm0xJKvfYGEOwZ5VP76P++nyyAg==
X-Google-Smtp-Source: ABdhPJxnxD3CB/9+5BCPqRdLBDuWnvcCjjRpgFvxXOW0RsfmOBJPVhGilgvJZ/ty/H3/94vwogLNxmc1JQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:c552:ee7c:6a14:80cc])
 (user=elver job=sendgmr) by 2002:a25:8b86:: with SMTP id j6mr29548944ybl.470.1619002322474;
 Wed, 21 Apr 2021 03:52:02 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:51:30 +0200
In-Reply-To: <20210421105132.3965998-1-elver@google.com>
Message-Id: <20210421105132.3965998-2-elver@google.com>
Mime-Version: 1.0
References: <20210421105132.3965998-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2 1/3] kfence: await for allocation using wait_event
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com, hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mostly-idle systems, we have observed that toggle_allocation_gate()
is a cause of frequent wake-ups, preventing an otherwise idle CPU to go
into a lower power state.

A late change in KFENCE's development, due to a potential deadlock [1],
required changing the scheduling-friendly wait_event_timeout() and
wake_up() to an open-coded wait-loop using schedule_timeout().
[1] https://lkml.kernel.org/r/000000000000c0645805b7f982e4@google.com

To avoid unnecessary wake-ups, switch to using wait_event_timeout().

Unfortunately, we still cannot use a version with direct wake_up() in
__kfence_alloc() due to the same potential for deadlock as in [1].
Instead, add a level of indirection via an irq_work that is scheduled if
we determine that the kfence_timer requires a wake_up().

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Replace kfence_timer_waiting with simpler waitqueue_active() check.
---
 lib/Kconfig.kfence |  1 +
 mm/kfence/core.c   | 45 +++++++++++++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index 78f50ccb3b45..e641add33947 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -7,6 +7,7 @@ menuconfig KFENCE
 	bool "KFENCE: low-overhead sampling-based memory safety error detector"
 	depends on HAVE_ARCH_KFENCE && (SLAB || SLUB)
 	select STACKTRACE
+	select IRQ_WORK
 	help
 	  KFENCE is a low-overhead sampling-based detector of heap out-of-bounds
 	  access, use-after-free, and invalid-free errors. KFENCE is designed
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 768dbd58170d..235d726f88bc 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/debugfs.h>
+#include <linux/irq_work.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kfence.h>
 #include <linux/kmemleak.h>
@@ -587,6 +588,17 @@ late_initcall(kfence_debugfs_init);
 
 /* === Allocation Gate Timer ================================================ */
 
+#ifdef CONFIG_KFENCE_STATIC_KEYS
+/* Wait queue to wake up allocation-gate timer task. */
+static DECLARE_WAIT_QUEUE_HEAD(allocation_wait);
+
+static void wake_up_kfence_timer(struct irq_work *work)
+{
+	wake_up(&allocation_wait);
+}
+static DEFINE_IRQ_WORK(wake_up_kfence_timer_work, wake_up_kfence_timer);
+#endif
+
 /*
  * Set up delayed work, which will enable and disable the static key. We need to
  * use a work queue (rather than a simple timer), since enabling and disabling a
@@ -604,25 +616,13 @@ static void toggle_allocation_gate(struct work_struct *work)
 	if (!READ_ONCE(kfence_enabled))
 		return;
 
-	/* Enable static key, and await allocation to happen. */
 	atomic_set(&kfence_allocation_gate, 0);
 #ifdef CONFIG_KFENCE_STATIC_KEYS
+	/* Enable static key, and await allocation to happen. */
 	static_branch_enable(&kfence_allocation_key);
-	/*
-	 * Await an allocation. Timeout after 1 second, in case the kernel stops
-	 * doing allocations, to avoid stalling this worker task for too long.
-	 */
-	{
-		unsigned long end_wait = jiffies + HZ;
-
-		do {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			if (atomic_read(&kfence_allocation_gate) != 0)
-				break;
-			schedule_timeout(1);
-		} while (time_before(jiffies, end_wait));
-		__set_current_state(TASK_RUNNING);
-	}
+
+	wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate), HZ);
+
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
 #endif
@@ -729,6 +729,19 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	 */
 	if (atomic_read(&kfence_allocation_gate) || atomic_inc_return(&kfence_allocation_gate) > 1)
 		return NULL;
+#ifdef CONFIG_KFENCE_STATIC_KEYS
+	/*
+	 * waitqueue_active() is fully ordered after the update of
+	 * kfence_allocation_gate per atomic_inc_return().
+	 */
+	if (waitqueue_active(&allocation_wait)) {
+		/*
+		 * Calling wake_up() here may deadlock when allocations happen
+		 * from within timer code. Use an irq_work to defer it.
+		 */
+		irq_work_queue(&wake_up_kfence_timer_work);
+	}
+#endif
 
 	if (!READ_ONCE(kfence_enabled))
 		return NULL;
-- 
2.31.1.368.gbe11c130af-goog

