Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2737B283
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhEKXZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhEKXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF9476162A;
        Tue, 11 May 2021 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620775447;
        bh=Y5B1gAaD553/B60EQz4f9S2hfDIVR14D0rpSSdnM/Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKRH2HKlndoVCl8T2TkCSQwQnJr+cFdiqeF/b+2RA6T5vsUCofdHTxPuxy7bTBmIB
         NRPMlVdO6OMRcEvjfq8CegDOmierxEjGHxnMsqeolDwqOmeBLHtNspRCE5zeGSl1Iv
         RSXPgpJEsJLHafTN1Jp7u/Jz3FW/rkcxXJ1hqGWZ63upBlB6bUFwDnyr8RjsYnMQQ7
         6d8XKlXAUFpLimk8MhbPSvaroCOMor+8uR5XuVAzSLTSRjRfl8uGH2QAs19Ta3n9ye
         YtXelibTUzaePmp0nso6RdEyO1v3wauq8yW2+jwvDeCsqxJRn/DbfDIonkATZUt6Mk
         4ucZLQ/hXEgCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A02C25C0B55; Tue, 11 May 2021 16:24:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/10] kcsan: Refactor passing watchpoint/other_info
Date:   Tue, 11 May 2021 16:23:55 -0700
Message-Id: <20210511232401.2896217-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

The `watchpoint_idx` argument to kcsan_report() isn't meaningful for
races which were not detected by a watchpoint, and it would be clearer
if callers passed the other_info directly so that a NULL value can be
passed in this case.

Given that callers manipulate their watchpoints before passing the index
into kcsan_report_*(), and given we index the `other_infos` array using
this before we sanity-check it, the subsequent sanity check isn't all
that useful.

Let's remove the `watchpoint_idx` sanity check, and move the job of
finding the `other_info` out of kcsan_report().

Other than the removal of the check, there should be no functional
change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 5232bf218ea7..88225f6d471e 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -600,7 +600,7 @@ static noinline bool prepare_report(unsigned long *flags,
 
 static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 			 enum kcsan_value_change value_change,
-			 enum kcsan_report_type type, int watchpoint_idx)
+			 enum kcsan_report_type type, struct other_info *other_info)
 {
 	unsigned long flags = 0;
 	const struct access_info ai = {
@@ -610,12 +610,8 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		.task_pid	= in_task() ? task_pid_nr(current) : -1,
 		.cpu_id		= raw_smp_processor_id()
 	};
-	struct other_info *other_info = type == KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
-					? NULL : &other_infos[watchpoint_idx];
 
 	kcsan_disable_current();
-	if (WARN_ON(watchpoint_idx < 0 || watchpoint_idx >= ARRAY_SIZE(other_infos)))
-		goto out;
 
 	/*
 	 * Because we may generate reports when we're in scheduler code, the use
@@ -642,7 +638,6 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	}
 
 	lockdep_on();
-out:
 	kcsan_enable_current();
 }
 
@@ -650,18 +645,18 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
 			   int watchpoint_idx)
 {
 	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_MAYBE,
-		     KCSAN_REPORT_CONSUMED_WATCHPOINT, watchpoint_idx);
+		     KCSAN_REPORT_CONSUMED_WATCHPOINT, &other_infos[watchpoint_idx]);
 }
 
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
 			       enum kcsan_value_change value_change, int watchpoint_idx)
 {
 	kcsan_report(ptr, size, access_type, value_change,
-		     KCSAN_REPORT_RACE_SIGNAL, watchpoint_idx);
+		     KCSAN_REPORT_RACE_SIGNAL, &other_infos[watchpoint_idx]);
 }
 
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
 {
 	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_TRUE,
-		     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, 0);
+		     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, NULL);
 }
-- 
2.31.1.189.g2e36527f23

