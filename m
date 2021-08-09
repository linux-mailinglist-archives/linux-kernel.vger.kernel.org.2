Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5E3E44C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhHIL0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbhHIL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:26:11 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5AFC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:25:51 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id v19-20020ad455530000b029032620cab853so12089520qvy.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EAMypyoEmRp/mmdsUbAy/IShN4ZX4EbgjctTw6o3qXc=;
        b=TEAy3JoenMQ0xSCVWYMngPIJPE8ECLUn/AA7SVoHlgSIP2tq8HluIlOKWCV2KNSVMH
         EcsXw3XWcmJrZzMCA7gx1Wst4jURDBe0bl30dT/Qse9/7IAzz4ph6+6N1hoaKq7N3hbx
         /wX9fcZqa4QXsCrrqY+vDoV36uNiOOQzdqe45j3RhCg6VG4voY1gUfgpvTXCWAZs5h5m
         9ftsJBk2zUwlWC59JMcT7OdWtShMLBocKLyAgk49AJjSYSdPpCCGZ3WE3vZQyFb0NCaE
         bbwIyTtBZ+L3B1b79vmX77HF0kcFgSyn/M9g+lDjwmSTQxckPkGm6Ul+5jK/Ux4bMZLS
         HNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EAMypyoEmRp/mmdsUbAy/IShN4ZX4EbgjctTw6o3qXc=;
        b=aTpYUrXyzwnWsANUaBIUYVEAw/yOeIx0krGfQG0skKbSFWeZORLGC7R09zpt3rXRTk
         D9S1tX3U0dSJlbddIE4BydmkCw8DVjYzrnjEvrp1p4neoB9rCChVGnLO7/ojHN0FnCF4
         HJlcRDSJ4PbxqXDwXMdWyMrKIAC+tMpyhChS3r/dKj/1A87q8iC26oUw5BvTiIZL0vYQ
         3dr7DVPeLXkXEI81T4CRFvPla3Pz2MjH5G4QKl5ucuon0thZ76kJ3vwvDxySGOF6maKl
         b10rliourHOS2KmWzUe99IPWHISO2ZyR0CPRZjKrzhaIRrQbTw8Dsh+plReTN6KTuo8u
         mDfg==
X-Gm-Message-State: AOAM530fgFVWyoiRnjX4ctQsbNatIVUU8Ut7FjHWF8CyA7UDyTXf/FjW
        WISBQbDb6f1DZPiZMXuytMAXejt5JQ==
X-Google-Smtp-Source: ABdhPJzzxXIhAbGURARiY3RG/gNWnk0VgAC01odf0EyvYVrBA5jc5wd3tH2tDtxh4DijnwWG37ndr0EPJQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e5a3:e652:2b8b:ef12])
 (user=elver job=sendgmr) by 2002:a05:6214:d1:: with SMTP id
 f17mr12117201qvs.12.1628508350253; Mon, 09 Aug 2021 04:25:50 -0700 (PDT)
Date:   Mon,  9 Aug 2021 13:25:14 +0200
In-Reply-To: <20210809112516.682816-1-elver@google.com>
Message-Id: <20210809112516.682816-7-elver@google.com>
Mime-Version: 1.0
References: <20210809112516.682816-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 6/8] kcsan: Start stack trace with explicit location if provided
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an explicit access address is set, as is done for scoped accesses,
always start the stack trace from that location. get_stack_skipnr() is
changed into sanitize_stack_entries(), which if given an address, scans
the stack trace for a matching function and then replaces that entry
with the explicitly provided address.

The previous reports for scoped accesses were all over the place, which
could be quite confusing. We now always point at the start of the scope.

Signed-off-by: Marco Elver <elver@google.com>
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
2.32.0.605.g8dce9f2422-goog

