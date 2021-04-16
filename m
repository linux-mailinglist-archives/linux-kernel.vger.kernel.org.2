Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A63621BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbhDPOII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:08:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:23099 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236348AbhDPOHZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:07:25 -0400
IronPort-SDR: 0fOZMKzbKiOe7NkxAV6Zln5iz2X7I0l4zTOg9qfBjkymcrfitXJOdV5VDxJKQWZA74L2J5lLS5
 xgP05q+8OppA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854337"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854337"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:07:01 -0700
IronPort-SDR: YCx63q1A9h0aVW/LAWa0TfKY3Frv4BN2dgfjAfEH72fSRlx8Sc3ZT3c6xDEcS/drcQseptSH2Q
 qeMpMbXrADQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766834"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:06:58 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 15/25] perf stat: Filter out unmatched aggregation for hybrid event
Date:   Fri, 16 Apr 2021 22:05:07 +0800
Message-Id: <20210416140517.18206-16-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
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
v4:
 - No change.

 tools/perf/util/stat-display.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5255d78b1c30..15eafd249e46 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -643,6 +643,20 @@ static void aggr_cb(struct perf_stat_config *config,
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
@@ -656,6 +670,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
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

