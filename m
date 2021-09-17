Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEFF40FF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbhIQSoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242570AbhIQSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:44:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067D2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:42:52 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q13-20020a05620a038d00b003d38f784161so72957299qkm.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bqy07kGPYsMNzuUJlHwETp2BeTurO4WRlTy8/LiV/t8=;
        b=PmKIa83DXF84pPDOz+CuFVXCccbMvtCLj9QFBQsQrXjPe+MD+LvS7ZEFUyyY4DNNdr
         l41ub3BZ0Glym2OAGaG/aLIDpsldH257YNGpSVSMVCopjcpPwOu6of5xWHUCtrMPqCfX
         1PDIukg/dnsMYLdHunN2t4KuuvdthY6E+/qBaR6xbL8nNq1tRKyWSMxFbxOBY92XqFGZ
         qHhRu1Q7dnrCbuE6MDlYK3pALMVBDhdUhTZIxOZntCkV+B78fGXnjic8zZ/Y6rYwnZHw
         o9JAWX2Lgq7KgVQ+Hr1hbYVxUovS9OBFj4D2YDkmU5yy0yMF8dCjfmO4M+ROgTxZUn9r
         GToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bqy07kGPYsMNzuUJlHwETp2BeTurO4WRlTy8/LiV/t8=;
        b=rZvpEjnYwG2q8nSy9Rh32JV6cZH8izuPvlZD0Q9uEdhsOxAILoWif+JJuR7qvyh5nC
         ZWYBa8+jMJljQTu5AaRRjP8H+4XE5JPoZnaL2hVxVFtwYJQgWlaOR5trmMKOkAN9rDq6
         dByrQBiulNWX0GzRQc1dirB9fpuPRsowMZ1y5PqfF0QuOmHpOxDvy+Hq0urKN33JR/sL
         lXd06cG+6DmK54C2jT9zfpC4UJQSs7LYzxEqDaMZSbPzojJeSFq0kKwNB5v+rzyO+zew
         uytN4bEaDIKKUqPjkyYeLTwUMF1j2zIVtRVLXWSASouT2hl1UxeFYxDfQUh0pfHV/bxH
         XSZg==
X-Gm-Message-State: AOAM530BL9WXhLlCNy7hK5yZbZBtJrgvpe/edPR7ZSZjLJ658mfHE1de
        8rhsDAdgBw77SX3eMCQ0D+RVV1TNcSdw
X-Google-Smtp-Source: ABdhPJwHAeMyV5LsQZJk4Z1S6Wi1WazWzStq76iL0O0rylNgF5FqqeuFWEgBc1UxUdwGMSBMvw/YaOY1498T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6399:5df3:21d3:3cca])
 (user=irogers job=sendgmr) by 2002:ad4:4947:: with SMTP id
 o7mr2610965qvy.6.1631904171208; Fri, 17 Sep 2021 11:42:51 -0700 (PDT)
Date:   Fri, 17 Sep 2021 11:42:40 -0700
In-Reply-To: <20210917184240.2181186-1-irogers@google.com>
Message-Id: <20210917184240.2181186-2-irogers@google.com>
Mime-Version: 1.0
References: <20210917184240.2181186-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 2/2] perf test: Workload test of all PMUs
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

Iterate over the list of PMUs and run the 'true' workload on them. If
the event isn't printed then run the large 'perf bench internals
synthesize' workload and check the event is counted.

On a Skylake this test takes 1m15s mainly running the 'true' workload.

Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_pmu.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_all_pmu.sh

diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
new file mode 100755
index 000000000000..2de7fd0394fd
--- /dev/null
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# perf all PMU test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+for p in $(perf list --raw-dump pmu); do
+  echo "Testing $p"
+  result=$(perf stat -e "$p" true 2>&1)
+  if [[ ! "$result" =~ "$p" ]] && [[ ! "$result" =~ "<not supported>" ]]; then
+    # We failed to see the event and it is supported. Possibly the workload was
+    # too small so retry with something longer.
+    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
+    if [[ ! "$result" =~ "$p" ]]; then
+      echo "Event '$p' not printed in:"
+      echo "$result"
+      exit 1
+    fi
+  fi
+done
+
+exit 0
-- 
2.33.0.464.g1972c5931b-goog

