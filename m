Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B340720A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhIJTeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhIJTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631302385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0X78Rx8PEU2bGck9prhr9nA8dirqKGHObRz/km7EfAA=;
        b=Bj4IcHAn4VBX3cynAWDx0the7E3F7NB1zTr8MITgqlVEzcOrZxhyXP8K4wkKEeRQ1YfLFi
        bmDi+IchvoZ/IW0h9EB48rLQ3EkEQphWYNFDl0yd+GZz1A0xYVyxuBPmzWVH6ze0UJs35P
        TjQZqGwB/j3ilM3mCbORuw3p2TWrtVE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-BWb1mZSrMYyXfYVKQ8j-DA-1; Fri, 10 Sep 2021 15:33:04 -0400
X-MC-Unique: BWb1mZSrMYyXfYVKQ8j-DA-1
Received: by mail-ej1-f70.google.com with SMTP id o14-20020a1709062e8e00b005d37183e041so1528944eji.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0X78Rx8PEU2bGck9prhr9nA8dirqKGHObRz/km7EfAA=;
        b=mIxEi88Kpsc0eq7Ezzq/uVTrkaXtfO04X7giGEJ4lOtH5RgdDtGeeErem4JW8woN3I
         zlcdcm+C3Mc7lmT8dIWMMu2fn0ZTr4IY8Zyj8rQbMdmH9nje3uz2WLYRCvEF5wp/riIN
         u9XImWlUC+D4cAxlaqG+5SrZ8txmhz/4Tldh113LNQeS1h3rBq5hpZEBbjzsarm7EO3O
         WWUQqmehICYSzrr/9u8Il+SWPwXp6e+rykDkES5Mcq8AlDb7pB8xFlDX32mwwF5LXHqs
         sd8iJjfv80RMIST0vvpBgEde/kRA/XMJryfCO69NsjqpU74qBWDjG2NMCbynB+wF5eZ0
         4NEQ==
X-Gm-Message-State: AOAM532OKFtz0ZILsoyNW7zVk6A5Eu9HshQHQP3N4e5th/QRrTQl2CNK
        ad9jcoV+wpOhs8NBdUCB9xPkClYwXtxwdljF+M+k1HDFQRRXtxx3FNFc6LGXX5mnEibeSlIm6K1
        pFYisavxeEyLbce/3BVr8AHb3
X-Received: by 2002:a17:906:c7d0:: with SMTP id dc16mr11193806ejb.555.1631302382690;
        Fri, 10 Sep 2021 12:33:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbqAyS3xE9Hg5m/vdEVJDcoO8Js2yIMpXUtzDeDwykWF1379isGdDp4t37HMtO0c9Ob0VLwg==
X-Received: by 2002:a17:906:c7d0:: with SMTP id dc16mr11193791ejb.555.1631302382482;
        Fri, 10 Sep 2021 12:33:02 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id c7sm3083007ede.21.2021.09.10.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:33:01 -0700 (PDT)
Date:   Fri, 10 Sep 2021 21:32:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tools: Fix hybrid config terms list corruption
Message-ID: <YTuy66ZrpJz508wi@krava>
References: <20210909125508.28693-1-adrian.hunter@intel.com>
 <20210909125508.28693-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909125508.28693-3-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 03:55:08PM +0300, Adrian Hunter wrote:
