Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D017134C478
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhC2HDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhC2HCS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:18 -0400
IronPort-SDR: yOu1FFmNbyZ5JKWrrjr1O81tpXfB7EsyYRPoh8VPPOzRAnczHwCxmKmmS78xbc/xKIi8uILLZr
 9vLrowYm9FgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956265"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956265"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:18 -0700
IronPort-SDR: esiWQkdqCzpRUVERcoeqyBflvUEtQIeH2usyd7ZhO12R7kjEU7loqfnILYm537m/uInQjqxl/X
 91eREURd9EFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677484"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:16 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 14/27] perf stat: Add default hybrid events
Date:   Mon, 29 Mar 2021 15:00:33 +0800
Message-Id: <20210329070046.8815-15-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously if '-e' is not specified in perf stat, some software events
and hardware events are added to evlist by default.

Before:

  # ./perf stat -a -- sleep 1

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

  # ./perf stat -a -- sleep 1

   Performance counter stats for 'system wide':

           24,048.60 msec task-clock                #   23.947 CPUs utilized
                 438      context-switches          #   18.213 /sec
                  24      cpu-migrations            #    0.998 /sec
                   6      page-faults               #    0.249 /sec
          24,813,157      cpu_core/cycles/          #    1.032 M/sec
           8,072,687      cpu_atom/cycles/          #  335.682 K/sec
          20,731,286      cpu_core/instructions/    #  862.058 K/sec
           3,737,203      cpu_atom/instructions/    #  155.402 K/sec
           2,620,924      cpu_core/branches/        #  108.984 K/sec
             381,186      cpu_atom/branches/        #   15.851 K/sec
              93,248      cpu_core/branch-misses/   #    3.877 K/sec
              36,515      cpu_atom/branch-misses/   #    1.518 K/sec

         1.004235472 seconds time elapsed

We can see two events are created for one hardware event.

One TODO is, the shadow stats looks a bit different, now it's just
'M/sec'.

The perf_stat__update_shadow_stats and perf_stat__print_shadow_stats
need to be improved in future if we want to get the original shadow
stats.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No functional change.

 tools/perf/builtin-stat.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7b2dfe21c5a8..33fda8f55f66 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1140,6 +1140,13 @@ static int parse_stat_cgroups(const struct option *opt,
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
@@ -1619,6 +1626,12 @@ static int add_default_attributes(void)
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
@@ -1856,6 +1869,14 @@ static int add_default_attributes(void)
 	}
 
 	if (!evsel_list->core.nr_entries) {
+		if (perf_pmu__has_hybrid()) {
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

