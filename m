Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66788364A06
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbhDSSpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDSSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:45:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D73C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:45:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so8685611ybo.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=txGtE5OBaRSKSRhG0f4/f/o7EAA2cx8QOFvutq3JGho=;
        b=j2DPyy9wRqNdfA95LndINjcw54n+gtWnysw1meWxruqCEkeJeJ4wYspRZFuTWPy9g3
         WgSn3CaDvOPfiFX+5HYmBslU4gaMykva52ezF50xT9XLs5F3RJF6km8dBJSoBUqiyaWK
         cYCMDlVH+PNGX2Btve9tCLGYc+Us78sNxwED15no/FhRd92sBaKLFvo2aMO364hnNCHw
         btfLmxh0TFWn8hlXGU7jP1Z0ugO6aG4pSDdxPM5OWgb+yjTcUSIjHQjlPZfPwoAsulgU
         5Eaj0Y33nlLpBJhuwhvXnD9db+KXHptWZZ5zXqtQlVqd+d3gS0Q1s7Dyw/QYuYH4lN95
         lJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=txGtE5OBaRSKSRhG0f4/f/o7EAA2cx8QOFvutq3JGho=;
        b=AH5LihHZ+9hjVajbTeJD7TdzgG9MPclZuQE7ynbQVVC2gR7bdHEPMAIiR+oIF5gtLK
         uJQ7aycAPUw6dutNEyblYt/3u7VI+fRa3DPj1UBJ+XDsQ6XX1KEKL2+iguUNsKKPtI+8
         /eFKI/USf7B14At0cR1oS9s8r0z9kULgq/QbV2VR3K5gO6phuCX6KonkMsNWgY/cLCSS
         ePPhzL6nQPPFSZc7PuXYIMgSs5yyz+gz2HtPLnNosah49m1ngc1dWbtFkSNlX7iOXFqs
         pAuccI4/juswaxlujQ9CwI/L6cjjMoCiENZgdb+4MVaqOyZQ43xfti2YZQSgxzbzuk3Y
         /BQA==
X-Gm-Message-State: AOAM532rDQMRfUWWvEoi6s9L7TGYRXTa7HAUbxGH9LhC/s/3VKqfR3uz
        ZWxh05sdHXHLLnt/BXNxcaHza3Gpfowub0edjXXiRrryDjsk05Yym0PEQ9uOtd17LV4m+lSf41j
        R3vaPWbxrX/zub1YfW5m0aKa6A3/mZKLEK6k4itSwrVmbtij2KhERCuDKNxY9f4/LzxAL0A==
X-Google-Smtp-Source: ABdhPJxkmR7MzzLQ3I8PwlOyvn6JgcygQcvhKcJG1CdmwhG2F1KI/PbXzFdCZpB8CvDOuc9A4Ha0yDzhwQI=
X-Received: from lrizzo2.svl.corp.google.com ([2620:15c:2c4:201:a5f6:b401:34b8:d28e])
 (user=lrizzo job=sendgmr) by 2002:a25:4508:: with SMTP id s8mr19430308yba.473.1618857902719;
 Mon, 19 Apr 2021 11:45:02 -0700 (PDT)
Date:   Mon, 19 Apr 2021 11:44:55 -0700
Message-Id: <20210419184455.2987243-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH] smp: add a best_effort version of smp_call_function_many()
From:   Luigi Rizzo <lrizzo@google.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        axboe@kernel.dk, paulmck@kernel.org
Cc:     Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of the 'wait' argument, smp_call_function_many() must spin
if any of the target CPUs have their csd busy waiting to be processed
for a previous call. This may cause high tail latencies e.g. when some
of the target CPUs are running functions that disable interrupts for a
long time; getrusage() is one possible culprit.

Here we introduce a variant, __smp_call_function_many(), that adds
a third 'best_effort' mode to the two existing ones (nowait, wait).
In best effort mode, the call will skip CPUs whose csd is busy, and if
any CPU is skipped it returns -EBUSY and the set of busy in the mask.
This allows the caller to decide how to proceed, e.g. it might retry at
a later time, or use a private csd, etc..

The new function is a compromise to avoid touching existing callers of
smp_call_function_many(). If the feature is considered interesting, we
could even replace the 'wait' argument with a ternary 'mode' in all
smp_call_function_*() and derived methods.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/smp.h | 10 ++++++
 kernel/smp.c        | 75 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 70c6f6284dcf..5c6c7d3e1f19 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -75,6 +75,11 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
+/* Modes for __smp_call_function_many() */
+#define SMP_CFM_NOWAIT		0
+#define SMP_CFM_WAIT		1
+#define SMP_CFM_BEST_EFFORT	2
+
 #ifdef CONFIG_SMP
 
 #include <linux/preempt.h>
@@ -120,6 +125,8 @@ extern void smp_cpus_done(unsigned int max_cpus);
 void smp_call_function(smp_call_func_t func, void *info, int wait);
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait);
+int __smp_call_function_many(struct cpumask *mask, smp_call_func_t func,
+			     void *info, int mode);
 
 int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait);
@@ -170,6 +177,9 @@ static inline void smp_send_reschedule(int cpu) { }
 #define smp_prepare_boot_cpu()			do {} while (0)
 #define smp_call_function_many(mask, func, info, wait) \
 			(up_smp_call_function(func, info))
+#define ____smp_call_function_many(mask, func, info, mode) \
+		(up_smp_call_function(func, info), 0)
+
 static inline void call_function_init(void) { }
 
 static inline int
