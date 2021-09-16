Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F80740D0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhIPAdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233572AbhIPAdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:33:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A84861207;
        Thu, 16 Sep 2021 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752308;
        bh=ry9tozdZi9XZUdthO9aeF7062nIDFhDih8Wu43tZfI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eM24mmhILIqh/qwO1mWjkByfhsEZ3993PLkmWKG3tsozob5uc44UfC3PItwZDF9rb
         DHaZ5QS3CtZJ3Rad7ua904e8bYp4f7ym9FOlp7bD+HkH7r/+Q56NQwp/s+rerP5bNI
         tuxZa8211WSlhKgUrVdiq6h7WcA0vYVXwtrHnrpgGIMOH2Mgsc+32N7zgHYaszmUhN
         6xH5IObVlJbdfDrIuuC6xTwm5E41WCn0JBF90JPa4uyhQxxwrQ9RZs2f4yS8YUWG5S
         sEiA4YCJo0LbCJZdnAPmEkvdlJeGt9cBl0IiLKHW+/zB8aEXdkIquKHkopcYSOgzIE
         V6RjWunazML1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B62565C0954; Wed, 15 Sep 2021 17:31:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 6/9] kcsan: Start stack trace with explicit location if provided
Date:   Wed, 15 Sep 2021 17:31:43 -0700
Message-Id: <20210916003146.3910358-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
References: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

If an explicit access address is set, as is done for scoped accesses,
always start the stack trace from that location. get_stack_skipnr() is
changed into sanitize_stack_entries(), which if given an address, scans
the stack trace for a matching function and then replaces that entry
with the explicitly provided address.

The previous reports for scoped accesses were all over the place, which
could be quite confusing. We now always point at the start of the scope.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 19 ++++++++------
 kernel/kcsan/report.c     | 55 +++++++++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index e282c1166373..a3b12429e1d3 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -338,7 +338,10 @@ static noinline void test_kernel_assert_bits_nochange(void)
 	ASSERT_EXCLUSIVE_BITS(test_var, ~TEST_CHANGE_BITS);
 }
 
-/* To check that scoped assertions do trigger anywhere in scope. */
+/*
+ * Scoped assertions do trigger anywhere in scope. However, the report should
+ * still only point at the start of the scope.
+ */
 static noinline void test_enter_scope(void)
 {
 	int x = 0;
@@ -845,22 +848,22 @@ static void test_assert_exclusive_writer_scoped(struct kunit *test)
 			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 		},
 	};
-	const struct expect_report expect_anywhere = {
+	const struct expect_report expect_inscope = {
 		.access = {
 			{ test_enter_scope, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_SCOPED },
 			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 		},
 	};
 	bool match_expect_start = false;
-	bool match_expect_anywhere = false;
+	bool match_expect_inscope = false;
 
 	begin_test_checks(test_kernel_assert_writer_scoped, test_kernel_write_nochange);
 	do {
 		match_expect_start |= report_matches(&expect_start);
-		match_expect_anywhere |= report_matches(&expect_anywhere);
-	} while (!end_test_checks(match_expect_start && match_expect_anywhere));
+		match_expect_inscope |= report_matches(&expect_inscope);
+	} while (!end_test_checks(match_expect_inscope));
 	KUNIT_EXPECT_TRUE(test, match_expect_start);
-	KUNIT_EXPECT_TRUE(test, match_expect_anywhere);
+	KUNIT_EXPECT_FALSE(test, match_expect_inscope);
 }
 
 __no_kcsan
@@ -889,9 +892,9 @@ static void test_assert_exclusive_access_scoped(struct kunit *test)
 	do {
 		match_expect_start |= report_matches(&expect_start1) || report_matches(&expect_start2);
 		match_expect_inscope |= report_matches(&expect_inscope);
-	} while (!end_test_checks(match_expect_start && match_expect_inscope));
+	} while (!end_test_checks(match_expect_inscope));
 	KUNIT_EXPECT_TRUE(test, match_expect_start);
-	KUNIT_EXPECT_TRUE(test, match_expect_inscope);
+	KUNIT_EXPECT_FALSE(test, match_expect_inscope);
 }
 
 /*
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 50c4119f5cc0..4849cde9db9b 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -8,6 +8,7 @@
 #include <linux/debug_locks.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
+#include <linux/kallsyms.h>
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
 #include <linux/preempt.h>
@@ -301,6 +302,48 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 	return skip;
 }
 
+/*
+ * Skips to the first entry that matches the function of @ip, and then replaces
+ * that entry with @ip, returning the entries to skip.
+ */
+static int
+replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned long ip)
+{
+	unsigned long symbolsize, offset;
+	unsigned long target_func;
+	int skip;
+
+	if (kallsyms_lookup_size_offset(ip, &symbolsize, &offset))
+		target_func = ip - offset;
+	else
+		goto fallback;
+
+	for (skip = 0; skip < num_entries; ++skip) {
+		unsigned long func = stack_entries[skip];
+
+		if (!kallsyms_lookup_size_offset(func, &symbolsize, &offset))
+			goto fallback;
+		func -= offset;
+
+		if (func == target_func) {
+			stack_entries[skip] = ip;
+			return skip;
+		}
+	}
+
+fallback:
+	/* Should not happen; the resulting stack trace is likely misleading. */
+	WARN_ONCE(1, "Cannot find frame for %pS in stack trace", (void *)ip);
+	return get_stack_skipnr(stack_entries, num_entries);
+}
+
+static int
+sanitize_stack_entries(unsigned long stack_entries[], int num_entries, unsigned long ip)
+{
+	return ip ? replace_stack_entry(stack_entries, num_entries, ip) :
+			  get_stack_skipnr(stack_entries, num_entries);
+}
+
 /* Compares symbolized strings of addr1 and addr2. */
 static int sym_strcmp(void *addr1, void *addr2)
 {
@@ -328,12 +371,12 @@ static void print_verbose_info(struct task_struct *task)
 
 static void print_report(enum kcsan_value_change value_change,
 			 const struct access_info *ai,
-			 const struct other_info *other_info,
+			 struct other_info *other_info,
 			 u64 old, u64 new, u64 mask)
 {
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
 	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
-	int skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
+	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries, ai->ip);
 	unsigned long this_frame = stack_entries[skipnr];
 	unsigned long other_frame = 0;
 	int other_skipnr = 0; /* silence uninit warnings */
@@ -345,8 +388,9 @@ static void print_report(enum kcsan_value_change value_change,
 		return;
 
 	if (other_info) {
-		other_skipnr = get_stack_skipnr(other_info->stack_entries,
-						other_info->num_stack_entries);
+		other_skipnr = sanitize_stack_entries(other_info->stack_entries,
+						      other_info->num_stack_entries,
+						      other_info->ai.ip);
 		other_frame = other_info->stack_entries[other_skipnr];
 
 		/* @value_change is only known for the other thread */
@@ -585,7 +629,8 @@ static struct access_info prepare_access_info(const volatile void *ptr, size_t s
 		.access_type	= access_type,
 		.task_pid	= in_task() ? task_pid_nr(current) : -1,
 		.cpu_id		= raw_smp_processor_id(),
-		.ip		= ip,
+		/* Only replace stack entry with @ip if scoped access. */
+		.ip		= (access_type & KCSAN_ACCESS_SCOPED) ? ip : 0,
 	};
 }
 
-- 
2.31.1.189.g2e36527f23

