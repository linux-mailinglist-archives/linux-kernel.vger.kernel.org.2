Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660FE437FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhJVUwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234435AbhJVUvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C31613B3;
        Fri, 22 Oct 2021 20:48:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T2-000QU8-ED;
        Fri, 22 Oct 2021 16:48:44 -0400
Message-ID: <20211022204844.276334429@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 33/40] kprobes: convert tests to kunit
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

This converts the kprobes testcases to use the kunit framework.
It adds a dependency on CONFIG_KUNIT, and the output will change
to TAP:

TAP version 14
1..1
    # Subtest: kprobes_test
    1..4
random: crng init done
    ok 1 - test_kprobe
    ok 2 - test_kprobes
    ok 3 - test_kretprobe
    ok 4 - test_kretprobes
ok 1 - kprobes_test

Note that the kprobes testcases are no longer run immediately after
kprobes initialization, but as a late initcall when kunit is
initialized. kprobes itself is initialized with an early initcall,
so the order is still correct.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/kprobes.c      |   3 -
 kernel/test_kprobes.c | 222 +++++++++++-------------------------------
 lib/Kconfig.debug     |   3 +-
 3 files changed, 61 insertions(+), 167 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b62af9fc3607..4676627cb066 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2581,9 +2581,6 @@ static int __init init_kprobes(void)
 		err = register_module_notifier(&kprobe_module_nb);
 
 	kprobes_initialized = (err == 0);
-
-	if (!err)
-		init_test_probes();
 	return err;
 }
 early_initcall(init_kprobes);
diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index 76c997fdbc9d..e78f18144145 100644
--- a/kernel/test_kprobes.c
+++ b/kernel/test_kprobes.c
@@ -5,18 +5,17 @@
  * Copyright IBM Corp. 2008
  */
 
-#define pr_fmt(fmt) "Kprobe smoke test: " fmt
-
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 #include <linux/random.h>
+#include <kunit/test.h>
 
 #define div_factor 3
 
 static u32 rand1, preh_val, posth_val;
-static int errors, handler_errors, num_tests;
 static u32 (*target)(u32 value);
 static u32 (*target2)(u32 value);
+static struct kunit *current_test;
 
 static noinline u32 kprobe_target(u32 value)
 {
@@ -25,10 +24,7 @@ static noinline u32 kprobe_target(u32 value)
 
 static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	if (preemptible()) {
-		handler_errors++;
-		pr_err("pre-handler is preemptible\n");
-	}
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	preh_val = (rand1 / div_factor);
 	return 0;
 }
@@ -36,14 +32,8 @@ static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 static void kp_post_handler(struct kprobe *p, struct pt_regs *regs,
 		unsigned long flags)
 {
-	if (preemptible()) {
-		handler_errors++;
-		pr_err("post-handler is preemptible\n");
-	}
-	if (preh_val != (rand1 / div_factor)) {
-		handler_errors++;
-		pr_err("incorrect value in post_handler\n");
-	}
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor));
 	posth_val = preh_val + div_factor;
 }
 
@@ -53,30 +43,14 @@ static struct kprobe kp = {
 	.post_handler = kp_post_handler
 };
 
-static int test_kprobe(void)
+static void test_kprobe(struct kunit *test)
 {
-	int ret;
-
-	ret = register_kprobe(&kp);
-	if (ret < 0) {
-		pr_err("register_kprobe returned %d\n", ret);
-		return ret;
-	}
-
-	ret = target(rand1);
+	current_test = test;
+	KUNIT_EXPECT_EQ(test, 0, register_kprobe(&kp));
+	target(rand1);
 	unregister_kprobe(&kp);
-
-	if (preh_val == 0) {
-		pr_err("kprobe pre_handler not called\n");
-		handler_errors++;
-	}
-
-	if (posth_val == 0) {
-		pr_err("kprobe post_handler not called\n");
-		handler_errors++;
-	}
-
-	return 0;
+	KUNIT_EXPECT_NE(test, 0, preh_val);
+	KUNIT_EXPECT_NE(test, 0, posth_val);
 }
 
 static noinline u32 kprobe_target2(u32 value)
