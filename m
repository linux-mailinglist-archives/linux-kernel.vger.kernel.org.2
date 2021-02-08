Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD7B313D0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhBHSSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:18:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:27508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234041AbhBHPoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:44:01 -0500
IronPort-SDR: 8WKFnjEmZEUujrXD8+ZepVawdWe9qXwl+mvCo8KrQBs3NpSvjpduKVReHG5iXrrG46TLUzK/gu
 CKEr0D+fmiFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874630"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874630"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: SBii2DsVIbE5Jy3/GRWN8urxR5R+vpRKwKZpo8XQniQ9HF8oq4lMEr9HPhT0G44g9riPHBXsYS
 N7UsR0MeiqBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820926"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 43/49] perf stat: Add default hybrid events
Date:   Mon,  8 Feb 2021 07:25:40 -0800
Message-Id: <1612797946-18784-44-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

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
root@otcpl-adl-s-2:~# ./perf stat -vv -- taskset -c 16 ./triad_loop
...
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             120
  config                           0x1
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 3
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             120
  config                           0x3
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 4
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             120
  config                           0x4
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 5
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             120
  config                           0x2
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 7
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0x400000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 8
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0xa00000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 9
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0x400000001
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 10
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0xa00000001
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 11
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0x400000004
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 12
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0xa00000004
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 13
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0x400000005
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 27954  cpu -1  group_fd -1  flags 0x8 = 14
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0xa00000005
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
...

 Performance counter stats for 'taskset -c 16 ./triad_loop':

            201.31 msec task-clock                #    0.997 CPUs utilized
                 1      context-switches          #    0.005 K/sec
                 1      cpu-migrations            #    0.005 K/sec
               166      page-faults               #    0.825 K/sec
       623,267,134      cycles                    # 3096.043 M/sec                    (0.16%)
       603,082,383      cycles                    # 2995.777 M/sec                    (99.84%)
       406,410,481      instructions              # 2018.820 M/sec                    (0.16%)
     1,604,213,375      instructions              # 7968.837 M/sec                    (99.84%)
        81,444,171      branches                  #  404.569 M/sec                    (0.16%)
       200,616,430      branches                  #  996.550 M/sec                    (99.84%)
         3,769,856      branch-misses             #   18.727 M/sec                    (0.16%)
            16,111      branch-misses             #    0.080 M/sec                    (99.84%)

       0.201895853 seconds time elapsed

We can see two events are created for one hardware event.
First one is core event the second one is atom event.

One thing is, the shadow stats looks a bit different, now it's just
'M/sec'.

The perf_stat__update_shadow_stats and perf_stat__print_shadow_stats
need to be improved in future if we want to get the original shadow
stats.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 44d1a5f..0b08665 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1137,6 +1137,13 @@ static int parse_hybrid_type(const struct option *opt,
 	return 0;
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
@@ -1613,6 +1620,12 @@ static int add_default_attributes(void)
   { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_MISSES		},
 
 };
+	struct perf_event_attr default_sw_attrs[] = {
+  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
+  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
+  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
+  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
+};
 
 /*
  * Detailed stats (-d), covering the L1 and last level data caches:
@@ -1849,6 +1862,15 @@ static int add_default_attributes(void)
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
2.7.4

