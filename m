Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389B534C476
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhC2HC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:51230 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhC2HCQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:16 -0400
IronPort-SDR: EJaaua1nskb/FDjXSosaY7luUJu+xGbC5A1lyuvnzaia3EUfNB/GCq+4217CWIhmsTQabQHIM5
 WH+dacPKcalg==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191590442"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191590442"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:14 -0700
IronPort-SDR: LXapwTj3fBpewncVdeeD5ycCdcXCyMFSduT2ozsnrMCqxVtwVhGErdqBZpI80PB3IGR8ZEjzrl
 MAqU205pkSZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677442"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:05 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 10/27] perf parse-events: Create two hybrid raw events
Date:   Mon, 29 Mar 2021 15:00:29 +0800
Message-Id: <20210329070046.8815-11-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, same raw event is possible to be available on
both cpu_core pmu and cpu_atom pmu. So it's supported to create
two raw events for one event encoding.

  # ./perf stat -e r3c -a -vv -- sleep 1
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
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4
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
    type                             10
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
  perf_event_attr:
    type                             10
    size                             120
    config                           0x3c
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 21
  ------------------------------------------------------------

  ...

  ------------------------------------------------------------
  perf_event_attr:
    type                             10
    size                             120
    config                           0x3c
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
  r3c: 0: 295983 1001500321 1001500321
  r3c: 1: 66453 1001536385 1001536385
  r3c: 2: 156191 1001559687 1001559687
  r3c: 3: 177709 1001590937 1001590937
  r3c: 4: 110819 1001674167 1001674167
  r3c: 5: 368516 1001693927 1001693927
  r3c: 6: 185745 1001782896 1001782896
  r3c: 7: 735332 1001567982 1001567982
  r3c: 8: 1783115 1001595406 1001595406
  r3c: 9: 90088 1001606000 1001606000
  r3c: 10: 409253 1001697624 1001697624
  r3c: 11: 2942563 1001721371 1001721371
  r3c: 12: 100495 1001740753 1001740753
  r3c: 13: 62970 1001769269 1001769269
  r3c: 14: 201978 1001799810 1001799810
  r3c: 15: 1401633 1001829314 1001829314
  r3c: 0: 328088 1001962968 1001962968
  r3c: 1: 257037 1001990202 1001990202
  r3c: 2: 168703 1002065267 1002065267
  r3c: 3: 187959 1002115120 1002115120
  r3c: 4: 126987 1002151672 1002151672
  r3c: 5: 79831 1002202614 1002202614
  r3c: 6: 72101 1002214094 1002214094
  r3c: 7: 442006 1002248710 1002248710
  r3c: 9088843 16026665849 16026665849
  r3c: 1662712 8016950647 8016950647

   Performance counter stats for 'system wide':

           9,088,843      cpu_core/r3c/
           1,662,712      cpu_atom/r3c/

         1.003722876 seconds time elapsed

type 4 is cpu_core pmu type.
type 10 is cpu_atom pmu type.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - Raw event creation is moved to parse-events-hybrid.c.

 tools/perf/util/parse-events-hybrid.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index ff2909bfbf86..8a630cbab8f3 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -74,6 +74,41 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
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
@@ -91,6 +126,9 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 	if (attr->type != PERF_TYPE_RAW) {
 		return add_hw_hybrid(parse_state, list, attr, name,
 				     config_terms);
+	} else {
+		return add_raw_hybrid(parse_state, list, attr, name,
+				      config_terms);
 	}
 
 	return -1;
-- 
2.17.1