@@ -93,10 +67,7 @@ static int kp_pre_handler2(struct kprobe *p, struct pt_regs *regs)
 static void kp_post_handler2(struct kprobe *p, struct pt_regs *regs,
 		unsigned long flags)
 {
-	if (preh_val != (rand1 / div_factor) + 1) {
-		handler_errors++;
-		pr_err("incorrect value in post_handler2\n");
-	}
+	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor) + 1);
 	posth_val = preh_val + div_factor;
 }
 
@@ -106,51 +77,31 @@ static struct kprobe kp2 = {
 	.post_handler = kp_post_handler2
 };
 
-static int test_kprobes(void)
+static void test_kprobes(struct kunit *test)
 {
-	int ret;
 	struct kprobe *kps[2] = {&kp, &kp2};
 
+	current_test = test;
+
 	/* addr and flags should be cleard for reusing kprobe. */
 	kp.addr = NULL;
 	kp.flags = 0;
-	ret = register_kprobes(kps, 2);
-	if (ret < 0) {
-		pr_err("register_kprobes returned %d\n", ret);
-		return ret;
-	}
 
+	KUNIT_EXPECT_EQ(test, 0, register_kprobes(kps, 2));
 	preh_val = 0;
 	posth_val = 0;
-	ret = target(rand1);
+	target(rand1);
 
-	if (preh_val == 0) {
-		pr_err("kprobe pre_handler not called\n");
-		handler_errors++;
-	}
-
-	if (posth_val == 0) {
-		pr_err("kprobe post_handler not called\n");
-		handler_errors++;
-	}
+	KUNIT_EXPECT_NE(test, 0, preh_val);
+	KUNIT_EXPECT_NE(test, 0, posth_val);
 
 	preh_val = 0;
 	posth_val = 0;
-	ret = target2(rand1);
-
-	if (preh_val == 0) {
-		pr_err("kprobe pre_handler2 not called\n");
-		handler_errors++;
-	}
-
-	if (posth_val == 0) {
-		pr_err("kprobe post_handler2 not called\n");
-		handler_errors++;
-	}
+	target2(rand1);
 
+	KUNIT_EXPECT_NE(test, 0, preh_val);
+	KUNIT_EXPECT_NE(test, 0, posth_val);
 	unregister_kprobes(kps, 2);
-	return 0;
-
 }
 
 #ifdef CONFIG_KRETPROBES
@@ -158,10 +109,7 @@ static u32 krph_val;
 
 static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
-	if (preemptible()) {
-		handler_errors++;
-		pr_err("kretprobe entry handler is preemptible\n");
-	}
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	krph_val = (rand1 / div_factor);
 	return 0;
 }
@@ -170,19 +118,9 @@ static int return_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	unsigned long ret = regs_return_value(regs);
 
-	if (preemptible()) {
-		handler_errors++;
-		pr_err("kretprobe return handler is preemptible\n");
-	}
-	if (ret != (rand1 / div_factor)) {
-		handler_errors++;
-		pr_err("incorrect value in kretprobe handler\n");
-	}
-	if (krph_val == 0) {
-		handler_errors++;
-		pr_err("call to kretprobe entry handler failed\n");
-	}
-
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, ret, rand1 / div_factor);
+	KUNIT_EXPECT_NE(current_test, krph_val, 0);
 	krph_val = rand1;
 	return 0;
 }
@@ -193,39 +131,21 @@ static struct kretprobe rp = {
 	.kp.symbol_name = "kprobe_target"
 };
 
-static int test_kretprobe(void)
+static void test_kretprobe(struct kunit *test)
 {
-	int ret;
-
-	ret = register_kretprobe(&rp);
-	if (ret < 0) {
-		pr_err("register_kretprobe returned %d\n", ret);
-		return ret;
-	}
-
-	ret = target(rand1);
+	current_test = test;
+	KUNIT_EXPECT_EQ(test, 0, register_kretprobe(&rp));
+	target(rand1);
 	unregister_kretprobe(&rp);
-	if (krph_val != rand1) {
-		pr_err("kretprobe handler not called\n");
-		handler_errors++;
-	}
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, krph_val, rand1);
 }
 
 static int return_handler2(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	unsigned long ret = regs_return_value(regs);
 
-	if (ret != (rand1 / div_factor) + 1) {
-		handler_errors++;
-		pr_err("incorrect value in kretprobe handler2\n");
-	}
-	if (krph_val == 0) {
-		handler_errors++;
-		pr_err("call to kretprobe entry handler failed\n");
-	}
-
+	KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor) + 1);
+	KUNIT_EXPECT_NE(current_test, krph_val, 0);
 	krph_val = rand1;
 	return 0;
 }
