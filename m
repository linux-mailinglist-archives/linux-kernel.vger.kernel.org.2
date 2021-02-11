Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C031926F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhBKSkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBKSkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:40:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97319C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:39:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w11so6966132ybq.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=CS2iDjpZDTwxsyM6gA0CiISpb5Ai7JeBaJae0IrTLnY=;
        b=G9k6K6R49J8Eml+NkQVIUeeXvA7P82RZ6BDCPNMacjwtKzHvW3Nxa/THEj7SSCeqxg
         3UWL9AnkdRfb+oRDjNSLHuZyTVN9eoZieAuUq9UIf7Ks5VoljBP3s4WZxSeY45RpcitA
         gsLMLP7U6RDk0xHvEC0TzC4UAEBwdKWd0vB4+LUgPR8wf+SGHmNw+2mQZNL2/g7uCiOd
         yWN7n3bMgBOkU4O7UdxgmGaM0y30/8GfJ4Xz3+1g0NAxkZ0J6wWEfIZy5IIY51FN5EK1
         CzhtmaSRZDYEx3uZAPJe3TNfNWdJDmzgynnTSA43tvqV6nLOG+EIzNhm5JgmZVoX0BH7
         UqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=CS2iDjpZDTwxsyM6gA0CiISpb5Ai7JeBaJae0IrTLnY=;
        b=WXNgTfPBHlii+gX8LrjZNICCNWcnHBbi8NYp2xwhszwJV8gUQ7nOq9PMSZ9cvOd6Mk
         /NwHlHFLeFC58NQwRkMUz63ija6kbGy3ravxJ4qZkUfBZRLDDohJu3JtXQv155eXCZwZ
         XonFalMvW+eo4Q2lJVUooqRF27/V4DnSVQ1hC/n5rujYl2ez/XIUNgsDnw62SYKKQ+kZ
         unjWpNGORGiq/GQqFDK8QGnaKF2P6TaA+XT4oLJ9PHL2OQpm7Q8MNrxhWb7Zn8Js/KGg
         QKmljyp+3RSIqEQ1zwXKHe7L/0e3FXtkpnLcRlD2TJmgz4zyqNa775AuGOizQNpOloum
         /+zQ==
X-Gm-Message-State: AOAM531Y5XjwbGZJxzpx6H3FXouqe01LzZLb4s1cvNaqKU/37yLNA5LO
        2creZWBBbWN6b1eq26LlsgOkzBcZ9UP6
X-Google-Smtp-Source: ABdhPJx7RhAnMeahYJYSa/gQr3EjwjKerfYYQyDhgKB0KJ3jPOXAXXDvQHfFTo3XK5x9SODpFIfEcqdYXRmX
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:8029:cf99:f706:da41])
 (user=irogers job=sendgmr) by 2002:a5b:98a:: with SMTP id c10mr13807836ybq.406.1613068759826;
 Thu, 11 Feb 2021 10:39:19 -0800 (PST)
Date:   Thu, 11 Feb 2021 10:39:14 -0800
Message-Id: <20210211183914.4093187-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] perf env: Remove unneeded internal/cpumap inclusions
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/epoll-ctl.c               | 1 -
 tools/perf/bench/epoll-wait.c              | 1 -
 tools/perf/bench/futex-hash.c              | 1 -
 tools/perf/bench/futex-lock-pi.c           | 1 -
 tools/perf/bench/futex-requeue.c           | 1 -
 tools/perf/bench/futex-wake-parallel.c     | 1 -
 tools/perf/bench/futex-wake.c              | 1 -
 tools/perf/tests/openat-syscall-all-cpus.c | 1 -
 tools/perf/util/synthetic-events.c         | 1 -
 9 files changed, 9 deletions(-)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index ca2d591aad8a..ddaca75c3bc0 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -21,7 +21,6 @@
 #include <sys/resource.h>
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 75dca9773186..0a0ff1247c83 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -76,7 +76,6 @@
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
 #include <sys/types.h>
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 915bf3da7ce2..b65373ce5c4f 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <sys/time.h>
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index bb25d8beb3b8..89c6d160379c 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <errno.h>
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 #include "bench.h"
 #include "futex.h"
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 7a15c2e61022..5fa23295ee5f 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/time64.h>
 #include <errno.h>
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 #include "bench.h"
 #include "futex.h"
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index cd2b81a845ac..6e6f5247e1fe 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -29,7 +29,6 @@ int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe
 #include <linux/time64.h>
 #include <errno.h>
 #include "futex.h"
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
 #include <err.h>
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 2dfcef3e371e..6d217868f53c 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/time64.h>
 #include <errno.h>
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 #include "bench.h"
 #include "futex.h"
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 71f85e2cc127..f7dd6c463f04 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -15,7 +15,6 @@
 #include "tests.h"
 #include "thread_map.h"
 #include <perf/cpumap.h>
-#include <internal/cpumap.h>
 #include "debug.h"
 #include "stat.h"
 #include "util/counts.h"
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index c6f9db3faf83..0b767233ae1f 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -24,7 +24,6 @@
 #include <linux/perf_event.h>
 #include <asm/bug.h>
 #include <perf/evsel.h>
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 #include <internal/lib.h> // page_size
 #include <internal/threadmap.h>
-- 
2.30.0.478.g8a0d178c01-goog

