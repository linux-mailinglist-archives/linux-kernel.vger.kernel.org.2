Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1E035F290
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350571AbhDNLaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350589AbhDNL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:29:19 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C2C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:58 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id t11-20020aa7d4cb0000b0290382e868be07so3153536edr.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8yNlufzVA2jCQWSX0cYvr/qzprbw9+PqCJzc62HA7Xc=;
        b=aY8yONrXMph/Bow0x1FLsc46KI/XXnXO/p/Wo4cdDASPlpGca5LaV8MNZ6ekOV2En3
         M/QQuHi+++rymGpANdEDSe7eAFQW8bRXEAW/n8BOu7AzEW09gMGKQD8WsOtddRMdF+RT
         UY2tpWbMtzSwKEbomEw5UpEYaOhuml1iKPWaJ/D49Sr/6VWLVB/tfRS9uFWPXDL6SYRa
         plvI1jLUp/agKF7tNUNPSSXxSRLLnMh4eSMnE7mE+gG6PMlzFotTv/7I9VvT3izXIhcS
         NhlW6hEOMrpjDWOCz2TE8sXBDR3Uo7aMBhIpH0RjpCCbj5YIfAJz2uKdNzbK4W2O9PI1
         7k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8yNlufzVA2jCQWSX0cYvr/qzprbw9+PqCJzc62HA7Xc=;
        b=YtSftFA86SZa+dLzz/XDWCsNsxsZadY/REsZnqWG1MY3+ZXYcFXZs4YTubMxk6lPge
         E0Q/QMtX40o/9xyxSotvEr5qcV9BycSMqBCNiD3Kbd0kLzIQHu/CkKhJ0vbzb4VPVzTd
         270eIZlwQ5wvKCj/czKNKJ0f/KcW5XfUGH/gT99ZP/QS05WedH6E3STAIiCEBaVJVuQ3
         VMBseWAoVFAU5mM8wYIXGsc175d5xYDWtDF630HXAqn2NPEfzVa0mPWt0uGfAJt8zBv2
         2KrWsUwpwDsQx/t6p2H7p4efIdakq/qg2lYgEdP9s5qEAj1jKcTL1luy7JeWK8JkTsIL
         jzdg==
X-Gm-Message-State: AOAM532DpYul7ufwOvWPXAJHLddXfNQNUyJxrPZA4e3ohm4wqjNcN6/E
        HiFrZjIltfbi9Tv8L1EnGy1qj8Gi3Q==
X-Google-Smtp-Source: ABdhPJz8jLA1vmq/v9GW+RbwGIPkXat09MPZdZaMbcQWE9RAX5Jxg2JKP2WkH2Paef0uS0HVCDwHFp2gNg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
 (user=elver job=sendgmr) by 2002:a17:906:40da:: with SMTP id
 a26mr14032298ejk.513.1618399736735; Wed, 14 Apr 2021 04:28:56 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:28:22 +0200
In-Reply-To: <20210414112825.3008667-1-elver@google.com>
Message-Id: <20210414112825.3008667-7-elver@google.com>
Mime-Version: 1.0
References: <20210414112825.3008667-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 6/9] kcsan: Remove reporting indirection
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
2.31.1.295.g9ea45b61b8-goog

