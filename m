Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9C7313C28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhBHSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:03:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:27842 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233999AbhBHPg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:36:27 -0500
IronPort-SDR: T+4Yftaq13M3/B6mm9QIvqNDjQhHfB6X6yb+x4Qg2aaRr1u0ydfX3lt8lzoUiDGEcSDTh8c1Q0
 W5/FdqWTW2Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874622"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874622"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: i/4+WKS/tJop78PTCLykMcQF853OxKd5P8JR3C0a3Ujh1UZkQANFGHF6pa1DoqnIZQ4TsQftiI
 OsLc8gjbWUtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820899"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:36 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 36/49] perf parse-events: Create two hybrid cache events
Date:   Mon,  8 Feb 2021 07:25:33 -0800
Message-Id: <1612797946-18784-37-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

For cache events, they have pre-defined configs. The kernel needs
to know where the cache event comes from (e.g. from cpu_core pmu
or from cpu_atom pmu). But the perf type 'PERF_TYPE_HW_CACHE'
can't carry pmu information.

So the kernel introduces a new type 'PERF_TYPE_HW_CACHE_PMU'.

The new attr.config layout for PERF_TYPE_HW_CACHE_PMU is

 0xDD00CCBBAA
 0xAA: hardware cache ID
 0xBB: hardware cache op ID
 0xCC: hardware cache op result ID
 0xDD: PMU type ID

Similar as hardware event, PMU type ID is retrieved from sysfs.

When enabling a hybrid cache event without specified pmu, such as,
'perf stat -e L1-dcache-loads -a', two events are created
automatically. One is for atom, the other is for core.

root@otcpl-adl-s-2:~# ./perf stat -e L1-dcache-loads -vv -a -- sleep 1
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             7
  size                             120
  config                           0x400000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 8
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid -1  cpu 8  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid -1  cpu 9  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid -1  cpu 10  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid -1  cpu 11  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid -1  cpu 12  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid -1  cpu 13  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid -1  cpu 14  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 19
------------------------------------------------------------
perf_event_attr:
  type                             7
  size                             120
  config                           0xa00000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 20
sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 21
sys_perf_event_open: pid -1  cpu 18  group_fd -1  flags 0x8 = 22
sys_perf_event_open: pid -1  cpu 19  group_fd -1  flags 0x8 = 23
sys_perf_event_open: pid -1  cpu 20  group_fd -1  flags 0x8 = 24
sys_perf_event_open: pid -1  cpu 21  group_fd -1  flags 0x8 = 25
sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 26
sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
L1-dcache-loads: 0: 77398 1001256700 1001256700
L1-dcache-loads: 1: 5286 1001255101 1001255101
L1-dcache-loads: 2: 26432 1001280449 1001280449
L1-dcache-loads: 3: 2853 1001274145 1001274145
L1-dcache-loads: 4: 521391 1001304618 1001304618
L1-dcache-loads: 5: 1231 1001287686 1001287686
L1-dcache-loads: 6: 1237 1001284439 1001284439
L1-dcache-loads: 7: 1384 1001278646 1001278646
L1-dcache-loads: 8: 1238 1001274988 1001274988
L1-dcache-loads: 9: 1225 1001267988 1001267988
L1-dcache-loads: 10: 88066 1001301843 1001301843
L1-dcache-loads: 11: 1243 1001308922 1001308922
L1-dcache-loads: 12: 1231 1001313498 1001313498
L1-dcache-loads: 13: 12880 1001306597 1001306597
L1-dcache-loads: 14: 21244 1001293603 1001293603
L1-dcache-loads: 15: 1225 1001287958 1001287958
L1-dcache-loads: 0: 1244 1001289333 1001289333
L1-dcache-loads: 1: 1361 1001288189 1001288189
L1-dcache-loads: 2: 1226 1001285926 1001285926
L1-dcache-loads: 3: 1226 1001289431 1001289431
L1-dcache-loads: 4: 1239 1001283299 1001283299
L1-dcache-loads: 5: 10500 1001318113 1001318113
L1-dcache-loads: 6: 1226 1001315332 1001315332
L1-dcache-loads: 7: 1226 1001325366 1001325366
L1-dcache-loads: 765564 16020577181 16020577181
L1-dcache-loads: 19248 8010394989 8010394989

 Performance counter stats for 'system wide':

           765,564      L1-dcache-loads
            19,248      L1-dcache-loads

       1.002255760 seconds time elapsed

type 7 is PERF_TYPE_HW_CACHE_PMU.
0x4 in 0x400000000 indicates the cpu_core pmu.
0xa in 0xa00000000 indicates the cpu_atom pmu.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c | 54 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1e767dc..28d356e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -464,6 +464,48 @@ static void config_hybrid_attr(struct perf_event_attr *attr,
 	attr->config = attr->config | ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT);
 }
 
+static int create_hybrid_cache_event(struct list_head *list, int *idx,
+				     struct perf_event_attr *attr, char *name,
+				     struct list_head *config_terms,
+				     struct perf_pmu *pmu)
+{
+	struct evsel *evsel;
+	__u32 type = attr->type;
+	__u64 config = attr->config;
+
+	config_hybrid_attr(attr, PERF_TYPE_HW_CACHE_PMU, pmu->type);
+	evsel = __add_event(list, idx, attr, true, name,
+			    pmu, config_terms, false, NULL);
+	if (evsel)
+		evsel->pmu_name = strdup(pmu->name);
+	else
+		return -ENOMEM;
+
+	attr->type = type;
+	attr->config = config;
+	return 0;
+}
+
+static int add_hybrid_cache(struct list_head *list, int *idx,
+			    struct perf_event_attr *attr, char *name,
+			    struct list_head *config_terms,
+			    bool *hybrid)
+{
+	struct perf_pmu *pmu;
+	int ret;
+
+	*hybrid = false;
+	perf_pmu__for_each_hybrid_pmus(pmu) {
+		*hybrid = true;
+		ret = create_hybrid_cache_event(list, idx, attr, name,
+						config_terms, pmu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int parse_events_add_cache(struct list_head *list, int *idx,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *err,
@@ -474,7 +516,8 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 	char name[MAX_NAME_LEN], *config_name;
 	int cache_type = -1, cache_op = -1, cache_result = -1;
 	char *op_result[2] = { op_result1, op_result2 };
-	int i, n;
+	int i, n, ret;
+	bool hybrid;
 
 	/*
 	 * No fallback - if we cannot get a clear cache type
@@ -534,6 +577,15 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 		if (get_config_terms(head_config, &config_terms))
 			return -ENOMEM;
 	}
+
+	if (!perf_pmu__hybrid_exist())
+		perf_pmu__scan(NULL);
+
+	ret = add_hybrid_cache(list, idx, &attr, config_name ? : name,
+			       &config_terms, &hybrid);
+	if (hybrid)
+		return ret;
+
 	return add_event(list, idx, &attr, config_name ? : name, &config_terms);
 }
 
-- 
2.7.4

