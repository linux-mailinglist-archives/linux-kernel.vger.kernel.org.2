Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4840639DD20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFGM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFGM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:59:29 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6D5C061789
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 05:57:23 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id q18-20020a0564025192b02903888712212fso9225867edd.19
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E19dPyijryKX8oHPsQVCw55m+yv2afCj/5+25DTbMh0=;
        b=OornHdIcrMBsYos/fgAmEXfE6OdKiXJWlE1zWSJQ8Hknd+WELMHcQ5cb5RJSWbr89u
         UPxUJeOUf9w5vbCDdaHWKvYdRbFCqO0Me3rhF7VxmLk3E7i3BaF5mPIGNe5C7CsrAQqN
         s2JIbM5wwtiZ1iZQZ7PJP9Evl/kMKWq1NWoOoU8gXk9adTMzpSl5vQ1v8U9osHca2oH0
         CzGt3ItJ43D/KPWrrIdHWMvIiKi5d+ZICEmDoUFAXSGtJpBZjrOIHZ9bcbDJTQEjpYYn
         kMV7Qn+ppN6Ke+odgVKMYxQkgop0QC5MhWt18K5ETZzC4txP3xIpha50O12ly8VZ+zyI
         w8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E19dPyijryKX8oHPsQVCw55m+yv2afCj/5+25DTbMh0=;
        b=lSHsMW09vg5yJWWLrGGTALqzXcoMJuEIkkdOm9mbjCU9NifsavSoKXk4n4eWG1gZt1
         DmJ8ZfiLCFFtl8cDBuN1JVk79E2J8eCP3iGWhUV+X3eIq7bruuGYSeaOcZn3+XGSCIpJ
         3dLVsB3c64aijlQoO7/gFUyrdVEcZ7uKcmrto86yaU/BS+rvzkmuX+TJadnLkERB7spY
         I3Psg1NyD+mI4DftSG7U/5Bai0ppi0bz2fTNAoqTG5zAKnqSLG9Cm1XQ2MLnJCkzJ8Mb
         xbJu0kRGFb8uc0/AcR6If0+EnyqJepiB+GhMc+8YlzJO7S7yYADnZUNHLjy5JRcqgfZT
         Lr1A==
X-Gm-Message-State: AOAM532f1RdcsEPBKguBvxFb6NUJXXqwgTqrYuM6l2XF5znJnQ6oP/2M
        7FnGd0pOR3cNwEICZpEkrlGmhQ6QDw==
X-Google-Smtp-Source: ABdhPJx6n7pFSnlE7EkpNVtahmOpFs4k4GXRJQkjYK8/TOF5neWhZmsv6lCIOpsszxPmuHq3PgaGNmSEOw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:2587:50:741c:6fde])
 (user=elver job=sendgmr) by 2002:a05:6402:5a:: with SMTP id
 f26mr19874084edu.306.1623070641707; Mon, 07 Jun 2021 05:57:21 -0700 (PDT)
Date:   Mon,  7 Jun 2021 14:56:53 +0200
In-Reply-To: <20210607125653.1388091-1-elver@google.com>
Message-Id: <20210607125653.1388091-8-elver@google.com>
Mime-Version: 1.0
References: <20210607125653.1388091-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 7/7] kcsan: permissive: Ignore data-racy 1-bit value changes
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, will@kernel.org,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rules to ignore data-racy reads with only 1-bit value changes.
Details about the rules are captured in comments in
kernel/kcsan/permissive.h. More background follows.

While investigating a number of data races, we've encountered data-racy
accesses on flags variables to be very common. The typical pattern is a
reader masking all but one bit, and/or the writer setting/clearing only
1 bit (current->flags being a frequently encountered case; more examples
in mm/sl[au]b.c, which disable KCSAN for this reason).

Since these types of data-racy accesses are common (with the assumption
they are intentional and hard to miscompile) having the option (with
CONFIG_KCSAN_PERMISSIVE=y) to filter them will avoid forcing everyone to
mark them, and deliberately left to preference at this time.

One important motivation for having this option built-in is to move
closer to being able to enable KCSAN on CI systems or for testers
wishing to test the whole kernel, while more easily filtering
less interesting data races with higher probability.

For the implementation, we considered several alternatives, but had one
major requirement: that the rules be kept together with the Linux-kernel
tree. Adding them to the compiler would preclude us from making changes
quickly; if the rules require tweaks, having them part of the compiler
requires waiting another ~1 year for the next release -- that's not
realistic. We are left with the following options:

	1. Maintain compiler plugins as part of the kernel-tree that
	   removes instrumentation for some accesses (e.g. plain-& with
	   1-bit mask). The analysis would be reader-side focused, as
	   no assumption can be made about racing writers.

Because it seems unrealistic to maintain 2 plugins, one for LLVM and
GCC, we would likely pick LLVM. Furthermore, no kernel infrastructure
exists to maintain LLVM plugins, and the build-system implications and
maintenance overheads do not look great (historically, plugins written
against old LLVM APIs are not guaranteed to work with newer LLVM APIs).

	2. Find a set of rules that can be expressed in terms of
	   observed value changes, and make it part of the KCSAN runtime.
	   The analysis is writer-side focused, given we rely on observed
	   value changes.

