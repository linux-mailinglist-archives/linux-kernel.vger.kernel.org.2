Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E966C413BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhIUUud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhIUUu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:50:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794A6C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:48:58 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h16-20020a05621402f000b0037cc26a5659so6280638qvu.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YRlcwai5LvG85hd6NJ2+esADNJKAvO1QJ6LOzStIvoc=;
        b=cx4RaPiuNKucS5+fY05v1LAUQYp712Amt429aLOtH8a8ka46KPAEKxfwsXrsL6yLW1
         m+WlfS1neH18WD5ARNcB41n/PG0idYcgGY6G69i1KXY30wVDHCIFAXMmIvsSkPs8bpAc
         CiIYizrE/d4PhAc6ucG7SIHrWLJMhQHCED2E787XVwR28fHMLp1zFtSNzm6HmdvOFyrn
         ZKUqynWRefx2fM+ICY+L52VT8kiqkuRp5iY9jjdvly4xxZ2Q3nFgGufOHjwM3Qo3OGN2
         xhW9N+0HcXXmglPNPqfd0C7uf16O+m6qf0FxOw8MXch1B0Zr2JXRCEdcPVXzT25mhbVF
         KUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YRlcwai5LvG85hd6NJ2+esADNJKAvO1QJ6LOzStIvoc=;
        b=bgTrc/NnkIXVu53Pd4qtwrfkoUfbssSimhwAoH4IQ7nCHI4IX01ur9Ay4NQzug5rjA
         UIW5dh3Zx3qxv75SalHjByhCrN84Ig3Kva9iOE4BuTOV9KjKXd9Ay0so6Y5Y7P22T0f7
         hRUV5QB0thdVRejs/uV9/0UD5sNFURtib4Tws+G36cW7MOrLpbk8H8QmXC27ICSso0gQ
         oL5CKunbvNZCThNN5nawBRQhM6S78n1hIwdf0rqZ4qN8y3ytItIJkl0YP3fzHMfOOcaw
         axZqAZ7JWI3qe3dD3XolrvHpzBBUnqw8a1VAJFolExJ1fTkn/vpahY4tThW9RsqdeCR4
         JM8w==
X-Gm-Message-State: AOAM532LoZYIP5SSwdnouQYCetn2GxDccz//XJmEGNgsyNfuwpKJcsdv
        93cFwQomQQcdqt69XYe8r2LREfAF+ZAu
X-Google-Smtp-Source: ABdhPJy7pzI+58A/rFxsyE7qXX7Ruf8kuENwAlDeUpw1b6W37wfBiWGzDyGN2PwEYrHoXS953LTY0nQ6B+Z6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dffa:819a:f0e2:47e])
 (user=irogers job=sendgmr) by 2002:a0c:ef04:: with SMTP id
 t4mr2006399qvr.61.1632257337601; Tue, 21 Sep 2021 13:48:57 -0700 (PDT)
Date:   Tue, 21 Sep 2021 13:48:39 -0700
In-Reply-To: <20210921204839.236840-1-irogers@google.com>
Message-Id: <20210921204839.236840-4-irogers@google.com>
Mime-Version: 1.0
References: <20210921204839.236840-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 4/4] libtraceevent: Increase libtraceevent logging when verbose
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

