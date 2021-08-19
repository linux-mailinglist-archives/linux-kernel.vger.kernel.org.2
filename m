Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED713F12FB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhHSF5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhHSF5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:57:11 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF2DC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:56:35 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g73-20020a379d4c000000b003d3ed03ca28so3421509qke.23
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AOAqyGjtKgVDD2kT9RfbIkxegX7sUZc8Qt8tnITpTiw=;
        b=DgQ/cGC0BcJDkSz56kRwwaDeMLethVWve5kg6VtQ+j73sWwYsHzrSv9y6q+LM+ea4j
         pTfTAA33uKBEWAuyFNvU1xUY20LXWLkLqGiVPey/kXce6BEz2H9xZjp58/NZVFDRdsr9
         /M0jMJd1c0+3hFqRbfvhvrmz2uycEVpVPTGF8Z1nAl2xru2bAuOi43oKCrNjtxS8HmKp
         VHClwszOV+x/B5QQC7Akz+NHktJO4dFPP6ihf/q0OF3i0B5OJNBlH3kdygM5IkfKjmzg
         DEvZXACLFEn3Aqi7mPz7e6Fvwej/19YjC4irQrEjBqB4osIxb9jdQJgtWapMfidrc17M
         IH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AOAqyGjtKgVDD2kT9RfbIkxegX7sUZc8Qt8tnITpTiw=;
        b=QLJayzYqXeQNa7ypFF9cy2YcQqq/FtWohmWwwtdyMsm86aCgONOusDRueFNUvmapgt
         G8Cjeh5AxA4thmXs9qKJDTOOOZEM7m2jQ1sUea1NzNSm/5/TsEEtc78z+1E2kv/ABRI6
         AEA6x2H+D3TZeMQfHUk2zKiQc9iKkkDUlF2HN0Wx44hSGwzjs/4x+LXkZRP7XDSZRTNr
         vtibGUJVe6kkg0M6iQ+Rkp7AknfhkCaQ5GULHq3iDYiDypEGNjTbeiyDOIBwezuxkWEG
         pJumzIw414sEHhiC+6lVl63Ks2oNSzWFhcp4Sz9xho4qjyjSG43D+dU8/8LTNxlS7rpa
         ovbg==
X-Gm-Message-State: AOAM532ERQI9WvSGiytpda6ocZZe2a3+FFyoUuXjfV2ymeKh+RVrEwWr
        VvwXdk/RZTWQJfa5dt9VT3DynAJYFToi
X-Google-Smtp-Source: ABdhPJzIXCVD1x6oOJCDo4RakHghMtcPldsS2Bym7MS1Jwl6BbGVGKzNyCD/VGhBRDkfckGRcnJELwu6ohG9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:303a:65e9:2a16:99b2])
 (user=irogers job=sendgmr) by 2002:a05:6214:1768:: with SMTP id
 et8mr3845134qvb.6.1629352594807; Wed, 18 Aug 2021 22:56:34 -0700 (PDT)
Date:   Wed, 18 Aug 2021 22:56:29 -0700
Message-Id: <20210819055629.1059168-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [RFC PATCH] perf test: Workload test of metric and metricgroups
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test every metric and metricgroup with perf bench as a workload.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
 tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
 create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
new file mode 100755
index 000000000000..f0b7bda17970
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
+  perf stat -M "$m" perf bench internals synthesize
+done
+
+exit 0
diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
new file mode 100755
index 000000000000..767396e81121
--- /dev/null
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# perf all metrics test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+for m in `perf list --raw-dump metrics`; do
+  echo "Testing $m"
+  result=$(perf stat -M "$m" perf bench internals synthesize)
+  if [[ "$result" =~ "$m" ]]; then
+    echo "Metric not printed: $m"
+    exit 1
+  fi
+done
+
+exit 0
-- 
2.33.0.rc1.237.g0d66db33f3-goog

