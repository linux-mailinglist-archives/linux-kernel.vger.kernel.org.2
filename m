Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58F2313D25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhBHSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:21:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:27842 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234096AbhBHPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:45:28 -0500
IronPort-SDR: a4g9SrE2+9+UxAqqmyao/tcXRNTDXkYgwwb5Us79/6FiSZPCUi/oaNEQfKsv4vOyuHjfl82SZU
 ZjLBbuvPscVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874632"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874632"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: mmZOV23r7U4XxhQ3Qy0Jo+A/LTHBAD5BeiDY7hGHjRk0ifkFiCixQ52KRdswtRrCzOEGJjfxf4
 LbKqIQLmaI1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820931"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 45/49] perf stat: Merge event counts from all hybrid PMUs
Date:   Mon,  8 Feb 2021 07:25:42 -0800
Message-Id: <1612797946-18784-46-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

For hybrid events, by default stat aggregates and reports the event counts
per pmu.

root@otcpl-adl-s-2:~# ./perf stat -e cycles -a -- sleep 1

 Performance counter stats for 'system wide':

        17,291,386      cycles [cpu_core]
         1,556,803      cycles [cpu_atom]

       1.002154118 seconds time elapsed

Sometime, it's also useful to aggregate event counts from all PMUs.
Create a new option '--hybrid-merge' to enable that behavior and report
the counts without PMUs.

root@otcpl-adl-s-2:~# ./perf stat -e cycles -a --hybrid-merge -- sleep 1

 Performance counter stats for 'system wide':

        19,041,587      cycles

       1.002195329 seconds time elapsed

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 7 +++++++
 tools/perf/builtin-stat.c              | 3 ++-
 tools/perf/util/stat-display.c         | 3 ++-
 tools/perf/util/stat.h                 | 1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b0e357d..3d083a3 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -418,6 +418,13 @@ Multiple events are created from a single event specification when:
 2. Aliases, which are listed immediately after the Kernel PMU events
    by perf list, are used.
 
+--hybrid-merge::
+Merge the hybrid event counts from all PMUs.
+
+For hybrid events, by default stat aggregates and reports the event counts
+per pmu. But sometime, it's also useful to aggregate event counts from all
+PMUs. This option enables that behavior and reports the counts without PMUs.
+
 --smi-cost::
 Measure SMI cost if msr/aperf/ and msr/smi/ events are supported.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bfe7305..d367cfe 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1184,6 +1184,7 @@ static struct option stat_options[] = {
 	OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
 		    "disable CPU count aggregation", AGGR_NONE),
 	OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
+	OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge, "Merge identical named hybrid events"),
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
@@ -2379,7 +2380,7 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__check_cpu_maps(evsel_list);
 
-	if (perf_pmu__hybrid_exist())
+	if (perf_pmu__hybrid_exist() && !stat_config.hybrid_merge)
 		stat_config.no_merge = true;
 
 	/*
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 961d5ac..21a3f80 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -568,6 +568,7 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 		    !strcmp(alias->pmu_name, counter->pmu_name) ||
 		    (evsel__is_hybrid_event(alias) &&
 		     evsel__is_hybrid_event(counter) &&
+		     !config->hybrid_merge &&
 		     strcmp(alias->pmu_name, counter->pmu_name)))
 			break;
 		alias->merged_stat = true;
@@ -585,7 +586,7 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
 	cb(config, counter, data, true);
 	if (config->no_merge)
 		uniquify_event_name(counter);
-	else if (counter->auto_merge_stats)
+	else if (counter->auto_merge_stats || config->hybrid_merge)
 		collect_all_aliases(config, counter, cb, data);
 	return true;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index d85c292..80f6715 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -123,6 +123,7 @@ struct perf_stat_config {
 	bool			 ru_display;
 	bool			 big_num;
 	bool			 no_merge;
+	bool			 hybrid_merge;
 	bool			 walltime_run_table;
 	bool			 all_kernel;
 	bool			 all_user;
-- 
2.7.4

