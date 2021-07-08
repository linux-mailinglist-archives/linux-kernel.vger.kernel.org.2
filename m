Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42BE3BF39F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 03:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhGHBlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 21:41:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:38895 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhGHBlJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 21:41:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="270538740"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="270538740"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 18:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="457708830"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2021 18:38:23 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/4] perf pmu: Skip invalid hybrid pmu
Date:   Thu,  8 Jul 2021 09:36:58 +0800
Message-Id: <20210708013701.20347-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210708013701.20347-1-yao.jin@linux.intel.com>
References: <20210708013701.20347-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, such as Alderlake, if atom CPUs are offlined,
the kernel still exports the sysfs path '/sys/devices/cpu_atom/' for
'cpu_atom' pmu but the file '/sys/devices/cpu_atom/cpus' is empty,
which indicates this is an invalid pmu.

Need to check and skip the invalid hybrid pmu.

Before:

  # perf list
  ...
  branch-instructions OR cpu_atom/branch-instructions/ [Kernel PMU event]
  branch-instructions OR cpu_core/branch-instructions/ [Kernel PMU event]
  branch-misses OR cpu_atom/branch-misses/           [Kernel PMU event]
  branch-misses OR cpu_core/branch-misses/           [Kernel PMU event]
  bus-cycles OR cpu_atom/bus-cycles/                 [Kernel PMU event]
  bus-cycles OR cpu_core/bus-cycles/                 [Kernel PMU event]
  ...

The cpu_atom events are still displayed even if atom CPUs are offlined.

After:

  # perf list
  ...
  branch-instructions OR cpu_core/branch-instructions/ [Kernel PMU event]
  branch-misses OR cpu_core/branch-misses/           [Kernel PMU event]
  bus-cycles OR cpu_core/bus-cycles/                 [Kernel PMU event]
  ...

Now only cpu_core events are displayed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/pmu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 88c8ecdc60b0..cb20a9f69a04 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -927,6 +927,13 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	LIST_HEAD(format);
 	LIST_HEAD(aliases);
 	__u32 type;
+	bool is_hybrid = perf_pmu__hybrid_mounted(name);
+
+	/*
+	 * Check pmu name for hybrid and the pmu may be invalid in sysfs
+	 */
+	if (!strncmp(name, "cpu_", 4) && !is_hybrid)
+		return NULL;
 
 	/*
 	 * The pmu data we store & need consists of the pmu
@@ -955,7 +962,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->is_uncore = pmu_is_uncore(name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
-	pmu->is_hybrid = perf_pmu__hybrid_mounted(name);
+	pmu->is_hybrid = is_hybrid;
 	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 	pmu_add_sys_aliases(&aliases, pmu);
-- 
2.17.1

