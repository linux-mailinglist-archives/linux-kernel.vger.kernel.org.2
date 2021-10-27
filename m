Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF29C43C499
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbhJ0IGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:06:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:24462 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239064AbhJ0IGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:06:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="229960790"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="229960790"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 01:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="465644366"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga002.jf.intel.com with ESMTP; 27 Oct 2021 01:03:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/6] perf dlfilter: Add dlfilter-show-cycles
Date:   Wed, 27 Oct 2021 11:03:32 +0300
Message-Id: <20211027080334.365596-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027080334.365596-1-adrian.hunter@intel.com>
References: <20211027080334.365596-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new dlfilter to show cycles.

Cycle counts are accumulated per CPU (or per thread if CPU is not recorded)
from IPC information, and printed together with the change since the last
print, at the start of each line. Separate counts are kept for branches,
instructions or other events.

Note also, the itrace A option can be useful to provide higher granularity
cycle information.

Example:

 $ perf record -e intel_pt/cyc/u uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.044 MB perf.data ]
 $ perf script --itrace=A --call-trace --dlfilter dlfilter-show-cycles.so --deltatime | head
         0                   perf-exec  8509 [001]     0.000000000:  psb offs: 0
         0                   perf-exec  8509 [001]     0.000000000:  cbr: 42 freq: 4219 MHz (156%)
       833        833            uname  8509 [001]     0.000047689: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )        _start
       833                       uname  8509 [001]     0.000003261: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )            _dl_start
      2015       1182            uname  8509 [001]     0.000000282: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )            _dl_start
      2676        661            uname  8509 [001]     0.000002629: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )            _dl_start
      3612        936            uname  8509 [001]     0.000001232: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )            _dl_start
      4579        967            uname  8509 [001]     0.000002519: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )            _dl_start
      6145       1566            uname  8509 [001]     0.000001050: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )                _dl_setup_hash
      6239         94            uname  8509 [001]     0.000000023: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )                _dl_sysdep_start

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt  |  19 ++-
 tools/perf/Makefile.perf                    |   2 +-
 tools/perf/dlfilters/dlfilter-show-cycles.c | 144 ++++++++++++++++++++
 3 files changed, 163 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/dlfilters/dlfilter-show-cycles.c

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index c7457b31f7c9..5fa0a448e6a6 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -164,7 +164,9 @@ actual number of cycles increases even though the cycles reported does not.
 The number of instructions is known, but if IPC is reported, cycles can be too
 low and so IPC is too high.  Note that inaccuracy decreases as the period of
 sampling increases i.e. if the number of cycles is too low by a small amount,
-that becomes less significant if the number of cycles is large.
+that becomes less significant if the number of cycles is large.  It may also be
+useful to use the 'A' option in conjunction with dlfilter-show-cycles.so to
+provide higher granularity cycle information.
 
 Also note that the IPC instruction count may or may not include the current
 instruction.  If the cycle count is associated with an asynchronous branch
@@ -1082,6 +1084,21 @@ The Z option is equivalent to having recorded a trace without TSC
 decoding a trace of a virtual machine.
 
 
+dlfilter-show-cycles.so
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Cycles can be displayed using dlfilter-show-cycles.so in which case the itrace A
+option can be useful to provide higher granularity cycle information:
+
+	perf script --itrace=A --call-trace --dlfilter dlfilter-show-cycles.so
+
+To see a list of dlfilters:
+
+	perf script -v --list-dlfilters
+
+See also linkperf:perf-dlfilters[1]
+
+
 dump option
 ~~~~~~~~~~~
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7df13e74450c..e155570cb662 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -362,7 +362,7 @@ ifndef NO_JVMTI
 PROGRAMS += $(OUTPUT)$(LIBJVMTI)
 endif
 
-DLFILTERS := dlfilter-test-api-v0.so
+DLFILTERS := dlfilter-test-api-v0.so dlfilter-show-cycles.so
 DLFILTERS := $(patsubst %,$(OUTPUT)dlfilters/%,$(DLFILTERS))
 
 # what 'all' will build and 'install' will install, in perfexecdir
