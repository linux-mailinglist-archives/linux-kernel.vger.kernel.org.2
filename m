Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE43EBE2D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 00:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhHMWKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 18:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhHMWKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 18:10:22 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1CCC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 15:09:54 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id c14-20020a6bfd0e0000b02905b2d3028604so577306ioi.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dkH736UO2whYaPRMkgIy8/mDOeX3AUXNM7Fd5nVe07E=;
        b=i9HwI+8X9LmOWiN6miSpTYU+HxPbqRqVGjXaniio5YKDolqGahqrPrE69V+RLUf/ZR
         n3ywlApSEywUsihYxOGmZNQiOajbV233QOONlShGiQkvYpp4eN173ggajmmb95ro+wwy
         lUoMeuL7uV+PHwZwEANcAu/77Ncmz8/nCdnWmGDoufm/ptJCfmjJaKjg49b2U1vxKH0Q
         lGMDUM+ZgZH+4ZfRM/wphV+xMOsyBDSF7bs8rOJx+LyccczeLprl1RivBZ7CP3jl8jHn
         aN8gAu3bLKbxDdIHoZeEyNiokFRaPpqWOtDsaBWhGDd7i64ZOFpaDM0MIGpYaz4H6TEA
         ggbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dkH736UO2whYaPRMkgIy8/mDOeX3AUXNM7Fd5nVe07E=;
        b=Mc5JKHhx99qOurhoBeHcSRaLk3KCJ4zK/U2Hg4hy5yG2/LdHrLOop5OX7MdIDbfM2V
         vmLho2pPs1OJYqBevJ4HAZ6WW79wardZvjkdz4iO4ygA3QDXbEi0j27Ae5DHzo8unOEb
         Zr6iqZ0aJZKutexXP1WyEcg3qAvF1oUCze6I12Od+1cZPI3CRec8tkplgwmIW4fQDhjm
         eq7ik7CMTtSXrVQsgT79Z1hQyBh1RRQ1M81JVjaOYbUAxBl4nG0CoYThfOjWAmHFe+UX
         krMMsuCm3rZ8VBLUSaHAhE0+H2HuXYysorV2rtUhr5GKf6yIozom8xQcMKryLNs5lujZ
         iILw==
X-Gm-Message-State: AOAM5306vsWlpfvtRTezagh0ATkqztjNVqcFqqOHAFGiKP4zSbp4bjaq
        0RMbR7TGVlp3IPEMj9iv/EWSaaf9ai8=
X-Google-Smtp-Source: ABdhPJyBPHNjsEFOFDZn6y5egPuZ7XgVNnWbBEkEwRy2gZiOk/kaKH5YPf0lwNsYHMRFicyFMQThQOrbTFs=
X-Received: from cjense.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:6d0])
 (user=cjense job=sendgmr) by 2002:a05:6638:10c7:: with SMTP id
 q7mr4092301jad.97.1628892594249; Fri, 13 Aug 2021 15:09:54 -0700 (PDT)
Date:   Fri, 13 Aug 2021 22:09:37 +0000
Message-Id: <20210813220936.2105426-1-cjense@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 1/1] Add field checking tests for perf stat JSON output.
From:   Claire Jensen <cjense@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, yao.jin@linux.intel.com,
        song@kernel.org, andi@firstfloor.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        alexander.antonov@linux.intel.com, changbin.du@intel.com,
        liuqi115@huawei.com, irogers@google.com, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        clairej735@gmail.com
Cc:     Claire Jensen <cjense@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counts number of fields to make sure expected fields are present.

