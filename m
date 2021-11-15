Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2C4500C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhKOJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbhKOI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:59:59 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4B9C061204
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:56:58 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id h13-20020adfa4cd000000b001883fd029e8so3290431wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KoIGQMcPDNQgf+l0n0SpbMR7KXGkG+Y/GyFEGlGCO3o=;
        b=IBr/z4EKJFSM75I81wBnCyglSG/3Ya2Ix/jImMc1GYpTGxtZ0rn9JBx31N7o/0lQSI
         kFlAL8fbu+k6VJ/m1aiOpkk37CTXZnwTGnqaJ7A235Bqr+pxGbvXybR4dsmn1fL0pOw5
         6x0WNk+EJMlxLV7RDzhIlU8h1Zf9AbXFPZ4FiLgqDrbNvqplQtpV1qKlqjYodleg3TKX
         47yBWEIzoWlXx1+6sueNmUjLlwF/IjQ7uvi0mHHiNi73SRjQVRm5iOz5To6QvQJLZrVK
         TtwCuUE2yZd4U58ckl3Ted24bj509eBJMnXXiEaWdXW/6pLQnMhsnJLZm1hkIcWlj+kF
         cH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KoIGQMcPDNQgf+l0n0SpbMR7KXGkG+Y/GyFEGlGCO3o=;
        b=KXmOoyZbmDAOHrmNsKmuDSq4cv7DoBr0hIsTfVW/9X2+moEHJomLgO2WtxUPHW8PlG
         baWur/adWIrcASySilR0vh9lbfWQ5347LN2vMd0TPJuthdfrGSTJZhidxobn9dUTpy68
         BdFpS3Lh0dPAx7Fc2/EWxSOHArJom1WFU4lda2t93v1zA804rcK49/PP0mJ03JxEYaVw
         tOwk2qxDy4M2j8nFzs8gthSRhpoO5D+q1CC5mfDyExv8rZGCEcyii1Dgq4h3o+dNYOeZ
         GsF6es2QQSRiZL1+FJ30SF1DCTkY8nCRtLeEET/2Y7GeYr/gO7pmAoVeMdbGU0rCI40D
         GM1g==
X-Gm-Message-State: AOAM530PQufC0T2BIcYTYxx4QNFqjrjSkqTLrLlht7sfIsB690Yq89w3
        N1F1pUkCxY0MdTSRbY3ivIJlsEGyAQ==
X-Google-Smtp-Source: ABdhPJzOmtxmSllVxqGTlBcsrK01DnQbMGKLOj3GNZgFR/5oZDiExWI3o46tr/f226rHkH0OfgWbR1kYdA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6385:6bd0:4ede:d8c6])
 (user=elver job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr470410wms.1.1636966616454; Mon, 15 Nov 2021 00:56:56 -0800 (PST)
Date:   Mon, 15 Nov 2021 09:56:30 +0100
Message-Id: <20211115085630.1756817-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] panic: use error_report_end tracepoint on warnings
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Popov <alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the error detector "warning" to the error_report event and use
the error_report_end tracepoint at the end of a warning report.

This allows in-kernel tests but also userspace to more easily determine
if a warning occurred without polling kernel logs.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/trace/events/error_report.h | 8 +++++---
 kernel/panic.c                      | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/error_report.h b/include/trace/events/error_report.h
index 96f64bf218b2..ed0164f8e79c 100644
--- a/include/trace/events/error_report.h
+++ b/include/trace/events/error_report.h
@@ -17,14 +17,16 @@
 
 enum error_detector {
 	ERROR_DETECTOR_KFENCE,
-	ERROR_DETECTOR_KASAN
+	ERROR_DETECTOR_KASAN,
+	ERROR_DETECTOR_WARN
 };
 
 #endif /* __ERROR_REPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY */
 
-#define error_detector_list	\
+#define error_detector_list			\
 	EM(ERROR_DETECTOR_KFENCE, "kfence")	\
-	EMe(ERROR_DETECTOR_KASAN, "kasan")
+	EM(ERROR_DETECTOR_KASAN, "kasan")	\
+	EMe(ERROR_DETECTOR_WARN, "warning")
 /* Always end the list with an EMe. */
 
 #undef EM
diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..8e299cae1615 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/ratelimit.h>
 #include <linux/debugfs.h>
+#include <trace/events/error_report.h>
 #include <asm/sections.h>
 
 #define PANIC_TIMER_STEP 100
@@ -609,6 +610,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	print_irqtrace_events(current);
 
 	print_oops_end_marker();
+	trace_error_report_end(ERROR_DETECTOR_WARN, (unsigned long)caller);
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
-- 
2.34.0.rc1.387.gb447b232ab-goog

