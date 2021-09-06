Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3738401E0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbhIFQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:09:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:53222 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243510AbhIFQJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:09:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="218136421"
X-IronPort-AV: E=Sophos;i="5.85,272,1624345200"; 
   d="scan'208";a="218136421"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 09:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,272,1624345200"; 
   d="scan'208";a="468894542"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga007.jf.intel.com with ESMTP; 06 Sep 2021 09:08:22 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf dlfilter: Add dlfilter-show-cycles
Date:   Mon,  6 Sep 2021 19:08:50 +0300
Message-Id: <20210906160850.22716-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new dlfilter to show cycles.

Cycle counts are accumulated per CPU (or per thread if CPU is not recorded)
from IPC information, and printed together with the change since the last
print, at the start of each line.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Makefile.perf                    |   2 +-
 tools/perf/dlfilters/dlfilter-show-cycles.c | 107 ++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/dlfilters/dlfilter-show-cycles.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e04313c4d840..6b2c8b46ea80 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -360,7 +360,7 @@ ifndef NO_JVMTI
 PROGRAMS += $(OUTPUT)$(LIBJVMTI)
 endif
 
-DLFILTERS := dlfilter-test-api-v0.so
+DLFILTERS := dlfilter-test-api-v0.so dlfilter-show-cycles.so
 DLFILTERS := $(patsubst %,$(OUTPUT)dlfilters/%,$(DLFILTERS))
 
 # what 'all' will build and 'install' will install, in perfexecdir
diff --git a/tools/perf/dlfilters/dlfilter-show-cycles.c b/tools/perf/dlfilters/dlfilter-show-cycles.c
new file mode 100644
index 000000000000..d5b37f560ffd
--- /dev/null
+++ b/tools/perf/dlfilters/dlfilter-show-cycles.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dlfilter-show-cycles.c: Print the number of cycles at the start of each line
+ * Copyright (c) 2021, Intel Corporation.
+ */
+#include <perf/perf_dlfilter.h>
+#include <stdio.h>
+
+#define MAX_CPU 4096
+
+static __u64 cycles[MAX_CPU];
+static __u64 cycles_rpt[MAX_CPU];
+
+#define BITS		16
+#define TABLESZ		(1 << BITS)
+#define TABLEMAX	(TABLESZ / 2)
+#define MASK		(TABLESZ - 1)
+
+static struct entry {
+	__u32 used;
+	__s32 tid;
+	__u64 cycles;
+	__u64 cycles_rpt;
+} table[TABLESZ];
+
+static int tid_cnt;
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
+static void add_entry(__s32 tid, __u64 cnt)
+{
+	struct entry *e = find_entry(tid);
+
+	if (e)
+		e->cycles += cnt;
+}
+
+int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	__s32 cpu = sample->cpu;
+	__s32 tid = sample->tid;
+
+	if (cpu >= 0 && cpu < MAX_CPU)
+		cycles[cpu] += sample->cyc_cnt;
+	else if (tid != -1)
+		add_entry(tid, sample->cyc_cnt);
+	return 0;
+}
+
+int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	__s32 cpu = sample->cpu;
+	__s32 tid = sample->tid;
+
+	if (cpu >= 0 && cpu < MAX_CPU) {
+		printf("%10llu %10llu ", cycles[cpu], cycles[cpu] - cycles_rpt[cpu]);
+		cycles_rpt[cpu] = cycles[cpu];
+		return 0;
+	}
+
+	if (tid != -1) {
+		struct entry *e = find_entry(tid);
+
+		if (e) {
+			printf("%10llu %10llu ", e->cycles, e->cycles - e->cycles_rpt);
+			e->cycles_rpt = e->cycles;
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
+		"start of each line.";
+
+	*long_description = long_desc;
+	return "Print the number of cycles at the start of each line";
+}
-- 
2.17.1

