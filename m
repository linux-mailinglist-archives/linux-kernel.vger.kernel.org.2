Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982743D2205
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhGVJjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhGVJjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626949185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfSu3uIp392jCxR+c88j2xDyWu7I7n++pa2vgNqBSgY=;
        b=GYiGXNW0v142rXAiX11WAukEaw6HxLNFFbjD3L2c4xInKDNeJgnI6bwB7VmOp0zZc6Kwvr
        4a9atm3SKcbws0+49TFtK/L7yD2uD6Mu0XEsvu+AWlZPIc9sCyq2ZBWvxRDaOrTAPgbsQi
        Vr0DeNKb9wamySfeXMMPZAnFCyPOZb0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-RjFNz9TvPqiY7rQYUOEdrA-1; Thu, 22 Jul 2021 06:19:43 -0400
X-MC-Unique: RjFNz9TvPqiY7rQYUOEdrA-1
Received: by mail-ej1-f70.google.com with SMTP id q8-20020a170906a088b02904be5f536463so1678807ejy.0
        for <Linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UfSu3uIp392jCxR+c88j2xDyWu7I7n++pa2vgNqBSgY=;
        b=Yi9/Zzuk/B+gDzgzAbx3HHoLF1wv+zXAPqSjtMkbwmp9ObXjuh3rG8iiEFqHBX5pvN
         r4TyD8CK7sMIiLumw/7yLx5fBHR5h5qbMn4j0+lDJKDKAKRT/QwBxZJbY73D3w8g0Lyw
         XhUzEvcNRmDznc8m7JSuYmvED8AcuiGkfwvdih95k+i/vgBujVIdisVT1eA7TXH316ZW
         zSjfUYKZBkWsbtzVuaAxtiIpPH0gTZNFT9cIL82L6/zXZp3S3Lf3P004SXAgvPgf4Itu
         UXeuIoioHy9x8/+DRdeING9WsnfeXXpwyZTi673ToMTqfTUvhKpn3iVnQdm9SL9ZVaqS
         UhEg==
X-Gm-Message-State: AOAM533tgXh3lcJyGjU+LjL+24hpg++QC3zkWasPl4FxA3t2yTTS+zMg
        ZG2yuEgdXHKoTdYlbwF2hUJ1+Prxpmsep0GArJP06/V5HPIezG1X6iQOXQkmzBYWJwf94+W6DOz
        e0Q6XZDmOeYUkBGRTblCeLFSV
X-Received: by 2002:a17:907:986e:: with SMTP id ko14mr42776111ejc.219.1626949182597;
        Thu, 22 Jul 2021 03:19:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPp+x8hEE6Y5etLjFw+yq6DAZzVK3EA2fuKBDOpB8/tzmRotpDiFiCFeifLfHofQpy5c0TJg==
X-Received: by 2002:a17:907:986e:: with SMTP id ko14mr42776096ejc.219.1626949182395;
        Thu, 22 Jul 2021 03:19:42 -0700 (PDT)
Received: from krava ([83.240.60.59])
        by smtp.gmail.com with ESMTPSA id o23sm9301105ejc.124.2021.07.22.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 03:19:42 -0700 (PDT)
Date:   Thu, 22 Jul 2021 12:19:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 3/3] perf tools: Enable on a list of CPUs for hybrid
Message-ID: <YPlGPC3OkPihS91A@krava>
References: <20210712071235.28533-1-yao.jin@linux.intel.com>
 <20210712071235.28533-4-yao.jin@linux.intel.com>
 <YPXUMTFbj2Tl3eBz@krava>
 <ecf0e815-616f-0a08-cefd-baac93c0e47d@linux.intel.com>
 <YPaUc3iodIASdYRY@krava>
 <598463ae-0bb0-7609-407b-4822112b2093@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598463ae-0bb0-7609-407b-4822112b2093@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:30:11PM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 7/20/2021 5:16 PM, Jiri Olsa wrote:
