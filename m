Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A2A40FF8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242488AbhIQSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhIQSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:44:12 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:42:50 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 81-20020a370954000000b00430e5d191b7so67063149qkj.22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=y0sa4e4lbQGIc32UF0ZQ0jyLYMg0ma5kgGxjvCLIZ0w=;
        b=IFYJlUlhIPcI1hQb+REipCAWLVdyXl0WZ98CK8ZXSEZ60ImDvlWlCCT8HZ3Ho5h75S
         CuLbyKQplXUkIK2rj61z2LwUeiSt75X75bSPY6A+Y41zce6kz8Kt0OGqElJG9uX8ubYF
         a1yotOo2FaFWrd2nhfHC1KfTqD1+j46V2/3WEN+FIZRPj/dEJLS+rIEk3nYGsW+t+0Bw
         hxGXG7e4a2k9MuOJkfKXSh0IUBNIbebLHgCljFcUb5qCzonZe4EcOsWeB8jrkOqUHe/I
         NTh8t/sbSmB2+eISUmLKsiVFLvKsXQEkkcioAX7ivzV+rVHq3AkVrrl1C5Ejf1zkQbue
         mVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=y0sa4e4lbQGIc32UF0ZQ0jyLYMg0ma5kgGxjvCLIZ0w=;
        b=QaLmuCc41aXW4kCvDEjKYMjnIO67GgDiiBTPbdEu22PUTGqGSrg71ygEKvNoa0ZtOH
         O9qyT5Da+3hDDCucF7bHF/2PpYTEZ8/0/9/paPDVsjFLB2OE2OO2WimiEBZYbq5UgLPl
         uWgDvyvjngvKtScT/8SdiisH6ppPNU5fNwbvicMFIL+0lo5UGoYIMlKXKnVy8W7QbCgC
         CmrCqrXG/8NUEzuxzLWeJzEZniZVwqasrOAfTNzCsHPk+aN++HhhMcFUS31fy+j9oJQp
         FDu4WAUOQUIWDJhF6cmosfYf29hngDsIq20OjQSereQZ6dYEbFRWoWVShukxYRtrVejt
         0PKQ==
X-Gm-Message-State: AOAM533NRoZPRx6epEdrFYCu4PJDMAiNeVW3CbEJG/WniWExEptrNiJK
        qh7WgEqBFW3594lNzWtAw29cCZYsqMbC
X-Google-Smtp-Source: ABdhPJzHbmiBJdDc6C9qsiti3TK5gWC0T5RcTS09qatJztA4ABtTuvDlheJobW0rQ0qw/povhR2Jql2bn75T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6399:5df3:21d3:3cca])
 (user=irogers job=sendgmr) by 2002:a05:6214:13ee:: with SMTP id
 ch14mr12944480qvb.43.1631904169179; Fri, 17 Sep 2021 11:42:49 -0700 (PDT)
Date:   Fri, 17 Sep 2021 11:42:39 -0700
Message-Id: <20210917184240.2181186-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 1/2] perf test: Workload test of metric and metricgroups
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test every metric and metricgroup with 'true' as a workload. For
metrics, check that we see the metric printed or get unsupported. If the
'true' workload executes too quickly retry with 'perf bench internals
synthesize'.

v3. Fix test condition (thanks to Paul A. Clarke <pc@us.ibm.com>). Add a
    fallback case of a larger workload so that we don't ignore "<not
    counted>".
v2. Switched the workload to something faster.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++
 tools/perf/tests/shell/stat_all_metrics.sh    | 22 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
 create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
new file mode 100755
index 000000000000..de24d374ce24
--- /dev/null
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# perf all metricgroups test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+for m in $(perf list --raw-dump metricgroups); do
+  echo "Testing $m"
+  perf stat -M "$m" true
+done
+
+exit 0
diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
new file mode 100755
index 000000000000..7f4ba3cad632
--- /dev/null
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# perf all metrics test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+for m in $(perf list --raw-dump metrics); do
+  echo "Testing $m"
+  result=$(perf stat -M "$m" true 2>&1)
+  if [[ ! "$result" =~ "$m" ]] && [[ ! "$result" =~ "<not supported>" ]]; then
+    # We failed to see the metric and the events are support. Possibly the
+    # workload was too small so retry with something longer.
+    result=$(perf stat -M "$m" perf bench internals synthesize 2>&1)
+    if [[ ! "$result" =~ "$m" ]]; then
+      echo "Metric '$m' not printed in:"
+      echo "$result"
+      exit 1
+    fi
+  fi
+done
+
+exit 0
-- 
2.33.0.464.g1972c5931b-goog

