Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EDB313B99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 18:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhBHRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 12:53:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:27508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233960AbhBHPcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:32:31 -0500
IronPort-SDR: vERitAeSajm4WrARp8pHJ4EePwIlPfZ/RWcNz3mRdB2h/W0xmsr/ico2ibKsJ2Tf829GxFU3KQ
 +8u/N0HWOpmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874623"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874623"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: ttzch8cFWylH7NWHaoZJ+NeYxiWb3vSTdprddBd21ETfLJs20VLbX0hFd1HHWDk6xRTwCilDRO
 HQb9noOQnEHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820906"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:36 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 38/49] perf list: Display pmu prefix for partially supported hybrid cache events
Date:   Mon,  8 Feb 2021 07:25:35 -0800
Message-Id: <1612797946-18784-39-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Part of hardware cache events are only available on one cpu pmu.
For example, 'L1-dcache-load-misses' is only available on cpu_core.
perf list should clearly report this info.

root@otcpl-adl-s-2:~# ./perf list

Before:
  L1-dcache-load-misses                              [Hardware cache event]
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-stores                                   [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  L1-icache-loads                                    [Hardware cache event]
  LLC-load-misses                                    [Hardware cache event]
  LLC-loads                                          [Hardware cache event]
  LLC-store-misses                                   [Hardware cache event]
  LLC-stores                                         [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  dTLB-loads                                         [Hardware cache event]
  dTLB-store-misses                                  [Hardware cache event]
  dTLB-stores                                        [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]
  node-load-misses                                   [Hardware cache event]
  node-loads                                         [Hardware cache event]
  node-store-misses                                  [Hardware cache event]
  node-stores                                        [Hardware cache event]

After:
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-stores                                   [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  LLC-load-misses                                    [Hardware cache event]
  LLC-loads                                          [Hardware cache event]
  LLC-store-misses                                   [Hardware cache event]
  LLC-stores                                         [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  cpu_atom/L1-icache-loads/                          [Hardware cache event]
  cpu_core/L1-dcache-load-misses/                    [Hardware cache event]
  cpu_core/node-load-misses/                         [Hardware cache event]
  cpu_core/node-loads/                               [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  dTLB-loads                                         [Hardware cache event]
  dTLB-store-misses                                  [Hardware cache event]
  dTLB-stores                                        [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]

Now we can clearly see 'L1-dcache-load-misses' is only available
on cpu_core.

If without pmu prefix, it indicates the event is available on both
cpu_core and cpu_atom.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c | 79 +++++++++++++++++++++++++++++++++++++-----
 tools/perf/util/pmu.c          | 11 ++++++
 tools/perf/util/pmu.h          |  2 ++
 3 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index bba7db3..ddf6f79 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2809,7 +2809,7 @@ int is_valid_tracepoint(const char *event_string)
 	return 0;
 }
 
-static bool is_event_supported(u8 type, unsigned config)
+static bool is_event_supported(u8 type, u64 config)
 {
 	bool ret = true;
 	int open_return;
@@ -2929,10 +2929,21 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 
 int print_hwcache_events(const char *event_glob, bool name_only)
 {
-	unsigned int type, op, i, evt_i = 0, evt_num = 0;
-	char name[64];
-	char **evt_list = NULL;
+	unsigned int type, op, i, evt_i = 0, evt_num = 0, npmus;
+	char name[64], new_name[128];
+	char **evt_list = NULL, **evt_pmus = NULL;
 	bool evt_num_known = false;
+	struct perf_pmu *pmu = NULL;
+
+	if (!perf_pmu__hybrid_exist())
+		 perf_pmu__scan(NULL);
+
+	npmus = perf_pmu__hybrid_npmus();
+	if (npmus) {
+		evt_pmus = zalloc(sizeof(char *) * npmus);
+		if (!evt_pmus)
+			goto out_enomem;
+	}
 
 restart:
 	if (evt_num_known) {
@@ -2948,20 +2959,61 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 				continue;
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
+				unsigned int hybrid_supported = 0, j;
+				bool supported;
+
 				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
 				if (event_glob != NULL && !strglobmatch(name, event_glob))
 					continue;
 
-				if (!is_event_supported(PERF_TYPE_HW_CACHE,
-							type | (op << 8) | (i << 16)))
-					continue;
+				if (!perf_pmu__hybrid_exist()) {
+					if (!is_event_supported(PERF_TYPE_HW_CACHE,
+								type | (op << 8) | (i << 16))) {
+						continue;
+					}
+				} else {
+					perf_pmu__for_each_hybrid_pmus(pmu) {
+						if (!evt_num_known) {
+							evt_num++;
+							continue;
+						}
+
+						supported = is_event_supported(
+									PERF_TYPE_HW_CACHE_PMU,
+									type | (op << 8) | (i << 16) |
+									((__u64)pmu->type << PERF_PMU_TYPE_SHIFT));
+						if (supported) {
+							snprintf(new_name, sizeof(new_name), "%s/%s/",
+								 pmu->name, name);
+							evt_pmus[hybrid_supported] = strdup(new_name);
+							hybrid_supported++;
+						}
+					}
+
+					if (hybrid_supported == 0)
+						continue;
+				}
 
 				if (!evt_num_known) {
 					evt_num++;
 					continue;
 				}
 
-				evt_list[evt_i] = strdup(name);
+				if ((hybrid_supported == 0) ||
+				    (hybrid_supported == npmus)) {
+					evt_list[evt_i] = strdup(name);
+					if (npmus > 0) {
+						for (j = 0; j < npmus; j++)
+							zfree(&evt_pmus[j]);
+					}
+				} else {
+					for (j = 0; j < hybrid_supported; j++) {
+						evt_list[evt_i++] = evt_pmus[j];
+						evt_pmus[j] = NULL;
+					}
+					continue;
+				}
+
 				if (evt_list[evt_i] == NULL)
 					goto out_enomem;
 				evt_i++;
@@ -2973,6 +3025,13 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 		evt_num_known = true;
 		goto restart;
 	}
+
+	for (evt_i = 0; evt_i < evt_num; evt_i++) {
+		if (!evt_list[evt_i])
+			break;
+	}
+
+	evt_num = evt_i;
 	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
 	evt_i = 0;
 	while (evt_i < evt_num) {
@@ -2991,6 +3050,10 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 	for (evt_i = 0; evt_i < evt_num; evt_i++)
 		zfree(&evt_list[evt_i]);
 	zfree(&evt_list);
+
+	for (evt_i = 0; evt_i < npmus; evt_i++)
+		zfree(&evt_pmus[evt_i]);
+	zfree(&evt_pmus);
 	return evt_num;
 
 out_enomem:
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ca2fc67..5ebb0da 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1901,3 +1901,14 @@ char *perf_pmu__hybrid_type_to_pmu(const char *type)
 	free(pmu_name);
 	return NULL;;
 }
+
+int perf_pmu__hybrid_npmus(void)
+{
+	struct perf_pmu *pmu;
+	int n = 0;
+
+	perf_pmu__for_each_hybrid_pmus(pmu)
+		n++;
+
+	return n;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index ccffc05..4bd7473 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -143,4 +143,6 @@ static inline bool perf_pmu__hybrid_exist(void)
 	return !list_empty(&perf_pmu__hybrid_pmus);
 }
 
+int perf_pmu__hybrid_npmus(void);
+
 #endif /* __PMU_H */
-- 
2.7.4

