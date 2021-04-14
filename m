Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67B535F291
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350648AbhDNLaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350597AbhDNL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:29:22 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BFCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:29:00 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id dk17so817212qvb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2hPM+SGX2bso2P06MksOdn7k4SylcbKetGkN5XP9cNQ=;
        b=Ui+ywIIo+MrZS3X5EcO7bgPjBNiydvyB+WuOsbsFM4XVnrdzrz9h0Lkgzmkh5WN4nN
         gG1JLpN5HHXSxqQitQ6bdGpCMHYOnq/cyVcCqP8MLlq/JyLl6Z8L3RUQMXb8l59KVaut
         1zhVTAdemgco39hlFOjBlHxNYUmwr8F7p8WpJ9rzsGx/ZW64BkRAacRfYyrak09HUdgq
         wc8ET2pW2Mwpw5tr8if4R2PGmx/GFEOOx9X4G316+d0A10yg/TMRYCuYlcIbnGSZBUqq
         Tb810sFoMqTBcpe3xOMyC77ieRjpDE4fZoyNpEmE+TDZVOSnGGaTA8n4LJmJZerfBfDR
         sEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2hPM+SGX2bso2P06MksOdn7k4SylcbKetGkN5XP9cNQ=;
        b=A3FTetPiOIcP6hChsZ6PW9XdXjlKQBw906Moc+ZpvxbQFjVPfwom7D7KVoTu0EaSie
         vCu8vBl3/SGRaCoXO5LchCgFYsPVNPpyHxXNw/c3hH1Wq6Lmmfs1my89qZxirdxse5UN
         2fsV1QvRaMBX6CGDmjEe5mfIrV5gEiH32E1BhW6NGsmOCgyOQGRuzQMBC2yhJj3mSmbJ
         /qdcKPBV236nBsPSqHsRlobX26w0+yEB+6ggZYfh0KEn3P3DSZXMED8FNXxHXgadNJ59
         RHdrU4mfVzQgFEtctdlUU4fEpfUFpyjg4J3W4N3bcp0MFkZWovY4kR6sQEOYWta1+Igf
         olTg==
X-Gm-Message-State: AOAM533iBAAiWD3EsJjRxGGM1+gzKrcWfmxsFdABkEmw5I9Q6K3Nwabt
        KVHDotOmM5U77JAroTR0USj4QQkEGA==
X-Google-Smtp-Source: ABdhPJz8G5YH5FmSFdqtod0V+V0UdN19s9mLT2waEfcjUgrRN/b5qwGcgfyEZr0VvtIk0tHqaPCKGMjirQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
 (user=elver job=sendgmr) by 2002:a05:6214:223:: with SMTP id
 j3mr37761745qvt.9.1618399739655; Wed, 14 Apr 2021 04:28:59 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:28:23 +0200
In-Reply-To: <20210414112825.3008667-1-elver@google.com>
Message-Id: <20210414112825.3008667-8-elver@google.com>
Mime-Version: 1.0
References: <20210414112825.3008667-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 7/9] kcsan: Remove kcsan_report_type
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, will@kernel.org, dvyukov@google.com,
        glider@google.com, boqun.feng@gmail.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Now that the reporting code has been refactored, it's clear by
construction that print_report() can only be passed
KCSAN_REPORT_RACE_SIGNAL or KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, and these
can also be distinguished by the presence of `other_info`.

Let's simplify things and remove the report type enum, and instead let's
check `other_info` to distinguish these cases. This allows us to remove
code for cases which are impossible and generally makes the code simpler.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[ elver@google.com: add updated comments to kcsan_report_*() functions ]
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan.h  | 33 +++++++++++++--------------------
 kernel/kcsan/report.c | 29 +++++++----------------------
 2 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 2ee43fd5d6a4..572f119a19eb 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -116,32 +116,25 @@ enum kcsan_value_change {
 	KCSAN_VALUE_CHANGE_TRUE,
 };
 
-enum kcsan_report_type {
-	/*
-	 * The thread that set up the watchpoint and briefly stalled was
-	 * signalled that another thread triggered the watchpoint.
-	 */
-	KCSAN_REPORT_RACE_SIGNAL,
-
-	/*
-	 * A thread found and consumed a matching watchpoint.
-	 */
-	KCSAN_REPORT_CONSUMED_WATCHPOINT,
-
-	/*
-	 * No other thread was observed to race with the access, but the data
-	 * value before and after the stall differs.
-	 */
-	KCSAN_REPORT_RACE_UNKNOWN_ORIGIN,
-};
-
 /*
- * Notify the report code that a race occurred.
+ * The calling thread hit and consumed a watchpoint: set the access information
+ * to be consumed by the reporting thread. No report is printed yet.
  */
 void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
 			   int watchpoint_idx);