Signed-off-by: Claire Jensen <cjense@google.com>
---
 .../tests/shell/lib/perf_json_output_lint.py  |  48 ++++++++
 tools/perf/tests/shell/stat+json_output.sh    | 114 ++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100644 tools/perf/tests/shell/stat+json_output.sh

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
new file mode 100644
index 000000000000..45d9163e7423
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -0,0 +1,48 @@
+#!/usr/bin/python
+
+from __future__ import print_function
+import argparse
+import sys
+
+# Basic sanity check of perf JSON output as specified in the man page.
+# Currently just checks the number of fields per line in output.
+
+ap = argparse.ArgumentParser()
+ap.add_argument('--no-args', action='store_true')
+ap.add_argument('--interval', action='store_true')
+ap.add_argument('--all-cpus-no-aggr', action='store_true')
+ap.add_argument('--all-cpus', action='store_true')
+ap.add_argument('--event', action='store_true')
+ap.add_argument('--per-core', action='store_true')
+ap.add_argument('--per-thread', action='store_true')
+ap.add_argument('--per-die', action='store_true')
+ap.add_argument('--per-node', action='store_true')
+ap.add_argument('--per-socket', action='store_true')
+args = ap.parse_args()
+
+Lines = sys.stdin.readlines()
+ch = ','
+
+
+def check_json_output(exp):
+  for line in Lines:
+    if 'failed' not in line:
+      count = 0
+      count = line.count(ch)
+      if count != exp:
+        sys.stdout.write(''.join(Lines))
+        raise RuntimeError('wrong number of fields. counted {0}'
+                           ' expected {1} in {2}\n'.format(count, exp, line))
+
+
+try:
+  if args.no_args or args.all_cpus or args.event:
+    check_json_output(6)
+  if args.interval or args.per_thread:
+    check_json_output(7)
+  if args.per_core or args.per_socket or args.per_node or args.per_die:
+    check_json_output(8)
+
+except:
+  sys.stdout.write('Test failed for input:\n' + ''.join(Lines))
+  raise
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
new file mode 100644
index 000000000000..8a772badae45
--- /dev/null
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -0,0 +1,114 @@
+#!/bin/bash
+# perf stat JSON output linter
+# SPDX-License-Identifier: GPL-2.0
+# Checks various perf stat JSON output commands for the
+# correct number of fields.
+
+set -e
+set -x
+
+pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
+file="/proc/sys/kernel/perf_event_paranoid"
+paranoia=$(cat "$file" | grep -o -E '[0-9]+')
+
+check_no_args()
+{
+	perf stat -j sleep 1 2>&1 | \
+	python $pythonchecker --no-args
+}
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_all_cpus()
+	{
+		perf stat -j -a 2>&1 sleep 1 | \
+		python $pythonchecker --all-cpus
+	}
+	check_all_cpus
+fi
+
+check_interval()
+{
+	perf stat -j -I 1000 2>&1 sleep 1 | \
+	python $pythonchecker --interval
+}
+
+check_all_cpus_no_aggr()
+{
+	perf stat -j -A -a --no-merge 2>&1 sleep 1 | \
+	python $pythonchecker --all-cpus-no-aggr
+}
+
+check_event()
+{
+	perf stat -j -e cpu-clock 2>&1 sleep 1 | \
+	python $pythonchecker --event
+}
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_per_core()
+	{
+		perf stat -j --per-core -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-core
+	}
+	check_per_core
+fi
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_per_thread()
+	{
+		perf stat -j --per-thread -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-thread
+	}
+	check_per_thread
+fi
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_per_die test skipped because of paranoia level.
+else
+	check_per_die()
+	{
+		perf stat -j --per-die -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-die
+	}
+	check_per_die
+fi
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_per_node test skipped because of paranoia level.
+else
+	check_per_node()
+	{
+		perf stat -j --per-node -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-node
+	}
+	check_per_node
+fi
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_per_socket test skipped because of paranoia level.
+else
+	check_per_socket()
+	{
+		perf stat -j --per-socket -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-socket
+	}
+	check_per_socket
+fi
+
+check_no_args
+check_interval
+check_all_cpus_no_aggr
+check_event
+exit 0
-- 
2.33.0.rc1.237.g0d66db33f3-goog