> > On Tue, Jul 20, 2021 at 03:07:02PM +0800, Jin, Yao wrote:
> > 
> > SNIP
> > 
> > > 
> > > OK, evlist__fix_cpus() is better, use this name in v4.
> > > 
> > > > > +{
> > > > > +	struct perf_cpu_map *cpus;
> > > > > +	struct evsel *evsel, *tmp;
> > > > > +	struct perf_pmu *pmu;
> > > > > +	int ret, unmatched_count = 0, events_nr = 0;
> > > > > +
> > > > > +	if (!perf_pmu__has_hybrid() || !cpu_list)
> > > > > +		return 0;
> > > > > +
> > > > > +	cpus = perf_cpu_map__new(cpu_list);
> > > > > +	if (!cpus)
> > > > > +		return -1;
> > > > > +
> > > > > +	evlist__for_each_entry_safe(evlist, tmp, evsel) {
> > > > > +		struct perf_cpu_map *matched_cpus, *unmatched_cpus;
> > > > > +		char buf1[128], buf2[128];
> > > > > +
> > > > > +		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
> > > > > +		if (!pmu)
> > > > > +			continue;
> > > > > +
> > > > > +		ret = perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
> > > > > +					   &unmatched_cpus);
> > > > > +		if (ret)
> > > > > +			goto out;
> > > > > +
> > > > > +		events_nr++;
> > > > > +
> > > > > +		if (matched_cpus->nr > 0 && (unmatched_cpus->nr > 0 ||
> > > > > +		    matched_cpus->nr < cpus->nr ||
> > > > > +		    matched_cpus->nr < pmu->cpus->nr)) {
> > > > > +			perf_cpu_map__put(evsel->core.cpus);
> > > > > +			perf_cpu_map__put(evsel->core.own_cpus);
> > > > > +			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
> > > > > +			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);
> > > > 
> > > > I'm bit confused in here.. AFAIUI there's 2 evsel objects create
> > > > for hybrid 'cycles' ... should they have already proper cpus set?
> > > > 
> > > 
> > > For 'cycles', yes two evsels are created automatically. One is for atom CPU
> > > (e.g. 8-11), the other is for core CPU (e.g. 0-7). In this example, these 2
> > > evsels have already the cpus set.
> > 
> > hum, so those evsels are created with pmu's cpus, right?
> > 
> 
> Yes, that's right. But we also check and adjust the evsel->cpus by using
> user's cpu list on hybrid (what the evlist__use_cpu_list() does).
> 
> > > 
> > > While the 'cpus' here is just the user specified cpu list.
> > > cpus = perf_cpu_map__new(cpu_list);
> > 
> > then I think they will be changed by evlist__create_maps
> > with whatever user wants?
> > 
> 
> No, it will not be changed by evlist__create_maps.
> 
> In evlist__create_maps(),
> evlist->core.has_user_cpus = !!target->cpu_list && !target->hybrid;
> 
> It disables has_user_cpus for hybrid.
> 
> So in __perf_evlist__propagate_maps, they will not be changed by evlist->cpus.
> 
> if (!evsel->own_cpus || evlist->has_user_cpus) {
> 	perf_cpu_map__put(evsel->cpus);
> 	evsel->cpus = perf_cpu_map__get(evlist->cpus);
> 	
> > could we just change __perf_evlist__propagate_maps to follow
> > pmu's cpus?
> > 
> 
> In __perf_evlist__propagate_maps, it has already followed pmu's cpus because
> the evlist->has_user_cpus is false for hybrid.

sorry for delay

ok, so we first fix the cpus on hybrid events and then
propagate maps.. I guess it's ok, because it's in libperf
and that has no notion of hybrid so far

could you please rename that function so it's also obvious
it's for hybrid only

  evlist__fix_hybrid_cpus ? not sure ;-)

and add some comment with example to explain what the
function is doing

thanks,
jirka

