Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCD340A716
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbhINHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:10:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240407AbhINHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:10:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18E4bEdY032547;
        Tue, 14 Sep 2021 03:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XtWFmCJ+jnDTcPJFZgO+orLIOGz4cJnUDsmZvUjJeRM=;
 b=H9pVAhCj+esFUhUFIqDiYdOiBgTjKa3pouRzsOapx7B0IdYqXvtmurZlvBL7TYkaydht
 RZ5LtzLYh30YV6gUObFpAu38we6r+6Wb6M5hOHCUUwJFogCMI4yUYH4eHmKw9Q+A2+4c
 OByfNnUP7Usi+l7ML85VN0N5sVE+m/PGfdNaCxDgP61T0QwNqsfEyn8v2nAlKB5EmpDa
 7mNK1JQAEbJjIztPv/aM9WRFYMmKKqvj8fCpxI8JUwQbpF0PSGv05rH0ZW3Nlt3CuY9K
 H6Gwu1w/rM3iZZlVmz2GGJF3OFRAls3+8aqAH7DKWxHM3XfEjOxGjcmaceZZBNuJ2K8r 7A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b2mvatsuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 03:08:31 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18E78CaK012357;
        Tue, 14 Sep 2021 07:08:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3b0m38y2u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 07:08:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18E78PuM55247246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 07:08:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 343F84C058;
        Tue, 14 Sep 2021 07:08:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E0134C050;
        Tue, 14 Sep 2021 07:08:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 14 Sep 2021 07:08:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id A055EE06BB; Tue, 14 Sep 2021 09:08:24 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2] kprobes: convert tests to kunit
Date:   Tue, 14 Sep 2021 09:08:16 +0200
Message-Id: <20210914070816.3516994-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: csdhw6winDjetl7LTwwc-8m5_mayxLfT
X-Proofpoint-ORIG-GUID: csdhw6winDjetl7LTwwc-8m5_mayxLfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/kprobes.c      |   3 -
 kernel/test_kprobes.c | 221 +++++++++++-------------------------------
 lib/Kconfig.debug     |   1 +
 3 files changed, 59 insertions(+), 166 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 790a573bbe00..adf6ed1932c2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2508,9 +2508,6 @@ static int __init init_kprobes(void)
 		err = register_module_notifier(&kprobe_module_nb);
 
 	kprobes_initialized = (err == 0);
-
-	if (!err)
-		init_test_probes();
 	return err;
 }
 early_initcall(init_kprobes);
diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index 76c997fdbc9d..3c481560f439 100644
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
@@ -236,78 +156,53 @@ static struct kretprobe rp2 = {
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
+
+kunit_test_suites(&kprobes_test_suite);
 
-	return 0;
-}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ed4a31e34098..10dbed281a6a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2083,6 +2083,7 @@ config KPROBES_SANITY_TEST
 	bool "Kprobes sanity tests"
 	depends on DEBUG_KERNEL
 	depends on KPROBES
+	depends on KUNIT
 	help
 	  This option provides for testing basic kprobes functionality on
 	  boot. Samples of kprobe and kretprobe are inserted and
-- 
2.25.1

