Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2003A243E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhFJGI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:08:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399D3C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 23:06:48 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id o14-20020a05620a0d4eb02903a5eee61155so18690931qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Lg7NuraxXh2lGd7qtwMfaQYNPCgBXTD5T5nmYD665wQ=;
        b=XQDwLZHgrwTj2N7cSculUYKf7ggeGIYs7rmgGFNgCu63nPGWMljiUz7paT3UduyVph
         X9JtaGiZtU3nhFNvY1GVXyin2R/z4CefzNxlhW4K+Q+jWv62xcHPnMh2dbjqejXR9url
         mcz4H36GEvfkpCQbPk+hxJUS6ubSwmmrW6eAgCct0BFnBqkEBf2LCrJbnEh420GnmYno
         4lfomSXGx1EouNHpYce2HRHonMh8WbiOClMcXqW7dpiXoU6L/X6oQ8OQ8DrrH5Xibf5x
         U+9IfykvcPwpaKU0AfYBqpanzhoMdYc7dOLOdd2XejjXk/c5M76ZleDcxDWfxJqTG+1O
         +QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Lg7NuraxXh2lGd7qtwMfaQYNPCgBXTD5T5nmYD665wQ=;
        b=VVbtAoJwifZkjuAV8JAZ/f90SO/BCND0HdLW3nYqPo20Ixxri7KvvnNabzo8MJWQto
         Q3ICMXTGrqg9XyfTimQatsCBg3G15qMxLcYdZd/+1DhkIW+184fLJrAG3Dx0o5oxRrXv
         M3eqqIqDfSHRc/xptBepKQPdDYZSPebZwqxzA3XvQVsQeGPCqK7j9ey93uSFxlwvZSPP
         9GD6JvF0fHJFJhuTyDMVRO5uAN/4UVx8Ah8lZIBOjivsi6qMnoS1cNMmHVaE01VRhaY0
         EZyrOYHxXq5oFTRIfNgu4SXF3ddBzXu/Sa/qa8wvia/kz9dU19oGj/E3qaPllXMDyy1l
         8yWQ==
X-Gm-Message-State: AOAM530XgmDa1TDlZDus/hD27MzYDONgIWcTCQRisAl91lccvBVeg9UD
        Txrcq0bf6C6+FjwpUlOVMKBrgFtIxwed
X-Google-Smtp-Source: ABdhPJzG/2358ozZYs12Ycqlx4w1jnfiR285NrgYiNH84RWzpWIUrE5BLAl8Upw+zzR7i5/BgZvTg7zCLSeq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7996:689a:4aa:98a7])
 (user=irogers job=sendgmr) by 2002:a0c:fe45:: with SMTP id
 u5mr3629854qvs.53.1623305207282; Wed, 09 Jun 2021 23:06:47 -0700 (PDT)
Date:   Wed,  9 Jun 2021 23:06:43 -0700
Message-Id: <20210610060643.595673-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH] libtraceevent: Increase libtraceevent logging when verbose
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
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
As this API isn't present in the deprecated tools version of
libtracevent I'm uploading this as an RFC.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 2c06abf6dcd2..700828e92fe1 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -24,6 +24,7 @@
 #include "util/parse-sublevel-options.h"
 
 #include <linux/ctype.h>
+#include <traceevent/event-parse.h>
 
 int verbose;
 int debug_peo_args;
@@ -228,6 +229,13 @@ int perf_debug_option(const char *str)
 	/* Allow only verbose value in range (0, 10), otherwise set 0. */
 	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
+	if (verbose == 1)
+		tep_set_loglevel(TEP_LOG_INFO);
+	else if (verbose == 2)
+		tep_set_loglevel(TEP_LOG_DEBUG);
+	else if (verbose >= 3)
+		tep_set_loglevel(TEP_LOG_ALL);
+
 	return 0;
 }
 
-- 
2.32.0.272.g935e593368-goog

