Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8A43B9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhJZSe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230483AbhJZSe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635273124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6pSoHrzFEYek0223M2oApqe/5UK7C/flZHJtZGdaKY=;
        b=JkOxtUAnFRzoyjpzM/hp/GzSy4kbdQovGeYJZglv4DiNZcMCRkd54QNfAFMDxwceLjM9RK
        G5gBkOYD+rZRcZRXlm3I2wGfxU2Ct8fsVdxLDwEvgJIvDAQoLPCuoqMiZNSkEYkbWlQtWg
        KihU7iMxlLnQo81FTt4Tjv3CAk7iFj8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-oTYx06uiNr69xFPKBFYeEA-1; Tue, 26 Oct 2021 14:32:02 -0400
X-MC-Unique: oTYx06uiNr69xFPKBFYeEA-1
Received: by mail-wm1-f69.google.com with SMTP id j38-20020a05600c1c2600b0032ccf96ea8eso33012wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f6pSoHrzFEYek0223M2oApqe/5UK7C/flZHJtZGdaKY=;
        b=t6+/6N3I0gtq43jG76tPT1f3qqfo2HisXymbEB1LxHv6RV/u11Ci9A649jAJUAFmr6
         BvOsWXpu5nciGPq7VGiN5hwveFFI0OvfsjWHBHCT5UJ62xhAOhVSUXb78kx41XYdzgoQ
         hsNQrsd2e4aMGiaRW2l6Ews81dWWzgHclU0Q6YB3bgdQEUGakhMJNCoSh9ADBT0hRilU
         J4zRCUSL2bmo8w4RpwF07r3/MZ+UjE0X6kq53huxAEV33CIO7wv4VbMyvUJrc6Dk9vtX
         ypIKPwA/exmUpwUa+woTOkAqquid9747Qu/hsquueZ/DTeMegZBEP/nYcA/CZ/wp1xHh
         rD5w==
X-Gm-Message-State: AOAM532SvHWMCCVyLh6VZdGoW5QAJUXfmFAWSJi+3wsR0bxCiaa+b46W
        PW8zxd8rbSjb29YnkCk4oJbUjyeZt+TUBw5JceQb07yoQFL9fjU0M5krdLEk9EYT82PE383nMUr
        dLZdY7VPcL8P5H1n05Yv1lHw2
X-Received: by 2002:a05:6000:2c2:: with SMTP id o2mr34691379wry.194.1635273121541;
        Tue, 26 Oct 2021 11:32:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnLUqQTK0PIG2QP9VGljoN5Qj/XBM8jVg3Cd5CQmCqll0fpzOMoEbahJ47iwL44t2zeGBYVQ==
X-Received: by 2002:a05:6000:2c2:: with SMTP id o2mr34691361wry.194.1635273121346;
        Tue, 26 Oct 2021 11:32:01 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id p11sm1371031wmi.0.2021.10.26.11.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:32:01 -0700 (PDT)
Date:   Tue, 26 Oct 2021 20:31:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YXhJn8rtkATcN9ZE@krava>
References: <20211026043351.56662-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026043351.56662-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 09:33:51PM -0700, Namhyung Kim wrote:
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
> v2 changes)
>  * change to enum perf_missing_pmu_features
>  * pass NULL to hashmap__find() to skip checking
>  * add a blank line after declaration
> 
>  tools/perf/util/evsel.c | 47 +++++++++++++++++++++++++++++++++++------
>  tools/perf/util/evsel.h |  7 ++++++
>  2 files changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..f33801b4615d 100644
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

should this just remove evsel from perf_missing_features.pmu?

I'm not sure when we should actually release this.. what's your rationale
for releasing it in here?

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
> @@ -1807,8 +1828,13 @@ static void evsel__disable_missing_features(struct evsel *evsel)
>  		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
>  	if (perf_missing_features.mmap2)
>  		evsel->core.attr.mmap2 = 0;
> -	if (perf_missing_features.exclude_guest)
> -		evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
> +	if (perf_missing_features.exclude_guest) {
> +		/* we only have EXCLUDE_GUEST bit, let's skip checking  */
> +		if (hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> +			evsel->core.attr.exclude_guest = 0;
> +			evsel->core.attr.exclude_host = 0;
> +		}
> +	}
>  	if (perf_missing_features.lbr_flags)
>  		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
>  				     PERF_SAMPLE_BRANCH_NO_CYCLES);
> @@ -1840,6 +1866,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  bool evsel__detect_missing_features(struct evsel *evsel)
>  {
> +	if (perf_missing_features.pmu == NULL)
> +		perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);

missing allocation fail check

thanks,
jirka

> +
>  	/*
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
> @@ -1900,10 +1929,16 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>  		perf_missing_features.mmap2 = true;
>  		pr_debug2_peo("switching off mmap2\n");
>  		return true;
> -	} else if (!perf_missing_features.exclude_guest &&
> -		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> -		perf_missing_features.exclude_guest = true;
> -		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> +	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
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
> 2.33.0.1079.g6e70778dc9-goog
> 

