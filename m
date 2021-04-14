Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0371C35F28F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350565AbhDNLaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbhDNL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:29:19 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8967CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:55 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id b20-20020a7bc2540000b029010f7732a35fso1516238wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mZuUlNh2PCUT9rxT70cSWAPcOboXAIvYNdGGwPvCpXY=;
        b=Svuo2zs9syaVjx2Jc3XHap+ACppiZC16djk78VgRkTorbGAU9WmnB/CAoHhlnNfE1b
         UY+kOhDDembXBG7zPF62ANKPDUUT/fi8DaCT9Qk0xov1RUuyr4+pwYwEBXTTJKgtSHHQ
         IpxJtOsubISTB+1QY6AQ6gYIPWa6Tw3uE2h3dCB1bTAUmkMjGzQPONmwAwzUZXDZAZgL
         hlKv/Aej7wFgh99YWNwjTg2MXav4Hhjs+upMZa3ZD+d5QdxCqhw7wsPyaLnHwZSAG6aZ
         HolHyv3CyGEs7pOI/8WQiMJxRepBoxCGY0fmiOLlw88iv1tuxK5I/SExXylgk+ocxBtC
         vv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mZuUlNh2PCUT9rxT70cSWAPcOboXAIvYNdGGwPvCpXY=;
        b=KAPqhw0mhTmJzdbdk7n6xztK74xArmgER35ix3MZol6cMqFa6Sbpr6JxdJ3inSROcn
         oPRuD1+4k+upvfMHbjMVF4R1f+JdO85vEOOy/PtjiVwApZGuwg6SbFe7KfUWdyHfI6RK
         3j6QWDI4vYF9lr+eUX4kMOx8QTYIHC3xubUqIpb4j0SvP34nZLDI02utODP8r5SW5GGI
         eURFKSPeYN0TSHrNqoSUQiYvPoNWxiUoPOV1duV0NbMxIJB0iGEcK1hFnKSH5R0FD4si
         bEivH2Gl54ZbI/80H4MXrgNcFM5P1c8QXv1nLxWXWPs+lKU5mX+KH+x2/Gg9A+XGovSl
         qqRw==
X-Gm-Message-State: AOAM531SBuFXo6RD2k0dIqew5ZmAIinD2ZC/5v7yTMwnq8n1xdmrpeLx
        ZciFLb9VtbPfk//FCR2sFiZ3DXll5A==
X-Google-Smtp-Source: ABdhPJziZajEWdKXUztVPS6gAZd2lHUy+KOSsedyp5d6k8OyW5CnuDZMrFvNqwgd3x63HPziLAuVVMJfBw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
 (user=elver job=sendgmr) by 2002:a5d:63c7:: with SMTP id c7mr4575938wrw.238.1618399734275;
 Wed, 14 Apr 2021 04:28:54 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:28:21 +0200
In-Reply-To: <20210414112825.3008667-1-elver@google.com>
Message-Id: <20210414112825.3008667-6-elver@google.com>
Mime-Version: 1.0
References: <20210414112825.3008667-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 5/9] kcsan: Refactor access_info initialization
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

In subsequent patches we'll want to split kcsan_report() into distinct
handlers for each report type. The largest bit of common work is
initializing the `access_info`, so let's factor this out into a helper,
and have the kcsan_report_*() functions pass the `aaccess_info` as a
parameter to kcsan_report().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
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
2.31.1.295.g9ea45b61b8-goog

