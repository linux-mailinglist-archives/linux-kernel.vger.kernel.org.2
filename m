Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC35835F28E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350646AbhDNL3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350575AbhDNL3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:29:16 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED28C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:53 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id z135-20020a1c7e8d0000b02901297f50f20dso1518255wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aFuAorZMO5YBHQhcmgbMO4HXRRT5kxuCC9J8md9w088=;
        b=bDu2hzRGhao5cINYO+08qKJth2vpZ1Kg9n5Ux+LVcGVuMLN+TvwQUrRMBblusZrOHk
         WUNwn2NCelW4xKnlaRD0B5YQJEywXhmxmly2Hfzg8oJw/FqMWuIRy8j31xjK6WnzVC8s
         sndY6Dx/CVFnVqw4wkwi92wCA1lLDzs9Fpo22tzKUOUEYuGKKdjzVderSISsy4alMyBC
         BeXY6d//EaSw7ATobHmXngDBdHiDtH3aWgP82NFq6+r7vQlJeDuQNVAcC2pP8qjGhgZ8
         d1eiTKPuJUsocwUdCl05dGPEZ99m7mCzW6sh+XOrbCcJS8GiaTRPTIJH3WCibjNN6pli
         69Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aFuAorZMO5YBHQhcmgbMO4HXRRT5kxuCC9J8md9w088=;
        b=UaUaMqqrv2l8LWfHwLAKjvdl6rcvh2fWIZx51wUDvExQGmR949KzuerV6TXaP84tlr
         h9JUYroNWNMudrz8rX8rzNDUsQxBSv1csJLjQ9zSVazRVo13dnVFjsl6HZbZQEz6frCK
         L6SeAo0MgJ3kF/A0/Jii1drqbRkZah9czTZCu1kOnM6tNYjFhOKip5V8IkU4QAQVhCDU
         FNcH2w6Gs2+QmOU9+QDxf3hOJ9+9JpBzoZ3xqpNd/U4BZPaBf34Es2lyz0L44w293sgL
         qomPo12bY4z2TVh8JH4a4Z7vHUR+erns4hUHTvba5P4g0Zl3NtfsE2TFApz3K6gbHoYh
         iQnw==
X-Gm-Message-State: AOAM530msUv/IBxx+vThcizEYb0viqfnL8lYsSNswYpx1JkmHa7dzwvO
        f8e0WUNNeTNpRWMSGvVER+9YXA2DAQ==
X-Google-Smtp-Source: ABdhPJzQ04CbEiO2DUOdtuuiqvKSM26OhmgIoXI2scEnjzt7fLG+C1ErkDJ6DI/DLisbfciMAkgybBDpOA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
 (user=elver job=sendgmr) by 2002:a7b:c5c8:: with SMTP id n8mr2537018wmk.63.1618399732254;
 Wed, 14 Apr 2021 04:28:52 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:28:20 +0200
In-Reply-To: <20210414112825.3008667-1-elver@google.com>
Message-Id: <20210414112825.3008667-5-elver@google.com>
Mime-Version: 1.0
References: <20210414112825.3008667-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 4/9] kcsan: Fold panic() call into print_report()
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

So that we can add more callers of print_report(), lets fold the panic()
call into print_report() so the caller doesn't have to handle this
explicitly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
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
2.31.1.295.g9ea45b61b8-goog

