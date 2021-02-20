Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33B03207A4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 00:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBTXXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 18:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhBTXWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 18:22:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00EC061786
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c19so5893313pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tV4RBrfHWy0xgCRmlWyctyDTYGwi60ErDkvqvfIJvYA=;
        b=ZY1b1OaNu0bPV649/ceNNCnFEe3oWGyX4Q84+CIJDjWbrl4iPum0uvX/0kjaznLj35
         6JBOmriiTVAKOycLJ6RyLeRrlZO1izo8R0sKhcY58RaAcMPYqoolsWZttR+t/+hGIHkh
         TvgGIbMiVvi5wGkg8/cCcQJBGBMF0jZcPKBp0ZJCole+nM10UQUnvxnlkFa9hhUHaAco
         QH7lccrU0wR1s/LAaNFqC2WpK4fOdHDSMx46twwmB8ZLEB5nsF1CROS+1JnN7pgKN41e
         m8LKvVRVSl35ZVc0E7cNVSMs56yP4Tp/luo9HkObeFOgo1J1hkS+YfQwXP8EuGjhPkfd
         w6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tV4RBrfHWy0xgCRmlWyctyDTYGwi60ErDkvqvfIJvYA=;
        b=A89CCGm44kZjkNqPiEcUdUrt0GaPkw5VaAOynqCWrRbqbvaFfWialIPkSJhw9duGJF
         wyEwGHMzAC5l+klarqV/oJDO9HliMWlJIK+RK00R8IEYOqMQrSZ88MRjEtw1xzsoe35/
         U8s4OY00PGPfsTocgd+zjxahoJNaU1n9R6kOpthEymk6fS6KIQce/J2TVJ3plRr1y15y
         +nC5biTzF2RMzcN7kNvi7LUJb9hWy4gNOm1a7LPm97x/yI20qh+tYa9np5IlCGqbmBp6
         03nkjO2uuBE2GdTvLpRJD4+mnxWP0Pu9yOD2+yGk4Sat+8+vEJnqE/Lf4GDeraU9ytM9
         B12Q==
X-Gm-Message-State: AOAM532mgRLZF4ji+xy1OyNXKUbb0Mek+6AWCgMkX6hfHrBljyMFa1+8
        9SrbE8HviB5t/v8eicl7PWm7rFIoQxOQaA==
X-Google-Smtp-Source: ABdhPJwTE4XbBxYpzMI/ddz7P4v8h1x5AERfoI/Gr/20YF+TR+/v8SuUzjTQSfw2/7gJ2jQYkOJV+A==
X-Received: by 2002:a17:90a:e603:: with SMTP id j3mr15963155pjy.161.1613863343467;
        Sat, 20 Feb 2021 15:22:23 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 4sm13171538pjc.23.2021.02.20.15.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 15:22:23 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v6 1/9] smp: Run functions concurrently in smp_call_function_many_cond()
Date:   Sat, 20 Feb 2021 15:17:04 -0800
Message-Id: <20210220231712.2475218-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220231712.2475218-1-namit@vmware.com>
References: <20210220231712.2475218-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Currently, on_each_cpu() and similar functions do not exploit the
potential of concurrency: the function is first executed remotely and
only then it is executed locally. Functions such as TLB flush can take
considerable time, so this provides an opportunity for performance
optimization.

To do so, modify smp_call_function_many_cond(), to allows the callers to
provide a function that should be executed (remotely/locally), and run
them concurrently. Keep other smp_call_function_many() semantic as it is
today for backward compatibility: the called function is not executed in
this case locally.

smp_call_function_many_cond() does not use the optimized version for a
single remote target that smp_call_function_single() implements. For
synchronous function call, smp_call_function_single() keeps a
call_single_data (which is used for synchronization) on the stack.
Interestingly, it seems that not using this optimization provides
greater performance improvements (greater speedup with a single remote
target than with multiple ones). Presumably, holding data structures
that are intended for synchronization on the stack can introduce
overheads due to TLB misses and false-sharing when the stack is used for
other purposes.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>

---
v5 -> v6:
* on_each_cpu_cond_mask() was missing preempt_disable/enable() [PeterZ]
* use multiplication instead of condition [PeterZ]
* assert preempt disabled on smp_call_function_many_cond()
* Break 80-char lines (Christoph)
---
 kernel/smp.c | 156 +++++++++++++++++++++++++++++----------------------
 1 file changed, 88 insertions(+), 68 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index aeb0adfa0606..c8a5a1facc1a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -608,12 +608,28 @@ int smp_call_function_any(const struct cpumask *mask,
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
+/*
+ * Flags to be used as scf_flags argument of smp_call_function_many_cond().
+ *
+ * %SCF_WAIT:		Wait until function execution is completed
+ * %SCF_RUN_LOCAL:	Run also locally if local cpu is set in cpumask
+ */
+#define SCF_WAIT	(1U << 0)
+#define SCF_RUN_LOCAL	(1U << 1)
+
 static void smp_call_function_many_cond(const struct cpumask *mask,
 					smp_call_func_t func, void *info,
-					bool wait, smp_cond_func_t cond_func)
+					unsigned int scf_flags,
+					smp_cond_func_t cond_func)
 {
+	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
-	int cpu, next_cpu, this_cpu = smp_processor_id();
+	bool wait = scf_flags & SCF_WAIT;
+	bool run_remote = false;
+	bool run_local = false;
+	int nr_cpus = 0;
+
+	lockdep_assert_preemption_disabled();
 
 	/*
 	 * Can deadlock when called with interrupts disabled.
@@ -621,8 +637,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	 * send smp call function interrupt to this cpu and as such deadlocks
 	 * can't happen.
 	 */
-	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress && !early_boot_irqs_disabled);
+	if (cpu_online(this_cpu) && !oops_in_progress &&
+	    !early_boot_irqs_disabled)
+		lockdep_assert_irqs_enabled();
 
 	/*
 	 * When @wait we can deadlock when we interrupt between llist_add() and
@@ -632,60 +649,65 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	 */
 	WARN_ON_ONCE(!in_task());
 
