Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2924C40D307
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhIPGGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhIPGGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:06:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5486C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:05:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 63-20020a250d42000000b0059dc43162c9so11075552ybn.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=D0r7TBMbEZnc2Tmp30aYQUE/VFgDrqrZPzYpb/fCP9U=;
        b=Jt6MQlFhyIvw2VNWhD8wr04h95Ttto+QvH0023lhvq/waQF7PhGlzEKlb/Ni0DzroC
         Q3IDXtN/LWMYLuhf7nu3BtFAyi/EKZzD7mXFtD8CgCVLz5kOiq/EvBQYYb5MAy0gMOxg
         jsshIRdhhE41Uz5g4i3Oq805XRY1W9vUMUJVLCn5SaMdSdYO8ILVvn8WpZTog3fxlplq
         +6FfLMK012Jpb8BuKgM/HYPTUTU34bJ607tph5E3fsSYGHJ10sfuJT7nfB0jBkivcyOl
         MVU7LV3b3BQmLMRmYUaIMHuJHxhWzjgAa8o7jc3jY/BOBhRyS36k8nnKqvfzeiVKtpA5
         RBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=D0r7TBMbEZnc2Tmp30aYQUE/VFgDrqrZPzYpb/fCP9U=;
        b=tK5deCqOchaBLDGTbmANdPeNMDjs1FGGWl12haFUkLKeWEm8WrpqD6GAORkd+HNlTE
         8/YTfTO3lixHC5AQbGQUzy0T4yUNY/GnkbqiHYRRuhPO7Mw1QPvEr3GUcEcOWo76SnXT
         vQ/NxnwUm9rtNepXXsGVYgTLVabRu+HLt7hG8yuHEH1Vi7bxJy/U1SDh1Sb+X123QaEa
         qQ8vaqkwHoCyzX9r+hd8hUPV5nmzhGpSHtPN87ie9/wXNeizpPdu/4+ka6kxERmX8rVU
         5NDN8SFm9ADbgLtgxMTXEXRpAxeGlFinV0lg1s9AUalJhCi1v6GZD29v3QqgapkC30GM
         /5XQ==
X-Gm-Message-State: AOAM532RBAmsEdaJmDBEQIP1Q5JxjW6+pLgZ4+jz1XWNRs3VXaTfI3pk
        HifGLWMpFraopO0sO+LR1SxcTtKQ/VGi
X-Google-Smtp-Source: ABdhPJx5FbJpBunw6Fx0AcOekAy/kFV87vGAH5kU3v7Yt5ESkUQLPihxEJSoyk0TUWgEcCgAoWj7Pr3U/1p7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7b71:ab93:de5f:617b])
 (user=irogers job=sendgmr) by 2002:a5b:f03:: with SMTP id x3mr5069739ybr.546.1631772331782;
 Wed, 15 Sep 2021 23:05:31 -0700 (PDT)
Date:   Wed, 15 Sep 2021 23:05:25 -0700
Message-Id: <20210916060525.1890638-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2] perf test: Workload test of metric and metricgroups
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

Test every metric and metricgroup with 'true' as a workload.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
 tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)
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
index 000000000000..81b19ba27e68
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
+  result=$(perf stat -M "$m" true)
+  if [[ "$result" =~ "$m" ]]; then
+    echo "Metric not printed: $m"
+    exit 1
+  fi
+done
+
+exit 0
-- 
2.33.0.309.g3052b89438-goog

