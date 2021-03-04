Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360A032C94B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392364AbhCDBGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1453020AbhCDAlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:41:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A32DA64F02;
        Thu,  4 Mar 2021 00:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818442;
        bh=Vhs9XEv4KKb75L/8l7YYjPgCu6G0PsBYhlGuPCtDhik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlF81TFnCRhBB8I9lhW/wqIp1VdBGd/dITdtf6abs5AfwlPEvE0A5GRhcr55o8Da9
         50eg6lX9VAaG++LjerBwNJXXizTiXXjQeAjS8rOyK0Si3w1e/MU9/0miqPgyFA8vKR
         r0XF+VannfWpLHoygRxd+TAcJJewY7cMv+vBSKRCx5z+YBeV+j1pGeCbxd1ehc5QDv
         IiwNqkyOjeZ6RvrZVVbQR2Y3Ea5y3Hr8XYs0t70s8bNC7gdnxj3g+Lw4QNpevMwYVh
         I3Iv3X6u9OrHNxPMzV+iJGX6o2Z6Tn8RaROQDY86i+R3mGRnQZZvkFWYeknjZsVcOi
         x40jgqDH5i8Dg==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 3/4] kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests
Date:   Wed,  3 Mar 2021 16:40:39 -0800
Message-Id: <20210304004040.25074-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Since KUnit now support parameterized tests via KUNIT_CASE_PARAM, update
KCSAN's test to switch to it for parameterized tests. This simplifies
parameterized tests and gets rid of the "parameters in case name"
workaround (hack).

At the same time, we can increase the maximum number of threads used,
because on systems with too few CPUs, KUnit allows us to now stop at the
maximum useful threads and not unnecessarily execute redundant test
cases with (the same) limited threads as had been the case before.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 116 +++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 62 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index f16f632..b71751f 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -13,6 +13,8 @@
  * Author: Marco Elver <elver@google.com>
  */
 
+#define pr_fmt(fmt) "kcsan_test: " fmt
+
 #include <kunit/test.h>
 #include <linux/jiffies.h>
 #include <linux/kcsan-checks.h>
@@ -951,22 +953,53 @@ static void test_atomic_builtins(struct kunit *test)
 }
 
 /*
- * Each test case is run with different numbers of threads. Until KUnit supports
- * passing arguments for each test case, we encode #threads in the test case
- * name (read by get_num_threads()). [The '-' was chosen as a stylistic
- * preference to separate test name and #threads.]
+ * Generate thread counts for all test cases. Values generated are in interval
+ * [2, 5] followed by exponentially increasing thread counts from 8 to 32.
  *
  * The thread counts are chosen to cover potentially interesting boundaries and
- * corner cases (range 2-5), and then stress the system with larger counts.
+ * corner cases (2 to 5), and then stress the system with larger counts.
  */
-#define KCSAN_KUNIT_CASE(test_name)                                            \
-	{ .run_case = test_name, .name = #test_name "-02" },                   \
-	{ .run_case = test_name, .name = #test_name "-03" },                   \
-	{ .run_case = test_name, .name = #test_name "-04" },                   \
-	{ .run_case = test_name, .name = #test_name "-05" },                   \
-	{ .run_case = test_name, .name = #test_name "-08" },                   \
-	{ .run_case = test_name, .name = #test_name "-16" }
+static const void *nthreads_gen_params(const void *prev, char *desc)
+{
+	long nthreads = (long)prev;
+
+	if (nthreads < 0 || nthreads >= 32)
+		nthreads = 0; /* stop */
+	else if (!nthreads)
+		nthreads = 2; /* initial value */
+	else if (nthreads < 5)
+		nthreads++;
+	else if (nthreads == 5)
+		nthreads = 8;
+	else
+		nthreads *= 2;
 
+	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
+		/*
+		 * Without any preemption, keep 2 CPUs free for other tasks, one
+		 * of which is the main test case function checking for
+		 * completion or failure.
+		 */
+		const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
+		const long min_required_cpus = 2 + min_unused_cpus;
+
+		if (num_online_cpus() < min_required_cpus) {
+			pr_err_once("Too few online CPUs (%u < %d) for test\n",
+				    num_online_cpus(), min_required_cpus);
+			nthreads = 0;
+		} else if (nthreads >= num_online_cpus() - min_unused_cpus) {
+			/* Use negative value to indicate last param. */
+			nthreads = -(num_online_cpus() - min_unused_cpus);
+			pr_warn_once("Limiting number of threads to %ld (only %d online CPUs)\n",
+				     -nthreads, num_online_cpus());
+		}
+	}
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "threads=%ld", abs(nthreads));
+	return (void *)nthreads;
+}
+
+#define KCSAN_KUNIT_CASE(test_name) KUNIT_CASE_PARAM(test_name, nthreads_gen_params)
 static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_basic),
 	KCSAN_KUNIT_CASE(test_concurrent_races),
@@ -996,24 +1029,6 @@ static struct kunit_case kcsan_test_cases[] = {
 
 /* ===== End test cases ===== */
 
-/* Get number of threads encoded in test name. */
-static bool __no_kcsan
-get_num_threads(const char *test, int *nthreads)
-{
-	int len = strlen(test);
-
-	if (WARN_ON(len < 3))
-		return false;
-
-	*nthreads = test[len - 1] - '0';
-	*nthreads += (test[len - 2] - '0') * 10;
-
-	if (WARN_ON(*nthreads < 0))
-		return false;
-
-	return true;
-}
-
 /* Concurrent accesses from interrupts. */
 __no_kcsan
 static void access_thread_timer(struct timer_list *timer)
@@ -1076,9 +1091,6 @@ static int test_init(struct kunit *test)
 	if (!torture_init_begin((char *)test->name, 1))
 		return -EBUSY;
 
-	if (!get_num_threads(test->name, &nthreads))
-		goto err;
-
 	if (WARN_ON(threads))
 		goto err;
 
@@ -1087,38 +1099,18 @@ static int test_init(struct kunit *test)
 			goto err;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
-		/*
-		 * Without any preemption, keep 2 CPUs free for other tasks, one
-		 * of which is the main test case function checking for
-		 * completion or failure.
-		 */
-		const int min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
-		const int min_required_cpus = 2 + min_unused_cpus;
+	nthreads = abs((long)test->param_value);
+	if (WARN_ON(!nthreads))
+		goto err;
 
-		if (num_online_cpus() < min_required_cpus) {
-			pr_err("%s: too few online CPUs (%u < %d) for test",
-			       test->name, num_online_cpus(), min_required_cpus);
-			goto err;
-		} else if (nthreads > num_online_cpus() - min_unused_cpus) {
-			nthreads = num_online_cpus() - min_unused_cpus;
-			pr_warn("%s: limiting number of threads to %d\n",
-				test->name, nthreads);
-		}
-	}
+	threads = kcalloc(nthreads + 1, sizeof(struct task_struct *), GFP_KERNEL);
+	if (WARN_ON(!threads))
+		goto err;
 
-	if (nthreads) {
-		threads = kcalloc(nthreads + 1, sizeof(struct task_struct *),
-				  GFP_KERNEL);
-		if (WARN_ON(!threads))
+	threads[nthreads] = NULL;
+	for (i = 0; i < nthreads; ++i) {
+		if (torture_create_kthread(access_thread, NULL, threads[i]))
 			goto err;
-
-		threads[nthreads] = NULL;
-		for (i = 0; i < nthreads; ++i) {
-			if (torture_create_kthread(access_thread, NULL,
-						   threads[i]))
-				goto err;
-		}
 	}
 
 	torture_init_end();
-- 
2.9.5

