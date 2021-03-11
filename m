Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FC0336CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhCKHJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231640AbhCKHIs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:48 -0500
IronPort-SDR: iZ1JmN6g4yFJJhBHK+h1HUdVKBEvnS5uz9sPswRlm8enWPnwQ07Pt0ThRg/5fpJ7VQxXyGBBwO
 BSdwuegDPJVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246062"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:48 -0800
IronPort-SDR: Gxk3lv1M7uOft691tHsDlTnuL2HHXZaq9/IBMlaDg81FKvQMx3kgyb3Qnr0UMwLvvjCvY2zCf8
 Mkp88jaT/V9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937909"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:46 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 12/27] perf parse-events: Support hybrid raw events
Date:   Thu, 11 Mar 2021 15:07:27 +0800
Message-Id: <20210311070742.9318-13-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, same raw event is possible to be available on
both cpu_core pmu and cpu_atom pmu. So it's supported to create
two raw events for one event encoding.

  root@ssp-pwrt-002:~# ./perf stat -e r3c -a -vv -- sleep 1
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
  sys_perf_event_open: pid -1  cpu 17  group_fd -1  flags 0x8 = 21
  sys_perf_event_open: pid -1  cpu 18  group_fd -1  flags 0x8 = 22
  sys_perf_event_open: pid -1  cpu 19  group_fd -1  flags 0x8 = 23
  sys_perf_event_open: pid -1  cpu 20  group_fd -1  flags 0x8 = 24
  sys_perf_event_open: pid -1  cpu 21  group_fd -1  flags 0x8 = 25
  sys_perf_event_open: pid -1  cpu 22  group_fd -1  flags 0x8 = 26
  sys_perf_event_open: pid -1  cpu 23  group_fd -1  flags 0x8 = 27
  r3c: 0: 807321251 1002093589 1002093589
  r3c: 1: 807321699 1002088203 1002088203
  r3c: 2: 802163010 1002086701 1002086701
  r3c: 3: 802162967 1002080660 1002080660
  r3c: 4: 801769096 1002077047 1002077047
  r3c: 5: 801766174 1002071197 1002071197
  r3c: 6: 804147338 1002065696 1002065696
  r3c: 7: 804141152 1002055345 1002055345
  r3c: 8: 801743651 1002043364 1002043364
  r3c: 9: 801742285 1002036921 1002036921
  r3c: 10: 804083297 1002032502 1002032502
  r3c: 11: 804084735 1002027992 1002027992
  r3c: 12: 804504507 1002026371 1002026371
  r3c: 13: 804504679 1002022466 1002022466
  r3c: 14: 811424953 1002021767 1002021767
  r3c: 15: 811423320 1002021594 1002021594
  r3c: 0: 810883154 1002021654 1002021654
  r3c: 1: 810881069 1002017334 1002017334
  r3c: 2: 810878689 1002014010 1002014010
  r3c: 3: 810876654 1002011516 1002011516
  r3c: 4: 800488244 1002007858 1002007858
  r3c: 5: 800486260 1002003635 1002003635
  r3c: 6: 800483374 1002000384 1002000384
  r3c: 7: 800481011 1001997122 1001997122
  r3c: 12874304114 16032851415 16032851415
  r3c: 6445458455 8016073513 8016073513

   Performance counter stats for 'system wide':

      12,874,304,114      cpu_core/r3c/
       6,445,458,455      cpu_atom/r3c/

         1.002310991 seconds time elapsed

It also supports the raw event inside pmu. Syntax is similar:

cpu_core/<raw event>/
cpu_atom/<raw event>/

  root@ssp-pwrt-002:~# ./perf stat -e cpu_core/r3c/ -vv  -- ./triad_loop
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
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid 12340  cpu -1  group_fd -1  flags 0x8 = 3
  cpu_core/r3c/: 0: 449000613 293915211 293915211
  cpu_core/r3c/: 449000613 293915211 293915211

   Performance counter stats for './triad_loop':

         449,000,613      cpu_core/r3c/

         0.294859229 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c | 56 +++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 30435adc7a7b..9b2a33103a57 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1532,6 +1532,55 @@ static int add_hybrid_numeric(struct parse_events_state *parse_state,
 	return 0;
 }
 
+static int create_hybrid_raw_event(struct parse_events_state *parse_state,
+				   struct list_head *list,
+				   struct perf_event_attr *attr,
+				   struct list_head *head_config,
+				   struct list_head *config_terms,
+				   struct perf_pmu *pmu)
+{
+	struct evsel *evsel;
+
+	attr->type = pmu->type;
+	evsel = __add_event(list, &parse_state->idx, attr, true,
+			    get_config_name(head_config),
+			    pmu, config_terms, false, NULL);
+	if (evsel)
+		evsel->pmu_name = strdup(pmu->name);
+	else
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int add_hybrid_raw(struct parse_events_state *parse_state,
+			  struct list_head *list,
+			  struct perf_event_attr *attr,
+			  struct list_head *head_config,
+			  struct list_head *config_terms,
+			  bool *hybrid)
+{
+	struct perf_pmu *pmu;
+	int ret;
+
+	*hybrid = false;
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		*hybrid = true;
+		if (parse_state->pmu_name &&
+		    strcmp(parse_state->pmu_name, pmu->name)) {
+			continue;
+		}
+
+		ret = create_hybrid_raw_event(parse_state, list, attr,
+					      head_config, config_terms,
+					      pmu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
@@ -1558,7 +1607,12 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 	/*
 	 * Skip the software dummy event.
 	 */
-	if (type != PERF_TYPE_SOFTWARE) {
+	if (type == PERF_TYPE_RAW) {
+		ret = add_hybrid_raw(parse_state, list, &attr, head_config,
+				     &config_terms, &hybrid);
+		if (hybrid)
+			return ret;
+	} else if (type != PERF_TYPE_SOFTWARE) {
 		if (!perf_pmu__hybrid_exist())
 			perf_pmu__scan(NULL);
 
-- 
2.17.1

