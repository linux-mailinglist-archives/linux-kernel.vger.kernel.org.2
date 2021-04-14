Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F212535F292
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350582AbhDNLaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350603AbhDNL3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:29:24 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:29:03 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id ay2-20020a0564022022b02903824b52f2d8so3158755edb.22
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ynSDj0gr7BYAa8rgkGogbZ/dJW9wUhiWNxksecLrupI=;
        b=Ou/B/TmT8xgJI4RVQfe3YabHKtiUe4ufbiF7jmq8tf90kv4JWlv6VbySI+vOzaPywm
         IjNXhl3EHkHk17OVFjcIvx1q0YWdZOdctIng60kkGHVSTZ3B/S5iJpv00YP908t6kPdL
         WKw9FqCsHaOo3rl3vl9QxOjiQuSF9+JQPtRrJeQmhUUlM4K2NbcF0uBkk7INWg0NZhh3
         8tPpqtLQBwuxb3hZNl1iJ6OBXNB3dYFaATuyvCtPse+tgb9aYcSWcgqqV+BbhvaOLyFp
         0k4a/t2nxO26YDPmjtqMJzolYTFNRgTW3AMmwem92K81izq5gp1lvyk7kybUx8Wns1u6
         z0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ynSDj0gr7BYAa8rgkGogbZ/dJW9wUhiWNxksecLrupI=;
        b=mZX6g06HO+LdF4Qi61NSJrXhvs/71SUIky29aHgGOPJZnlYVF/J81Y6dQDZyFWG1tY
         WXqAaDUCd8r7jezdX0YrmIrB5y5+TJNOMpdbT9hlzgLz1Jj7m8jcv0hpGkvHq//mDfAl
         Kq2A0HiE5xrDrReFWcj4bKUEoOIUCvsdLhJXas7ULn2idSBd63w+yOg6ojW77/oncfm0
         r6mFgnvUEhwLkj2+FrnXSZ6Sg6/VPxlYIMyEjp+a39H/1LzkBrWPEQERIgNhRAbf4GQ2
         S6QSyOn80PnccKy6XIkbScHVTMZ9jdAP4+OS5WCvT2F5dYIwbJNCB9viXHOJ2T1t/JM/
         9X4Q==
X-Gm-Message-State: AOAM533VQaJdMm7cPemCDgJiYTgXALLjb7wFqhvC2lILesBqJe/4VZ1g
        EjBI6+70TQ9c3Lrytnck/tjGoV+eug==
X-Google-Smtp-Source: ABdhPJx12VmOYP4xk+3Si24MuLTjA6bgBOFNSVj5IaGVqawsmjpJUcml7tEsbuvPBOz23uEomFxb6w0MmQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
 (user=elver job=sendgmr) by 2002:a17:906:3d62:: with SMTP id
 r2mr36491433ejf.488.1618399741876; Wed, 14 Apr 2021 04:29:01 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:28:24 +0200
In-Reply-To: <20210414112825.3008667-1-elver@google.com>
Message-Id: <20210414112825.3008667-9-elver@google.com>
Mime-Version: 1.0
References: <20210414112825.3008667-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 8/9] kcsan: Report observed value changes
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

When a thread detects that a memory location was modified without its
watchpoint being hit, the report notes that a change was detected, but
does not provide concrete values for the change. Knowing the concrete
values can be very helpful in tracking down any racy writers (e.g. as
specific values may only be written in some portions of code, or under
certain conditions).

When we detect a modification, let's report the concrete old/new values,
along with the access's mask of relevant bits (and which relevant bits
were modified). This can make it easier to identify potential racy
writers. As the snapshots are at most 8 bytes, we can only report values
for acceses up to this size, but this appears to cater for the common
case.

When we detect a race via a watchpoint, we may or may not have concrete
values for the modification. To be helpful, let's attempt to log them
when we do as they can be ignored where irrelevant.

The resulting reports appears as follows, with values zero-padded to the
access width:

| ==================================================================
| BUG: KCSAN: data-race in el0_svc_common+0x34/0x25c arch/arm64/kernel/syscall.c:96
|
| race at unknown origin, with read to 0xffff00007ae6aa00 of 8 bytes by task 223 on cpu 1:
|  el0_svc_common+0x34/0x25c arch/arm64/kernel/syscall.c:96
|  do_el0_svc+0x48/0xec arch/arm64/kernel/syscall.c:178
|  el0_svc arch/arm64/kernel/entry-common.c:226 [inline]
|  el0_sync_handler+0x1a4/0x390 arch/arm64/kernel/entry-common.c:236
|  el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:674
|
| value changed: 0x0000000000000000 -> 0x0000000000000002
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 1 PID: 223 Comm: syz-executor.1 Not tainted 5.8.0-rc3-00094-ga73f923ecc8e-dirty #3
| Hardware name: linux,dummy-virt (DT)
| ==================================================================