+
+/*
+ * The calling thread observed that the watchpoint it set up was hit and
+ * consumed: print the full report based on information set by the racing
+ * thread.
+ */
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
 			       enum kcsan_value_change value_change, int watchpoint_idx);
+
+/*
+ * No other thread was observed to race with the access, but the data value
+ * before and after the stall differs. Reports a race of "unknown origin".
+ */
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ba924f110c95..50cee2357885 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -326,7 +326,6 @@ static void print_verbose_info(struct task_struct *task)
 }
 
 static void print_report(enum kcsan_value_change value_change,
-			 enum kcsan_report_type type,
 			 const struct access_info *ai,
 			 const struct other_info *other_info)
 {
@@ -343,7 +342,7 @@ static void print_report(enum kcsan_value_change value_change,
 	if (skip_report(KCSAN_VALUE_CHANGE_TRUE, stack_entries[skipnr]))
 		return;
 
-	if (type == KCSAN_REPORT_RACE_SIGNAL) {
+	if (other_info) {
 		other_skipnr = get_stack_skipnr(other_info->stack_entries,
 						other_info->num_stack_entries);
 		other_frame = other_info->stack_entries[other_skipnr];
@@ -358,8 +357,7 @@ static void print_report(enum kcsan_value_change value_change,
 
 	/* Print report header. */
 	pr_err("==================================================================\n");
-	switch (type) {
-	case KCSAN_REPORT_RACE_SIGNAL: {
+	if (other_info) {
 		int cmp;
 
 		/*
@@ -371,22 +369,15 @@ static void print_report(enum kcsan_value_change value_change,
 		       get_bug_type(ai->access_type | other_info->ai.access_type),
 		       (void *)(cmp < 0 ? other_frame : this_frame),
 		       (void *)(cmp < 0 ? this_frame : other_frame));
-	} break;
-
-	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+	} else {
 		pr_err("BUG: KCSAN: %s in %pS\n", get_bug_type(ai->access_type),
 		       (void *)this_frame);
-		break;
-
-	default:
-		BUG();
 	}
 
 	pr_err("\n");
 
 	/* Print information about the racing accesses. */
-	switch (type) {
-	case KCSAN_REPORT_RACE_SIGNAL:
+	if (other_info) {
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
 		       get_access_type(other_info->ai.access_type), other_info->ai.ptr,
 		       other_info->ai.size, get_thread_desc(other_info->ai.task_pid),
@@ -404,16 +395,10 @@ static void print_report(enum kcsan_value_change value_change,
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
 		       get_access_type(ai->access_type), ai->ptr, ai->size,
 		       get_thread_desc(ai->task_pid), ai->cpu_id);
-		break;
-
-	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+	} else {
 		pr_err("race at unknown origin, with %s to 0x%px of %zu bytes by %s on cpu %i:\n",
 		       get_access_type(ai->access_type), ai->ptr, ai->size,
 		       get_thread_desc(ai->task_pid), ai->cpu_id);
-		break;
-
-	default:
-		BUG();
 	}
 	/* Print stack trace of this thread. */
 	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
@@ -623,7 +608,7 @@ void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access
 	 * be done once we know the full stack trace in print_report().
 	 */
 	if (value_change != KCSAN_VALUE_CHANGE_FALSE)
-		print_report(value_change, KCSAN_REPORT_RACE_SIGNAL, &ai, other_info);
+		print_report(value_change, &ai, other_info);
 
 	release_report(&flags, other_info);
 out:
@@ -640,7 +625,7 @@ void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int acce
 	lockdep_off(); /* See kcsan_report_known_origin(). */
 
 	raw_spin_lock_irqsave(&report_lock, flags);
-	print_report(KCSAN_VALUE_CHANGE_TRUE, KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, &ai, NULL);
+	print_report(KCSAN_VALUE_CHANGE_TRUE, &ai, NULL);
 	raw_spin_unlock_irqrestore(&report_lock, flags);
 
 	lockdep_on();
-- 
2.31.1.295.g9ea45b61b8-goog

