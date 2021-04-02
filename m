Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3954353037
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhDBUW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbhDBUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:22:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B126FC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 13:22:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 184so6633637ljf.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NlTZYOTP6gxY+A8f1lp9gD0t94fGeKsz+KEdX5TSTq4=;
        b=IL8emjWCMFzBpzm2REpTKSDItPqwcRHkwDyhpVa+fQUkJHytbmfdiE4bYlyWATY2+w
         vGTzZ0xBGkMjQPOKifR5x0SRxTG5xC72QHw+kb5i6FZbHNZsW5bB5fBxr6sojWyFhWt4
         X1xXaYrNxVN9lblPGDiEvQMy5/KffFH4hkIo8BEUkoY3t793mTbMa9DxGLkN3te4my0o
         RXKafDau/hoEXeBFpQ4TuNACE7UmlDCyaBx8kX6IhRI6V4d1HnMZ/KogECpPd0Hd3Ub0
         53KDDwBj5vpxhBAzPjV0CNJ/XDi9uCuiiJ7J/rXVXGxLoqAYHSZmfWj+F8WQOdZ5e5N+
         CtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlTZYOTP6gxY+A8f1lp9gD0t94fGeKsz+KEdX5TSTq4=;
        b=MYHvq4o1mxzPOAcrvI1QAlBTvEsinqqRScjhlpFZqGcR9wokS0Ha5uSyWP3kDPETdF
         jTzCKu3bCMfCZy2WiNsZajT1ynwWM++zZOheO//ElNO5xuvG0xQV800LTnUv4l31iQY1
         KBhDuCimXEiL4PzXVbN9sXDC6vsAqUPxn2Ykdb8ugTZnDIF0/9VXnJFn5JBiB11QuX3s
         2nwGy6TFCJ8p9jmS6g1xlvzNoxj7V5xbnQMv/5FgYK0FKt4tVu8KOi6CFsR5N4lKLWls
         Q4OzhVtsoru3IjDWnFgrSZIAvuuYTIonFcgUhe4IW7RAWEjB/Qs6NrVmvziEvAX7PhGA
         l1eQ==
X-Gm-Message-State: AOAM532d1qibRkrMHKZaEPzzmGCOnmGrfcPFneORXPVcNx/vK3bmOEcG
        byVOx/jriPEO9oJPeXpeefI=
X-Google-Smtp-Source: ABdhPJxrao1ogZYKuL2wEhq0h305cuoO/EgEpfZutWpdL6CCxZVyr0MHx315wkyYwd+B5ezHkncHwQ==
X-Received: by 2002:a2e:6e17:: with SMTP id j23mr9128468ljc.209.1617394969128;
        Fri, 02 Apr 2021 13:22:49 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f11sm952514lfr.119.2021.04.02.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:22:48 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH-next 2/5] lib/test_vmalloc.c: add a new 'nr_threads' parameter
Date:   Fri,  2 Apr 2021 22:22:34 +0200
Message-Id: <20210402202237.20334-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210402202237.20334-1-urezki@gmail.com>
References: <20210402202237.20334-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using this parameter we can specify how many workers are
created to perform vmalloc tests. By default it is one CPU.
The maximum value is set to 1024.

As a result of this change a 'single_cpu_test' one becomes
obsolete, therefore it is no longer needed.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 88 +++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 48 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 4eb6abdaa74e..d337985e4c5e 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -23,8 +23,8 @@
 	module_param(name, type, 0444);			\
 	MODULE_PARM_DESC(name, msg)				\
 
-__param(bool, single_cpu_test, false,
-	"Use single first online CPU to run tests");
+__param(int, nr_threads, 0,
+	"Number of workers to perform tests(min: 1 max: 1024)");
 
 __param(bool, sequential_test_order, false,
 	"Use sequential stress tests order");
@@ -50,13 +50,6 @@ __param(int, run_test_mask, INT_MAX,
 		/* Add a new test case description here. */
 );
 
