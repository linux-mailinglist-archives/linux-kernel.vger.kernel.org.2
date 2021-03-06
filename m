Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E462332FCCD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhCFTex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231266AbhCFTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615059265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZ/0UpjlDaAlIEYFykpQQPa4f11Jamk3TyEJDHiIAHk=;
        b=JoIKJehrFfCP+4XGY0CQlFQ1czm/RQGzBEWoOvWnh0M+cRqwaIYQUOeAXmi8MU49s8HtGK
        Tl1iJqmIe0u8PoC7grsZn0KuT6KFdr/+WRexDxbvJqZuweOiazv6jfBKb36yqCwp459bUl
        sLxXY2BVSIwapxpkpHhIqD7hkBUV+h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-eYgJsONjPtOXUcjdSwp13g-1; Sat, 06 Mar 2021 14:34:21 -0500
X-MC-Unique: eYgJsONjPtOXUcjdSwp13g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E86951074644;
        Sat,  6 Mar 2021 19:34:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6BC135D9C6;
        Sat,  6 Mar 2021 19:34:15 +0000 (UTC)
Date:   Sat, 6 Mar 2021 20:34:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        qiangqing.zhang@nxp.com, kjain@linux.ibm.com
Subject: Re: [PATCH 1/5] perf metricgroup: Support printing metrics for arm64
Message-ID: <YEPZNssS200w3Axy@krava>
References: <1614784938-27080-1-git-send-email-john.garry@huawei.com>
 <1614784938-27080-2-git-send-email-john.garry@huawei.com>
 <YEE9oInI38txHWmo@krava>
 <95205463-4c80-4e8a-a7c0-c2a4e4553838@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95205463-4c80-4e8a-a7c0-c2a4e4553838@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 11:06:58AM +0000, John Garry wrote:
> 
> Hi Jirka,
> 
> > > -	struct pmu_events_map *map = perf_pmu__find_map(NULL);
> > > +	struct pmu_events_map *map = find_cpumap();
> > so this is just for arm at the moment right?
> > 
> 
> Yes - but to be more accurate, arm64.
> 
> At the moment, from the archs which use pmu-events, only arm64 and nds32
> have versions of get_cpuid_str() which require a non-NULL pmu argument.
> 
> But then apparently nds32 only supports a single CPU, so this issue of
> heterogeneous CPUs should not be a concern there :)
> 
> > could we rather make this arch specific code, so we don't need
> > to do the scanning on archs where this is not needed?
> > 
> > like marking perf_pmu__find_map as __weak and add arm specific
> > version?
> 
> Well I was thinking that this code should not be in metricgroup.c anyway.
> 
> So there is code which is common in current perf_pmu__find_map() for all
> archs.
> 
> I could factor that out into a common function, below. Just a bit worried
> about perf_pmu__find_map() and perf_pmu__find_pmu_map() being confused.

right, so perf_pmu__find_map does not take perf_pmu as argument
anymore, so the prefix does not fit, how about pmu_events_map__find ?

thanks,
jirka


> 
> Here's how that would look:
> 
> +++ b/tools/perf/arch/arm64/util/pmu.c
> 
> #include "../../util/cpumap.h"
> #include "../../util/pmu.h"
> 
> struct pmu_events_map *perf_pmu__find_map(void)
> {
> 	struct perf_pmu *pmu = perf_pmu__find("armv8_pmuv3_0");
> 
> 	if (!pmu || !pmu->cpus || pmu->cpus->nr != cpu__max_cpu())
> 		return NULL;
> 
> 	return perf_pmu__find_pmu_map(pmu);
> }
> 
> And:
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 26c990e32378..312164ce9299 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -618,7 +618,7 @@ static int metricgroup__print_sys_event_iter(struct
> pmu_event *pe, void *data)
>  void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  			bool raw, bool details)
>  {
> -	struct pmu_events_map *map = perf_pmu__find_map(NULL);
> +	struct pmu_events_map *map = perf_pmu__find_map();
>  	struct pmu_event *pe;
>  	int i;
>  	struct rblist groups;
> @@ -1253,8 +1253,7 @@ int metricgroup__parse_groups(const struct option
> *opt,
>  			      struct rblist *metric_events)
>  {
>  	struct evlist *perf_evlist = *(struct evlist **)opt->value;
> -	struct pmu_events_map *map = perf_pmu__find_map(NULL);
> -
> +	struct pmu_events_map *map = perf_pmu__find_map();
> 
>  	return parse_groups(perf_evlist, str, metric_no_group,
>  			    metric_no_merge, NULL, metric_events, map);
> @@ -1273,7 +1272,7 @@ int metricgroup__parse_groups_test(struct evlist
> *evlist,
> 
>  bool metricgroup__has_metric(const char *metric)
>  {
> -	struct pmu_events_map *map = perf_pmu__find_map(NULL);
> +	struct pmu_events_map *map = perf_pmu__find_map();
>  	struct pmu_event *pe;
>  	int i;
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 44ef28302fc7..d49bf20b6058 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -690,7 +690,7 @@ static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
>  	return cpuid;
>  }
> 
> -struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
> +struct pmu_events_map *perf_pmu__find_pmu_map(struct perf_pmu *pmu)
>  {
>  	struct pmu_events_map *map;
>  	char *cpuid = perf_pmu__getcpuid(pmu);
> @@ -717,6 +717,11 @@ struct pmu_events_map *perf_pmu__find_map(struct
> perf_pmu *pmu)
>  	return map;
>  }
> 
> +struct pmu_events_map *__weak perf_pmu__find_map(void)
> +{
> +	return perf_pmu__find_pmu_map(NULL);
> +}
> +
>  bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>  {
>  	char *tmp = NULL, *tok, *str;
> @@ -805,7 +810,7 @@ static void pmu_add_cpu_aliases(struct list_head *head,
> struct perf_pmu *pmu)
>  {
>  	struct pmu_events_map *map;
> 
> -	map = perf_pmu__find_map(pmu);
> +	map = perf_pmu__find_pmu_map(pmu);
>  	if (!map)
>  		return;
> 
> 
> Thoughts?
> 
> Thanks!
> 

