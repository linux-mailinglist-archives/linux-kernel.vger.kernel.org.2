Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061F834C473
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhC2HCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:51195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhC2HCF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:05 -0400
IronPort-SDR: HLQngfYuk2aWW5kBlmY+YCpAau0uFhqyrbsMNOT1UfHf7k1aqF+TXMOYrUbyT2ojJKg1gj22nk
 Cl6DlCQw30RA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191590435"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191590435"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:05 -0700
IronPort-SDR: GfwMcmbTv+f1eXnsTb9wvpA1mFMEkS1z6T4E9hyMwLjZC6RZ5vj1FDsLyvZQe0x+vR/9qrwkEY
 U9oa445D8Qog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677402"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:02 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>, hardware@vger.kernel.org
Subject: [PATCH v3 09/27] perf parse-events: Create two hybrid cache events
Date:   Mon, 29 Mar 2021 15:00:28 +0800
Message-Id: <20210329070046.8815-10-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cache events, they have pre-defined configs. The kernel needs
to know where the cache event comes from (e.g. from cpu_core pmu
or from cpu_atom pmu). But the perf type 'PERF_TYPE_HW_CACHE'
can't carry pmu information.

So the kernel introduces a new type 'PERF_TYPE_HW_CACHE_PMU'.

The new attr.config layout for PERF_TYPE_HW_CACHE_PMU is

0xDD00CCBBAA
AA: hardware cache ID
BB: hardware cache op ID
CC: hardware cache op result ID
DD: PMU type ID

Similar as hardware event, PMU type ID is retrieved from sysfs.

When enabling a hybrid cache event without specified pmu, such as,
'perf stat -e L1-dcache-loads -a', two events are created
automatically. One is for atom, the other is for core.

  # ./perf stat -e L1-dcache-loads -vv -a -- sleep 1
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
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4
  ------------------------------------------------------------

  ......

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
  sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 21
  ------------------------------------------------------------

  ......

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
  sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
  L1-dcache-loads: 0: 12071 1001549888 1001549888
  L1-dcache-loads: 1: 12704 1001602818 1001602818
  L1-dcache-loads: 2: 21560 1001687258 1001687258
  L1-dcache-loads: 3: 8104 1001727825 1001727825
  L1-dcache-loads: 4: 7855 1001738995 1001738995
  L1-dcache-loads: 5: 7714 1001766241 1001766241
  L1-dcache-loads: 6: 7704 1001790333 1001790333
  L1-dcache-loads: 7: 58026 1001826950 1001826950
  L1-dcache-loads: 8: 107639 1001641286 1001641286
  L1-dcache-loads: 9: 67013 1001682357 1001682357
  L1-dcache-loads: 10: 17137 1001700068 1001700068
  L1-dcache-loads: 11: 86449 1001696907 1001696907
  L1-dcache-loads: 12: 7723 1001716599 1001716599
  L1-dcache-loads: 13: 10211 1001743285 1001743285
  L1-dcache-loads: 14: 13023 1001765343 1001765343
  L1-dcache-loads: 15: 8991 1001788673 1001788673
  L1-dcache-loads: 0: 240163 1001800830 1001800830
  L1-dcache-loads: 1: 7454 1001773983 1001773983
  L1-dcache-loads: 2: 32323 1001686339 1001686339
  L1-dcache-loads: 3: 11039 1001732430 1001732430
  L1-dcache-loads: 4: 52867 1001753753 1001753753
  L1-dcache-loads: 5: 7481 1001756879 1001756879
  L1-dcache-loads: 6: 7471 1001814616 1001814616
  L1-dcache-loads: 7: 29627 1001815092 1001815092
  L1-dcache-loads: 453924 16027424826 16027424826
  L1-dcache-loads: 388425 8014133922 8014133922

   Performance counter stats for 'system wide':

             453,924      cpu_core/L1-dcache-loads/
             388,425      cpu_atom/L1-dcache-loads/

         1.003644499 seconds time elapsed

type 7 is PERF_TYPE_HW_CACHE_PMU.
0x4 in 0x400000000 indicates the cpu_core pmu.
0xa in 0xa00000000 indicates the cpu_atom pmu.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - Hybrid cache event creation is moved to parse-events-hybrid.c.

 tools/perf/util/parse-events-hybrid.c | 23 +++++++++++++++++++++++
 tools/perf/util/parse-events-hybrid.h |  5 +++++
 tools/perf/util/parse-events.c        |  8 ++++++++
 3 files changed, 36 insertions(+)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index bd48563596e0..ff2909bfbf86 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -95,3 +95,26 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 
 	return -1;
 }
+
+int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
+				   struct perf_event_attr *attr, char *name,
+				   struct list_head *config_terms,
+				   bool *hybrid)
+{
+	struct perf_pmu *pmu;
+	int ret;
+
+	*hybrid = false;
+	if (!perf_pmu__has_hybrid())
+		return 0;
+
+	*hybrid = true;
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		ret = create_event_hybrid(PERF_TYPE_HW_CACHE_PMU, idx, list,
+					  attr, name, config_terms, pmu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/parse-events-hybrid.h
index d81a76978480..9ad33cd0cef4 100644
--- a/tools/perf/util/parse-events-hybrid.h
+++ b/tools/perf/util/parse-events-hybrid.h
@@ -14,4 +14,9 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 				     char *name, struct list_head *config_terms,
 				     bool *hybrid);
 
+int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
+				   struct perf_event_attr *attr, char *name,
+				   struct list_head *config_terms,
+				   bool *hybrid);
+
 #endif /* __PERF_PARSE_EVENTS_HYBRID_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1bbd0ba92ba7..3692fa3c964a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -458,6 +458,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 	int cache_type = -1, cache_op = -1, cache_result = -1;
 	char *op_result[2] = { op_result1, op_result2 };
 	int i, n;
+	bool hybrid;
 
 	/*
 	 * No fallback - if we cannot get a clear cache type
@@ -517,6 +518,13 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 		if (get_config_terms(head_config, &config_terms))
 			return -ENOMEM;
 	}
+
+	i = parse_events__add_cache_hybrid(list, idx, &attr,
+					   config_name ? : name, &config_terms,
+					   &hybrid);
+	if (hybrid)
+		return i;
+
 	return add_event(list, idx, &attr, config_name ? : name, &config_terms);
 }
 
-- 
2.17.1

