Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1E336CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhCKHJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231669AbhCKHI4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:56 -0500
IronPort-SDR: JN/R7DUWXXUcyY0T+/Q2iWAJnS9RvZEOP7J8AKANRzT44JY8lDoO1oqSoG+k0Bl1FWYXML9sPt
 ACd+CGsv/9rQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246080"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246080"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:55 -0800
IronPort-SDR: sYISkTII7BhqcvDnSM45wXvfEIBO48MNW0Eb5OcDVuKSJwEtU+b6JHohWCwxyjlaU7zEQdkDOM
 /IMXItY2Gs3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937945"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:53 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 15/27] perf stat: Filter out unmatched aggregation for hybrid event
Date:   Thu, 11 Mar 2021 15:07:30 +0800
Message-Id: <20210311070742.9318-16-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf-stat has supported some aggregation modes, such as --per-core,
--per-socket and etc. While for hybrid event, it may only available
on part of cpus. So for --per-core, we need to filter out the
unavailable cores, for --per-socket, filter out the unavailable
sockets, and so on.

Before:

  root@ssp-pwrt-002:~# ./perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1

   Performance counter stats for 'system wide':

  S0-D0-C0           2      1,604,426,524      cpu_core/cycles/
  S0-D0-C4           2      1,604,408,224      cpu_core/cycles/
  S0-D0-C8           2      1,605,995,644      cpu_core/cycles/
  S0-D0-C12          2      1,628,056,554      cpu_core/cycles/
  S0-D0-C16          2      1,611,488,734      cpu_core/cycles/
  S0-D0-C20          2      1,616,314,761      cpu_core/cycles/
  S0-D0-C24          2      1,603,558,295      cpu_core/cycles/
  S0-D0-C28          2      1,603,541,128      cpu_core/cycles/
  S0-D0-C32          0      <not counted>      cpu_core/cycles/
  S0-D0-C33          0      <not counted>      cpu_core/cycles/
  S0-D0-C34          0      <not counted>      cpu_core/cycles/
  S0-D0-C35          0      <not counted>      cpu_core/cycles/
  S0-D0-C36          0      <not counted>      cpu_core/cycles/
  S0-D0-C37          0      <not counted>      cpu_core/cycles/
  S0-D0-C38          0      <not counted>      cpu_core/cycles/
  S0-D0-C39          0      <not counted>      cpu_core/cycles/

After:

  root@ssp-pwrt-002:~# ./perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1

   Performance counter stats for 'system wide':

  S0-D0-C0           2      1,621,781,943      cpu_core/cycles/
  S0-D0-C4           2      1,621,755,088      cpu_core/cycles/
  S0-D0-C8           2      1,604,276,920      cpu_core/cycles/
  S0-D0-C12          2      1,603,446,963      cpu_core/cycles/
  S0-D0-C16          2      1,604,231,725      cpu_core/cycles/
  S0-D0-C20          2      1,603,435,286      cpu_core/cycles/
  S0-D0-C24          2      1,603,387,250      cpu_core/cycles/
  S0-D0-C28          2      1,604,173,183      cpu_core/cycles/

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stat-display.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ed37d8e7ea1a..2db7c36a03ad 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -634,6 +634,20 @@ static void aggr_cb(struct perf_stat_config *config,
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
@@ -647,6 +661,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	double uval;
 
 	ad.id = id = config->aggr_map->map[s];
+
+	if (perf_pmu__hybrid_exist() &&
+	    !aggr_id_hybrid_matched(config, counter, id)) {
+		return;
+	}
+
 	ad.val = ad.ena = ad.run = 0;
 	ad.nr = 0;
 	if (!collect_data(config, counter, aggr_cb, &ad))
-- 
2.17.1