@@ -236,78 +156,54 @@ static struct kretprobe rp2 = {
 	.kp.symbol_name = "kprobe_target2"
 };
 
-static int test_kretprobes(void)
+static void test_kretprobes(struct kunit *test)
 {
-	int ret;
 	struct kretprobe *rps[2] = {&rp, &rp2};
 
+	current_test = test;
 	/* addr and flags should be cleard for reusing kprobe. */
 	rp.kp.addr = NULL;
 	rp.kp.flags = 0;
-	ret = register_kretprobes(rps, 2);
-	if (ret < 0) {
-		pr_err("register_kretprobe returned %d\n", ret);
-		return ret;
-	}
+	KUNIT_EXPECT_EQ(test, 0, register_kretprobes(rps, 2));
 
 	krph_val = 0;
-	ret = target(rand1);
-	if (krph_val != rand1) {
-		pr_err("kretprobe handler not called\n");
-		handler_errors++;
-	}
+	target(rand1);
+	KUNIT_EXPECT_EQ(test, krph_val, rand1);
 
 	krph_val = 0;
-	ret = target2(rand1);
-	if (krph_val != rand1) {
-		pr_err("kretprobe handler2 not called\n");
-		handler_errors++;
-	}
+	target2(rand1);
+	KUNIT_EXPECT_EQ(test, krph_val, rand1);
 	unregister_kretprobes(rps, 2);
-	return 0;
 }
 #endif /* CONFIG_KRETPROBES */
 
-int init_test_probes(void)
+static int kprobes_test_init(struct kunit *test)
 {
-	int ret;
-
 	target = kprobe_target;
 	target2 = kprobe_target2;
 
 	do {
 		rand1 = prandom_u32();
 	} while (rand1 <= div_factor);
+	return 0;
+}
 
-	pr_info("started\n");
-	num_tests++;
-	ret = test_kprobe();
-	if (ret < 0)
-		errors++;
-
-	num_tests++;
-	ret = test_kprobes();
-	if (ret < 0)
-		errors++;
-
+static struct kunit_case kprobes_testcases[] = {
+	KUNIT_CASE(test_kprobe),
+	KUNIT_CASE(test_kprobes),
 #ifdef CONFIG_KRETPROBES
-	num_tests++;
-	ret = test_kretprobe();
-	if (ret < 0)
-		errors++;
-
-	num_tests++;
-	ret = test_kretprobes();
-	if (ret < 0)
-		errors++;
-#endif /* CONFIG_KRETPROBES */
+	KUNIT_CASE(test_kretprobe),
+	KUNIT_CASE(test_kretprobes),
+#endif
+	{}
+};
 
-	if (errors)
-		pr_err("BUG: %d out of %d tests failed\n", errors, num_tests);
-	else if (handler_errors)
-		pr_err("BUG: %d error(s) running handlers\n", handler_errors);
-	else
-		pr_info("passed successfully\n");
+static struct kunit_suite kprobes_test_suite = {
+	.name = "kprobes_test",
+	.init = kprobes_test_init,
+	.test_cases = kprobes_testcases,
+};
 
-	return 0;
-}
+kunit_test_suites(&kprobes_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2a9b6dcdac4f..6ceb11a43e4c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2080,9 +2080,10 @@ config TEST_DIV64
 	  If unsure, say N.
 
 config KPROBES_SANITY_TEST
-	bool "Kprobes sanity tests"
+	tristate "Kprobes sanity tests"
 	depends on DEBUG_KERNEL
 	depends on KPROBES
+	depends on KUNIT
 	help
 	  This option provides for testing basic kprobes functionality on
 	  boot. Samples of kprobe and kretprobe are inserted and
-- 
2.33.0
