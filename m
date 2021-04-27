Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FF536BFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhD0HEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:54937 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236000AbhD0HEc (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:32 -0400
IronPort-SDR: TyyAb6PInmYX1kUJDMLDNeNEZELEL0Pga+w5Hra1D+9DBREgZ10phucTNh6GKZqRvTpGKujntt
 QkiKW2Me3LOg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573022"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573022"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:49 -0700
IronPort-SDR: Ebm2gcgpmbITmMBOOu44AWLxM5IMrCmOQLSNx1zlcvCiWEn7/obdww3+US+p2YBiH4csyWt49a
 YmwZbetA5NxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506920"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:47 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 15/26] perf stat: Filter out unmatched aggregation for hybrid event
Date:   Tue, 27 Apr 2021 15:01:28 +0800
Message-Id: <20210427070139.25256-16-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
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
v6:
 - No change.

v5:
 - Use Jiri's code, which is much simpler than original.

v4:
 - No change.

 tools/perf/util/stat-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 0679129ad05e..a76fff5e7d83 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -667,6 +667,9 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
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

