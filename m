Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7D35F28C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350548AbhDNL3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350544AbhDNL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:29:12 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B17C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:50 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l7-20020ac80c470000b029019ad46696f7so1665604qti.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mUd7E8x0BAm4t1vvxUhc96USRUC2VnPVzcusbEWbh3k=;
        b=bvqPmC3FbAhgGGAtG/zcuz6HLuCwkoqKZ5EmVZ9V5RB3ESq1DoY9I+of3Q+oa6XG7w
         5qpCHF9CRobuxQJwLNZBg4GcQm9F0C5QSeB4UmxjVODFGPK1HsgF1nFzhdtKtX8xgJNG
         TWceHN7O13ogWUQZ0IXNCwdX0sf7sSEagBdHabttew7TVBs1cSiC+et6DJj2KjeDFkg8
         jDvBm07jbomOnxE5nFIGJXDCTTMDe28x8WP7KkNQlxYRnIsOmcktwHY90joYm+nzdcOw
         3fnqqrSCWiULk553RytCVLJwzqOnvkmR3xP319dJ8xviTWaQoweKnDjQt9X7YQBsknfv
         vKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mUd7E8x0BAm4t1vvxUhc96USRUC2VnPVzcusbEWbh3k=;
        b=bJJgUQxu/KuCPbA7eyMMAqOVONqBF0HC2Fw7bL67ea7D1W/KryzUfKyZwOniX3661c
         ENlsCBo4HgTqNRDh2Mk8QqHaBmLySc7bF8wBDTYC9HyOzowJD+Old4g3ozmkV5SwymsV
         oBcP34sUQeTnnpiOJzWHQwObOB39RNltv4IctOMToX963PyD6k7G5D9LN4tb22YtZSKg
         vIfj+wANiQzbQ79oM1caaCtEIUPn/ONgYpyXX0IWu47wpOYpfVSzrVJtww+HNkU049vc
         11b7U9Lf5tkO0v9muR7qfkvzd0Oe7m13w9/YsVLia/CncOMfYP0P7OV1XeVUqPcZ4kED
         DCIQ==
X-Gm-Message-State: AOAM531Aubo2ouPsLRR9omGtJVcv1HUDTgQWj10chA6I+jnGR7E+RHfH
        JizMhK1MBTbxJ0YxhqrJT9YAwR6tNw==
X-Google-Smtp-Source: ABdhPJzqqZKJ8Nltq0MECU1+cNGh8WHgIUvblGliEhoxYeS8i/R8VpSebLAupPlbxO7A+0A1of+erMuBQQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
 (user=elver job=sendgmr) by 2002:a0c:c581:: with SMTP id a1mr37671645qvj.34.1618399730080;
 Wed, 14 Apr 2021 04:28:50 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:28:19 +0200
In-Reply-To: <20210414112825.3008667-1-elver@google.com>
Message-Id: <20210414112825.3008667-4-elver@google.com>
Mime-Version: 1.0
References: <20210414112825.3008667-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 3/9] kcsan: Refactor passing watchpoint/other_info
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
2.31.1.295.g9ea45b61b8-goog

