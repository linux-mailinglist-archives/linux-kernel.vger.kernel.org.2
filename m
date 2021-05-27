Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4343928F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhE0H4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:56:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:39420 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234508AbhE0H4M (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:56:12 -0400
IronPort-SDR: 2bCg3oxhXb2fDAoJke+/2vorZZjD0vyA8BHkhf0jhbiJlmaHsQ9iO5LIZGvFKJXtNBPbf/WiZx
 GI/P24AqUCig==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288262834"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288262834"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:40 -0700
IronPort-SDR: XbNPyHGHats2Ryf6vLWLbcpcHKU3dJslNyaxpsX7DigozW65Z1DKgzrgD6v3T85neO7U0LariF
 Jl/SW3u5G8eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547586545"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 00:54:37 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 3/8] perf tools: Support pmu prefix for mem-store event
Date:   Thu, 27 May 2021 08:16:05 +0800
Message-Id: <20210527001610.10553-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527001610.10553-1-yao.jin@linux.intel.com>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For enabling mem-store event, it doesn't need an auxiliary event.
So just build an event name string with the pmu prefix.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - New in v2.

 tools/perf/arch/x86/util/mem-events.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index f9e444a4fe70..5214370ca4e4 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -5,6 +5,7 @@
 
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
+static char mem_stores_name[100];
 
 #define MEM_LOADS_AUX		0x8203
 #define MEM_LOADS_AUX_NAME     "{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P"
@@ -13,7 +14,7 @@ static bool mem_loads_name__init;
 
 static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
-	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
+	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
 	E(NULL,			NULL,				NULL),
 };
 
@@ -66,5 +67,14 @@ char *perf_mem_events__name(int i, char *pmu_name)
 		return mem_loads_name;
 	}
 
+	if (i == PERF_MEM_EVENTS__STORE) {
+		if (!pmu_name)
+			pmu_name = (char *)"cpu";
+
+		scnprintf(mem_stores_name, sizeof(mem_stores_name),
+			  e->name, pmu_name);
+		return mem_stores_name;
+	}
+
 	return (char *)e->name;
 }
-- 
2.17.1

