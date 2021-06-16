Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00F13A92A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhFPGdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:33:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:61585 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhFPGdO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:33:14 -0400
IronPort-SDR: 4231z6lXhQnNK0WDmSloWIi7iRslYNNpWfrl1Q3KuITB2lnrj+IH+CXLOeQZ5O/vSu+05plmPn
 sIuXV0QZ3CzQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206081980"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="206081980"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 23:31:08 -0700
IronPort-SDR: S7oKWZsrLomh6CXYSo/b5nvAOewFNBsUi2PnpKEYjDIAwVepBbKTOnx33wY/nIm0oXHUdVzkXh
 1Fjcdy+nebjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="471912867"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2021 23:31:05 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Merge uncore events by default for hybrid platform
Date:   Wed, 16 Jun 2021 14:30:04 +0800
Message-Id: <20210616063004.2824-1-yao.jin@linux.intel.com>
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

Of course, we also keep the '--no-merge' still works for uncore events.

  # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ --no-merge true

   Performance counter stats for 'system wide':

               1,952      uncore_arb_0/event=0x81,umask=0x1/
               1,921      uncore_arb_1/event=0x81,umask=0x1/
                   0      uncore_arb_0/event=0x84,umask=0x1/
                   0      uncore_arb_1/event=0x84,umask=0x1/

         0.000575536 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c      |  3 ---
 tools/perf/util/stat-display.c | 29 +++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 7 deletions(-)

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
index b759dfd633b4..c6070f4684ca 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -595,6 +595,19 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 	}
 }
 
+static bool is_uncore(struct evsel *evsel)
+{
+	struct perf_pmu *pmu;
+
+	if (evsel->pmu_name) {
+		pmu = perf_pmu__find(evsel->pmu_name);
+		if (pmu)
+			return pmu->is_uncore;
+	}
+
+	return false;
+}
+
 static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
 			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
 				       bool first),
@@ -603,10 +616,18 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
 	if (counter->merged_stat)
 		return false;
 	cb(config, counter, data, true);
-	if (config->no_merge)
-		uniquify_event_name(counter);
-	else if (counter->auto_merge_stats)
-		collect_all_aliases(config, counter, cb, data);
+	if (perf_pmu__has_hybrid()) {
+		if (config->no_merge || !is_uncore(counter))
+			uniquify_event_name(counter);
+		else if (counter->auto_merge_stats)
+			collect_all_aliases(config, counter, cb, data);
+	} else {
+		if (config->no_merge)
+			uniquify_event_name(counter);
+		else if (counter->auto_merge_stats)
+			collect_all_aliases(config, counter, cb, data);
+	}
+
 	return true;
 }
 
-- 
2.17.1

