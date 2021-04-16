Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD13621B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhDPOHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:07:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:23063 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236261AbhDPOHL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:07:11 -0400
IronPort-SDR: gB5ee4AWjTU32yexzEGDHCkoxD3Brvyte8BkJW332YKbfHuqyTy9r/Hvu9b/5bRAlndKInX2Bk
 3y9XInE7aZ+w==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854300"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854300"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:06:46 -0700
IronPort-SDR: yCFaOomamjkkxOHlADqP6b4GFkTJT25RDUZLGdF6mEPu3NLXCGX8Xt1vZFeTu2BCdoD9ExJvEs
 FKojVjbqjXKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766736"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:06:43 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 10/25] perf parse-events: Create two hybrid raw events
Date:   Fri, 16 Apr 2021 22:05:02 +0800
Message-Id: <20210416140517.18206-11-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, same raw event is possible to be available
on both cpu_core pmu and cpu_atom pmu. It's supported to create
two raw events for one event encoding. For raw events, the
attr.type is PMU type.

  # perf stat -e r3c -a -vv -- sleep 1
  Control descriptor is not initialized
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             120
    config                           0x3c
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
    type                             4
    size                             120
    config                           0x3c
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 19
  ------------------------------------------------------------
  perf_event_attr:
    type                             8
    size                             120
    config                           0x3c
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
    type                             8
    size                             120
    config                           0x3c
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
  r3c: 0: 434449 1001412521 1001412521
  r3c: 1: 173162 1001482031 1001482031
  r3c: 2: 231710 1001524974 1001524974
  r3c: 3: 110012 1001563523 1001563523
  r3c: 4: 191517 1001593221 1001593221
  r3c: 5: 956458 1001628147 1001628147
  r3c: 6: 416969 1001715626 1001715626
  r3c: 7: 1047527 1001596650 1001596650
  r3c: 8: 103877 1001633520 1001633520
  r3c: 9: 70571 1001637898 1001637898
  r3c: 10: 550284 1001714398 1001714398
  r3c: 11: 1257274 1001738349 1001738349
  r3c: 12: 107797 1001801432 1001801432
  r3c: 13: 67471 1001836281 1001836281
  r3c: 14: 286782 1001923161 1001923161
  r3c: 15: 815509 1001952550 1001952550
  r3c: 0: 95994 1002071117 1002071117
  r3c: 1: 105570 1002142438 1002142438
  r3c: 2: 115921 1002189147 1002189147
  r3c: 3: 72747 1002238133 1002238133
  r3c: 4: 103519 1002276753 1002276753
  r3c: 5: 121382 1002315131 1002315131
  r3c: 6: 80298 1002248050 1002248050
  r3c: 7: 466790 1002278221 1002278221
  r3c: 6821369 16026754282 16026754282
  r3c: 1162221 8017758990 8017758990

   Performance counter stats for 'system wide':

           6,821,369      cpu_core/r3c/
           1,162,221      cpu_atom/r3c/

         1.002289965 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v4:
 - Directly return add_raw_hybrid().

v3:
 - Raw event creation is moved to parse-events-hybrid.c.

 tools/perf/util/parse-events-hybrid.c | 38 ++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 7a7e065d2b5f..e27b747080e1 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -77,6 +77,41 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
 	return 0;
 }
 
+static int create_raw_event_hybrid(int *idx, struct list_head *list,
+				   struct perf_event_attr *attr, char *name,
+				   struct list_head *config_terms,
+				   struct perf_pmu *pmu)
+{
+	struct evsel *evsel;
+
+	attr->type = pmu->type;
+	evsel = parse_events__add_event_hybrid(list, idx, attr, name,
+					       pmu, config_terms);
+	if (evsel)
+		evsel->pmu_name = strdup(pmu->name);
+	else
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int add_raw_hybrid(struct parse_events_state *parse_state,
+			  struct list_head *list, struct perf_event_attr *attr,
+			  char *name, struct list_head *config_terms)
+{
+	struct perf_pmu *pmu;
+	int ret;
+
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		ret = create_raw_event_hybrid(&parse_state->idx, list, attr,
+					      name, config_terms, pmu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 				     struct list_head *list,
 				     struct perf_event_attr *attr,
@@ -96,7 +131,8 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 				     config_terms);
 	}
 
-	return -1;
+	return add_raw_hybrid(parse_state, list, attr, name,
+			      config_terms);
 }
 
 int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
-- 
2.17.1