-/*
- * Depends on single_cpu_test parameter. If it is true, then
- * use first online CPU to trigger a test on, otherwise go with
- * all online CPUs.
- */
-static cpumask_t cpus_run_test_mask = CPU_MASK_NONE;
-
 /*
  * Read write semaphore for synchronization of setup
  * phase that is done in main thread and workers.
@@ -386,16 +379,13 @@ struct test_case_data {
 	u64 time;
 };
 
-/* Split it to get rid of: WARNING: line over 80 characters */
-static struct test_case_data
-	per_cpu_test_data[NR_CPUS][ARRAY_SIZE(test_case_array)];
-
 static struct test_driver {
 	struct task_struct *task;
+	struct test_case_data data[ARRAY_SIZE(test_case_array)];
+
 	unsigned long start;
 	unsigned long stop;
-	int cpu;
-} per_cpu_test_driver[NR_CPUS];
+} *tdriver;
 
 static void shuffle_array(int *arr, int n)
 {
@@ -423,9 +413,6 @@ static int test_func(void *private)
 	ktime_t kt;
 	u64 delta;
 
-	if (set_cpus_allowed_ptr(current, cpumask_of(t->cpu)) < 0)
-		pr_err("Failed to set affinity to %d CPU\n", t->cpu);
-
 	for (i = 0; i < ARRAY_SIZE(test_case_array); i++)
 		random_array[i] = i;
 
@@ -450,9 +437,9 @@ static int test_func(void *private)
 		kt = ktime_get();
 		for (j = 0; j < test_repeat_count; j++) {
 			if (!test_case_array[index].test_func())
-				per_cpu_test_data[t->cpu][index].test_passed++;
+				t->data[index].test_passed++;
 			else
-				per_cpu_test_data[t->cpu][index].test_failed++;
+				t->data[index].test_failed++;
 		}
 
 		/*
@@ -461,7 +448,7 @@ static int test_func(void *private)
 		delta = (u64) ktime_us_delta(ktime_get(), kt);
 		do_div(delta, (u32) test_repeat_count);
 
-		per_cpu_test_data[t->cpu][index].time = delta;
+		t->data[index].time = delta;
 	}
 	t->stop = get_cycles();
 
@@ -477,53 +464,56 @@ static int test_func(void *private)
 	return 0;
 }
 
-static void
+static int
 init_test_configurtion(void)
 {
 	/*
-	 * Reset all data of all CPUs.
+	 * A maximum number of workers is defined as hard-coded
+	 * value and set to 1024. We add such gap just in case
+	 * and for potential heavy stressing.
 	 */
-	memset(per_cpu_test_data, 0, sizeof(per_cpu_test_data));
+	nr_threads = clamp(nr_threads, 1, 1024);
 
-	if (single_cpu_test)
-		cpumask_set_cpu(cpumask_first(cpu_online_mask),
-			&cpus_run_test_mask);
-	else
-		cpumask_and(&cpus_run_test_mask, cpu_online_mask,
-			cpu_online_mask);
+	/* Allocate the space for test instances. */
+	tdriver = kcalloc(nr_threads, sizeof(*tdriver), GFP_KERNEL);
+	if (tdriver == NULL)
+		return -1;
 
 	if (test_repeat_count <= 0)
 		test_repeat_count = 1;
 
 	if (test_loop_count <= 0)
 		test_loop_count = 1;
+
+	return 0;
 }
 
 static void do_concurrent_test(void)
 {
-	int cpu, ret;
+	int i, ret;
 
 	/*
 	 * Set some basic configurations plus sanity check.
 	 */
-	init_test_configurtion();
+	ret = init_test_configurtion();
+	if (ret < 0)
+		return;
 
 	/*
 	 * Put on hold all workers.
 	 */
 	down_write(&prepare_for_test_rwsem);
 
-	for_each_cpu(cpu, &cpus_run_test_mask) {
-		struct test_driver *t = &per_cpu_test_driver[cpu];
+	for (i = 0; i < nr_threads; i++) {
+		struct test_driver *t = &tdriver[i];
 
-		t->cpu = cpu;
-		t->task = kthread_run(test_func, t, "vmalloc_test/%d", cpu);
+		t->task = kthread_run(test_func, t, "vmalloc_test/%d", i);
 
 		if (!IS_ERR(t->task))
 			/* Success. */
 			atomic_inc(&test_n_undone);
 		else
-			pr_err("Failed to start kthread for %d CPU\n", cpu);
+			pr_err("Failed to start %d kthread\n", i);
 	}
 
 	/*
@@ -541,29 +531,31 @@ static void do_concurrent_test(void)
 		ret = wait_for_completion_timeout(&test_all_done_comp, HZ);
 	} while (!ret);
 
-	for_each_cpu(cpu, &cpus_run_test_mask) {
-		struct test_driver *t = &per_cpu_test_driver[cpu];
-		int i;
+	for (i = 0; i < nr_threads; i++) {
+		struct test_driver *t = &tdriver[i];
+		int j;
 
 		if (!IS_ERR(t->task))
 			kthread_stop(t->task);
 
-		for (i = 0; i < ARRAY_SIZE(test_case_array); i++) {
-			if (!((run_test_mask & (1 << i)) >> i))
+		for (j = 0; j < ARRAY_SIZE(test_case_array); j++) {
+			if (!((run_test_mask & (1 << j)) >> j))
 				continue;
 
 			pr_info(
 				"Summary: %s passed: %d failed: %d repeat: %d loops: %d avg: %llu usec\n",
-				test_case_array[i].test_name,
-				per_cpu_test_data[cpu][i].test_passed,
-				per_cpu_test_data[cpu][i].test_failed,
+				test_case_array[j].test_name,
+				t->data[j].test_passed,
+				t->data[j].test_failed,
 				test_repeat_count, test_loop_count,
-				per_cpu_test_data[cpu][i].time);
+				t->data[j].time);
 		}
 
-		pr_info("All test took CPU%d=%lu cycles\n",
-			cpu, t->stop - t->start);
+		pr_info("All test took worker%d=%lu cycles\n",
+			i, t->stop - t->start);
 	}
+
+	kfree(tdriver);
 }
 
 static int vmalloc_test_init(void)
-- 
2.20.1

