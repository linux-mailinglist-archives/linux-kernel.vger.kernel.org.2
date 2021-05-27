Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06133928F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhE0H4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:56:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:39405 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234785AbhE0H4K (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:56:10 -0400
IronPort-SDR: s7e0hZ733MloFJrRFAzm6yJRmVX2oQdhsWd/JDAxnIWf23/02IV81ol2AJauDgcBIf5ezhCF+X
 TB7eidTqeZTg==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288262817"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288262817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:34 -0700
IronPort-SDR: b6NHUZEPTxBCG2Pthb8OR2kJ9TJjq7ZfoiPZBJbXuoUaLtVniYnCxkurQrlStnSs3vfJTCf4CC
 3AXz1+QbijRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547586505"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 00:54:32 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/8] perf tools: Check mem-loads auxiliary event
Date:   Thu, 27 May 2021 08:16:03 +0800
Message-Id: <20210527001610.10553-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527001610.10553-1-yao.jin@linux.intel.com>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some platforms, an auxiliary event has to be enabled
simultaneously with the load latency event.

For Alderlake, the auxiliary event is created in "cpu_core" pmu.

So first we need to check the existing of "cpu_core" pmu
and then check if this pmu has auxiliary event.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - No change.

 tools/perf/arch/x86/util/mem-events.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 588110fd8904..e79232e3f2a0 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -11,8 +11,13 @@ static bool mem_loads_name__init;
 
 bool is_mem_loads_aux_event(struct evsel *leader)
 {
-	if (!pmu_have_event("cpu", "mem-loads-aux"))
-		return false;
+	if (perf_pmu__find("cpu")) {
+		if (!pmu_have_event("cpu", "mem-loads-aux"))
+			return false;
+	} else if (perf_pmu__find("cpu_core")) {
+		if (!pmu_have_event("cpu_core", "mem-loads-aux"))
+			return false;
+	}
 
 	return leader->core.attr.config == MEM_LOADS_AUX;
 }
-- 
2.17.1

