Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF35932DAD9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhCDUHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:07:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232049AbhCDUHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614888364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TOSnIoRGX/IFskCbEXE1PadKf5zKC7G0GnjlRFK0Mu4=;
        b=hvN8bBQ2jgiEazoNWfRQNIyN+Kfxyeu9T54S09HOf0/nheh7ztWxgT8Bajxkc0Nri6Gfi7
        Ys4GS1AyVvnaCeON9SEkDnOXXO3Wu+DGXobvn/T58zjlNay5MRHJvwygOoVOT4uXTM2qKT
        mLqUsle4MMZvOFv8A88icCRNjvBAQok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-mx1nsWEMOXKXN1D-2itr8g-1; Thu, 04 Mar 2021 15:06:00 -0500
X-MC-Unique: mx1nsWEMOXKXN1D-2itr8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82670193F560;
        Thu,  4 Mar 2021 20:05:57 +0000 (UTC)
Received: from krava (unknown [10.40.196.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id E10DD5D9C6;
        Thu,  4 Mar 2021 20:05:53 +0000 (UTC)
Date:   Thu, 4 Mar 2021 21:05:52 +0100
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
Message-ID: <YEE9oInI38txHWmo@krava>
References: <1614784938-27080-1-git-send-email-john.garry@huawei.com>
 <1614784938-27080-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614784938-27080-2-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:22:14PM +0800, John Garry wrote:
> Calling perf_pmu__find_map(NULL) returns the cpumap for the common CPU
> PMU. However arm64 supports heterogeneous-CPU based systems, and so there
> may be no common CPU PMU. As such, perf_pmu__find_map(NULL) returns NULL
> for arm64.
> 
> To support printing metrics for arm64, iterate through all PMUs, looking
> for a CPU PMU, and use the cpumap there for determining supported metrics.
> 
> For heterogeneous systems (like arm big.LITTLE), supporting metrics has
> potential challenges, like not all CPUs in a system not supporting a
> specific metric event. So just don't support it for now.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/util/metricgroup.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 26c990e32378..9a2a23093961 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -6,6 +6,7 @@
>  /* Manage metrics and groups of metrics from JSON files */
>  
>  #include "metricgroup.h"
> +#include "cpumap.h"
>  #include "debug.h"
>  #include "evlist.h"
>  #include "evsel.h"
> @@ -615,10 +616,31 @@ static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
>  				     d->details, d->groups, d->metriclist);
>  }
>  
> +static struct pmu_events_map *find_cpumap(void)
> +{
> +	struct perf_pmu *pmu = NULL;
> +
> +	while ((pmu = perf_pmu__scan(pmu))) {
> +		if (!is_pmu_core(pmu->name))
> +			continue;
> +
> +		/*
> +		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
> +		 * not support some events or have different event IDs.
> +		 */
> +		if (pmu->cpus && pmu->cpus->nr != cpu__max_cpu())
> +			return NULL;
> +
> +		return perf_pmu__find_map(pmu);
> +	}
> +
> +	return NULL;
> +}
> +
>  void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  			bool raw, bool details)
>  {
> -	struct pmu_events_map *map = perf_pmu__find_map(NULL);
> +	struct pmu_events_map *map = find_cpumap();

so this is just for arm at the moment right?

could we rather make this arch specific code, so we don't need
to do the scanning on archs where this is not needed?

like marking perf_pmu__find_map as __weak and add arm specific
version?

thanks,
jirka

>  	struct pmu_event *pe;
>  	int i;
>  	struct rblist groups;
> -- 
> 2.26.2
> 

