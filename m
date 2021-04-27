Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF136BFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhD0HEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:54937 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235173AbhD0HE3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:29 -0400
IronPort-SDR: Wj47eyO8WZggYpxB8TyychVRA94+O+1NoVnxQKahW87kDhVZw0hOZsUY76UiIDEhL23aT5xiww
 vIQbKDtk5dJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573015"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573015"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:46 -0700
IronPort-SDR: 0MJQXcbM0TAXVCF0ZvphpPdmWdUUdaslNOdbN3BH9EBaXHVBFnKqA8XMgvJBW2axC53dPDTLja
 Fdg7+OqAiXoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506859"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:44 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 14/26] perf stat: Add default hybrid events
Date:   Tue, 27 Apr 2021 15:01:27 +0800
Message-Id: <20210427070139.25256-15-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously if '-e' is not specified in perf stat, some software events
and hardware events are added to evlist by default.

Before:

  # perf stat -a -- sleep 1

   Performance counter stats for 'system wide':

           24,044.40 msec cpu-clock                 #   23.946 CPUs utilized
                  99      context-switches          #    4.117 /sec
                  24      cpu-migrations            #    0.998 /sec
                   3      page-faults               #    0.125 /sec
           7,000,244      cycles                    #    0.000 GHz
           2,955,024      instructions              #    0.42  insn per cycle
             608,941      branches                  #   25.326 K/sec
              31,991      branch-misses             #    5.25% of all branches

         1.004106859 seconds time elapsed

Among the events, cycles, instructions, branches and branch-misses
are hardware events.

One hybrid platform, two hardware events are created for one
hardware event.

cpu_core/cycles/,
cpu_atom/cycles/,
cpu_core/instructions/,
cpu_atom/instructions/,
cpu_core/branches/,
cpu_atom/branches/,
cpu_core/branch-misses/,
cpu_atom/branch-misses/

These events would be added to evlist on hybrid platform.

Since parse_events() has been supported to create two hardware events
for one event on hybrid platform, so we just use parse_events(evlist,
"cycles,instructions,branches,branch-misses") to create the default
events and add them to evlist.

After:

  # perf stat -a -- sleep 1

   Performance counter stats for 'system wide':

           24,043.99 msec cpu-clock                 #   23.991 CPUs utilized
                 139      context-switches          #    5.781 /sec
                  25      cpu-migrations            #    1.040 /sec
                   6      page-faults               #    0.250 /sec
          10,381,751      cpu_core/cycles/          #  431.782 K/sec
           1,264,216      cpu_atom/cycles/          #   52.579 K/sec
           3,406,958      cpu_core/instructions/    #  141.697 K/sec
             414,588      cpu_atom/instructions/    #   17.243 K/sec
             705,149      cpu_core/branches/        #   29.327 K/sec
              82,358      cpu_atom/branches/        #    3.425 K/sec
              40,821      cpu_core/branch-misses/   #    1.698 K/sec
               9,086      cpu_atom/branch-misses/   #  377.891 /sec

         1.002228863 seconds time elapsed

We can see two events are created for one hardware event.

One TODO is, the shadow stats looks a bit different, now it's just
'M/sec'.

The perf_stat__update_shadow_stats and perf_stat__print_shadow_stats
need to be improved in future if we want to get the original shadow
stats.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v6:
 - No change.

v5:
 - Do the same way like when topdown calls parse events for checking
   result and displayt the error.

v4:
 - No change.

 tools/perf/builtin-stat.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 835e3696b9ce..42e60764ad8d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1639,6 +1639,12 @@ static int add_default_attributes(void)
   { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS	},
   { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_MISSES		},
 
+};
+	struct perf_event_attr default_sw_attrs[] = {
+  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
+  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
+  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
+  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
 };
 
 /*
@@ -1876,6 +1882,28 @@ static int add_default_attributes(void)
 	}
 
 	if (!evsel_list->core.nr_entries) {
+		if (perf_pmu__has_hybrid()) {
+			const char *hybrid_str = "cycles,instructions,branches,branch-misses";
+
+			if (target__has_cpu(&target))
+				default_sw_attrs[0].config = PERF_COUNT_SW_CPU_CLOCK;
+
+			if (evlist__add_default_attrs(evsel_list,
+						      default_sw_attrs) < 0) {
+				return -1;
+			}
+
+			err = parse_events(evsel_list, hybrid_str, &errinfo);
+			if (err) {
+				fprintf(stderr,
+					"Cannot set up hybrid events %s: %d\n",
+					hybrid_str, err);
+				parse_events_print_error(&errinfo, hybrid_str);
+				return -1;
+			}
+			return err;
+		}
+
 		if (target__has_cpu(&target))
 			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
 
-- 
2.17.1

