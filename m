Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF793313D21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhBHSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:20:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:27508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234094AbhBHPp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:45:27 -0500
IronPort-SDR: IFFgjaReJtVYMJz3f9IdDKr1fbHTzsI4a6O9ZNGzu8QbYVctXQTiqYQ6Wb9tQY9pNe2C2B/tib
 HS/oyI6/QTSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874633"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: yde6U8lU1kE08M/PM2PsJTjlFWapCiPOsB7UMO2OklB7UAYNp1eV1O+ceu19RoMqAGbBcfZNty
 LEnXSk3Uo+Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820934"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 46/49] perf stat: Filter out unmatched aggregation for hybrid event
Date:   Mon,  8 Feb 2021 07:25:43 -0800
Message-Id: <1612797946-18784-47-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

perf-stat has supported some aggregation modes, such as --per-core,
--per-socket and etc. While for hybrid event, it may only available
on part of cpus. So for --per-core, we need to filter out the
unavailable cores, for --per-socket, filter out the unavailable
sockets, and so on.

Before:

root@otcpl-adl-s-2:~# ./perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0           2            311,114      cycles [cpu_core]
S0-D0-C4           2             59,784      cycles [cpu_core]
S0-D0-C8           2            121,287      cycles [cpu_core]
S0-D0-C12          2          2,690,245      cycles [cpu_core]
S0-D0-C16          2          2,060,545      cycles [cpu_core]
S0-D0-C20          2          3,632,251      cycles [cpu_core]
S0-D0-C24          2            775,736      cycles [cpu_core]
S0-D0-C28          2            742,020      cycles [cpu_core]
S0-D0-C32          0      <not counted>      cycles [cpu_core]
S0-D0-C33          0      <not counted>      cycles [cpu_core]
S0-D0-C34          0      <not counted>      cycles [cpu_core]
S0-D0-C35          0      <not counted>      cycles [cpu_core]
S0-D0-C36          0      <not counted>      cycles [cpu_core]
S0-D0-C37          0      <not counted>      cycles [cpu_core]
S0-D0-C38          0      <not counted>      cycles [cpu_core]
S0-D0-C39          0      <not counted>      cycles [cpu_core]

       1.001779842 seconds time elapsed

After:

root@otcpl-adl-s-2:~# ./perf stat --per-core -e cpu_core/cycles/ -a -- sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0           2          1,088,230      cycles [cpu_core]
S0-D0-C4           2             57,228      cycles [cpu_core]
S0-D0-C8           2             98,327      cycles [cpu_core]
S0-D0-C12          2          2,741,955      cycles [cpu_core]
S0-D0-C16          2          2,090,432      cycles [cpu_core]
S0-D0-C20          2          3,192,108      cycles [cpu_core]
S0-D0-C24          2          2,910,752      cycles [cpu_core]
S0-D0-C28          2            388,696      cycles [cpu_core]

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stat-display.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 21a3f80..fa11572 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -630,6 +630,20 @@ static void aggr_cb(struct perf_stat_config *config,
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
@@ -643,6 +657,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
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
2.7.4