diff --git a/tools/perf/dlfilters/dlfilter-show-cycles.c b/tools/perf/dlfilters/dlfilter-show-cycles.c
new file mode 100644
index 000000000000..9eccc97bff82
--- /dev/null
+++ b/tools/perf/dlfilters/dlfilter-show-cycles.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dlfilter-show-cycles.c: Print the number of cycles at the start of each line
+ * Copyright (c) 2021, Intel Corporation.
+ */
+#include <perf/perf_dlfilter.h>
+#include <string.h>
+#include <stdio.h>
+
+#define MAX_CPU 4096
+
+enum {
+	INSTR_CYC,
+	BRNCH_CYC,
+	OTHER_CYC,
+	MAX_ENTRY
+};
+
+static __u64 cycles[MAX_CPU][MAX_ENTRY];
+static __u64 cycles_rpt[MAX_CPU][MAX_ENTRY];
+
+#define BITS		16
+#define TABLESZ		(1 << BITS)
+#define TABLEMAX	(TABLESZ / 2)
+#define MASK		(TABLESZ - 1)
+
+static struct entry {
+	__u32 used;
+	__s32 tid;
+	__u64 cycles[MAX_ENTRY];
+	__u64 cycles_rpt[MAX_ENTRY];
+} table[TABLESZ];
+
+static int tid_cnt;
+
+static int event_entry(const char *event)
+{
+	if (!event)
+		return OTHER_CYC;
+	if (!strncmp(event, "instructions", 12))
+		return INSTR_CYC;
+	if (!strncmp(event, "branches", 8))
+		return BRNCH_CYC;
+	return OTHER_CYC;
+}
+
+static struct entry *find_entry(__s32 tid)
+{
+	__u32 pos = tid & MASK;
+	struct entry *e;
+
+	e = &table[pos];
+	while (e->used) {
+		if (e->tid == tid)
+			return e;
+		if (++pos == TABLESZ)
+			pos = 0;
+		e = &table[pos];
+	}
+
+	if (tid_cnt >= TABLEMAX) {
+		fprintf(stderr, "Too many threads\n");
+		return NULL;
+	}
+
+	tid_cnt += 1;
+	e->used = 1;
+	e->tid = tid;
+	return e;
+}
+
+static void add_entry(__s32 tid, int pos, __u64 cnt)
+{
+	struct entry *e = find_entry(tid);
+
+	if (e)
+		e->cycles[pos] += cnt;
+}
+
+int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	__s32 cpu = sample->cpu;
+	__s32 tid = sample->tid;
+	int pos;
+
+	if (!sample->cyc_cnt)
+		return 0;
+
+	pos = event_entry(sample->event);
+
+	if (cpu >= 0 && cpu < MAX_CPU)
+		cycles[cpu][pos] += sample->cyc_cnt;
+	else if (tid != -1)
+		add_entry(tid, pos, sample->cyc_cnt);
+	return 0;
+}
+
+static void print_vals(__u64 cycles, __u64 delta)
+{
+	if (delta)
+		printf("%10llu %10llu ", cycles, delta);
+	else
+		printf("%10llu %10s ", cycles, "");
+}
+
+int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	__s32 cpu = sample->cpu;
+	__s32 tid = sample->tid;
+	int pos;
+
+	pos = event_entry(sample->event);
+
+	if (cpu >= 0 && cpu < MAX_CPU) {
+		print_vals(cycles[cpu][pos], cycles[cpu][pos] - cycles_rpt[cpu][pos]);
+		cycles_rpt[cpu][pos] = cycles[cpu][pos];
+		return 0;
+	}
+
+	if (tid != -1) {
+		struct entry *e = find_entry(tid);
+
+		if (e) {
+			print_vals(e->cycles[pos], e->cycles[pos] - e->cycles_rpt[pos]);
+			e->cycles_rpt[pos] = e->cycles[pos];
+			return 0;
+		}
+	}
+
+	printf("%22s", "");
+	return 0;
+}
+
+const char *filter_description(const char **long_description)
+{
+	static char *long_desc = "Cycle counts are accumulated per CPU (or "
+		"per thread if CPU is not recorded) from IPC information, and "
+		"printed together with the change since the last print, at the "
+		"start of each line. Separate counts are kept for branches, "
+		"instructions or other events.";
+
+	*long_description = long_desc;
+	return "Print the number of cycles at the start of each line";
+}
-- 
2.25.1

