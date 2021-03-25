Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ADE348E22
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhCYKit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:38:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14895 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhCYKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F5hNj69pKzkfVs;
        Thu, 25 Mar 2021 18:36:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 18:38:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <irogers@google.com>
CC:     <linuxarm@huawei.com>, <kjain@linux.ibm.com>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <pc@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/6] perf metricgroup: Make find_metric() public with name change
Date:   Thu, 25 Mar 2021 18:33:13 +0800
Message-ID: <1616668398-144648-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function find_metric() is required for the metric processing in the
pmu-events testcase, so make it public. Also change the name to include
"metricgroup".

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 5 +++--
 tools/perf/util/metricgroup.h | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6acb44ad439b..71a13406e0bd 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -900,7 +900,8 @@ static int __add_metric(struct list_head *metric_list,
 		    (match_metric(__pe->metric_group, __metric) ||	\
 		     match_metric(__pe->metric_name, __metric)))
 
-static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
+struct pmu_event *metrcgroup_find_metric(const char *metric,
+					 struct pmu_events_map *map)
 {
 	struct pmu_event *pe;
 	int i;
@@ -985,7 +986,7 @@ static int __resolve_metric(struct metric *m,
 			struct expr_id *parent;
 			struct pmu_event *pe;
 
-			pe = find_metric(cur->key, map);
+			pe = metrcgroup_find_metric(cur->key, map);
 			if (!pe)
 				continue;
 
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index ed1b9392e624..1674c6a36d74 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -44,7 +44,8 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_group,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
-
+struct pmu_event *metrcgroup_find_metric(const char *metric,
+					 struct pmu_events_map *map);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   struct pmu_events_map *map,
 				   const char *str,
-- 
2.26.2

