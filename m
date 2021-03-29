Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A2534C479
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhC2HDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231185AbhC2HCV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:21 -0400
IronPort-SDR: zmHgYKBNaGyrbuwmZfN0DFmIpCxrDQ8NwbqK7Q0nPJHlyn6cu7QiGAi4Rzg9RJq69SsmgVfsHj
 Xwyr5erbMHew==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956274"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956274"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:20 -0700
IronPort-SDR: EX7Z43J1wPKCIg7BdQrp4Gxxgj7zk+MLNufDVI61glmfg/C9pyX6YJq5IfVgExiuY3hILmbLrO
 1Dgs45Vg97dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677502"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:18 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 15/27] perf stat: Filter out unmatched aggregation for hybrid event
Date:   Mon, 29 Mar 2021 15:00:34 +0800
Message-Id: <20210329070046.8815-16-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf-stat has supported some aggregation modes, such as --per-core,
--per-socket and etc. While for hybrid event, it may only available
on part of cpus. So for --per-core, we need to filter out the
unavailable cores, for --per-socket, filter out the unavailable
sockets, and so on.

Before:

  # perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1

   Performance counter stats for 'system wide':

  S0-D0-C0           2            479,530      cpu_core/cycles/
  S0-D0-C4           2            175,007      cpu_core/cycles/
  S0-D0-C8           2            166,240      cpu_core/cycles/
  S0-D0-C12          2            704,673      cpu_core/cycles/
  S0-D0-C16          2            865,835      cpu_core/cycles/
  S0-D0-C20          2          2,958,461      cpu_core/cycles/
  S0-D0-C24          2            163,988      cpu_core/cycles/
  S0-D0-C28          2            164,729      cpu_core/cycles/
  S0-D0-C32          0      <not counted>      cpu_core/cycles/
  S0-D0-C33          0      <not counted>      cpu_core/cycles/
  S0-D0-C34          0      <not counted>      cpu_core/cycles/
  S0-D0-C35          0      <not counted>      cpu_core/cycles/
  S0-D0-C36          0      <not counted>      cpu_core/cycles/
  S0-D0-C37          0      <not counted>      cpu_core/cycles/
  S0-D0-C38          0      <not counted>      cpu_core/cycles/
  S0-D0-C39          0      <not counted>      cpu_core/cycles/

         1.003597211 seconds time elapsed

After:

  # perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1

   Performance counter stats for 'system wide':

  S0-D0-C0           2            210,428      cpu_core/cycles/
  S0-D0-C4           2            444,830      cpu_core/cycles/
  S0-D0-C8           2            435,241      cpu_core/cycles/
  S0-D0-C12          2            423,976      cpu_core/cycles/
  S0-D0-C16          2            859,350      cpu_core/cycles/
  S0-D0-C20          2          1,559,589      cpu_core/cycles/
  S0-D0-C24          2            163,924      cpu_core/cycles/
  S0-D0-C28          2            376,610      cpu_core/cycles/

         1.003621290 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No functional change.

 tools/perf/util/stat-display.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 161826938a00..b7ce3c4ae5a8 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -635,6 +635,20 @@ static void aggr_cb(struct perf_stat_config *config,
 	}
 }
 
+static bool aggr_id_hybrid_matched(struct perf_stat_config *config,
+				   struct evsel *counter, struct aggr_cpu_id id)
+{
+	struct aggr_cpu_id s;
+
+	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
+		s = config->aggr_get_id(config, evsel__cpus(counter), i);
+		if (cpu_map__compare_aggr_cpu_id(s, id))
+			return true;
+	}
+
+	return false;
+}
+
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
 				   char *prefix, bool metric_only,
@@ -648,6 +662,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	double uval;
 
 	ad.id = id = config->aggr_map->map[s];
+
+	if (perf_pmu__has_hybrid() &&
+	    !aggr_id_hybrid_matched(config, counter, id)) {
+		return;
+	}
+
 	ad.val = ad.ena = ad.run = 0;
 	ad.nr = 0;
 	if (!collect_data(config, counter, aggr_cb, &ad))
-- 
2.17.1