diff --git a/kernel/smp.c b/kernel/smp.c
index aeb0adfa0606..75155875fadc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -242,6 +242,18 @@ static __always_inline void csd_lock(call_single_data_t *csd)
 	smp_wmb();
 }
 
+static __always_inline bool csd_trylock(call_single_data_t *csd)
+{
+	unsigned int flags = READ_ONCE(csd->node.u_flags);
+
+	if (flags & CSD_FLAG_LOCK)
+		return false;
+	csd->node.u_flags |= CSD_FLAG_LOCK;
+	/* See csd_trylock() */
+	smp_wmb();
+	return true;
+}
+
 static __always_inline void csd_unlock(call_single_data_t *csd)
 {
 	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
@@ -608,12 +620,14 @@ int smp_call_function_any(const struct cpumask *mask,
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
-static void smp_call_function_many_cond(const struct cpumask *mask,
-					smp_call_func_t func, void *info,
-					bool wait, smp_cond_func_t cond_func)
+static struct cpumask *smp_call_function_many_cond(const struct cpumask *mask,
+						   smp_call_func_t func,
+						   void *info, int mode,
+						   smp_cond_func_t cond_func)
 {
 	struct call_function_data *cfd;
 	int cpu, next_cpu, this_cpu = smp_processor_id();
+	bool busy = false, wait = (mode == SMP_CFM_WAIT);
 
 	/*
 	 * Can deadlock when called with interrupts disabled.
@@ -639,18 +653,18 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	/* No online cpus?  We're done. */
 	if (cpu >= nr_cpu_ids)
-		return;
+		return NULL;
 
 	/* Do we have another CPU which isn't us? */
 	next_cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
 	if (next_cpu == this_cpu)
 		next_cpu = cpumask_next_and(next_cpu, mask, cpu_online_mask);
 
-	/* Fastpath: do that cpu by itself. */
-	if (next_cpu >= nr_cpu_ids) {
+	/* Fastpath: if not best-effort do that cpu by itself. */
+	if (next_cpu >= nr_cpu_ids && mode != SMP_CFM_BEST_EFFORT) {
 		if (!cond_func || cond_func(cpu, info))
 			smp_call_function_single(cpu, func, info, wait);
-		return;
+		return NULL;
 	}
 
 	cfd = this_cpu_ptr(&cfd_data);
@@ -660,7 +674,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	/* Some callers race with other cpus changing the passed mask */
 	if (unlikely(!cpumask_weight(cfd->cpumask)))
-		return;
+		return NULL;
 
 	cpumask_clear(cfd->cpumask_ipi);
 	for_each_cpu(cpu, cfd->cpumask) {
@@ -669,9 +683,17 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		if (cond_func && !cond_func(cpu, info))
 			continue;
 
-		csd_lock(csd);
-		if (wait)
-			csd->node.u_flags |= CSD_TYPE_SYNC;
+		if (mode == SMP_CFM_BEST_EFFORT) {
+			if (!csd_trylock(csd)) {
+				cpumask_clear_cpu(cpu, cfd->cpumask);
+				busy = true;
+				continue;
+			}
+		} else {
+			csd_lock(csd);
+			if (wait)
+				csd->node.u_flags |= CSD_TYPE_SYNC;
+		}
 		csd->func = func;
 		csd->info = info;
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
@@ -693,8 +715,32 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd_lock_wait(csd);
 		}
 	}
+	return busy ? cfd->cpumask : NULL;
 }
 
+/**
+ * Extended version of smp_call_function_many(). Same constraints.
+ * @mode == 0 same as wait = false, returns 0;
+ * @mode == 1 same as wait = true, returns 0;
+ * @mode = SMP_CFM_BEST_EFFORT: skips CPUs with previous pending requests,
+ *     returns 0 and *mask unmodified if no CPUs are skipped,
+ *     -EBUSY if CPUs are skipped, and *mask is the set of skipped CPUs
+ */
+int __smp_call_function_many(struct cpumask *mask, smp_call_func_t func,
+			     void *info, int mode)
+{
+	struct cpumask *ret = smp_call_function_many_cond(mask, func, info,
+							  mode, NULL);
+
+	if (!ret)
+		return 0;
+	cpumask_andnot(mask, mask, ret);
+	cpumask_and(mask, mask, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), mask);
+	return -EBUSY;
+}
+EXPORT_SYMBOL(__smp_call_function_many);
+
 /**
  * smp_call_function_many(): Run a function on a set of other CPUs.
  * @mask: The set of cpus to run on (only runs on online subset).
@@ -712,7 +758,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
 {
-	smp_call_function_many_cond(mask, func, info, wait, NULL);
+	const int mode = wait ? SMP_CFM_WAIT : SMP_CFM_NOWAIT;
+
+	smp_call_function_many_cond(mask, func, info, mode, NULL);
 }
 EXPORT_SYMBOL(smp_call_function_many);
 
@@ -898,9 +946,10 @@ EXPORT_SYMBOL(on_each_cpu_mask);
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask)
 {
+	const int mode = wait ? SMP_CFM_WAIT : SMP_CFM_NOWAIT;
 	int cpu = get_cpu();
 
-	smp_call_function_many_cond(mask, func, info, wait, cond_func);
+	smp_call_function_many_cond(mask, func, info, mode, cond_func);
 	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
 		unsigned long flags;
 
-- 
2.31.1.368.gbe11c130af-goog

