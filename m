Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6A442FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKBOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230208AbhKBOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635862220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86ZdZUm6BVWafF2DKgMsTetmERlgP6t1RGR51JEaCCI=;
        b=OGcft0uNClkPjQSD96l383qi51MLX+q4oj/IW2ehN0qN/7ZKXe334h1bx2NK+Z/ZjT5YAY
        piRWXFfzPT86ssGLGEks08qUQwpEWxmaaN0R1GcqoWF41mg2rcIoW8QRzJ04LV5t5DYt46
        XobZQKtuBy909FX5DLUYZo41JuuiHzA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-6kOk1-uuNEinKpmn3WLpBQ-1; Tue, 02 Nov 2021 10:10:19 -0400
X-MC-Unique: 6kOk1-uuNEinKpmn3WLpBQ-1
Received: by mail-ed1-f69.google.com with SMTP id y12-20020a056402270c00b003e28de6e995so5469061edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=86ZdZUm6BVWafF2DKgMsTetmERlgP6t1RGR51JEaCCI=;
        b=20gKKQPZyKeqd6zTR56xIOxw1mOCgoO1Os1TUzcbXshT0jwHgg1GLsOcd8S7IN0Gk4
         ZhuEgRugZpQykFY1KJJEK0xihwAWdRRZxFKxJwNFg3EpdEOvbeKQdNEmyq1HG5n6gI/E
         Gj3CfPQsoVoeMdgLCjaIljJxtg1Dm3Y95LLTsX7nCfsQ5YpLiA9Qe0Sb9tw1ZxwtBn3V
         NRjtZ96QFSf4Z4OIS51rIFmNVXuloSE+ObgpG5Y07N7bpw3+DxcVHF0ORcGIPlhf1l8P
         DxFqG79vYw3hHHcfm8N62XXtKP4bUi9oIOgxeCwTUCH9vuC36JlIVQ5FO4FCZQtCy410
         ElQg==
X-Gm-Message-State: AOAM531Di1CKiFMq6z3/ru+LjWLAUmClytUnoiyvKlifuCNYSCAAsL1J
        ohUgpO4bFbpPXbIRF2U8IPInqC+2p+Y1hGstc+t0OVQg7XPd2iClwqP6RhVGFK80nL+rJ1WS3qv
        yVhIVSUHBxR7yI7wkoD0kA3PO
X-Received: by 2002:a05:6402:141:: with SMTP id s1mr51523202edu.317.1635862217881;
        Tue, 02 Nov 2021 07:10:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgSMWvUdqe4Amb7cVh+0lScwAX1oJJ5cj2yDtbS70L1GrVy4vaz/gplSKoY0UFXPb/4MaPAQ==
X-Received: by 2002:a05:6402:141:: with SMTP id s1mr51523182edu.317.1635862217616;
        Tue, 02 Nov 2021 07:10:17 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id h17sm5081574ede.38.2021.11.02.07.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:10:17 -0700 (PDT)
Date:   Tue, 2 Nov 2021 15:10:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YYFGxwFMvTRN5KBI@krava>
References: <20211029224929.379505-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029224929.379505-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 03:49:29PM -0700, Namhyung Kim wrote:
> The current logic for the perf missing feature has a bug that it can
> wrongly clear some modifiers like G or H.  Actually some PMUs don't
> support any filtering or exclusion while others do.  But we check it
> as a global feature.
> 
> For example, the cycles event can have 'G' modifier to enable it only
> in the guest mode on x86.  When you don't run any VMs it'll return 0.
> 
>   # perf stat -a -e cycles:G sleep 1
> 
>     Performance counter stats for 'system wide':
> 
>                     0      cycles:G
> 
>           1.000721670 seconds time elapsed
> 
> But when it's used with other pmu events that don't support G modifier,
> it'll be reset and return non-zero values.
> 
>   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> 
>     Performance counter stats for 'system wide':
> 
>           538,029,960      cycles:G
>        16,924,010,738      msr/tsc/
> 
>           1.001815327 seconds time elapsed
> 
> This is because of the missing feature detection logic being global.
> Add a hashmap to set pmu-specific exclude_host/guest features.
> 
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v3 changes)
>  * check memory allocation failure
>  * add more NULL check

we were discussing this with Arnaldo yesterday and he had an idea to use
evsel->pmu link to store this info instead of hash.. I first thought we
needed 'evsel' related data, but after I gave it some thought I think that
might actually work

