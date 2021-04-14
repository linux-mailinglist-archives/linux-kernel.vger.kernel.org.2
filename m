Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC335F28D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350642AbhDNL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350543AbhDNL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:29:11 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6F3C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:48 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p5so823912qvr.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mMtpkoi7Dg1KI2BVOCvCvQkqmnY+V0ww8kwlTHqSHyQ=;
        b=ZaPyMeCkuGUrEuXfuFpHu0vuIW42WqZyOyAqTAZad0QEZt52MwoQNefncM5i6DdEhY
         wofZZj79o7BVkE06wj1dn80ne2ciLKmKAOrEBBIl2y56QTF+SWk5M+jEbegVVn6AiGix
         4ccfQVtHnxgJSyWsapinxg6VBgRE+fXzCudwxGaQGOCx/ENcKRuxEzdYRK9DSDTJ1bnN
         CCCqZKC4iDAPORo+lS/3pvFByAlSMmwaTHnEkjVmeOVB3vrKOTp/HX/H3q1XjJ2k2c4D
         mSdzK4bZ1LBFlBlpeDx5mkg9QpB/hyqRevdMnCbAVviJgdSQb8y5gOGpHui3GR+6Qxae
         wZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mMtpkoi7Dg1KI2BVOCvCvQkqmnY+V0ww8kwlTHqSHyQ=;
        b=kf0FiQ4GZuPbxA0ZTwnNS8umWyuVKtvwla7bPoYkJwFuFM8jmr2aw6lfPWIfHTdSe2
         UDusXFnu+raKpqz1V1TNPflgIRY1lgyjhHYa3ZguUwYEe1PvKcGrd6WeuIGxMt9DCuVn
         RoTlntNgxkKLT6MoOEA2AXB/rzE77qPtBUaqYEZupALVoGHbVY1TErJyjn7gp/Pfnbid
         loU0ZeQVvnUT33+hFlNBwW2KxAAUxSPV7sCtFJB/WxvSeZStQiU5dqmoixdteZQSAqv5
         Vy9fCQr+wkbmvz1oXJclHrxGo3yIFe7OmAfGFA8JYEQ+dpoDad4PHHXE/QW5J/jQihGT
         BpTg==
X-Gm-Message-State: AOAM531k5Ysp7mlqW/LZv0LZfQmtNu4E9eAf8TsXwiKIPnTVd8uooklz
        lgQFe7hL1/3CbJIunUCwi0PQ263P6w==
X-Google-Smtp-Source: ABdhPJygonIhCHuloKZW4R6VhI27UX+vRiQAVBm+aaZ0pobVDsj0B5S5LlTi3xqnIytztGQVwxl0q05+PQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
 (user=elver job=sendgmr) by 2002:a05:6214:248f:: with SMTP id
 gi15mr37426775qvb.40.1618399727735; Wed, 14 Apr 2021 04:28:47 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:28:18 +0200
In-Reply-To: <20210414112825.3008667-1-elver@google.com>
Message-Id: <20210414112825.3008667-3-elver@google.com>
Mime-Version: 1.0
References: <20210414112825.3008667-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 2/9] kcsan: Distinguish kcsan_report() calls
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
2.31.1.295.g9ea45b61b8-goog

