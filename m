Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B23CF6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhGTIhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234864AbhGTIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626772600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wwmuzr8AmgyRK7EVr2ih7+SXOXPmpw+O/q8g6/RyDT0=;
        b=IGCcRXTt4rTY+FZAEeBJruB8K5VFNk8p9bRpQxfE48q5goKg2VKlaxWOFx676sQNzuYGtu
        0+1a7oKi3gC+FvlcmjCLeocWQ/138zu9MH/wDoQ5HVmvcrPauIRt2Oj91JoD4F23LHOwbB
        WFTUA4bGPQMmGBfyXTAvvfgXJhytHls=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-n3aD5Vv3M9ab7wnFViXDFw-1; Tue, 20 Jul 2021 05:16:39 -0400
X-MC-Unique: n3aD5Vv3M9ab7wnFViXDFw-1
Received: by mail-ed1-f71.google.com with SMTP id c21-20020aa7d6150000b02903ab03a06e86so10564082edr.14
        for <Linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 02:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wwmuzr8AmgyRK7EVr2ih7+SXOXPmpw+O/q8g6/RyDT0=;
        b=H0Nv363roEz1TNAjyEX7Xa+dVITwAErV/t/g71gb6fDCYuTZy6ZPYftOkaeTUxK1b+
         1BwwMyatsA7Oh5Zyn/lGFY4jfTebukozZtPbjGHludQ2i/Jq0cl9mk6tsoEPfh/qQ5Ya
         FAWqmkwCGi7eUBGH75PfxpYuBM2xqfS/sofdOQiGSViKgggACEPORXN9mdNMXR19DlHR
         a//syMX1bK5DHCofgRQYrca17aQYoL1Rn3qno8QwV08F1g9R+aeLWoqg0lEe1dutwl6e
         thyIZBmYlk+VysZmVUq+Nzs+x6lZc7PZRd6kSlTb5+moABWotWmN24wNa1hPb0FAKlZ6
         6ecg==
X-Gm-Message-State: AOAM533/UCZUPBSf+6I5HUepj6svTvul9sbdrO/IqMN+kLl2kwZG5Ydi
        s94ikDnb/7y/Iv+vjBDqaonEJvLPcn7KbSVkRm8/DSwJe9ov/Np5qASvij8dB3bocfu+wtFu6NT
        PIAsZP5pS1gtrl6OdOup1odEO
X-Received: by 2002:a05:6402:1b06:: with SMTP id by6mr38822514edb.95.1626772598385;
        Tue, 20 Jul 2021 02:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDrAmbo6ANlymcQGs+SQHruUiSWgtvNqPSlFQywRs+deGFlzXhd7Tme6H/F4A3JjNsV5xdeA==
X-Received: by 2002:a05:6402:1b06:: with SMTP id by6mr38822496edb.95.1626772598147;
        Tue, 20 Jul 2021 02:16:38 -0700 (PDT)
Received: from krava ([83.240.63.206])
        by smtp.gmail.com with ESMTPSA id da23sm9062333edb.34.2021.07.20.02.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 02:16:37 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:16:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 3/3] perf tools: Enable on a list of CPUs for hybrid
Message-ID: <YPaUc3iodIASdYRY@krava>
References: <20210712071235.28533-1-yao.jin@linux.intel.com>
 <20210712071235.28533-4-yao.jin@linux.intel.com>
 <YPXUMTFbj2Tl3eBz@krava>
 <ecf0e815-616f-0a08-cefd-baac93c0e47d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf0e815-616f-0a08-cefd-baac93c0e47d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 03:07:02PM +0800, Jin, Yao wrote:

SNIP

> 
> OK, evlist__fix_cpus() is better, use this name in v4.
> 
> > > +{
> > > +	struct perf_cpu_map *cpus;
> > > +	struct evsel *evsel, *tmp;
> > > +	struct perf_pmu *pmu;
> > > +	int ret, unmatched_count = 0, events_nr = 0;
> > > +
> > > +	if (!perf_pmu__has_hybrid() || !cpu_list)
> > > +		return 0;
> > > +
> > > +	cpus = perf_cpu_map__new(cpu_list);
> > > +	if (!cpus)
> > > +		return -1;
> > > +
> > > +	evlist__for_each_entry_safe(evlist, tmp, evsel) {
> > > +		struct perf_cpu_map *matched_cpus, *unmatched_cpus;
> > > +		char buf1[128], buf2[128];
> > > +
> > > +		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
> > > +		if (!pmu)
> > > +			continue;
> > > +
> > > +		ret = perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
> > > +					   &unmatched_cpus);
> > > +		if (ret)
> > > +			goto out;
> > > +
> > > +		events_nr++;
> > > +
> > > +		if (matched_cpus->nr > 0 && (unmatched_cpus->nr > 0 ||
> > > +		    matched_cpus->nr < cpus->nr ||
> > > +		    matched_cpus->nr < pmu->cpus->nr)) {
> > > +			perf_cpu_map__put(evsel->core.cpus);
> > > +			perf_cpu_map__put(evsel->core.own_cpus);
> > > +			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
> > > +			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);
> > 
> > I'm bit confused in here.. AFAIUI there's 2 evsel objects create
> > for hybrid 'cycles' ... should they have already proper cpus set?
> > 
> 
> For 'cycles', yes two evsels are created automatically. One is for atom CPU
> (e.g. 8-11), the other is for core CPU (e.g. 0-7). In this example, these 2
> evsels have already the cpus set.

hum, so those evsels are created with pmu's cpus, right?

> 
> While the 'cpus' here is just the user specified cpu list.
> cpus = perf_cpu_map__new(cpu_list);

then I think they will be changed by evlist__create_maps
with whatever user wants?

could we just change __perf_evlist__propagate_maps to follow
pmu's cpus?

jirka

> 
> We need to check that the cpu in 'cpus' is available on hybrid pmu or not
> and adjust the evsel->core.cpus according the matching results.
> 
> > > +
> > > +			if (unmatched_cpus->nr > 0) {
> > > +				cpu_map__snprint(matched_cpus, buf1, sizeof(buf1));
> > > +				pr_warning("WARNING: use %s in '%s' for '%s', skip other cpus in list.\n",
> > > +					   buf1, pmu->name, evsel->name);
> > > +			}
> > > +		}
> > > +
> > > +		if (matched_cpus->nr == 0) {
> > > +			evlist__remove(evlist, evsel);
> > > +			evsel__delete(evsel);
> > > +
> > > +			cpu_map__snprint(cpus, buf1, sizeof(buf1));
> > > +			cpu_map__snprint(pmu->cpus, buf2, sizeof(buf2));
> > > +			pr_warning("WARNING: %s isn't a '%s', please use a CPU list in the '%s' range (%s)\n",
> > > +				   buf1, pmu->name, pmu->name, buf2);
> > > +			unmatched_count++;
> > > +		}
> > 
> > hum, should we rather fail in here?
> > 
> 
> perf stat -e cpu_core/cycles/,cpu_atom/instructions/ -C11
> 
> CPU11 is atom CPU so the evsel 'cpu_core/cycles/' is failed but cpu_atom/instructions/ is OK.
> 
> Don't we report the partially successful event?
> 
> Thanks
> Jin Yao
> 
> > jirka
> > 
> 

