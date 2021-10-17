Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54DB430BA7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbhJQTII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234918AbhJQTIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634497551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhLrgvl92SOuN+amkEP7tIEGzxF/NYFDa7oCqrxuZ1w=;
        b=iId7kAb4qZoHcIMrXZVpkThLG9hZIPEZ/9fmTAvYpU/fdmL7IDhzSN1Mx9Wh63GiF+mlg7
        Z5xDd1u7Hvp/q4zTMETdh/KxNdnhTXZkXXi80T9hYbLPQQcsT//HPx9X3NfHLtaHCrY20X
        WpQy5b8EaENdSXRhbe5I7whWPMKW1SI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-oL8it4HpMT2FjvY_ghPEaA-1; Sun, 17 Oct 2021 15:05:49 -0400
X-MC-Unique: oL8it4HpMT2FjvY_ghPEaA-1
Received: by mail-wm1-f72.google.com with SMTP id o196-20020a1ca5cd000000b0030dc197412aso2552934wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 12:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PhLrgvl92SOuN+amkEP7tIEGzxF/NYFDa7oCqrxuZ1w=;
        b=0wfOIy8nKeqKzjc9MwoPaJDFSISb9ic3GzzP09emYOe4x9RKv02Vt0g6tmpcWNIYo8
         JOxNIMH1/U2BbvStShTmsGqCmJIOnSU8934R0sOI2PlasL5W/l0l2pO3sIZt09OBJNbR
         BcZ7Qs9XtLmk1DQoDsqy7787Z/aE6QW1wmEVGxZ9TNvOYKDddvrPtDu+zm6ev/9O4APW
         8DCdOD1X6EGjV67LiW2ZNO1DadvjCzdwzacQmAwIX1jXjlNKUBvTeSz5RMIuks14D/Wu
         rWQvj+k7y9V/YeGpNsCaXiXjiBdigirZOUdcEMDvkPqu7TxnKIBGmV/nBiJjJcODOYLT
         lgCg==
X-Gm-Message-State: AOAM532Qy4P3Msffma7R4ay832iEqnxf+2Z4+CmrqM2E1rn5TpS22Sxt
        XEiONZ0x7jg3pOn/Ab+szrJckgsZkQKaRQv9Lfrdi2IejpEsAsEiaES+1KDnsSY++ufxbgayXtd
        jo5O8SEQ6TEzqU6ozV/0o1wyN
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr26678525wmg.129.1634497548748;
        Sun, 17 Oct 2021 12:05:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIarph1p2tV0Gn76CbVa7QuKFyD0RSnLMqx7bdO9kBVfCj9OjbUwHuDWOZaIskNP0aaDPDaQ==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr26678499wmg.129.1634497548501;
        Sun, 17 Oct 2021 12:05:48 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id r3sm10477211wrw.55.2021.10.17.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 12:05:48 -0700 (PDT)
Date:   Sun, 17 Oct 2021 21:05:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YWx0CgTyyZ4sm/l4@krava>
References: <20211016051253.2035821-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016051253.2035821-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:12:53PM -0700, Namhyung Kim wrote:
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
>  tools/perf/util/evsel.c | 47 +++++++++++++++++++++++++++++++++++------
>  tools/perf/util/evsel.h |  6 ++++++
>  2 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..437a28e769fe 100644
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
> +		void *pmu;

could you just pass NULL in here instead of NULL?

> +
> +		if (hashmap__find(perf_missing_features.pmu, evsel, &pmu)) {
> +			evsel->core.attr.exclude_guest = 0;
> +			evsel->core.attr.exclude_host = 0;
> +		}
> +	}
>  	if (perf_missing_features.lbr_flags)
>  		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
>  				     PERF_SAMPLE_BRANCH_NO_CYCLES);
> @@ -1840,6 +1867,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  bool evsel__detect_missing_features(struct evsel *evsel)
>  {
> +	if (perf_missing_features.pmu == NULL)
> +		perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);
> +
>  	/*
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
> @@ -1900,10 +1930,15 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>  		perf_missing_features.mmap2 = true;
>  		pr_debug2_peo("switching off mmap2\n");
>  		return true;
> -	} else if (!perf_missing_features.exclude_guest &&
> -		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> -		perf_missing_features.exclude_guest = true;
> -		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> +	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
> +		   !hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> +		struct perf_missing_pmu_features pmu_features = { true };

missing new line after declaration

> +		hashmap__add(perf_missing_features.pmu, evsel, &pmu_features);
> +
> +		if (!perf_missing_features.exclude_guest) {
> +			perf_missing_features.exclude_guest = true;
> +			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> +		}
>  		return true;
>  	} else if (!perf_missing_features.sample_id_all) {
>  		perf_missing_features.sample_id_all = true;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 1f7edfa8568a..8dd11c8e022d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -172,6 +172,12 @@ struct perf_missing_features {
>  	bool data_page_size;
>  	bool code_page_size;
>  	bool weight_struct;
> +
> +	struct hashmap *pmu;
> +};
> +
> +struct perf_missing_pmu_features {
> +	bool exclude_guest;
>  };

hum, is this really needed? I think you could just pass '1' as value,
because you care only if the item is hashed, right?

in any case the value is the current stack address of the
  struct perf_missing_pmu_features pmu_features = { true };

so it might as well be just '1' ... I was confused at the beggining
and looked for the reason of this struct ;-)

we do that already in util/stat.c

jirka

>  
>  extern struct perf_missing_features perf_missing_features;
> -- 
> 2.33.0.1079.g6e70778dc9-goog
> 