-	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
+	/* Check if we need local execution. */
+	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask))
+		run_local = true;
+
+	/* Check if we need remote execution, i.e., any CPU excluding this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)
 		cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
+	if (cpu < nr_cpu_ids)
+		run_remote = true;
 
-	/* No online cpus?  We're done. */
-	if (cpu >= nr_cpu_ids)
-		return;
-
-	/* Do we have another CPU which isn't us? */
-	next_cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
-	if (next_cpu == this_cpu)
-		next_cpu = cpumask_next_and(next_cpu, mask, cpu_online_mask);
-
-	/* Fastpath: do that cpu by itself. */
-	if (next_cpu >= nr_cpu_ids) {
-		if (!cond_func || cond_func(cpu, info))
-			smp_call_function_single(cpu, func, info, wait);
-		return;
-	}
-
-	cfd = this_cpu_ptr(&cfd_data);
+	if (run_remote) {
+		cfd = this_cpu_ptr(&cfd_data);
+		cpumask_and(cfd->cpumask, mask, cpu_online_mask);
+		__cpumask_clear_cpu(this_cpu, cfd->cpumask);
 
-	cpumask_and(cfd->cpumask, mask, cpu_online_mask);
-	__cpumask_clear_cpu(this_cpu, cfd->cpumask);
-
-	/* Some callers race with other cpus changing the passed mask */
-	if (unlikely(!cpumask_weight(cfd->cpumask)))
-		return;
+		cpumask_clear(cfd->cpumask_ipi);
+		for_each_cpu(cpu, cfd->cpumask) {
+			call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
-	cpumask_clear(cfd->cpumask_ipi);
-	for_each_cpu(cpu, cfd->cpumask) {
-		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
+			if (cond_func && !cond_func(cpu, info))
+				continue;
 
-		if (cond_func && !cond_func(cpu, info))
-			continue;
-
-		csd_lock(csd);
-		if (wait)
-			csd->node.u_flags |= CSD_TYPE_SYNC;
-		csd->func = func;
-		csd->info = info;
+			csd_lock(csd);
+			if (wait)
+				csd->node.u_flags |= CSD_TYPE_SYNC;
+			csd->func = func;
+			csd->info = info;
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-		csd->node.src = smp_processor_id();
-		csd->node.dst = cpu;
+			csd->node.src = smp_processor_id();
+			csd->node.dst = cpu;
 #endif
-		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
-			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
+			if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
+				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
+				nr_cpus++;
+				last_cpu = cpu;
+			}
+		}
+
+		/*
+		 * Choose the most efficient way to send an IPI. Note that the
+		 * number of CPUs might be zero due to concurrent changes to the
+		 * provided mask.
+		 */
+		if (nr_cpus == 1)
+			arch_send_call_function_single_ipi(last_cpu);
+		else if (likely(nr_cpus > 1))
+			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}
 
-	/* Send a message to all CPUs in the map */
-	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+	if (run_local && (!cond_func || cond_func(this_cpu, info))) {
+		unsigned long flags;
 
-	if (wait) {
+		local_irq_save(flags);
+		func(info);
+		local_irq_restore(flags);
+	}
+
+	if (run_remote && wait) {
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
@@ -696,12 +718,14 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 }
 
 /**
- * smp_call_function_many(): Run a function on a set of other CPUs.
+ * smp_call_function_many(): Run a function on a set of CPUs.
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
+ * @flags: Bitmask that controls the operation. If %SCF_WAIT is set, wait
+ *        (atomically) until function has completed on other CPUs. If
+ *        %SCF_RUN_LOCAL is set, the function will also be run locally
+ *        if the local CPU is set in the @cpumask.
  *
  * If @wait is true, then returns once @func has returned.
  *
@@ -712,7 +736,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
 {
-	smp_call_function_many_cond(mask, func, info, wait, NULL);
+	smp_call_function_many_cond(mask, func, info, wait * SCF_WAIT, NULL);
 }
 EXPORT_SYMBOL(smp_call_function_many);
 
@@ -860,16 +884,15 @@ EXPORT_SYMBOL(on_each_cpu);
 void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
 			void *info, bool wait)
 {
-	int cpu = get_cpu();
+	unsigned int scf_flags;
 
-	smp_call_function_many(mask, func, info, wait);
-	if (cpumask_test_cpu(cpu, mask)) {
-		unsigned long flags;
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
-	}
-	put_cpu();
+	scf_flags = SCF_RUN_LOCAL;
+	if (wait)
+		scf_flags |= SCF_WAIT;
+
+	preempt_disable();
+	smp_call_function_many_cond(mask, func, info, scf_flags, NULL);
+	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_mask);
 
@@ -898,17 +921,14 @@ EXPORT_SYMBOL(on_each_cpu_mask);
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask)
 {
-	int cpu = get_cpu();
+	unsigned int scf_flags = SCF_RUN_LOCAL;
 
-	smp_call_function_many_cond(mask, func, info, wait, cond_func);
-	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
-		unsigned long flags;
+	if (wait)
+		scf_flags |= SCF_WAIT;
 
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
-	}
-	put_cpu();
+	preempt_disable();
+	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
+	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-- 
2.25.1

