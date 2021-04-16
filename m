Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44385362A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbhDPVlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhDPVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:41:46 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DEBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:41:19 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o21-20020a05622a0095b02901b1324f9fceso6873885qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=16osPIg+L8iFbBbX26b2dgHdAr7cmIuZsXJwe7Kia+g=;
        b=WBimkN8DWryRmhzJxGj1LBDcTnpBNhzCOkYkTKVLyqlkm06LeBDi9CTPbJQaymbLQW
         x0WhodsEAesUcItNZLnebP3kZTdSgbYT5GnlA0eW13axE1nRFhHd9Jikc0elBVarnlwb
         NGwNfokyMKx9F2MF+7wJW4jajRQSHxPZb89Y9mQ7qitPR6HXmWz4z4zMSNQ6sdGJm7c/
         5HGku1xtgjuJ3t8aq7jiap5qkqebKSXBUWeALG2NP/MDnjk4YWPp49DLenryzGnHb/Wp
         BWb74qHaC+GgK5BPdQ3o/WFOlA2RfDOAw+Eo10BPaMcC3LPX735X1lsmLwYNxG5O6OZb
         WZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=16osPIg+L8iFbBbX26b2dgHdAr7cmIuZsXJwe7Kia+g=;
        b=LoU+cXwkvNBW9voPuz8d8Rd0QDD4iiYAINPx6ruJeu7IUzLCnVwUHL8vqpA3AROBVV
         7OKLlxwFCrG9opYFLoeTXNfkymZ5fLyxWjpbN2/+5eGytFIwhhg76g+XRe09gSLPO3EC
         hmN+ynh8WJ0g6bYgH7VcwJiUj1FPNoLYHZ4zIkVTsv3AT8+nHfhBoFPIRatJQTzHccRQ
         rd4fG3gaWAG+w3SAf2UtebGTNzvXrYJoktt/al7Oo7mApqLHYivhGzQKPIw10DCqBAao
         wGOJ7QyVeS9VwbgPc2oxaCcjKEF+AJnaGtHjHCt/EaICgMCbR2MdhzMWjLtUwlLL6AcP
         ZBqA==
X-Gm-Message-State: AOAM530rZ7bF+b0D/0RwTYH2AfktJLpdQRemP+mymMuohhQUAF+Qz4V1
        nOXLojjo+wLMM0Vid+WpdbYCWHNo6JQX
X-Google-Smtp-Source: ABdhPJz8bALJqumEOr6IoT4IIs3oknvaJ4pQgL0djIhAFUOFYs2/o6mvcAiW2S7wcGYrwl9OaBu8hN2ikEZO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:42bc:2b31:3f37:1a26])
 (user=irogers job=sendgmr) by 2002:a0c:f64d:: with SMTP id
 s13mr10266118qvm.13.1618609278854; Fri, 16 Apr 2021 14:41:18 -0700 (PDT)
Date:   Fri, 16 Apr 2021 14:41:13 -0700
Message-Id: <20210416214113.552252-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH] perf arm64: Fix off-by-one directory paths.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relative path include works in the regular build due to -I paths but may
break in other situations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/kvm-stat.c         | 4 ++--
 tools/perf/arch/arm64/util/pmu.c              | 4 ++--
 tools/perf/arch/arm64/util/unwind-libunwind.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
index 50376b9062c1..2303256b7d05 100644
--- a/tools/perf/arch/arm64/util/kvm-stat.c
+++ b/tools/perf/arch/arm64/util/kvm-stat.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <memory.h>
-#include "../../util/evsel.h"
-#include "../../util/kvm-stat.h"
+#include "../../../util/evsel.h"
+#include "../../../util/kvm-stat.h"
 #include "arm64_exception_types.h"
 #include "debug.h"
 
diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index d3259d61ca75..2234fbd0a912 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "../../util/cpumap.h"
-#include "../../util/pmu.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/pmu.h"
 
 struct pmu_events_map *pmu_events_map__find(void)
 {
diff --git a/tools/perf/arch/arm64/util/unwind-libunwind.c b/tools/perf/arch/arm64/util/unwind-libunwind.c
index 1495a9523a23..5aecf88e3de6 100644
--- a/tools/perf/arch/arm64/util/unwind-libunwind.c
+++ b/tools/perf/arch/arm64/util/unwind-libunwind.c
@@ -4,9 +4,9 @@
 #ifndef REMOTE_UNWIND_LIBUNWIND
 #include <libunwind.h>
 #include "perf_regs.h"
-#include "../../util/unwind.h"
+#include "../../../util/unwind.h"
 #endif
-#include "../../util/debug.h"
+#include "../../../util/debug.h"
 
 int LIBUNWIND__ARCH_REG_ID(int regnum)
 {
-- 
2.31.1.368.gbe11c130af-goog

