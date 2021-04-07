Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1369B3569C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351059AbhDGKha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:37:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16383 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347068AbhDGKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:37:29 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFglR0q71zjYhZ;
        Wed,  7 Apr 2021 18:35:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 18:37:10 +0800
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
Subject: [PATCH v3 1/6] perf metricgroup: Make find_metric() public with name change
Date:   Wed, 7 Apr 2021 18:32:45 +0800
Message-ID: <1617791570-165223-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617791570-165223-1-git-send-email-john.garry@huawei.com>
References: <1617791570-165223-1-git-send-email-john.garry@huawei.com>
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

Tested-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/util/metricgroup.c | 5 +++--
 tools/perf/util/metricgroup.h | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6acb44ad439b..37fe34a5d93d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -900,7 +900,8 @@ static int __add_metric(struct list_head *metric_list,
 		    (match_metric(__pe->metric_group, __metric) ||	\
 		     match_metric(__pe->metric_name, __metric)))
 
-static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
+struct pmu_event *metricgroup__find_metric(const char *metric,
+					   struct pmu_events_map *map)
 {
 	struct pmu_event *pe;
 	int i;
@@ -985,7 +986,7 @@ static int __resolve_metric(struct metric *m,
 			struct expr_id *parent;
 			struct pmu_event *pe;
 
-			pe = find_metric(cur->key, map);
+			pe = metricgroup__find_metric(cur->key, map);
 			if (!pe)
 				continue;
 
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index ed1b9392e624..1424e7c1af77 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -44,7 +44,8 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_group,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
-
+struct pmu_event *metricgroup__find_metric(const char *metric,
+					   struct pmu_events_map *map);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   struct pmu_events_map *map,
 				   const char *str,
-- 
2.26.2

