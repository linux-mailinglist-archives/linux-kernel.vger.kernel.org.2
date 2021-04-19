Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1C363E03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhDSIva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbhDSIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:51:27 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A20C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:50:57 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id 91-20020adf82e40000b0290106e67e7bfcso5906292wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vYl7G57j5M+nH2KzFf9qyrbxlx0FOF9ni4b2Z/4AoS0=;
        b=j0gtczwPaI+cs4X0SI5bpT9FOnjc+W1uVLyPs+aAetSjO6f/HrBMPoDZh+5dwauc8V
         kTvpy2Rw30R4hN4dZp79bF54547BHLL5vfc8Ddi8dgyAMd32lQuK1DXC7o24cIxc4rD0
         wJN7MOgPITZgUKAYi/eqGlBnLoS5ODMaseG7ew4M80eB7J0Et6VGG68cXC8dNLkyf7+1
         mlHjE1wEFTENGwOCoLTjzRawVMw8mhMf7wfJPKh3oxjoQ8dsdW2DU9SC6EIeNsBcrSWE
         CuCA0uD5l6ccw2Iu0dGpmG88BxIntliqMSt4CRRJhmr0HEjtEl+pP4LfAJ6EpPmjps4B
         GiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vYl7G57j5M+nH2KzFf9qyrbxlx0FOF9ni4b2Z/4AoS0=;
        b=bLrcGlGfY5xHaWmdDs2kr15R7oa09e7q9oJ+Ypdr5Mb07LJJ5Ydjtnbd2VBdcyvRg7
         AnBJgan6QQcQHNbVtt4Kld3x/tA+C7dDJ5EBWsif58L621j4QSX9h46N3uwGKKsMkIXT
         c7+DEujecF8vHYNtB1SiApn8Lia9HDF4XVmNk0rJmgjItgH0PIjefOWvSwoGuN9AB9Wo
         Hq9wO3MsaK4+S51f1Fg5d7MMe3EdDODu7H6MrZWyYFdEjr5SkfMoZvVxIBBXFIwExYxc
         eRu6btrPQdhJ997etQ9sEjaso4hEJtKUnL+7RZeE8jub9oRxJz41PfA3C0nUA1NqD2xg
         nJjQ==
X-Gm-Message-State: AOAM530p4v4oju7srHcD1Ykg+QfLlUcnPF+DE4BFjH1gntaNZ3R9ZrNo
        9tSpTB5cz12yB+YLXdIZGIyj2GRmHw==
X-Google-Smtp-Source: ABdhPJzkMlFib2sTj44vDpZc4hhB+ZlXfwBn2wMs7xBakSpQW9OwsdQEzis16G7Q5uQB4QEPzu3OjKS06Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:92f8:c03b:1448:ada5])
 (user=elver job=sendgmr) by 2002:a05:600c:48a6:: with SMTP id
 j38mr20532545wmp.99.1618822256477; Mon, 19 Apr 2021 01:50:56 -0700 (PDT)
Date:   Mon, 19 Apr 2021 10:50:25 +0200
In-Reply-To: <20210419085027.761150-1-elver@google.com>
Message-Id: <20210419085027.761150-2-elver@google.com>
Mime-Version: 1.0
References: <20210419085027.761150-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 1/3] kfence: await for allocation using wait_event
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com
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
 lib/Kconfig.kfence |  1 +
 mm/kfence/core.c   | 58 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 43 insertions(+), 16 deletions(-)

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
index 768dbd58170d..5f0a56041549 100644
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
@@ -587,6 +588,20 @@ late_initcall(kfence_debugfs_init);
 
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
+
+/* Indicate if timer task is waiting, to avoid unnecessary irq_work. */
+static bool kfence_timer_waiting;
+#endif
+
 /*
  * Set up delayed work, which will enable and disable the static key. We need to
  * use a work queue (rather than a simple timer), since enabling and disabling a
@@ -604,25 +619,16 @@ static void toggle_allocation_gate(struct work_struct *work)
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
+	WRITE_ONCE(kfence_timer_waiting, true);
+	smp_mb(); /* See comment in __kfence_alloc(). */
+	wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate), HZ);
+	smp_store_release(&kfence_timer_waiting, false); /* Order after wait_event(). */
+
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
 #endif
@@ -729,6 +735,26 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	 */
 	if (atomic_read(&kfence_allocation_gate) || atomic_inc_return(&kfence_allocation_gate) > 1)
 		return NULL;
+#ifdef CONFIG_KFENCE_STATIC_KEYS
+	/*
+	 * Read of kfence_timer_waiting must be ordered after write to
+	 * kfence_allocation_gate (fully ordered per atomic_inc_return()).
+	 *
+	 * Conversely, the write to kfence_timer_waiting must be ordered before
+	 * the check of kfence_allocation_gate in toggle_allocation_gate().
+	 *
+	 * This ensures that toggle_allocation_gate() always sees the updated
+	 * kfence_allocation_gate, or we see that the timer is waiting and will
+	 * queue the work to wake it up.
+	 */
+	if (READ_ONCE(kfence_timer_waiting)) {
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

