Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E498442260
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhKAVL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhKAVLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:11:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85AC360E78;
        Mon,  1 Nov 2021 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635800957;
        bh=sEfKN0NZd6gkY2xJp3EuoMMK4sBsBMev9r7FJ/wAeQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5bc33fftzS4eBz3uQdewHKnMjK0/grj7AgqNu51QICp97AuxMVDQY5TFyi0o/ffi
         O7ee7nteYowRZ+Db0UPTc7RODokE+ThEM1pTdk3wCa9xkZCUcvthXmqjxW8SBSgzWQ
         p3Qfwpz8AWYz/RfMaNpTNNMmwDFjjDihUX5MVUDv+/HVQoQ1C6Ru1956j5uqutRmdB
         XEDPXFDOIitIawV7Z1N5tVEM/LbGieLZQ2bAu2XU4PB6+9ZjST+XVmVWcp178wIUHk
         AIsQJU/XR999r22TSMmd7VYfiXlekNCbNnQiyyQNt9F4lOLayD4/+5j60zLJNOKUzw
         tp5I09pK/0qag==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD549410A1; Mon,  1 Nov 2021 18:09:13 -0300 (-03)
Date:   Mon, 1 Nov 2021 18:09:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YYBXeVFPfm1ZWgBG@kernel.org>
References: <20211029224929.379505-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029224929.379505-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 29, 2021 at 03:49:29PM -0700, Namhyung Kim escreveu:
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

Can't hashmap__add() fail?

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

-- 

- Arnaldo
