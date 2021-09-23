Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE55F416275
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbhIWPyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbhIWPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:54:13 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6DEC061760
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:42:59 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 62-20020aed2044000000b002a6aa209efaso16952668qta.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hDRJpwXs+0R0eoksKhPMDicSLgR3CIp6XLHTux6N7rg=;
        b=EAFBGXgLjGA9GukMEydU6QBSXUC65k0uD0qk8+iOEakYEJWC+Xp0J26Y6kRGuqymZ3
         JPLoSZ44AdJN9iXui33U4+HiS5yOBGR33BU+C6MEpkiSzoMveaECsMn3gkrO/TGeQHxB
         Rll4j71Ub2yP6h2iq9ahfjjegjHytvhvtIJiFb+9AhtoSvc+Io4c5HQq2h/myf6Fp03e
         +NfVBa0KyKbhbekQqZ7ACZWHxqr68NA2WT/VXC3RTTh14NdiBiz4Lmq1ffXim5ED1AIG
         +46lJTzwQmhJ4L/gpQ+n7IjJVA+fI6HdfVWLArHbvzLeFmVrxMKvsi81kQfECPeYAwmA
         6YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hDRJpwXs+0R0eoksKhPMDicSLgR3CIp6XLHTux6N7rg=;
        b=sqeySx0F8A6yPKY4cy7ImERdY67jJXgsDXHow6NUgHPnIYudQ9cMztpwdDVubfu9eE
         NIP9JEw+26rqAGfJVC/4BI6NLXjrqu+X985hO+1+qpHDuOchNZtzysiLqVmIiVe6MhRC
         QghIcYhBfOnYdY0UUQj6g8KG8XlcbvvzBtdm6cnVTg5okYGycRoxccH3OknxgVv3NCGD
         o3xmZbzoumcj1ziswhSfeDldJ14ItISXUFYflc7Tmo02ZRMkwS9t5nYUAOXZn4FvHjcr
         es5atSswE7ZGtjc+VxJffdLzdxWBzJ0/+KSJCgkyo45c0b69UIgZKjLiUaYd0P7APjmB
         tNnA==
X-Gm-Message-State: AOAM531B6XVWB3jnt4u1Ut5QadRG01tNXhjrMb/JUs0l5+6PYjK8BHRS
        aOUaYTZR7IqLZwk4utKaFIw5Xs9GXP5v
X-Google-Smtp-Source: ABdhPJw0BscPobtjGvad3odDFK0zIfd6nQgILBF4vYOqEFAiFNwx7uvRrJg5KG/GrMMbu3hdYUD+jqOwb9A5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a5b:791:: with SMTP id b17mr6743168ybq.263.1632411778504;
 Thu, 23 Sep 2021 08:42:58 -0700 (PDT)
Date:   Thu, 23 Sep 2021 08:42:54 -0700
Message-Id: <20210923154254.737657-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2] perf arm: Fix off-by-one directory paths.
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

v2. Rebase. Comments on v1 were that we should handle include paths
    differently and it is agreed that can be a sensible refactor but
    beyond the scope of this change.
https://lore.kernel.org/lkml/20210504191227.793712-1-irogers@google.com/

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
index c7c7ec0812d5..5fc6a2a3dbc5 100644
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
index 515aae470e23..293a23bf8be3 100644
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
2.33.0.464.g1972c5931b-goog

