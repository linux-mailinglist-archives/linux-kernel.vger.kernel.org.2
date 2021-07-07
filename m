Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8DB3BE2DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhGGGAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 02:00:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:58040 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhGGGAu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 02:00:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="206231714"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="206231714"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 22:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="461240118"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2021 22:58:07 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf stat: Merge uncore events by default for hybrid platform
Date:   Wed,  7 Jul 2021 13:56:52 +0800
Message-Id: <20210707055652.962-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, by default stat aggregates and reports the event counts
per pmu. For example,

  # perf stat -e cycles -a true

   Performance counter stats for 'system wide':

           1,400,445      cpu_core/cycles/
             680,881      cpu_atom/cycles/

         0.001770773 seconds time elapsed

While for uncore events, that's not a suitable method. Uncore has nothing
to do with hybrid. So for uncore events, we aggregate event counts from all
PMUs and report the counts without PMUs.

Before:

  # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ -a true

   Performance counter stats for 'system wide':

               2,058      uncore_arb_0/event=0x81,umask=0x1/
               2,028      uncore_arb_1/event=0x81,umask=0x1/
                   0      uncore_arb_0/event=0x84,umask=0x1/
                   0      uncore_arb_1/event=0x84,umask=0x1/

         0.000614498 seconds time elapsed

After:

  # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ -a true

   Performance counter stats for 'system wide':

               3,996      arb/event=0x81,umask=0x1/
                   0      arb/event=0x84,umask=0x1/

         0.000630046 seconds time elapsed

Of course, we also keep the '--no-merge' working for uncore events.

  # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ --no-merge true

   Performance counter stats for 'system wide':

               1,952      uncore_arb_0/event=0x81,umask=0x1/
               1,921      uncore_arb_1/event=0x81,umask=0x1/
                   0      uncore_arb_0/event=0x84,umask=0x1/
                   0      uncore_arb_1/event=0x84,umask=0x1/

         0.000575536 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - Use evsel__find_pmu() to find uncore pmu.
 - Create hybrid_uniquify() to check if uniquify the event name for hybrid.

 tools/perf/builtin-stat.c      |  3 ---
 tools/perf/util/stat-display.c | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f9f74a514315..b67a44982b61 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2442,9 +2442,6 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__check_cpu_maps(evsel_list);
 
-	if (perf_pmu__has_hybrid())
-		stat_config.no_merge = true;
-
 	/*
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index c588a6b7a8db..87f77016b9cc 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -593,6 +593,18 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 	}
 }
 
+static bool is_uncore(struct evsel *evsel)
+{
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+	return pmu && pmu->is_uncore;
+}
+
+static bool hybrid_uniquify(struct evsel *evsel)
+{
+	return perf_pmu__has_hybrid() && !is_uncore(evsel);
+}
+
 static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
 			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
 				       bool first),
@@ -601,7 +613,7 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
 	if (counter->merged_stat)
 		return false;
 	cb(config, counter, data, true);
-	if (config->no_merge)
+	if (config->no_merge || hybrid_uniquify(counter))
 		uniquify_event_name(counter);
 	else if (counter->auto_merge_stats)
 		collect_all_aliases(config, counter, cb, data);
-- 
2.27.0

