Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6716637B27F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEKXZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhEKXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2B296191D;
        Tue, 11 May 2021 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620775447;
        bh=X1/U/qzckFQazuA5uriCvq8IvEsm6FYgA6sHfXzxcOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OdlhUWP0LUV+ckIOYzN2wTxDZgaiCS25nlARXvnY0S95iiL5Hky/8GFiUVtyDMPDh
         NY1xd9jB3acEp/4TpO9F+PvBwAAQ4G0m0zzbHxtf17vMDup974WB13NXVQz17uqPNH
         QXxgp7ESeYiPfct5qY9dSUixGL7CXj/V9h/DL+7+m6JmzbugfkxfMAEGsaSWdfaCbj
         cc1JgCTu0OIz+6GZZxqo+Bc4uDgN2+THcUAo919X7oegaziMaZsL8qG/ZH9Yf3D65X
         tw7otAe/POOlXdMzkxJAcD6Spm33Us/ukwSEpnLNgRy0NHEuHoZirQPjkPVj8J9tWm
         u/5amp5qB3+LQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9E3575C09EF; Tue, 11 May 2021 16:24:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/10] kcsan: Distinguish kcsan_report() calls
Date:   Tue, 11 May 2021 16:23:54 -0700
Message-Id: <20210511232401.2896217-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Currently kcsan_report() is used to handle three distinct cases:

* The caller hit a watchpoint when attempting an access. Some
  information regarding the caller and access are recorded, but no
  output is produced.

* A caller which previously setup a watchpoint detected that the
  watchpoint has been hit, and possibly detected a change to the
  location in memory being watched. This may result in output reporting
  the interaction between this caller and the caller which hit the
  watchpoint.

* A caller detected a change to a modification to a memory location
  which wasn't detected by a watchpoint, for which there is no
  information on the other thread. This may result in output reporting
  the unexpected change.

... depending on the specific case the caller has distinct pieces of
information available, but the prototype of kcsan_report() has to handle
all three cases. This means that in some cases we pass redundant
information, and in others we don't pass all the information we could
pass. This also means that the report code has to demux these three
cases.

So that we can pass some additional information while also simplifying
the callers and report code, add separate kcsan_report_*() functions for
the distinct cases, updating callers accordingly. As the watchpoint_idx
is unused in the case of kcsan_report_unknown_origin(), this passes a
dummy value into kcsan_report(). Subsequent patches will refactor the
report code to avoid this.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[ elver@google.com: try to make kcsan_report_*() names more descriptive ]
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c   | 12 ++++--------
 kernel/kcsan/kcsan.h  | 10 ++++++----
 kernel/kcsan/report.c | 26 +++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index d360183002d6..6fe1513e1e6a 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -380,9 +380,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 
 	if (consumed) {
 		kcsan_save_irqtrace(current);
-		kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
-			     KCSAN_REPORT_CONSUMED_WATCHPOINT,
-			     watchpoint - watchpoints);
+		kcsan_report_set_info(ptr, size, type, watchpoint - watchpoints);
 		kcsan_restore_irqtrace(current);
 	} else {
 		/*
@@ -558,8 +556,8 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
-		kcsan_report(ptr, size, type, value_change, KCSAN_REPORT_RACE_SIGNAL,
-			     watchpoint - watchpoints);
+		kcsan_report_known_origin(ptr, size, type, value_change,
+					  watchpoint - watchpoints);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
@@ -568,9 +566,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
-			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
-				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN,
-				     watchpoint - watchpoints);
+			kcsan_report_unknown_origin(ptr, size, type);
 	}
 
 	/*
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 9881099d4179..2ee43fd5d6a4 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -136,10 +136,12 @@ enum kcsan_report_type {
 };
 
 /*
- * Print a race report from thread that encountered the race.
+ * Notify the report code that a race occurred.
  */
-extern void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-			 enum kcsan_value_change value_change,
-			 enum kcsan_report_type type, int watchpoint_idx);
+void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
+			   int watchpoint_idx);
+void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
+			       enum kcsan_value_change value_change, int watchpoint_idx);
+void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 13dce3c664d6..5232bf218ea7 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -598,9 +598,9 @@ static noinline bool prepare_report(unsigned long *flags,
 	}
 }
 
-void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-		  enum kcsan_value_change value_change,
-		  enum kcsan_report_type type, int watchpoint_idx)
+static void kcsan_report(const volatile void *ptr, size_t size, int access_type,
+			 enum kcsan_value_change value_change,
+			 enum kcsan_report_type type, int watchpoint_idx)
 {
 	unsigned long flags = 0;
 	const struct access_info ai = {
@@ -645,3 +645,23 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 out:
 	kcsan_enable_current();
 }
+
+void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
+			   int watchpoint_idx)
+{
+	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_MAYBE,
+		     KCSAN_REPORT_CONSUMED_WATCHPOINT, watchpoint_idx);
+}
+
+void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
+			       enum kcsan_value_change value_change, int watchpoint_idx)
+{
+	kcsan_report(ptr, size, access_type, value_change,
+		     KCSAN_REPORT_RACE_SIGNAL, watchpoint_idx);
+}
+
+void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type)
+{
+	kcsan_report(ptr, size, access_type, KCSAN_VALUE_CHANGE_TRUE,
+		     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN, 0);
+}
-- 
2.31.1.189.g2e36527f23

