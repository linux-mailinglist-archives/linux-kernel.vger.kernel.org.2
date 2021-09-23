Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AFC415470
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 02:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhIWAMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 20:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbhIWAMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:12:10 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E409DC061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:10:39 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id bj32-20020a05620a192000b00433162e24d3so14567892qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YRlcwai5LvG85hd6NJ2+esADNJKAvO1QJ6LOzStIvoc=;
        b=p252v6Wfpx8DGvA+HzHHCPRF+lJWWWCmAe1/SZMy6BXvM1IyvVvqGdtufi1WHFibmo
         WqaxM9Og4Do+U5Vw8hiDpFc9CapNZJgkJrJvrAM6vsXxiDRM/7Hn6XtdvLEPuxY9cnaA
         xbSjJ0fKtcFH76RCl1iU7SoisYq24wfzicjqEg7Dx1ormNIXgGy7bjX1in8wNSmIlyNv
         Mz/ypvRleSOiOaPo2pMA3/DojrbK7YUoD1oV/j92cHxR4Si+Jhhg+cRXftOiv7YuV1Zh
         AREFbGTzRoG6cBLCQmv6zr5jQnk6fY5nqnf2thY0vAP7ICv+Cbw1v70719X4L5CrWPt4
         0dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YRlcwai5LvG85hd6NJ2+esADNJKAvO1QJ6LOzStIvoc=;
        b=R3gObItWLNawUUz7X6Ci26AynH1tE4Ot7gxGdv0Rtc7Z8XfBsg6MGl+Twoc5iwRdtI
         VQ8eUOwtJQM44r4nC38zqhFtkNChjtwoQ9blrvunbECVIjJnxLSWltTOa8G0k0iQPjDd
         etCVEY7W400gyQYzo0KfNmCz+7g768RhOEKYNJFXYDmpSQqSjzbj3L4bO1t/nPCA+sP3
         g6L4fo6v8zL47jR2KWBdIqp44RmOuucdIbRFtJNUq/+8iIqg+jKDCeP9xnF8UFVIeAPY
         grEiisXhv0xiep1oHJKIfjJ8kXN2Y2QYQeQ2m21qB2oqrkQpPfEjmQ2NU+UZKS8Enkd2
         Lmmg==
X-Gm-Message-State: AOAM531b1an7DBo90KNe7HtGw1CeV7mBeXWg2eeWth+ZcE6BG3oRYHUt
        3oq9q+5LwuJQsnZ3o8L6x53catwk3amU
X-Google-Smtp-Source: ABdhPJzb1ZGvPQkb6oTpQF8xtPVzUnFzvsxJMqG6jaDXT7A0xrZH7l9cDotjiUgPDMC4euU8V1MJJf2g8Wn5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:adc6:: with SMTP id
 d6mr2226777ybe.463.1632355839083; Wed, 22 Sep 2021 17:10:39 -0700 (PDT)
Date:   Wed, 22 Sep 2021 17:10:24 -0700
In-Reply-To: <20210923001024.550263-1-irogers@google.com>
Message-Id: <20210923001024.550263-4-irogers@google.com>
Mime-Version: 1.0
References: <20210923001024.550263-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 4/4] libtraceevent: Increase libtraceevent logging when verbose
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libtraceevent has added more levels of debug printout and with changes
like:
https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com
previously generated output like "registering plugin" is no longer
displayed. This change makes it so that if perf's verbose debug output
is enabled then the debug and info libtraceevent messages can be
displayed.
The code is conditionally enabled based on the libtraceevent version as
discussed in the RFC:
https://lore.kernel.org/lkml/20210610060643.595673-1-irogers@google.com/

v2. Is a rebase and handles the case of building without
    LIBTRACEEVENT_DYNAMIC.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 2c06abf6dcd2..c7a9fa0ffae9 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -24,6 +24,16 @@
 #include "util/parse-sublevel-options.h"
 
 #include <linux/ctype.h>
+#include <traceevent/event-parse.h>
+
+#define MAKE_LIBTRACEEVENT_VERSION(a, b, c) ((a)*255*255+(b)*255+(c))
+#ifndef LIBTRACEEVENT_VERSION
+/*
+ * If LIBTRACEEVENT_VERSION wasn't computed then set to version 1.1.0 that ships
+ * with the Linux kernel tools.
+ */
+#define LIBTRACEEVENT_VERSION MAKE_LIBTRACEEVENT_VERSION(1, 1, 0)
+#endif
 
 int verbose;
 int debug_peo_args;
@@ -228,6 +238,15 @@ int perf_debug_option(const char *str)
 	/* Allow only verbose value in range (0, 10), otherwise set 0. */
 	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
+#if MAKE_LIBTRACEEVENT_VERSION(1, 3, 0) <= LIBTRACEEVENT_VERSION
+	if (verbose == 1)
+		tep_set_loglevel(TEP_LOG_INFO);
+	else if (verbose == 2)
+		tep_set_loglevel(TEP_LOG_DEBUG);
+	else if (verbose >= 3)
+		tep_set_loglevel(TEP_LOG_ALL);
+#endif
+
 	return 0;
 }
 
-- 
2.33.0.464.g1972c5931b-goog

