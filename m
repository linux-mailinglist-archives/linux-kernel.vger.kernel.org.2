Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BC368CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbhDWFh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:37:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:9315 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240645AbhDWFhh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:37:37 -0400
IronPort-SDR: Ow5WNCH+XBSUFQO949OYg3D+vyJUt2SvoPxsA/akv1ne2t4xd907QJss//0elm4vAo3uEXKZzb
 Zexh+A3stLPg==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501805"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501805"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:37:01 -0700
IronPort-SDR: p8KnXKkkoM/XRoYOQnQHq621jvZaDZDPlEPvdQzrv5wfDdx5ZMQnDikmgx5ZiR9S0D32qMXXYF
 N0y8SBVfacAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293604"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:36:58 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 09/26] perf parse-events: Create two hybrid cache events
Date:   Fri, 23 Apr 2021 13:35:24 +0800
Message-Id: <20210423053541.12521-10-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
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
v5:
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
index 7c2f644dd613..cc3b8d77c1c1 100644
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

