Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B273CEDA9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358417AbhGST0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357837AbhGSS4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626723382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpamxCgK6c3U1xR1ICi3sq3QuQdpZOfRseWBGzpvSRg=;
        b=SBA3fGTGLJOI4R10KYZEVo/2KFTWfRlf4zGnZHGjsstI8KmtwgSlT1teM+6TlGZ1ejYXCv
        7nJZv0sS+9hjbSpJKfJU3lGqOi8kF+vm8lZMCaFFBi0rC4PeOPfPQZx22N60wJiO3S/RXb
        Jyw1iBqLU5NsaMxQKJMczVDrGa+p4UE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-UZBrdTKTM4Ck5wyzhTMQIg-1; Mon, 19 Jul 2021 15:36:21 -0400
X-MC-Unique: UZBrdTKTM4Ck5wyzhTMQIg-1
Received: by mail-ed1-f69.google.com with SMTP id c21-20020aa7d6150000b02903ab03a06e86so9788212edr.14
        for <Linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZpamxCgK6c3U1xR1ICi3sq3QuQdpZOfRseWBGzpvSRg=;
        b=lgzM2Dy9kiN5d67u34kZDamtSosLUEtaxf9eYCoIRSJC8rnDMv9IrtuOQ6Vlf9VCOK
         Tc1glj9xpjtjlVrkhwECWHoB2cvjqcj6HF2+AbxpAWHJu0O0LkrUs6Oa7AXPdgNeFekn
         5u6cfTQMNC8MOiTEw8yumSCbUMaEEGfQcPnAX5WJ8hjtnvP/EoT9HZoJDNf1XGizBazR
         rqqQ99Vdu8t5TMFXU71YxsNlQPHNt7MMigookWIiaxuAv9iFHt/z4eOJQpPUfespBzjR
         lPcAYFuKZPcjFSMWZwu+izifYKy0j6wf8xXF1skd3xsdhwdCJduThG0xm6BROnrroIEy
         Ns4g==
X-Gm-Message-State: AOAM531Moo7HFx1MM1n04Wc10KCeGrSDckNJGDnnQmcbaU005KNRT/c1
        8FZQxrd5ONTpLS6XwzHBnyrfH2Hyn8Fq8xZzD6K8ATw6zYaCczNk0gWbSNxf7rsFdIcLYtVVNEm
        js3TVvazBP4ycxxFmURkA3P4U
X-Received: by 2002:a17:907:2721:: with SMTP id d1mr16524805ejl.170.1626723379948;
        Mon, 19 Jul 2021 12:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG7464FZLcfx6fUCvuXlYRxjeArk+Sxf7zLsI0FOSXIvFgZTX8Vkgif3OPD9T7ZG8CLXZy7Q==
X-Received: by 2002:a17:907:2721:: with SMTP id d1mr16524785ejl.170.1626723379675;
        Mon, 19 Jul 2021 12:36:19 -0700 (PDT)
Received: from krava ([83.240.60.59])
        by smtp.gmail.com with ESMTPSA id s24sm6294054ejd.19.2021.07.19.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:36:19 -0700 (PDT)
Date:   Mon, 19 Jul 2021 21:36:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 3/3] perf tools: Enable on a list of CPUs for hybrid
Message-ID: <YPXUMTFbj2Tl3eBz@krava>
References: <20210712071235.28533-1-yao.jin@linux.intel.com>
 <20210712071235.28533-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712071235.28533-4-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 03:12:35PM +0800, Jin Yao wrote:
