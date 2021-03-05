Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E932E705
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCELJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:09:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2621 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhCELI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:08:59 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DsPtF5QC2z67jpW;
        Fri,  5 Mar 2021 19:01:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 12:08:57 +0100
Received: from [10.47.8.182] (10.47.8.182) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 11:08:55 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/5] perf metricgroup: Support printing metrics for arm64
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <irogers@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>, <qiangqing.zhang@nxp.com>,
        <kjain@linux.ibm.com>
References: <1614784938-27080-1-git-send-email-john.garry@huawei.com>
 <1614784938-27080-2-git-send-email-john.garry@huawei.com>
 <YEE9oInI38txHWmo@krava>
Message-ID: <95205463-4c80-4e8a-a7c0-c2a4e4553838@huawei.com>
Date:   Fri, 5 Mar 2021 11:06:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YEE9oInI38txHWmo@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.182]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jirka,

>> -	struct pmu_events_map *map = perf_pmu__find_map(NULL);
>> +	struct pmu_events_map *map = find_cpumap();
> so this is just for arm at the moment right?
> 

Yes - but to be more accurate, arm64.

At the moment, from the archs which use pmu-events, only arm64 and nds32 
have versions of get_cpuid_str() which require a non-NULL pmu argument.

But then apparently nds32 only supports a single CPU, so this issue of 
heterogeneous CPUs should not be a concern there :)

> could we rather make this arch specific code, so we don't need
> to do the scanning on archs where this is not needed?
> 
> like marking perf_pmu__find_map as __weak and add arm specific
> version?

Well I was thinking that this code should not be in metricgroup.c anyway.

So there is code which is common in current perf_pmu__find_map() for all 
archs.

I could factor that out into a common function, below. Just a bit 
worried about perf_pmu__find_map() and perf_pmu__find_pmu_map() being 
confused.

Here's how that would look:

+++ b/tools/perf/arch/arm64/util/pmu.c

#include "../../util/cpumap.h"
#include "../../util/pmu.h"

struct pmu_events_map *perf_pmu__find_map(void)
{
	struct perf_pmu *pmu = perf_pmu__find("armv8_pmuv3_0");

	if (!pmu || !pmu->cpus || pmu->cpus->nr != cpu__max_cpu())
		return NULL;

	return perf_pmu__find_pmu_map(pmu);
}

And:

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 26c990e32378..312164ce9299 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -618,7 +618,7 @@ static int metricgroup__print_sys_event_iter(struct 
pmu_event *pe, void *data)
  void metricgroup__print(bool metrics, bool metricgroups, char *filter,
  			bool raw, bool details)
  {
-	struct pmu_events_map *map = perf_pmu__find_map(NULL);
+	struct pmu_events_map *map = perf_pmu__find_map();
  	struct pmu_event *pe;
  	int i;
  	struct rblist groups;
@@ -1253,8 +1253,7 @@ int metricgroup__parse_groups(const struct option 
*opt,
  			      struct rblist *metric_events)
  {
  	struct evlist *perf_evlist = *(struct evlist **)opt->value;
-	struct pmu_events_map *map = perf_pmu__find_map(NULL);
-
+	struct pmu_events_map *map = perf_pmu__find_map();

  	return parse_groups(perf_evlist, str, metric_no_group,
  			    metric_no_merge, NULL, metric_events, map);
@@ -1273,7 +1272,7 @@ int metricgroup__parse_groups_test(struct evlist 
*evlist,

  bool metricgroup__has_metric(const char *metric)
  {
-	struct pmu_events_map *map = perf_pmu__find_map(NULL);
+	struct pmu_events_map *map = perf_pmu__find_map();
  	struct pmu_event *pe;
  	int i;

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44ef28302fc7..d49bf20b6058 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -690,7 +690,7 @@ static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
  	return cpuid;
  }

-struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
+struct pmu_events_map *perf_pmu__find_pmu_map(struct perf_pmu *pmu)
  {
  	struct pmu_events_map *map;
  	char *cpuid = perf_pmu__getcpuid(pmu);
@@ -717,6 +717,11 @@ struct pmu_events_map *perf_pmu__find_map(struct 
perf_pmu *pmu)
  	return map;
  }

+struct pmu_events_map *__weak perf_pmu__find_map(void)
+{
+	return perf_pmu__find_pmu_map(NULL);
+}
+
  bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
  {
  	char *tmp = NULL, *tok, *str;
@@ -805,7 +810,7 @@ static void pmu_add_cpu_aliases(struct list_head 
*head, struct perf_pmu *pmu)
  {
  	struct pmu_events_map *map;

-	map = perf_pmu__find_map(pmu);
+	map = perf_pmu__find_pmu_map(pmu);
  	if (!map)
  		return;


Thoughts?

Thanks!
