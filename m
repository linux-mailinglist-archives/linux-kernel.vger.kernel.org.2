Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768F037B285
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhEKXZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhEKXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4538C61935;
        Tue, 11 May 2021 23:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620775447;
        bh=Rh9pXyfjudMjgF/UiIKw/9eo2K1l46YnyGDwYyQmKuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMzGzw07wEgYsp7S3h8fRkt+WEvdzDuiwWgYHiN2xxdjHrJMgpiH/ydBVJnqbZPcm
         J5oEj+jUiaYRAmReta/yPGaHPtGMhOwFwtMS3ycSGLz1YHqwIXMIFP71dUqG/6WJd0
         pfD65o87F8knyIDpogBKN/UdVIZDGH/YPbYqMGvBHZBezvqGrBCYETlx0s0v5ifHyY
         r4CSiDYOMV5jkTizm6Ct5cqGU6ZzLqy9jjxj/xMqZpEAvNmmbMUk+WrYO4RifNFled
         XuOxjymQ/iT2izA5Pb+n7cscwcxVRBKgZxen5gEVqze3ABPYTzRUyhBCg8tA3S85cd
         h5vwE8bJXO3/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A61B35C0DD7; Tue, 11 May 2021 16:24:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/10] kcsan: Remove reporting indirection
Date:   Tue, 11 May 2021 16:23:58 -0700
Message-Id: <20210511232401.2896217-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Now that we have separate kcsan_report_*() functions, we can factor the
distinct logic for each of the report cases out of kcsan_report(). While
this means each case has to handle mutual exclusion independently, this
minimizes the conditionality of code and makes it easier to read, and
will permit passing distinct bits of information to print_report() in
future.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[ elver@google.com: retain comment about lockdep_off() ]
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 115 ++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 66 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index d8441bed065c..ba924f110c95 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -434,13 +434,11 @@ static void print_report(enum kcsan_value_change value_change,
 
 static void release_report(unsigned long *flags, struct other_info *other_info)
 {
-	if (other_info)
-		/*
-		 * Use size to denote valid/invalid, since KCSAN entirely
-		 * ignores 0-sized accesses.
-		 */
-		other_info->ai.size = 0;
-
+	/*
+	 * Use size to denote valid/invalid, since KCSAN entirely ignores
+	 * 0-sized accesses.
+	 */
+	other_info->ai.size = 0;
 	raw_spin_unlock_irqrestore(&report_lock, *flags);
 }
 
@@ -573,61 +571,6 @@ static bool prepare_report_consumer(unsigned long *flags,
 	return false;
 }
 
-/*
- * Depending on the report type either sets @other_info and returns false, or
- * awaits @other_info and returns true. If @other_info is not required for the
- * report type, simply acquires @report_lock and returns true.
- */
-static noinline bool prepare_report(unsigned long *flags,
-				    enum kcsan_report_type type,
-				    const struct access_info *ai,
-				    struct other_info *other_info)
-{
-	switch (type) {
-	case KCSAN_REPORT_CONSUMED_WATCHPOINT:
-		prepare_report_producer(flags, ai, other_info);
-		return false;
-	case KCSAN_REPORT_RACE_SIGNAL:
-		return prepare_report_consumer(flags, ai, other_info);
-	default:
-		/* @other_info not required; just acquire @report_lock. */
-		raw_spin_lock_irqsave(&report_lock, *flags);
-		return true;
-	}
-}
-
-static void kcsan_report(const struct access_info *ai, enum kcsan_value_change value_change,
-			 enum kcsan_report_type type, struct other_info *other_info)
-{
-	unsigned long flags = 0;
-
-	kcsan_disable_current();
-
-	/*
-	 * Because we may generate reports when we're in scheduler code, the use
-	 * of printk() could deadlock. Until such time that all printing code
-	 * called in print_report() is scheduler-safe, accept the risk, and just
-	 * get our message out. As such, also disable lockdep to hide the
-	 * warning, and avoid disabling lockdep for the rest of the kernel.
-	 */
-	lockdep_off();
-
-	if (prepare_report(&flags, type, ai, other_info)) {
-		/*
-		 * Never report if value_change is FALSE, only if we it is
-		 * either TRUE or MAYBE. In case of MAYBE, further filtering may
-		 * be done once we know the full stack trace in print_report().
-		 */
-		if (value_change != KCSAN_VALUE_CHANGE_FALSE)
-			print_report(value_change, type, ai, other_info);
-
-		release_report(&flags, other_info);
-	}
-
-	lockdep_on();
-	kcsan_enable_current();
-}
-
 static struct access_info prepare_access_info(const volatile void *ptr, size_t size,
 					      int access_type)
 {
@@ -644,22 +587,62 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
 			   int watchpoint_idx)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+	unsigned long flags;
+
+	kcsan_disable_current();
+	lockdep_off(); /* See kcsan_report_known_origin(). */
 
-	kcsan_report(&ai, KCSAN_VALUE_CHANGE_MAYBE, KCSAN_REPORT_CONSUMED_WATCHPOINT,
-		     &other_infos[watchpoint_idx]);
+	prepare_report_producer(&flags, &ai, &other_infos[watchpoint_idx]);
+
+	lockdep_on();
+	kcsan_enable_current();
 }
 
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
 			       enum kcsan_value_change value_change, int watchpoint_idx)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+	struct other_info *other_info = &other_infos[watchpoint_idx];
+	unsigned long flags = 0;
 
-	kcsan_report(&ai, value_change, KCSAN_REPORT_RACE_SIGNAL, &other_infos[watchpoint_idx]);
+	kcsan_disable_current();
+	/*
+	 * Because we may generate reports when we're in scheduler code, the use
+	 * of printk() could deadlock. Until such time that all printing code
+	 * called in print_report() is scheduler-safe, accept the risk, and just
+	 * get our message out. As such, also disable lockdep to hide the
+	 * warning, and avoid disabling lockdep for the rest of the kernel.
+	 */
+	lockdep_off();
+
+	if (!prepare_report_consumer(&flags, &ai, other_info))
+		goto out;
+	/*
+	 * Never report if value_change is FALSE, only when it is
+	 * either TRUE or MAYBE. In case of MAYBE, further filtering may
+	 * be done once we know the full stack trace in print_report().
+	 */
+	if (value_change != KCSAN_VALUE_CHANGE_FALSE)
+		print_report(value_change, KCSAN_REPORT_RACE_SIGNAL, &ai, other_info);
+
+	release_report(&flags, other_info);
+out:
+	lockdep_on();
+	kcsan_enable_current();
 }
 
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
 {
 	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+	unsigned long flags;
+
+	kcsan_disable_current();
+	lockdep_off(); /* See kcsan_report_known_origin(). */
+
+	raw_spin_lock_irqsave(&report_lock, flags);
+	print_report(KCSAN_VALUE_CHANGE_TRUE, KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, &ai, NULL);
+	raw_spin_unlock_irqrestore(&report_lock, flags);
 
-	kcsan_report(&ai, KCSAN_VALUE_CHANGE_TRUE, KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, NULL);
+	lockdep_on();
+	kcsan_enable_current();
 }
-- 
2.31.1.189.g2e36527f23