> The perf-record and perf-stat have supported the option '-C/--cpus'
> to count or collect only on the list of CPUs provided. This option
> needs to be supported for hybrid as well.
> 
> For hybrid support, it needs to check that the CPUs are available on
> hybrid PMU. One example for AlderLake, cpu0-7 is 'cpu_core', cpu8-11
> is 'cpu_atom'.
> 
> Before:
> 
>   # perf stat -e cpu_core/cycles/ -C11 -- sleep 1
> 
>    Performance counter stats for 'CPU(s) 11':
> 
>      <not supported>      cpu_core/cycles/
> 
>          1.006179431 seconds time elapsed
> 
> The perf-stat silently returned "<not supported>" without any helpful
> information. It should error out that cpu11 was not 'cpu_core'.
> 
> After:
> 
>   # perf stat -e cpu_core/cycles/ -C11 -- sleep 1
>   WARNING: 11 isn't a 'cpu_core', please use a CPU list in the 'cpu_core' range (0-7)
>   failed to use cpu list 11
> 
> We also need to support the events without pmu prefix specified.
> 
>   # perf stat -e cycles -C11 -- sleep 1
>   WARNING: 11 isn't a 'cpu_core', please use a CPU list in the 'cpu_core' range (0-7)
> 
>    Performance counter stats for 'CPU(s) 11':
> 
>            1,067,373      cpu_atom/cycles/
> 
>          1.005544738 seconds time elapsed
> 
> The perf tool creates two cycles events automatically, cpu_core/cycles/ and
> cpu_atom/cycles/. It checks that cpu11 is not 'cpu_core', then shows a warning
> for cpu_core/cycles/ and only count the cpu_atom/cycles/.
> 
> If part of cpus are 'cpu_core' and part of cpus are 'cpu_atom', the example,
> 
>   # perf stat -e cycles -C0,11 -- sleep 1
>   WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
>   WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
> 
>    Performance counter stats for 'CPU(s) 0,11':
> 
>            1,914,704      cpu_core/cycles/
>            2,036,983      cpu_atom/cycles/
> 
>          1.005815641 seconds time elapsed
> 
> It now automatically selects cpu0 for cpu_core/cycles/, selects cpu11 for
> cpu_atom/cycles/, and output with some warnings.
> 
> Some more complex examples,
> 
>   # perf stat -e cycles,instructions -C0,11 -- sleep 1
>   WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
>   WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
>   WARNING: use 0 in 'cpu_core' for 'instructions', skip other cpus in list.
>   WARNING: use 11 in 'cpu_atom' for 'instructions', skip other cpus in list.
> 
>    Performance counter stats for 'CPU(s) 0,11':
> 
>            2,780,387      cpu_core/cycles/
>            1,583,432      cpu_atom/cycles/
>            3,957,277      cpu_core/instructions/
>            1,167,089      cpu_atom/instructions/
> 
>          1.006005124 seconds time elapsed
> 
>   # perf stat -e cycles,cpu_atom/instructions/ -C0,11 -- sleep 1
>   WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
>   WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
>   WARNING: use 11 in 'cpu_atom' for 'cpu_atom/instructions/', skip other cpus in list.
> 
>    Performance counter stats for 'CPU(s) 0,11':
> 
>            3,290,301      cpu_core/cycles/
>            1,953,073      cpu_atom/cycles/
>            1,407,869      cpu_atom/instructions/
> 
>          1.006260912 seconds time elapsed
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v3:
>  - Rebase to perf/core.
>  - No functional change.
> 
> v2:
>  - Automatically map to hybrid pmu.
> 
>  tools/perf/builtin-record.c     |  7 ++++
>  tools/perf/builtin-stat.c       |  6 +++
>  tools/perf/util/evlist-hybrid.c | 65 +++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist-hybrid.h |  1 +
>  tools/perf/util/evlist.c        |  1 +
>  tools/perf/util/pmu.c           | 35 ++++++++++++++++++
>  tools/perf/util/pmu.h           |  4 ++
>  7 files changed, 119 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 671a21c9ee4d..9518b028b850 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2884,6 +2884,13 @@ int cmd_record(int argc, const char **argv)
>  	/* Enable ignoring missing threads when -u/-p option is defined. */
>  	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
>  
> +	if (evlist__use_cpu_list(rec->evlist, rec->opts.target.cpu_list)) {
> +		pr_err("failed to use cpu list %s\n",
> +		       rec->opts.target.cpu_list);
> +		goto out;
> +	}
> +
> +	rec->opts.target.hybrid = perf_pmu__has_hybrid();
>  	err = -ENOMEM;
>  	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
>  		usage_with_options(record_usage, record_options);
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d25cb8088e8c..f7067587008f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2430,6 +2430,12 @@ int cmd_stat(int argc, const char **argv)
>  	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
>  		target.per_thread = true;
>  
> +	if (evlist__use_cpu_list(evsel_list, target.cpu_list)) {
> +		pr_err("failed to use cpu list %s\n", target.cpu_list);
> +		goto out;
> +	}
> +
> +	target.hybrid = perf_pmu__has_hybrid();
>  	if (evlist__create_maps(evsel_list, &target) < 0) {
>  		if (target__has_task(&target)) {
>  			pr_err("Problems finding threads of monitor\n");
> diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
> index db3f5fbdebe1..13c9f3063dda 100644
> --- a/tools/perf/util/evlist-hybrid.c
> +++ b/tools/perf/util/evlist-hybrid.c
> @@ -86,3 +86,68 @@ bool evlist__has_hybrid(struct evlist *evlist)
>  
>  	return false;
>  }
> +
> +int evlist__use_cpu_list(struct evlist *evlist, const char *cpu_list)


the name seems not to cover what it's doing, how about something
like evlist__fix_cpus or such

> +{
> +	struct perf_cpu_map *cpus;
> +	struct evsel *evsel, *tmp;
> +	struct perf_pmu *pmu;
> +	int ret, unmatched_count = 0, events_nr = 0;
> +
> +	if (!perf_pmu__has_hybrid() || !cpu_list)
> +		return 0;
> +
> +	cpus = perf_cpu_map__new(cpu_list);
> +	if (!cpus)
> +		return -1;
> +
> +	evlist__for_each_entry_safe(evlist, tmp, evsel) {
> +		struct perf_cpu_map *matched_cpus, *unmatched_cpus;
> +		char buf1[128], buf2[128];
> +
> +		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
> +		if (!pmu)
> +			continue;
> +
> +		ret = perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
> +					   &unmatched_cpus);
> +		if (ret)
> +			goto out;
> +
> +		events_nr++;
> +
> +		if (matched_cpus->nr > 0 && (unmatched_cpus->nr > 0 ||
> +		    matched_cpus->nr < cpus->nr ||
> +		    matched_cpus->nr < pmu->cpus->nr)) {
> +			perf_cpu_map__put(evsel->core.cpus);
> +			perf_cpu_map__put(evsel->core.own_cpus);
> +			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
> +			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);

I'm bit confused in here.. AFAIUI there's 2 evsel objects create
for hybrid 'cycles' ... should they have already proper cpus set?

> +
> +			if (unmatched_cpus->nr > 0) {
> +				cpu_map__snprint(matched_cpus, buf1, sizeof(buf1));
> +				pr_warning("WARNING: use %s in '%s' for '%s', skip other cpus in list.\n",
> +					   buf1, pmu->name, evsel->name);
> +			}
> +		}
> +
> +		if (matched_cpus->nr == 0) {
> +			evlist__remove(evlist, evsel);
> +			evsel__delete(evsel);
> +
> +			cpu_map__snprint(cpus, buf1, sizeof(buf1));
> +			cpu_map__snprint(pmu->cpus, buf2, sizeof(buf2));
> +			pr_warning("WARNING: %s isn't a '%s', please use a CPU list in the '%s' range (%s)\n",
> +				   buf1, pmu->name, pmu->name, buf2);
> +			unmatched_count++;
> +		}

hum, should we rather fail in here?

jirka