The approach taken here is (2). While a complete approach requires both
(1) and (2), experiments show that the majority of data races involving
trivial bit operations on flags variables can be removed with (2) alone.

It goes without saying that the filtering of data races using (1) or (2)
does _not_ guarantee they are safe! Therefore, limiting ourselves to (2)
for now is the conservative choice for setups that wish to enable
CONFIG_KCSAN_PERMISSIVE=y.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 32 +++++++++++++++++++++++++
 kernel/kcsan/permissive.h | 49 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 8bcffbdef3d3..dc55fd5a36fc 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -414,6 +414,14 @@ static noinline void test_kernel_atomic_builtins(void)
 	__atomic_load_n(&test_var, __ATOMIC_RELAXED);
 }
 
+static noinline void test_kernel_xor_1bit(void)
+{
+	/* Do not report data races between the read-writes. */
+	kcsan_nestable_atomic_begin();
+	test_var ^= 0x10000;
+	kcsan_nestable_atomic_end();
+}
+
 /* ===== Test cases ===== */
 
 /* Simple test with normal data race. */
@@ -952,6 +960,29 @@ static void test_atomic_builtins(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, match_never);
 }
 
+__no_kcsan
+static void test_1bit_value_change(struct kunit *test)
+{
+	const struct expect_report expect = {
+		.access = {
+			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
+			{ test_kernel_xor_1bit, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+		},
+	};
+	bool match = false;
+
+	begin_test_checks(test_kernel_read, test_kernel_xor_1bit);
+	do {
+		match = IS_ENABLED(CONFIG_KCSAN_PERMISSIVE)
+				? report_available()
+				: report_matches(&expect);
+	} while (!end_test_checks(match));
+	if (IS_ENABLED(CONFIG_KCSAN_PERMISSIVE))
+		KUNIT_EXPECT_FALSE(test, match);
+	else
+		KUNIT_EXPECT_TRUE(test, match);
+}
+
 /*
  * Generate thread counts for all test cases. Values generated are in interval
  * [2, 5] followed by exponentially increasing thread counts from 8 to 32.
@@ -1024,6 +1055,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_jiffies_noreport),
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
 	KCSAN_KUNIT_CASE(test_atomic_builtins),
+	KCSAN_KUNIT_CASE(test_1bit_value_change),
 	{},
 };
 
diff --git a/kernel/kcsan/permissive.h b/kernel/kcsan/permissive.h
index f90e30800c11..2c01fe4a59ee 100644
--- a/kernel/kcsan/permissive.h
+++ b/kernel/kcsan/permissive.h
@@ -12,6 +12,8 @@
 #ifndef _KERNEL_KCSAN_PERMISSIVE_H
 #define _KERNEL_KCSAN_PERMISSIVE_H
 
+#include <linux/bitops.h>
+#include <linux/sched.h>
 #include <linux/types.h>
 
 /*
@@ -22,7 +24,11 @@ static __always_inline bool kcsan_ignore_address(const volatile void *ptr)
 	if (!IS_ENABLED(CONFIG_KCSAN_PERMISSIVE))
 		return false;
 
-	return false;
+	/*
+	 * Data-racy bitops on current->flags are too common, ignore completely
+	 * for now.
+	 */
+	return ptr == &current->flags;
 }
 
 /*
@@ -41,6 +47,47 @@ kcsan_ignore_data_race(size_t size, int type, u64 old, u64 new, u64 diff)
 	if (type || size > sizeof(long))
 		return false;
 
+	/*
+	 * A common pattern is checking/setting just 1 bit in a variable; for
+	 * example:
+	 *
+	 *	if (flags & SOME_FLAG) { ... }
+	 *
+	 * and elsewhere flags is updated concurrently:
+	 *
+	 *	flags |= SOME_OTHER_FLAG; // just 1 bit
+	 *
+	 * While it is still recommended that such accesses be marked
+	 * appropriately, in many cases these types of data races are so common
+	 * that marking them all is often unrealistic and left to maintainer
+	 * preference.
+	 *
+	 * The assumption in all cases is that with all known compiler
+	 * optimizations (including those that tear accesses), because no more
+	 * than 1 bit changed, the plain accesses are safe despite the presence
+	 * of data races.
+	 *
+	 * The rules here will ignore the data races if we observe no more than
+	 * 1 bit changed.
+	 *
+	 * Of course many operations can effecively change just 1 bit, but the
+	 * general assuption that data races involving 1-bit changes can be
+	 * tolerated still applies.
+	 *
+	 * And in case a true bug is missed, the bug likely manifests as a
+	 * reportable data race elsewhere.
+	 */
+	if (hweight64(diff) == 1) {
+		/*
+		 * Exception: Report data races where the values look like
+		 * ordinary booleans (one of them was 0 and the 0th bit was
+		 * changed) More often than not, they come with interesting
+		 * memory ordering requirements, so let's report them.
+		 */
+		if (!((!old || !new) && diff == 1))
+			return true;
+	}
+
 	return false;
 }
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

