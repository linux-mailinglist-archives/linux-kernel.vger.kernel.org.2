Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F99336CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhCKHJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhCKHIx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:53 -0500
IronPort-SDR: NeaixQ+KW3S3gedWOUxuknHvS2ELSWghrikU/d5v4cW97D+bV3dF4FCtbpEZlHszkEnohqO+wy
 clM7qKQLuNqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246074"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246074"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:53 -0800
IronPort-SDR: +w5jdfstgUc4VSTvkc0kpP4tt1YzBRbT+x1xAVmSVfXctlRAShKoB0A72iBirGdiYuxPYCpELf
 k7mN26yDsgVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937928"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:51 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 14/27] perf stat: Add default hybrid events
Date:   Thu, 11 Mar 2021 15:07:29 +0800
Message-Id: <20210311070742.9318-15-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously if '-e' is not specified in perf stat, some software events
and hardware events are added to evlist by default.

  root@otcpl-adl-s-2:~# ./perf stat  -- ./triad_loop

   Performance counter stats for './triad_loop':

              109.43 msec task-clock                #    0.993 CPUs utilized
                   1      context-switches          #    0.009 K/sec
                   0      cpu-migrations            #    0.000 K/sec
                 105      page-faults               #    0.960 K/sec
         401,161,982      cycles                    #    3.666 GHz
       1,601,216,357      instructions              #    3.99  insn per cycle
         200,217,751      branches                  # 1829.686 M/sec
              14,555      branch-misses             #    0.01% of all branches

         0.110176860 seconds time elapsed

Among the events, cycles, instructions, branches and branch-misses
are hardware events.

One hybrid platform, two events are created for one hardware event.

core cycles,
atom cycles,
core instructions,
atom instructions,
core branches,
atom branches,
core branch-misses,
atom branch-misses

These events will be added to evlist in order on hybrid platform
if '-e' is not set.

Since parse_events() has been supported to create two hardware events
for one event on hybrid platform, so we just use parse_events(evlist,
"cycles,instructions,branches,branch-misses") to create the default
events and add them to evlist.

After:

  root@ssp-pwrt-002:~# ./perf stat  -- ./triad_loop

   Performance counter stats for './triad_loop':

              290.77 msec task-clock                #    0.996 CPUs utilized
                  25      context-switches          #    0.086 K/sec
                  13      cpu-migrations            #    0.045 K/sec
                 107      page-faults               #    0.368 K/sec
         449,620,957      cpu_core/cycles/          # 1546.334 M/sec
       <not counted>      cpu_atom/cycles/                                              (0.00%)
       1,601,499,820      cpu_core/instructions/    # 5507.870 M/sec
       <not counted>      cpu_atom/instructions/                                        (0.00%)
         200,272,310      cpu_core/branches/        #  688.776 M/sec
       <not counted>      cpu_atom/branches/                                            (0.00%)
              15,255      cpu_core/branch-misses/   #    0.052 M/sec
       <not counted>      cpu_atom/branch-misses/                                       (0.00%)

         0.291897676 seconds time elapsed

We can see two events are created for one hardware event.
First one is core event the second one is atom event.

One thing is, the shadow stats looks a bit different, now it's just
'M/sec'.

The perf_stat__update_shadow_stats and perf_stat__print_shadow_stats
need to be improved in future if we want to get the original shadow
stats.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6c0a21323814..7a732508b2b4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1162,6 +1162,13 @@ static int parse_stat_cgroups(const struct option *opt,
 	return parse_cgroups(opt, str, unset);
 }
 
+static int add_default_hybrid_events(struct evlist *evlist)
+{
+	struct parse_events_error err;
+
+	return parse_events(evlist, "cycles,instructions,branches,branch-misses", &err);
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1637,6 +1644,12 @@ static int add_default_attributes(void)
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
@@ -1874,6 +1887,15 @@ static int add_default_attributes(void)
 	}
 
 	if (!evsel_list->core.nr_entries) {
+		perf_pmu__scan(NULL);
+		if (perf_pmu__hybrid_exist()) {
+			if (evlist__add_default_attrs(evsel_list,
+						      default_sw_attrs) < 0) {
+				return -1;
+			}
+			return add_default_hybrid_events(evsel_list);
+		}
+
 		if (target__has_cpu(&target))
 			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
 
-- 
2.17.1

