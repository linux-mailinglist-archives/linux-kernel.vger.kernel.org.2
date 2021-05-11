Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3DA37B282
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhEKXZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhEKXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECAFB6162B;
        Tue, 11 May 2021 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620775447;
        bh=yfeLwaceygaV9HrvBzE3w/xE9pLLsBdplx6q4Zj1wNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qUoX/e6we0xNsXsPMB4MZX1ssXNO8OInOtB/K3M2d0ot6Sn9mUwJio+GolSoeaOUL
         CIyuEXpiljTsnKpGBoUFN5znEpeY1H+SLrTwoiisanjO32eyNYS8r4ZCpMjPP1nEzT
         TpjIGx/IS82NQ+bSFkMb2fy5uuNQJ8lDKlb9GLPbuylDjaL2rnu5b+okhORWqBVzCI
         4RzDEokZPxhQtdRExvnZ5UtmQWkTTql3VN7MqGfsW29UU9O+tF/IDmC6q84p9dk/9d
         Otpt+d7PWb0Y3h/Um0T1O1lmpm/5vaYk1HiQ65QN47h0bXGxPT8mNcLNhZ8TAH5Ebv
         7Uq9MLhmXkLmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A20C75C0D4A; Tue, 11 May 2021 16:24:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/10] kcsan: Fold panic() call into print_report()
Date:   Tue, 11 May 2021 16:23:56 -0700
Message-Id: <20210511232401.2896217-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

So that we can add more callers of print_report(), lets fold the panic()
call into print_report() so the caller doesn't have to handle this
explicitly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 88225f6d471e..8bfa970965a1 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -325,10 +325,7 @@ static void print_verbose_info(struct task_struct *task)
 	print_irqtrace_events(task);
 }
 
-/*
- * Returns true if a report was generated, false otherwise.
- */
-static bool print_report(enum kcsan_value_change value_change,
+static void print_report(enum kcsan_value_change value_change,
 			 enum kcsan_report_type type,
 			 const struct access_info *ai,
 			 const struct other_info *other_info)
@@ -344,7 +341,7 @@ static bool print_report(enum kcsan_value_change value_change,
 	 * Must check report filter rules before starting to print.
 	 */
 	if (skip_report(KCSAN_VALUE_CHANGE_TRUE, stack_entries[skipnr]))
-		return false;
+		return;
 
 	if (type == KCSAN_REPORT_RACE_SIGNAL) {
 		other_skipnr = get_stack_skipnr(other_info->stack_entries,
@@ -353,11 +350,11 @@ static bool print_report(enum kcsan_value_change value_change,
 
 		/* @value_change is only known for the other thread */
 		if (skip_report(value_change, other_frame))
-			return false;
+			return;
 	}
 
 	if (rate_limit_report(this_frame, other_frame))
-		return false;
+		return;
 
 	/* Print report header. */
 	pr_err("==================================================================\n");
@@ -431,7 +428,8 @@ static bool print_report(enum kcsan_value_change value_change,
 	dump_stack_print_info(KERN_DEFAULT);
 	pr_err("==================================================================\n");
 
-	return true;
+	if (panic_on_warn)
+		panic("panic_on_warn set ...\n");
 }
 
 static void release_report(unsigned long *flags, struct other_info *other_info)
@@ -628,11 +626,8 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		 * either TRUE or MAYBE. In case of MAYBE, further filtering may
 		 * be done once we know the full stack trace in print_report().
 		 */
-		bool reported = value_change != KCSAN_VALUE_CHANGE_FALSE &&
-				print_report(value_change, type, &ai, other_info);
-
-		if (reported && panic_on_warn)
-			panic("panic_on_warn set ...\n");
+		if (value_change != KCSAN_VALUE_CHANGE_FALSE)
+			print_report(value_change, type, &ai, other_info);
 
 		release_report(&flags, other_info);
 	}
-- 
2.31.1.189.g2e36527f23

