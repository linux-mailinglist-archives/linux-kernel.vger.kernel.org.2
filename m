Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3665237B287
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhEKXZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhEKXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E93F61934;
        Tue, 11 May 2021 23:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620775447;
        bh=NajS0J4OC8sH9w6ZtTRbeXDf2o4v2z1lml2NgCHFWsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfYNVMOmwPkcYQIRJxqRXoX040LFPJlbMZC0r7UexhAaG3/PtrTHXczVSbiwTHFjQ
         S9A/zYdpuyEr9ciTEVmg5wrrc3OclgJ8nINDjrb1PkVvJZYr2wEJz37qq4ezIhg7Om
         WQt6KB2bstohTikVc61fjGNUNBY2FlbnjojGCipKwAGfZVE62Lbp+f1d0y9KjPvgk7
         CrHlzu7Z9FBdTDn4s6kIbvT7/o5S0WhNqwvPA3dgSfjV7risFvbBHRrnG2NZhTgrXK
         zZe6M1MdKulS4T9VDpoesDnHPL9g8Xc3/CgRffB8I1xjT7X5pEszuKBiPI6442epfx
         OpNCm6UC6UF/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A43275C0DB3; Tue, 11 May 2021 16:24:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/10] kcsan: Refactor access_info initialization
Date:   Tue, 11 May 2021 16:23:57 -0700
Message-Id: <20210511232401.2896217-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

In subsequent patches we'll want to split kcsan_report() into distinct
handlers for each report type. The largest bit of common work is
initializing the `access_info`, so let's factor this out into a helper,
and have the kcsan_report_*() functions pass the `aaccess_info` as a
parameter to kcsan_report().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 8bfa970965a1..d8441bed065c 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -596,18 +596,10 @@ static noinline bool prepare_report(unsigned long *flags,
 	}
 }
 
-static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-			 enum kcsan_value_change value_change,
+static void kcsan_report(const struct access_info *ai, enum kcsan_value_change value_change,
 			 enum kcsan_report_type type, struct other_info *other_info)
 {
 	unsigned long flags = 0;
-	const struct access_info ai = {
-		.ptr		= ptr,
-		.size		= size,
-		.access_type	= access_type,
-		.task_pid	= in_task() ? task_pid_nr(current) : -1,
-		.cpu_id		= raw_smp_processor_id()
-	};
 
 	kcsan_disable_current();
 
@@ -620,14 +612,14 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	 */
 	lockdep_off();
 
-	if (prepare_report(&flags, type, &ai, other_info)) {
+	if (prepare_report(&flags, type, ai, other_info)) {
 		/*
 		 * Never report if value_change is FALSE, only if we it is
 		 * either TRUE or MAYBE. In case of MAYBE, further filtering may
 		 * be done once we know the full stack trace in print_report().
 		 */
 		if (value_change != KCSAN_VALUE_CHANGE_FALSE)
-			print_report(value_change, type, &ai, other_info);
+			print_report(value_change, type, ai, other_info);
 
 		release_report(&flags, other_info);
 	}
@@ -636,22 +628,38 @@ static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	kcsan_enable_current();
 }
 
+static struct access_info prepare_access_info(const volatile void *ptr, size_t size,
+					      int access_type)
+{
+	return (struct access_info) {
+		.ptr		= ptr,
+		.size		= size,
+		.access_type	= access_type,
+		.task_pid	= in_task() ? task_pid_nr(current) : -1,
+		.cpu_id		= raw_smp_processor_id()
+	};
+}
+
 void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
 			   int watchpoint_idx)
 {
-	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_MAYBE,
-		     KCSAN_REPORT_CONSUMED_WATCHPOINT, &other_infos[watchpoint_idx]);
+	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+
+	kcsan_report(&ai, KCSAN_VALUE_CHANGE_MAYBE, KCSAN_REPORT_CONSUMED_WATCHPOINT,
+		     &other_infos[watchpoint_idx]);
 }
 
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
 			       enum kcsan_value_change value_change, int watchpoint_idx)
 {
-	kcsan_report(ptr, size, access_type, value_change,
-		     KCSAN_REPORT_RACE_SIGNAL, &other_infos[watchpoint_idx]);
+	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+
+	kcsan_report(&ai, value_change, KCSAN_REPORT_RACE_SIGNAL, &other_infos[watchpoint_idx]);
 }
 
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
 {
-	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_TRUE,
-		     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, NULL);
+	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+
+	kcsan_report(&ai, KCSAN_VALUE_CHANGE_TRUE, KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, NULL);
 }
-- 
2.31.1.189.g2e36527f23

