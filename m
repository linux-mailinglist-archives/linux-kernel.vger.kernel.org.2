Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E95368CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbhDWFiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:38:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:9339 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240701AbhDWFhy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:37:54 -0400
IronPort-SDR: bvCdRsNfmXQv3sSR+Y7aK/4aXgOFDN7xTwy52PtwzyBx/dSIJGokflHxRxDVUn4hKhCaAQ+Bg4
 y3PZKM97YcsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501838"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501838"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:37:17 -0700
IronPort-SDR: BTq5gqpjcmWu0r/j5IeRvIPOYHX95ii1yd/rNGy2Lp1pUL5aW5QiGvzRquPVJFoY/CAT8ecXKd
 Yqv8hMcoIohQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293674"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:37:14 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 15/26] perf stat: Filter out unmatched aggregation for hybrid event
Date:   Fri, 23 Apr 2021 13:35:30 +0800
Message-Id: <20210423053541.12521-16-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
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
Co-developed-by: Jiri Olsa <jolsa@redhat.com>
---
v5:
 - Use Jiri's code to filter, which is much simpler than original.

v4:
 - No change.

 tools/perf/util/stat-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5255d78b1c30..06689f128e56 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -661,6 +661,9 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	if (!collect_data(config, counter, aggr_cb, &ad))
 		return;
 
+	if (perf_pmu__has_hybrid() && ad.ena == 0)
+		return;
+
 	nr = ad.nr;
 	ena = ad.ena;
 	run = ad.run;
-- 
2.17.1