If an access mask is set, it is shown underneath the "value changed"
line as "bits changed: 0x<bits changed> with mask 0x<non-zero mask>".

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[ elver@google.com: align "value changed" and "bits changed" lines,
  which required massaging the message; do not print bits+mask if no
  mask set. ]
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c   |  5 +++--
 kernel/kcsan/kcsan.h  |  6 ++++--
 kernel/kcsan/report.c | 31 ++++++++++++++++++++++++++-----
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 6fe1513e1e6a..26709ea65c71 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -557,7 +557,8 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		kcsan_report_known_origin(ptr, size, type, value_change,
-					  watchpoint - watchpoints);
+					  watchpoint - watchpoints,
+					  old, new, access_mask);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
@@ -566,7 +567,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
-			kcsan_report_unknown_origin(ptr, size, type);
+			kcsan_report_unknown_origin(ptr, size, type, old, new, access_mask);
 	}
 
 	/*
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 572f119a19eb..f36e25c497ed 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -129,12 +129,14 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
  * thread.
  */
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
-			       enum kcsan_value_change value_change, int watchpoint_idx);
+			       enum kcsan_value_change value_change, int watchpoint_idx,
+			       u64 old, u64 new, u64 mask);
 
 /*
  * No other thread was observed to race with the access, but the data value
  * before and after the stall differs. Reports a race of "unknown origin".
  */
-void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type);
+void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type,
+				 u64 old, u64 new, u64 mask);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 50cee2357885..e37e4386f86d 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -327,7 +327,8 @@ static void print_verbose_info(struct task_struct *task)
 
 static void print_report(enum kcsan_value_change value_change,
 			 const struct access_info *ai,
-			 const struct other_info *other_info)
+			 const struct other_info *other_info,
+			 u64 old, u64 new, u64 mask)
 {
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
 	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
@@ -407,6 +408,24 @@ static void print_report(enum kcsan_value_change value_change,
 	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
 		print_verbose_info(current);
 
+	/* Print observed value change. */
+	if (ai->size <= 8) {
+		int hex_len = ai->size * 2;
+		u64 diff = old ^ new;
+
+		if (mask)
+			diff &= mask;
+		if (diff) {
+			pr_err("\n");
+			pr_err("value changed: 0x%0*llx -> 0x%0*llx\n",
+			       hex_len, old, hex_len, new);
+			if (mask) {
+				pr_err(" bits changed: 0x%0*llx with mask 0x%0*llx\n",
+				       hex_len, diff, hex_len, mask);
+			}
+		}
+	}
+
 	/* Print report footer. */
 	pr_err("\n");
 	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
@@ -584,7 +603,8 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
 }
 
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
-			       enum kcsan_value_change value_change, int watchpoint_idx)
+			       enum kcsan_value_change value_change, int watchpoint_idx,
+			       u64 old, u64 new, u64 mask)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
 	struct other_info *other_info = &other_infos[watchpoint_idx];
@@ -608,7 +628,7 @@ void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access
 	 * be done once we know the full stack trace in print_report().
 	 */
 	if (value_change != KCSAN_VALUE_CHANGE_FALSE)
-		print_report(value_change, &ai, other_info);
+		print_report(value_change, &ai, other_info, old, new, mask);
 
 	release_report(&flags, other_info);
 out:
@@ -616,7 +636,8 @@ void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access
 	kcsan_enable_current();
 }
 
-void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
+void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type,
+				 u64 old, u64 new, u64 mask)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
 	unsigned long flags;
@@ -625,7 +646,7 @@ void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int acce
 	lockdep_off(); /* See kcsan_report_known_origin(). */
 
 	raw_spin_lock_irqsave(&report_lock, flags);
-	print_report(KCSAN_VALUE_CHANGE_TRUE, &ai, NULL);
+	print_report(KCSAN_VALUE_CHANGE_TRUE, &ai, NULL, old, new, mask);
 	raw_spin_unlock_irqrestore(&report_lock, flags);
 
 	lockdep_on();
-- 
2.31.1.295.g9ea45b61b8-goog

