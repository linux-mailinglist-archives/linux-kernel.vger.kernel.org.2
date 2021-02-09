Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FE0315BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhBJBCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbhBIWVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:21:46 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18040C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:21:17 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e12so89678pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZ7SfECiI01qzQd5pkoDVaSqFQohILm8dUyFC3HD1mU=;
        b=I+MBW32wti2MDkwCA2MkiQsKLztSQJRVpMKa+bqS592QSscmRVgtJrrigj7k8XWamB
         vP5nqfH0fd6y2abSo48eLW5PVyyZZAk9kutOrTjaLnLNKTUby18KcRsjUExHiKBtmUYT
         /LBcBpS7rnvEwy4iM2HeM1kzh29KUnXRkJSMRvoiJvxYIq2WVqF7k6KEHBnBfv79X3Ff
         wxrOJip/XZrjWUsKotO+FnfkgvgO0oQPytZnICDf4urd8pPzXjsk/TXNXG9GcusSQ7uY
         2hxQGZREj/QpSNt1WmAOaVSh4OHHc/eolMWPLy4aEeTeg/UKXpMNhAsuxJUkHSmCJA/V
         /iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZ7SfECiI01qzQd5pkoDVaSqFQohILm8dUyFC3HD1mU=;
        b=QpLx2BbFeqRfIxxF/XjtIi1Fs2wpzauCpMvJxycRYu5ATsLNrXRSmkh8zQlvJANxQI
         Wqlkh1pnz285Rmy3U1eFes5BKtVu6UmiHB0tphtoacPugHM0T311TjtSvIzjhkpE6e9Y
         diRq27SIjWXb6iV526cYvoVQ0fbbWvYorQvkvqnMdW5YusxAQQ4rdvbrNVqbVFVrHxX+
         CfumweReY/HgFinossVO54iGtjFRuVLh3W0wES2le3o/eQQJia31TlRSe23HWJx9rm6S
         pV/bA6rBuh2cY8o7l7B+aKOSBUPkoeAecjNt0ACDkN2hK1KI+Rlv/CaXkse8f6lLj31V
         wMgw==
X-Gm-Message-State: AOAM5329zxKRLhQuLRWN4ts9UARIs82HGipiYk64h/mE+KvuA+8Yo0mc
        6iATeuWfKgrgEU9C4yZNb2I=
X-Google-Smtp-Source: ABdhPJwwxMWs9Y8wqnEjqiHIOlAsvLnNfwBHu74IMX+L/sFdzuANd1JEIqzpYVfkk8XcsN4gjAJSMg==
X-Received: by 2002:a17:902:fe03:b029:e1:2c46:f3fd with SMTP id g3-20020a170902fe03b02900e12c46f3fdmr23452830plj.62.1612909276490;
        Tue, 09 Feb 2021 14:21:16 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v9sm58601pju.33.2021.02.09.14.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:21:15 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 1/8] smp: Run functions concurrently in smp_call_function_many_cond()
Date:   Tue,  9 Feb 2021 14:16:46 -0800
Message-Id: <20210209221653.614098-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209221653.614098-1-namit@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
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
 kernel/smp.c | 148 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 68 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 1b6070bf97bb..c308130f3bc9 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -604,12 +604,23 @@ int smp_call_function_any(const struct cpumask *mask,
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
+/*
+ * Flags to be used as scf_flags argument of smp_call_function_many_cond().
+ */
+#define SCF_WAIT	(1U << 0)	/* Wait until function execution completed */
+#define SCF_RUN_LOCAL	(1U << 1)	/* Run also locally if local cpu is set in cpumask */
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
 
 	/*
 	 * Can deadlock when called with interrupts disabled.
@@ -617,8 +628,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	 * send smp call function interrupt to this cpu and as such deadlocks
 	 * can't happen.
 	 */
-	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress && !early_boot_irqs_disabled);
+	if (cpu_online(this_cpu) && !oops_in_progress && !early_boot_irqs_disabled)
+		lockdep_assert_irqs_enabled();
 
 	/*
 	 * When @wait we can deadlock when we interrupt between llist_add() and
@@ -628,60 +639,65 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
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
-
-	cpumask_and(cfd->cpumask, mask, cpu_online_mask);
-	__cpumask_clear_cpu(this_cpu, cfd->cpumask);
+	if (run_remote) {
+		cfd = this_cpu_ptr(&cfd_data);
+		cpumask_and(cfd->cpumask, mask, cpu_online_mask);
+		__cpumask_clear_cpu(this_cpu, cfd->cpumask);
 
-	/* Some callers race with other cpus changing the passed mask */
-	if (unlikely(!cpumask_weight(cfd->cpumask)))
-		return;
-
-	cpumask_clear(cfd->cpumask_ipi);
-	for_each_cpu(cpu, cfd->cpumask) {
-		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
+		cpumask_clear(cfd->cpumask_ipi);
+		for_each_cpu(cpu, cfd->cpumask) {
+			call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
-		if (cond_func && !cond_func(cpu, info))
-			continue;
+			if (cond_func && !cond_func(cpu, info))
+				continue;
 
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
 
@@ -692,12 +708,14 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
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
@@ -708,7 +726,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
 {
-	smp_call_function_many_cond(mask, func, info, wait, NULL);
+	smp_call_function_many_cond(mask, func, info, wait ? SCF_WAIT : 0, NULL);
 }
 EXPORT_SYMBOL(smp_call_function_many);
 
@@ -856,16 +874,15 @@ EXPORT_SYMBOL(on_each_cpu);
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
 
@@ -894,17 +911,12 @@ EXPORT_SYMBOL(on_each_cpu_mask);
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
+	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-- 
2.25.1

