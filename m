Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952423E1A2E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhHERPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHERPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:15:00 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C13C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 10:14:45 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id 81-20020a6b02540000b02905824a68848bso3345151ioc.21
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=INEvP19P6WTC1AGBfQEXR3fV4WN5Ayl4veWqJISDaiQ=;
        b=N5Xwt3ZG+nWnvK2mcmtPCia+NEMrO/oyV9+aumLMqiwAqGkw4QI8GvxplQK6fHVJav
         kNgbLjymnv+CuALFDDkIO4a++gcamdQnr2Dkg5R3JrOe0eliBSerFwHKOFEn0kIVGsZ1
         aoplmPoGEY/VhgPWpEmQ2oA/sS/4i6v9WmyNWfrKpEhrO6cMyHijHgU1bamG8usON3kW
         eJMnUdNaJDzNB8OolugGcYngJRH09yucB/M5KH6zHHv0wPB6Jz7/+FSslvRYTArBYctl
         SOcaOQ2KrTzYNznABfgFE16XvHO9MutE6sg6C08bAmJ4++Ov+xj0KLIOOhSWCYnKbsqC
         OzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=INEvP19P6WTC1AGBfQEXR3fV4WN5Ayl4veWqJISDaiQ=;
        b=csXdZ744c21OLV86kshD6HUo2Fv/hUUowMXDFOhZ3BgyPx3jhuMD6w5ISCYYRzaBNJ
         t8e4s9wPs0RB7CE/+ZUne+qkLpEcREQMwwE9Eag8B4nDGSNaIgoU8CF0+jat5CohERBX
         cdgvjvjVd8sdcj43XDqIJUK8klHgMiXnRwcj9Ksvar/tdlPS0vfbwfZAby6IZpfJEfsM
         kSyxMG6DY1w+yBDAgxDUkDF0UimfyKjv0wbNiiA/oi/xuFMYpzPgfgR8+BIlaO3N/iPZ
         36fiXg1dVkWZugxhXGe3vmaMAROrE1c0eyZr3oyG5MWZ4TCRftXDBSKp9z0QAe2gl0Rt
         +pJg==
X-Gm-Message-State: AOAM531CYfmhTZZwpAKR/s49KmDiJr2+c7wjBXj7X/lecvfKk8H5EkiN
        a6dwsKXBiWgcjh3++j1MkHxosHA9Rb0=
X-Google-Smtp-Source: ABdhPJycgyaIlPUs35dwX8nRQZnNTy7oj/KlyZ/36c1VHTFdVZE4GKQN3/BTFvSouM1sUdjmwALZwxmSflg=
X-Received: from cjense.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:6d0])
 (user=cjense job=sendgmr) by 2002:a5d:97cc:: with SMTP id k12mr183182ios.4.1628183684323;
 Thu, 05 Aug 2021 10:14:44 -0700 (PDT)
Date:   Thu,  5 Aug 2021 17:14:31 +0000
Message-Id: <20210805171431.940897-1-cjense@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 1/1] perf test: Add test for CSV output.
From:   Claire Jensen <cjense@google.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, irogers@google.com,
        eranian@google.com
Cc:     Claire Jensen <cjense@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add field checking tests for perf stat CSV output. Counts expected
fields for various commands. No testing added for summary mode
since it is broken.

An example of the summary output is:

         summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
,,,,,1.37,stalled cycles per insn

This should be:

         summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
         summary,,,,,,1.37,stalled cycles per insn

The output has 7 fields when it should have 8. Additionally, the newline
spacing is wrong, so it was excluded from testing until a fix is made.
---
 .../tests/shell/lib/perf_csv_output_lint.py   |  55 ++++++++
 tools/perf/tests/shell/stat+csv_output.sh     | 117 ++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
 create mode 100644 tools/perf/tests/shell/stat+csv_output.sh

diff --git a/tools/perf/tests/shell/lib/perf_csv_output_lint.py b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
new file mode 100644
index 000000000000..ef8a32c3523c
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
@@ -0,0 +1,55 @@
+#!/usr/bin/python
+# SPDX-License-Identifier: GPL-2.0
+
+from __future__ import print_function
+import argparse
+import sys
+
+# Basic sanity check of perf CSV output as specified in the man page.
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
+ap.add_argument('--separator', const=',', nargs='?')
+args = ap.parse_args()
+
+Lines = sys.stdin.readlines()
+ch = args.separator
+
+
+def check_csv_output(exp):
+  for line in Lines:
+    if 'failed' not in line:
+      count = 0
+      count = line.count(args.separator)
+      if count != exp:
+        sys.stdout.write(''.join(Lines))
+        raise RuntimeError('wrong number of fields.'
+                           ' expected {0} in {1}\n'.format(exp, line))
+
+try:
+  if args.no_args or args.all_cpus or args.event:
+    check_csv_output(6)
+
+  if args.interval or args.per_thread:
+    check_csv_output(7)
+
+  if args.per_core or args.per_socket or args.per_node or args.per_die:
+    check_csv_output(8)
+
+except:
+  sys.stdout.write('Test failed for input: ' + ''.join(Lines))
+  raise
+
+
+
+
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
new file mode 100644
index 000000000000..282f9547e7be
--- /dev/null
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -0,0 +1,117 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# perf stat csv output test
+# Tests various perf stat CSV output commands for the
+# correct number of fields and the CSV separator set to ','.
+
+set -e
+
+pythonchecker=$(dirname $0)/lib/perf_csv_output_lint.py
+file="/proc/sys/kernel/perf_event_paranoid"
+paranoia=$(cat "$file" | grep -o -E '[0-9]+')
+echo $paranoia
+
+check_no_args()
+{
+	perf stat -x, sleep 1 2>&1 | \
+	python $pythonchecker --no-args --separator
+}
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_all_cpus()
+	{
+		perf stat -x, -a 2>&1 sleep 1 | \
+		python $pythonchecker --all-cpus --separator
+	}
+	check_all_cpus
+fi
+
+check_interval()
+{
+	perf stat -x, -I 1000 2>&1 sleep 1 | \
+	python $pythonchecker --interval --separator
+}
+
+check_all_cpus_no_aggr()
+{
+	perf stat -x, -A -a --no-merge 2>&1 sleep 1 | \
+	python $pythonchecker --all-cpus-no-aggr --separator
+}
+
+check_event()
+{
+	perf stat -x, -e cpu-clock 2>&1 sleep 1 | \
+	python $pythonchecker --event --separator
+}
+
+if [ $paranoia -gt 0 ];
+then
+	echo check_all_cpus test skipped because of paranoia level.
+else
+	check_per_core()
+	{
+		perf stat -x, --per-core -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-core --separator
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
+		perf stat -x, --per-thread -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-thread --separator
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
+		perf stat -x, --per-die -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-die --separator
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
+		perf stat -x, --per-node -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-node --separator
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
+		perf stat -x, --per-socket -a 2>&1 sleep 1 | \
+		python $pythonchecker --per-socket --separator
+	}
+	check_per_socket
+fi
+
+check_no_args
+check_interval
+check_all_cpus_no_aggr
+check_event
+
+exit 0
+
-- 
2.32.0.605.g8dce9f2422-goog

