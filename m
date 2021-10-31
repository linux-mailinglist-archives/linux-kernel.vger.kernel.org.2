Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957ED440DEB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 12:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJaLQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 07:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229638AbhJaLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 07:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635678842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZhE9mdP0aHXgyKJcuJZIJp6d1riyeDiPOisCSHkBWE=;
        b=GV3I5hMBKZjKomjhyr4suKcqBvVro8xiaqymloXTWLA3YFG6oCZ4gqt7ClLpT408s8ZiOh
        A9uwMwoRC7j+QIl/Y6tF8uqsiORt2LiEJW9zbw1ad55W74QZkb4GP573T1kBYylDbGe3LI
        12hUithQREo7F2jseuM2/mgyqj7ZMA4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-YuahG6UZNnWXv10h2J34eA-1; Sun, 31 Oct 2021 07:14:01 -0400
X-MC-Unique: YuahG6UZNnWXv10h2J34eA-1
Received: by mail-ed1-f70.google.com with SMTP id i9-20020a508709000000b003dd4b55a3caso13108207edb.19
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 04:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AZhE9mdP0aHXgyKJcuJZIJp6d1riyeDiPOisCSHkBWE=;
        b=n9VpMBuMSQyYM0+yJJ4x8XRsL/Vq3n9a6dy6+U62gFqbg7scqkXv2Q7rync2vPqByV
         bge/Sp8jiFhl1t4mVSATuT13klkqO3N1ReR2Q8VstETo9pdKgrgtAzoKtYZDuvVwgyL3
         zObF8E7A+9T2X4ofZlgRzFHEBWL8LXOhr1jPjbeJ1LTTJO4HEzmkYKYosrCixZs3OVGK
         ysbsbSJDh29TlVWzheMluF10Sy8DI6Admr+/2SSb3HSAb7a9xK4TAqCuRI+z3GGqTvsa
         esVAArcamFV6zYhn22i8d2tRvs2UBdDgiMeQObnLMKUoCojjpHXVhoNEyvyAN+Fw1uwV
         y02A==
X-Gm-Message-State: AOAM533NAS9znkW6hhOb75pFQlfQ1c14+KUqoZb53fUWEgsA4v5wRvmc
        ZY/miSJKe4fX+92th9YO3AlgYdnrjF548s8VJXBaSfO6ghZXZ2Mu8Hs9SakOeAX+9R5ggAxIAWK
        yvbfp1SUYw5TTudSGpAwiwG9j
X-Received: by 2002:a50:c3cc:: with SMTP id i12mr30946852edf.350.1635678839632;
        Sun, 31 Oct 2021 04:13:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznOYzluTgugVLqSq0ST5o9M4Zux8ysNixdSIyCDww0E/TLQKZ70UZ3XFjms7YCYT2pRCrt6Q==
X-Received: by 2002:a50:c3cc:: with SMTP id i12mr30946832edf.350.1635678839412;
        Sun, 31 Oct 2021 04:13:59 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id m10sm7023234edi.72.2021.10.31.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 04:13:58 -0700 (PDT)
Date:   Sun, 31 Oct 2021 12:13:57 +0100
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
Message-ID: <YX56dQxFINH4a4Su@krava>
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

Acked-by: Jiri Olsa <jolsa@redhat.com>

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