my argument was following usecase:

  cycles:G,instructions:G,pmu/bla1/:G,pmu/bla2/

that we would falsely clear pmu/bla1/:G if we used the 'evsel->pmu' data..
but then I realized it's detection if pmu support :G and so if the :G is
not there, none of the events should have it

thoughts?

thanks,
jirka


> 
> v2 changes)
>  * change to enum perf_missing_pmu_features
>  * pass NULL to hashmap__find() to skip checking
>  * add a blank line after declaration
> 
>  tools/perf/util/evsel.c | 54 ++++++++++++++++++++++++++++++++++++-----
>  tools/perf/util/evsel.h |  7 ++++++
>  2 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..d3ff4809627b 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1434,6 +1434,10 @@ void evsel__delete(struct evsel *evsel)
>  {
>  	evsel__exit(evsel);
>  	free(evsel);
> +
> +	/* just free it for the first evsel */
> +	hashmap__free(perf_missing_features.pmu);
> +	perf_missing_features.pmu = NULL;
>  }
>  
>  void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
> @@ -1791,6 +1795,23 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	return 0;
>  }
>  
> +#define PMU_HASH_BITS  4
> +
> +static size_t pmu_hash(const void *key, void *ctx __maybe_unused)
> +{
> +	const struct evsel *evsel = key;
> +
> +	return hash_bits(evsel->core.attr.type, PMU_HASH_BITS);
> +}
> +
> +static bool pmu_equal(const void *key1, const void *key2, void *ctx __maybe_unused)
> +{
> +	const struct evsel *a = key1;
> +	const struct evsel *b = key2;
> +
> +	return a->core.attr.type == b->core.attr.type;
> +}
> +
>  static void evsel__disable_missing_features(struct evsel *evsel)
>  {
>  	if (perf_missing_features.weight_struct) {
> @@ -1807,8 +1828,14 @@ static void evsel__disable_missing_features(struct evsel *evsel)
>  		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
>  	if (perf_missing_features.mmap2)
>  		evsel->core.attr.mmap2 = 0;
> -	if (perf_missing_features.exclude_guest)
> -		evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
> +	if (perf_missing_features.exclude_guest) {
> +		/* we only have EXCLUDE_GUEST bit, let's skip checking  */
> +		if (perf_missing_features.pmu != NULL &&
> +		    hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> +			evsel->core.attr.exclude_guest = 0;
> +			evsel->core.attr.exclude_host = 0;
> +		}
> +	}
>  	if (perf_missing_features.lbr_flags)
>  		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
>  				     PERF_SAMPLE_BRANCH_NO_CYCLES);
> @@ -1840,6 +1867,14 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  bool evsel__detect_missing_features(struct evsel *evsel)
>  {
> +	if (perf_missing_features.pmu == NULL) {
> +		perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);
> +		if (IS_ERR(perf_missing_features.pmu)) {
> +			pr_err("Memory allocation failure!\n");
> +			perf_missing_features.pmu = NULL;
> +		}
> +	}
> +
>  	/*
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
> @@ -1900,10 +1935,17 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>  		perf_missing_features.mmap2 = true;
>  		pr_debug2_peo("switching off mmap2\n");
>  		return true;
> -	} else if (!perf_missing_features.exclude_guest &&
> -		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> -		perf_missing_features.exclude_guest = true;
> -		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> +	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
> +		   perf_missing_features.pmu != NULL &&
> +		   !hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> +		uintptr_t pmu_features = PERF_MISSING_PMU_EXCLUDE_GUEST;
> +
> +		hashmap__add(perf_missing_features.pmu, evsel, (void *)pmu_features);
> +
> +		if (!perf_missing_features.exclude_guest) {
> +			perf_missing_features.exclude_guest = true;
> +			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> +		}
>  		return true;
>  	} else if (!perf_missing_features.sample_id_all) {
>  		perf_missing_features.sample_id_all = true;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 1f7edfa8568a..11b5ece19f0e 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -172,6 +172,13 @@ struct perf_missing_features {
>  	bool data_page_size;
>  	bool code_page_size;
>  	bool weight_struct;
> +
> +	/* contains enum perf_missing_pmu_features below */
> +	struct hashmap *pmu;
> +};
> +
> +enum perf_missing_pmu_features {
> +	PERF_MISSING_PMU_EXCLUDE_GUEST		= 1UL << 0,
>  };
>  
>  extern struct perf_missing_features perf_missing_features;
> -- 
> 2.33.1.1089.g2158813163f-goog
> 

