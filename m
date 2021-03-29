Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8419F34C477
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhC2HC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230503AbhC2HCQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:16 -0400
IronPort-SDR: uerrs/RjlXXhpZQHCNwPEL8GQjEpUGDHpYWNA1h1hxeBiid+Jt6+dmmzd3MjQ8gkhlcRKHPRDo
 SHxmypSBbMPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956253"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956253"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:15 -0700
IronPort-SDR: WsCHWWc3LRjCxAWZiISxwelBGorLwZ4Yi2HEklCDwfHOyw1aL0d80hDeQU8x6TPZLpSonXwIFZ
 oB+k40pcajeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677475"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:13 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 13/27] perf record: Create two hybrid 'cycles' events by default
Date:   Mon, 29 Mar 2021 15:00:32 +0800
Message-Id: <20210329070046.8815-14-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When evlist is empty, for example no '-e' specified in perf record,
one default 'cycles' event is added to evlist.

While on hybrid platform, it needs to create two default 'cycles'
events. One is for cpu_core, the other is for cpu_atom.

This patch actually calls evsel__new_cycles() two times to create
two 'cycles' events.

  # ./perf record -vv -a -- sleep 1
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             6
    size                             120
    config                           0x400000000
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|ID|CPU|PERIOD
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 13
  sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 = 14
  sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 = 15
  sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 = 16
  sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 = 17
  sys_perf_event_open: pid -1  cpu 12  group_fd -1  flags 0x8 = 18
  sys_perf_event_open: pid -1  cpu 13  group_fd -1  flags 0x8 = 19
  sys_perf_event_open: pid -1  cpu 14  group_fd -1  flags 0x8 = 20
  sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 21
  ------------------------------------------------------------
  perf_event_attr:
    type                             6
    size                             120
    config                           0xa00000000
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|ID|CPU|PERIOD
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 22
  sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 23
  sys_perf_event_open: pid -1  cpu 18  group_fd -1  flags 0x8 = 24
  sys_perf_event_open: pid -1  cpu 19  group_fd -1  flags 0x8 = 25
  sys_perf_event_open: pid -1  cpu 20  group_fd -1  flags 0x8 = 26
  sys_perf_event_open: pid -1  cpu 21  group_fd -1  flags 0x8 = 27
  sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 28
  sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 29
  ------------------------------------------------------------

We have to create evlist-hybrid.c otherwise due to the symbol
dependency the perf test python would be failed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - Move the major code to new created evlist-hybrid.c.

 tools/perf/builtin-record.c     | 19 +++++++++++----
 tools/perf/util/Build           |  1 +
 tools/perf/util/evlist-hybrid.c | 41 +++++++++++++++++++++++++++++++++
 tools/perf/util/evlist-hybrid.h | 12 ++++++++++
 tools/perf/util/evlist.c        |  5 +++-
 tools/perf/util/evsel.c         |  6 ++---
 tools/perf/util/evsel.h         |  2 +-
 7 files changed, 77 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/util/evlist-hybrid.c
 create mode 100644 tools/perf/util/evlist-hybrid.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 35465d1db6dd..1b44b1a8636e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -47,6 +47,8 @@
 #include "util/util.h"
 #include "util/pfm.h"
 #include "util/clockid.h"
+#include "util/pmu-hybrid.h"
+#include "util/evlist-hybrid.h"
 #include "asm/bug.h"
 #include "perf.h"
 
@@ -2786,10 +2788,19 @@ int cmd_record(int argc, const char **argv)
 	if (record.opts.overwrite)
 		record.opts.tail_synthesize = true;
 
-	if (rec->evlist->core.nr_entries == 0 &&
-	    __evlist__add_default(rec->evlist, !record.opts.no_samples) < 0) {
-		pr_err("Not enough memory for event selector list\n");
-		goto out;
+	if (rec->evlist->core.nr_entries == 0) {
+		if (perf_pmu__has_hybrid()) {
+			err = evlist__add_default_hybrid(rec->evlist,
+							 !record.opts.no_samples);
+		} else {
+			err = __evlist__add_default(rec->evlist,
+						    !record.opts.no_samples);
+		}
+
+		if (err < 0) {
+			pr_err("Not enough memory for event selector list\n");
+			goto out;
+		}
 	}
 
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 00c9fb064ba6..5ac116c895bf 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -10,6 +10,7 @@ perf-y += db-export.o
 perf-y += env.o
 perf-y += event.o
 perf-y += evlist.o
+perf-y += evlist-hybrid.o
 perf-y += sideband_evlist.o
 perf-y += evsel.o
 perf-y += evsel_fprintf.o
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
new file mode 100644
index 000000000000..185f60ec4351
--- /dev/null
+++ b/tools/perf/util/evlist-hybrid.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+#include <inttypes.h>
+#include "cpumap.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "../perf.h"
+#include "util/pmu-hybrid.h"
+#include "util/evlist-hybrid.h"
+#include <unistd.h>
+#include <stdlib.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <perf/evlist.h>
+#include <perf/evsel.h>
+#include <perf/cpumap.h>
+
+int evlist__add_default_hybrid(struct evlist *evlist, bool precise)
+{
+	struct evsel *evsel;
+	struct perf_pmu *pmu;
+	__u64 config;
+	struct perf_cpu_map *cpus;
+
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		config = PERF_COUNT_HW_CPU_CYCLES |
+			 ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT);
+		evsel = evsel__new_cycles(precise, PERF_TYPE_HARDWARE_PMU,
+					  config);
+		if (!evsel)
+			return -ENOMEM;
+
+		cpus = perf_cpu_map__get(pmu->cpus);
+		evsel->core.cpus = cpus;
+		evsel->core.own_cpus = perf_cpu_map__get(cpus);
+		evsel->pmu_name = strdup(pmu->name);
+		evlist__add(evlist, evsel);
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
new file mode 100644
index 000000000000..e25861649d8f
--- /dev/null
+++ b/tools/perf/util/evlist-hybrid.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_EVLIST_HYBRID_H
+#define __PERF_EVLIST_HYBRID_H
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include "evlist.h"
+#include <unistd.h>
+
+int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
+
+#endif /* __PERF_EVLIST_HYBRID_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f1c79ecf8107..013f8ed5d0f5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -25,6 +25,7 @@
 #include "util/string2.h"
 #include "util/perf_api_probe.h"
 #include "util/evsel_fprintf.h"
+#include "util/evlist-hybrid.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -247,8 +248,10 @@ void evlist__set_leader(struct evlist *evlist)
 
 int __evlist__add_default(struct evlist *evlist, bool precise)
 {
-	struct evsel *evsel = evsel__new_cycles(precise);
+	struct evsel *evsel;
 
+	evsel = evsel__new_cycles(precise, PERF_TYPE_HARDWARE,
+				  PERF_COUNT_HW_CPU_CYCLES);
 	if (evsel == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2d2614eeaa20..0ba4daa09453 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -295,11 +295,11 @@ static bool perf_event_can_profile_kernel(void)
 	return perf_event_paranoid_check(1);
 }
 
-struct evsel *evsel__new_cycles(bool precise)
+struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config)
 {
 	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_HARDWARE,
-		.config	= PERF_COUNT_HW_CPU_CYCLES,
+		.type	= type,
+		.config	= config,
 		.exclude_kernel	= !perf_event_can_profile_kernel(),
 	};
 	struct evsel *evsel;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dd4f56f9cfdf..e7dc3448ab2f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -220,7 +220,7 @@ static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 	return evsel__newtp_idx(sys, name, 0);
 }
 
-struct evsel *evsel__new_cycles(bool precise);
+struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-- 
2.17.1

