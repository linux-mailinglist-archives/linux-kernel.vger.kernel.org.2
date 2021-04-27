Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0EE36BFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhD0HEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:3195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234970AbhD0HEQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:16 -0400
IronPort-SDR: xlkCtSRwbGAmfme1DJbQL69gT+HQyPP3Og97uASLSNr+uwH3Zc0QFMucCzbiGLRAbz2dHGnmVY
 A7x6tYK+duLA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175944201"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="175944201"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:34 -0700
IronPort-SDR: Q7dibpEPQlLBSmaL+BMqr/n70HfBZCmMj2kx1LaI6Fv+aBu6h0N4nznswqH3viugOy4WICh0uJ
 Wc621I4UG5Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506693"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:31 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 09/26] perf parse-events: Create two hybrid cache events
Date:   Tue, 27 Apr 2021 15:01:22 +0800
Message-Id: <20210427070139.25256-10-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cache events, they have pre-defined configs. The kernel needs
to know where the cache event comes from (e.g. from cpu_core pmu
or from cpu_atom pmu). But the perf type PERF_TYPE_HW_CACHE
can't carry pmu information.

Now the type PERF_TYPE_HW_CACHE is extended to be PMU aware type.
The PMU type ID is stored at attr.config[63:32].

When enabling a hybrid cache event without specified pmu, such as,
'perf stat -e LLC-loads -a', two events are created
automatically. One is for atom, the other is for core.

  # perf stat -e LLC-loads -a -vv -- sleep 1
  Control descriptor is not initialized
  ------------------------------------------------------------
  perf_event_attr:
    type                             3
    size                             120
    config                           0x400000002
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
  ------------------------------------------------------------
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             3
    size                             120
    config                           0x400000002
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 19
  ------------------------------------------------------------
  perf_event_attr:
    type                             3
    size                             120
    config                           0x800000002
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8 = 20
  ------------------------------------------------------------
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             3
    size                             120
    config                           0x800000002
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
  LLC-loads: 0: 1507 1001800280 1001800280
  LLC-loads: 1: 666 1001812250 1001812250
  LLC-loads: 2: 3353 1001813453 1001813453
  LLC-loads: 3: 514 1001848795 1001848795
  LLC-loads: 4: 627 1001952832 1001952832
  LLC-loads: 5: 4399 1001451154 1001451154
  LLC-loads: 6: 1240 1001481052 1001481052
  LLC-loads: 7: 478 1001520348 1001520348
  LLC-loads: 8: 691 1001551236 1001551236
  LLC-loads: 9: 310 1001578945 1001578945
  LLC-loads: 10: 1018 1001594354 1001594354
  LLC-loads: 11: 3656 1001622355 1001622355
  LLC-loads: 12: 882 1001661416 1001661416
  LLC-loads: 13: 506 1001693963 1001693963
  LLC-loads: 14: 3547 1001721013 1001721013
  LLC-loads: 15: 1399 1001734818 1001734818
  LLC-loads: 0: 1314 1001793826 1001793826
  LLC-loads: 1: 2857 1001752764 1001752764
  LLC-loads: 2: 646 1001830694 1001830694
  LLC-loads: 3: 1612 1001864861 1001864861
  LLC-loads: 4: 2244 1001912381 1001912381
  LLC-loads: 5: 1255 1001943889 1001943889
  LLC-loads: 6: 4624 1002021109 1002021109
  LLC-loads: 7: 2703 1001959302 1001959302
  LLC-loads: 24793 16026838264 16026838264
  LLC-loads: 17255 8015078826 8015078826

   Performance counter stats for 'system wide':

              24,793      cpu_core/LLC-loads/
              17,255      cpu_atom/LLC-loads/

         1.001970988 seconds time elapsed

0x4 in 0x400000002 indicates the cpu_core pmu.
0x8 in 0x800000002 indicates the cpu_atom pmu.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v5 - v6:
 - No change.

v4:
 - Use PERF_TYPE_HW_CACHE (v3 uses PERF_TYPE_HW_CACHE_PMU)
 - Define 'ret' variable for return value.

v3:
 - Raw event creation is moved to parse-events-hybrid.c.

 tools/perf/util/parse-events-hybrid.c | 23 +++++++++++++++++++++++
 tools/perf/util/parse-events-hybrid.h |  5 +++++
 tools/perf/util/parse-events.c        | 10 +++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 8fd7f19a9865..7a7e065d2b5f 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -98,3 +98,26 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 
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
+		ret = create_event_hybrid(PERF_TYPE_HW_CACHE, idx, list,
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
index 9109f8b03fe7..c228bf5c7d88 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -460,7 +460,8 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 	char name[MAX_NAME_LEN], *config_name;
 	int cache_type = -1, cache_op = -1, cache_result = -1;
 	char *op_result[2] = { op_result1, op_result2 };
-	int i, n;
+	int i, n, ret;
+	bool hybrid;
 
 	/*
 	 * No fallback - if we cannot get a clear cache type
@@ -520,6 +521,13 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 		if (get_config_terms(head_config, &config_terms))
 			return -ENOMEM;
 	}
+
+	ret = parse_events__add_cache_hybrid(list, idx, &attr,
+					     config_name ? : name, &config_terms,
+					     &hybrid);
+	if (hybrid)
+		return ret;
+
 	return add_event(list, idx, &attr, config_name ? : name, &config_terms);
 }
 
-- 
2.17.1