> A config terms list was spliced twice, resulting in a never-ending loop
> when the list was traversed. Fix by using list_splice_init() and copying
> and freeing the lists as necessary.
> 
> This patch also depends on patch "perf tools: Factor out
> copy_config_terms() and free_config_terms()"
> 
> Example on ADL:
> 
>  Before:
> 
>  # perf record -e '{intel_pt//,cycles/aux-sample-size=4096/pp}' uname &
>  # jobs
>  [1]+  Running                    perf record -e "{intel_pt//,cycles/aux-sample-size=4096/pp}" uname
>  # perf top -E 10
>    PerfTop:    4071 irqs/sec  kernel: 6.9%  exact: 100.0% lost: 0/0 drop: 0/0 [4000Hz cycles],  (all, 24 CPUs)
>  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
>     97.60%  perf           [.] __evsel__get_config_term
>      0.25%  [kernel]       [k] kallsyms_expand_symbol.constprop.13
>      0.24%  perf           [.] kallsyms__parse
>      0.15%  [kernel]       [k] _raw_spin_lock
>      0.14%  [kernel]       [k] number
>      0.13%  [kernel]       [k] advance_transaction
>      0.08%  [kernel]       [k] format_decode
>      0.08%  perf           [.] map__process_kallsym_symbol
>      0.08%  perf           [.] rb_insert_color
>      0.08%  [kernel]       [k] vsnprintf
>  exiting.
>  # kill %1
> 
> After:
> 
>  # perf record -e '{intel_pt//,cycles/aux-sample-size=4096/pp}' uname &
>  Linux
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.060 MB perf.data ]
>  # perf script | head
>        perf-exec   604 [001]  1827.312293:                            psb:  psb offs: 0                       ffffffffb8415e87 pt_config_start+0x37 ([kernel.kallsyms])
>        perf-exec   604  1827.312293:          1                       branches:  ffffffffb856a3bd event_sched_in.isra.133+0xfd ([kernel.kallsyms]) => ffffffffb856a9a0 perf_pmu_nop_void+0x0 ([kernel.kallsyms])
>        perf-exec   604  1827.312293:          1                       branches:  ffffffffb856b10e merge_sched_in+0x26e ([kernel.kallsyms]) => ffffffffb856a2c0 event_sched_in.isra.133+0x0 ([kernel.kallsyms])
>        perf-exec   604  1827.312293:          1                       branches:  ffffffffb856a45d event_sched_in.isra.133+0x19d ([kernel.kallsyms]) => ffffffffb8568b80 perf_event_set_state.part.61+0x0 ([kernel.kallsyms])
>        perf-exec   604  1827.312293:          1                       branches:  ffffffffb8568b86 perf_event_set_state.part.61+0x6 ([kernel.kallsyms]) => ffffffffb85662a0 perf_event_update_time+0x0 ([kernel.kallsyms])
>        perf-exec   604  1827.312293:          1                       branches:  ffffffffb856a35c event_sched_in.isra.133+0x9c ([kernel.kallsyms]) => ffffffffb8567610 perf_log_itrace_start+0x0 ([kernel.kallsyms])
>        perf-exec   604  1827.312293:          1                       branches:  ffffffffb856a377 event_sched_in.isra.133+0xb7 ([kernel.kallsyms]) => ffffffffb8403b40 x86_pmu_add+0x0 ([kernel.kallsyms])
>        perf-exec   604  1827.312293:          1                       branches:  ffffffffb8403b86 x86_pmu_add+0x46 ([kernel.kallsyms]) => ffffffffb8403940 collect_events+0x0 ([kernel.kallsyms])
>        perf-exec   604  1827.312293:          1                       branches:  ffffffffb8403a7b collect_events+0x13b ([kernel.kallsyms]) => ffffffffb8402cd0 collect_event+0x0 ([kernel.kallsyms])
> 
> Fixes: 94da591b1c7913 ("perf parse-events: Create two hybrid raw events")
> Fixes: 9cbfa2f64c04d9 ("perf parse-events: Create two hybrid hardware events")
> Fixes: 30def61f64bac5 ("perf parse-events: Create two hybrid cache events")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/parse-events-hybrid.c | 18 +++++++++++++++---
>  tools/perf/util/parse-events.c        | 18 ++++++++++++------
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
> index 10160ab126f9..b234d95fb10a 100644
> --- a/tools/perf/util/parse-events-hybrid.c
> +++ b/tools/perf/util/parse-events-hybrid.c
> @@ -76,12 +76,16 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
>  	int ret;
>  
>  	perf_pmu__for_each_hybrid_pmu(pmu) {
> +		LIST_HEAD(terms);
> +
>  		if (pmu_cmp(parse_state, pmu))
>  			continue;
>  
> +		copy_config_terms(&terms, config_terms);
>  		ret = create_event_hybrid(PERF_TYPE_HARDWARE,
>  					  &parse_state->idx, list, attr, name,
> -					  config_terms, pmu);
> +					  &terms, pmu);
> +		free_config_terms(&terms);

hm, why is this needed.. there's now list_splice_init &terms within
create_event_hybrid call right? so there should be nothing nothing
to clean

same below

>  		if (ret)
>  			return ret;
>  	}
> @@ -115,11 +119,15 @@ static int add_raw_hybrid(struct parse_events_state *parse_state,
>  	int ret;
>  
>  	perf_pmu__for_each_hybrid_pmu(pmu) {
> +		LIST_HEAD(terms);
> +
>  		if (pmu_cmp(parse_state, pmu))
>  			continue;
>  
> +		copy_config_terms(&terms, config_terms);
>  		ret = create_raw_event_hybrid(&parse_state->idx, list, attr,
> -					      name, config_terms, pmu);
> +					      name, &terms, pmu);
> +		free_config_terms(&terms);
>  		if (ret)
>  			return ret;
>  	}
> @@ -165,11 +173,15 @@ int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
>  
>  	*hybrid = true;
>  	perf_pmu__for_each_hybrid_pmu(pmu) {
> +		LIST_HEAD(terms);
> +
>  		if (pmu_cmp(parse_state, pmu))
>  			continue;
>  
> +		copy_config_terms(&terms, config_terms);
>  		ret = create_event_hybrid(PERF_TYPE_HW_CACHE, idx, list,
> -					  attr, name, config_terms, pmu);
> +					  attr, name, &terms, pmu);
> +		free_config_terms(&terms);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index ded5808798f9..51a2219df601 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -387,7 +387,7 @@ __add_event(struct list_head *list, int *idx,
>  		evsel->name = strdup(name);
>  
>  	if (config_terms)
> -		list_splice(config_terms, &evsel->config_terms);
> +		list_splice_init(config_terms, &evsel->config_terms);
>  
>  	if (list)
>  		list_add_tail(&evsel->core.node, list);
> @@ -535,9 +535,12 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>  					     config_name ? : name, &config_terms,
>  					     &hybrid, parse_state);
>  	if (hybrid)
> -		return ret;
> +		goto out_free_terms;
>  
> -	return add_event(list, idx, &attr, config_name ? : name, &config_terms);
> +	ret = add_event(list, idx, &attr, config_name ? : name, &config_terms);
> +out_free_terms:
> +	free_config_terms(&config_terms);

.. apart from this one and below, when coming from 'goto out_free_terms'
we should call free_config_terms

jirka

> +	return ret;
>  }
>  
>  static void tracepoint_error(struct parse_events_error *e, int err,
> @@ -1457,10 +1460,13 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  					       get_config_name(head_config),
>  					       &config_terms, &hybrid);
>  	if (hybrid)
> -		return ret;
> +		goto out_free_terms;
>  
> -	return add_event(list, &parse_state->idx, &attr,
> -			 get_config_name(head_config), &config_terms);
> +	ret = add_event(list, &parse_state->idx, &attr,
> +			get_config_name(head_config), &config_terms);
> +out_free_terms:
> +	free_config_terms(&config_terms);
> +	return ret;
>  }
>  
>  int parse_events_add_tool(struct parse_events_state *parse_state,
> -- 
> 2.17.1
> 

