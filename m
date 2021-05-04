Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16709373086
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhEDTNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhEDTN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:13:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B00C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:12:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p64-20020a2529430000b02904f838e5bd13so151826ybp.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DPQoY+5BFGMPSoMOLLW+zrHnpLhcIS8wpMva4HHTy1Q=;
        b=DmMzNprx4BqDHLMu8jBGuQmT//Eu8g141YmQyTsvDtwk6nFFzYg5OXgfbEfG2s0agV
         N6LUzBZMgiYungbu2izdEpHDJ9zxekANw/+uVWYeao+5At9AkFgvyxlIJGX0j/rPFjF1
         iMLva4cQ68XAkNkqz6H7lxzKLQ4+/rubhsEBpVCjA88UtXfOOGEIgyAuL8PF1Ij6r2Cc
         YLpRYABfwULyKk9/XFMyrdOv6AMceith4AywxPtRg3AVXWlBW5T8/CXGPQtPc3mkFNtD
         eIEhLgXYFBOmt0vHNTzoCTAhOhFnkFMje2ItjxZLuXUElo10KpOQ4GrNgcJJQswjB8BZ
         j7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DPQoY+5BFGMPSoMOLLW+zrHnpLhcIS8wpMva4HHTy1Q=;
        b=c4sxGY/7Rc54znwUKxAr8aU8f9tdMs3pyYlGD3/kJfZ6d0tKTEElRpJl32Z/NZHTeJ
         J/qIkq8vayUndxirxFI5FPabDM+2ideXzNzXYEO9ZHsQBUfIhnuluEBXy7Dko3CcXcNC
         0a2d1c0Zlf2EjtlrbiHbtxD5XP4UvtdAmv6BYjYthWAZCVtt37NMZehfKwn/p3xkhrNL
         EdoqqHpOhiZPg2UQOQlscVh3ne7gWq0ssWnW+Q6/Mc1OoX7b3yfNEkMgHc+HGxv8z8NB
         t1F+gRNJEKi10vs27ytEzhdYMxOB3dD24x0h0PA5pJq12FrHbJTp4wzy2DaJIInefsLu
         aWUA==
X-Gm-Message-State: AOAM53123GMiq2nJEi0JdsHR0fACnVaM2OPrm2txtSVuXlWVBiYRhg8I
        uNUfImH8/tVRXGjmFSCxhxKlFA9X7iPu
X-Google-Smtp-Source: ABdhPJzYMNj5d0iA145d5Ox3Cz69OkPKW1/6qR9n7oxIpGfTwIyFVEQ98t5cbgS+AFcsWyUlfxxj374Nkt5J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6f05:c90a:7892:8680])
 (user=irogers job=sendgmr) by 2002:a25:b223:: with SMTP id
 i35mr34061518ybj.429.1620155551491; Tue, 04 May 2021 12:12:31 -0700 (PDT)
Date:   Tue,  4 May 2021 12:12:27 -0700
Message-Id: <20210504191227.793712-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] perf arm: Fix off-by-one directory paths.
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
fail in other situations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/auxtrace.c         |  8 +++----
 tools/perf/arch/arm/util/cs-etm.c           | 24 ++++++++++-----------
 tools/perf/arch/arm/util/perf_regs.c        |  2 +-
 tools/perf/arch/arm/util/pmu.c              |  2 +-
 tools/perf/arch/arm/util/unwind-libdw.c     |  6 +++---
 tools/perf/arch/arm/util/unwind-libunwind.c |  4 ++--
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index b187bddbd01a..7ed57222465e 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -8,10 +8,10 @@
 #include <linux/coresight-pmu.h>
 #include <linux/zalloc.h>
 
-#include "../../util/auxtrace.h"
-#include "../../util/debug.h"
-#include "../../util/evlist.h"
-#include "../../util/pmu.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/debug.h"
+#include "../../../util/evlist.h"
+#include "../../../util/pmu.h"
 #include "cs-etm.h"
 #include "arm-spe.h"
 
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d942f118d32c..67c7fb8d7eb0 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -16,19 +16,19 @@
 #include <linux/zalloc.h>
 
 #include "cs-etm.h"
-#include "../../util/debug.h"
-#include "../../util/record.h"
-#include "../../util/auxtrace.h"
-#include "../../util/cpumap.h"
-#include "../../util/event.h"
-#include "../../util/evlist.h"
-#include "../../util/evsel.h"
-#include "../../util/perf_api_probe.h"
-#include "../../util/evsel_config.h"
-#include "../../util/pmu.h"
-#include "../../util/cs-etm.h"
+#include "../../../util/debug.h"
+#include "../../../util/record.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/event.h"
+#include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
+#include "../../../util/perf_api_probe.h"
+#include "../../../util/evsel_config.h"
+#include "../../../util/pmu.h"
+#include "../../../util/cs-etm.h"
 #include <internal/lib.h> // page_size
-#include "../../util/session.h"
+#include "../../../util/session.h"
 
 #include <errno.h>
 #include <stdlib.h>
diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
index 2864e2e3776d..2833e101a7c6 100644
--- a/tools/perf/arch/arm/util/perf_regs.c
+++ b/tools/perf/arch/arm/util/perf_regs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../../util/perf_regs.h"
+#include "../../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index bbc297a7e2e3..b8b23b9dc598 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -10,7 +10,7 @@
 #include <linux/string.h>
 
 #include "arm-spe.h"
-#include "../../util/pmu.h"
+#include "../../../util/pmu.h"
 
 struct perf_event_attr
 *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/arch/arm/util/unwind-libdw.c
index 36ba4c69c3c5..b7692cb0c733 100644
--- a/tools/perf/arch/arm/util/unwind-libdw.c
+++ b/tools/perf/arch/arm/util/unwind-libdw.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
-#include "../../util/unwind-libdw.h"
-#include "../../util/perf_regs.h"
-#include "../../util/event.h"
+#include "../../../util/unwind-libdw.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/event.h"
 
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
diff --git a/tools/perf/arch/arm/util/unwind-libunwind.c b/tools/perf/arch/arm/util/unwind-libunwind.c
index 3a550225dfaf..438906bf0014 100644
--- a/tools/perf/arch/arm/util/unwind-libunwind.c
+++ b/tools/perf/arch/arm/util/unwind-libunwind.c
@@ -3,8 +3,8 @@
 #include <errno.h>
 #include <libunwind.h>
 #include "perf_regs.h"
-#include "../../util/unwind.h"
-#include "../../util/debug.h"
+#include "../../../util/unwind.h"
+#include "../../../util/debug.h"
 
 int libunwind__arch_reg_id(int regnum)
 {
-- 
2.31.1.607.g51e8a6a459-goog

