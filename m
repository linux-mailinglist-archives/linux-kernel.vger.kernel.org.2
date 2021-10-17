Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A7D430C3B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 23:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbhJQVJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 17:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232986AbhJQVJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 17:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634504822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LpIzi+9NK3PUf6LBs0Ejb1HOONl7d1E7Nt5k4G5ZxtQ=;
        b=GvPZ40/jHx4yAVBHlWhdTYW5moUe4BzaxG/9iImfnBiXAg7zO/WOpm/LXlXakq8bzb020r
        ev+aqKhtQerwtvs3Wy9oMMT0IC3bXea7QGIinvPhZ0eay9c2xmfarwUkGNkUTjStLDB5w8
        xELakRYuepHUSBPLVB2tmSQbU6nrtbQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-jYMTrtmrMlWkzEtkdEYVJg-1; Sun, 17 Oct 2021 17:07:01 -0400
X-MC-Unique: jYMTrtmrMlWkzEtkdEYVJg-1
Received: by mail-wr1-f71.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so7864580wrv.19
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 14:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpIzi+9NK3PUf6LBs0Ejb1HOONl7d1E7Nt5k4G5ZxtQ=;
        b=KJ57XCvTt/gstqd6UBwkusDq2Py2TQr6v4wUTmqUDNbARIMcD9TCcu23kHIZEEhrVh
         6TsXobFBuKx7DcyjMsMf1QeZi1sgLtv50H5WbaYKQBNrGuYTIvLuypuWgXcYK8KemYue
         TeFHhxJqNduHA+h7C0W2UtsgcLZcPJJlVFgNQ6BWOCq7NRK/iZcH8+cUpTgeBm+P4GVT
         FdXCq+xjY9mt/hR0Cv6FW1Ow2Ut7xnfYqxiAemMJQsG+GbeKcuVNXrd2J/olf8k3hwF4
         LfIrDY185vvoDjpuWdBqCwXDqJg5g9wLH97AWg/YVoLcDRNEiDqI0fU9LsWeLziPGWsJ
         MmiQ==
X-Gm-Message-State: AOAM530sm3PvLxT6UZHHIqC/e3hzwgk6KKLyFkB5yeeNcHU7pT+slh8F
        BfucG/Oc1VK1kAvs50bnYq0Y6akINomMhaRUKMwgWCMmEd1AZh7fyMCNK9vL5dLNwXeKzUMi3+Z
        D4ZZtaVPFUoRH6tirZXJHiA9W
X-Received: by 2002:adf:a454:: with SMTP id e20mr30948948wra.310.1634504819958;
        Sun, 17 Oct 2021 14:06:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFDy8Auos8k52A0eh6u4EO2wmKP0ZWb/82GK7fDpUrpwpzqnsQVWGDon7rX8LYqbCCWrGVgw==
X-Received: by 2002:adf:a454:: with SMTP id e20mr30948934wra.310.1634504819682;
        Sun, 17 Oct 2021 14:06:59 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id d9sm10739783wrm.96.2021.10.17.14.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 14:06:59 -0700 (PDT)
Date:   Sun, 17 Oct 2021 23:06:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YWyQcS5WYFBSeS2F@krava>
References: <20211016051253.2035821-1-namhyung@kernel.org>
 <YWx0CgTyyZ4sm/l4@krava>
 <E4C04539-9803-4405-A1EA-5D9517682E08@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E4C04539-9803-4405-A1EA-5D9517682E08@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 06:03:21PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> 
> On October 17, 2021 4:05:46 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrote:
> >On Fri, Oct 15, 2021 at 10:12:53PM -0700, Namhyung Kim wrote:
> >> The current logic for the perf missing feature has a bug that it can
> >> wrongly clear some modifiers like G or H.  Actually some PMUs don't
> >> support any filtering or exclusion while others do.  But we check it
> >> as a global feature.
> >> 
> >> For example, the cycles event can have 'G' modifier to enable it only
> >> in the guest mode on x86.  When you don't run any VMs it'll return 0.
> >> 
> >>   # perf stat -a -e cycles:G sleep 1
> >> 
> >>     Performance counter stats for 'system wide':
> >> 
> >>                     0      cycles:G
> >> 
> >>           1.000721670 seconds time elapsed
> >> 
> >> But when it's used with other pmu events that don't support G modifier,
> >> it'll be reset and return non-zero values.
> >> 
> >>   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> >> 
> >>     Performance counter stats for 'system wide':
> >> 
> >>           538,029,960      cycles:G
> >>        16,924,010,738      msr/tsc/
> >> 
> >>           1.001815327 seconds time elapsed
> >> 
> >> This is because of the missing feature detection logic being global.
> >> Add a hashmap to set pmu-specific exclude_host/guest features.
> >> 
> >> Reported-by: Stephane Eranian <eranian@google.com>
> >> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >> ---
> >>  tools/perf/util/evsel.c | 47 +++++++++++++++++++++++++++++++++++------
> >>  tools/perf/util/evsel.h |  6 ++++++
> >>  2 files changed, 47 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> index dbfeceb2546c..437a28e769fe 100644
> >> --- a/tools/perf/util/evsel.c
> >> +++ b/tools/perf/util/evsel.c
> >> @@ -1434,6 +1434,10 @@ void evsel__delete(struct evsel *evsel)
> >>  {
> >>  	evsel__exit(evsel);
> >>  	free(evsel);
> >> +
> >> +	/* just free it for the first evsel */
> >> +	hashmap__free(perf_missing_features.pmu);
> >> +	perf_missing_features.pmu = NULL;
> >>  }
> >>  
> >>  void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
> >> @@ -1791,6 +1795,23 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> >>  	return 0;
> >>  }
> >>  
> >> +#define PMU_HASH_BITS  4
> >> +
> >> +static size_t pmu_hash(const void *key, void *ctx __maybe_unused)
> >> +{
> >> +	const struct evsel *evsel = key;
> >> +
> >> +	return hash_bits(evsel->core.attr.type, PMU_HASH_BITS);
> >> +}
> >> +
> >> +static bool pmu_equal(const void *key1, const void *key2, void *ctx __maybe_unused)
> >> +{
> >> +	const struct evsel *a = key1;
> >> +	const struct evsel *b = key2;
> >> +
> >> +	return a->core.attr.type == b->core.attr.type;
> >> +}
> >> +
> >>  static void evsel__disable_missing_features(struct evsel *evsel)
> >>  {
> >>  	if (perf_missing_features.weight_struct) {
> >> @@ -1807,8 +1828,14 @@ static void evsel__disable_missing_features(struct evsel *evsel)
> >>  		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
> >>  	if (perf_missing_features.mmap2)
> >>  		evsel->core.attr.mmap2 = 0;
> >> -	if (perf_missing_features.exclude_guest)
> >> -		evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
> >> +	if (perf_missing_features.exclude_guest) {
> >> +		void *pmu;
> >
> >could you just pass NULL in here instead of NULL?
> 
> ENOPARSE 

ugh right... 'instead of &pmu' ;-)

thanks,
jirka

> 
> >
> >> +
> >> +		if (hashmap__find(perf_missing_features.pmu, evsel, &pmu)) {
> >> +			evsel->core.attr.exclude_guest = 0;
> >> +			evsel->core.attr.exclude_host = 0;
> >> +		}
> >> +	}
> >>  	if (perf_missing_features.lbr_flags)
> >>  		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
> >>  				     PERF_SAMPLE_BRANCH_NO_CYCLES);
> >> @@ -1840,6 +1867,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> >>  
> >>  bool evsel__detect_missing_features(struct evsel *evsel)
> >>  {
> >> +	if (perf_missing_features.pmu == NULL)
> >> +		perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);
> >> +
> >>  	/*
> >>  	 * Must probe features in the order they were added to the
> >>  	 * perf_event_attr interface.
> >> @@ -1900,10 +1930,15 @@ bool evsel__detect_missing_features(struct evsel *evsel)
> >>  		perf_missing_features.mmap2 = true;
> >>  		pr_debug2_peo("switching off mmap2\n");
> >>  		return true;
> >> -	} else if (!perf_missing_features.exclude_guest &&
> >> -		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> >> -		perf_missing_features.exclude_guest = true;
> >> -		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> >> +	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
> >> +		   !hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> >> +		struct perf_missing_pmu_features pmu_features = { true };
> >
> >missing new line after declaration
> >
> >> +		hashmap__add(perf_missing_features.pmu, evsel, &pmu_features);
> >> +
> >> +		if (!perf_missing_features.exclude_guest) {
> >> +			perf_missing_features.exclude_guest = true;
> >> +			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> >> +		}
> >>  		return true;
> >>  	} else if (!perf_missing_features.sample_id_all) {
> >>  		perf_missing_features.sample_id_all = true;
> >> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> >> index 1f7edfa8568a..8dd11c8e022d 100644
> >> --- a/tools/perf/util/evsel.h
> >> +++ b/tools/perf/util/evsel.h
> >> @@ -172,6 +172,12 @@ struct perf_missing_features {
> >>  	bool data_page_size;
> >>  	bool code_page_size;
> >>  	bool weight_struct;
> >> +
> >> +	struct hashmap *pmu;
> >> +};
> >> +
> >> +struct perf_missing_pmu_features {
> >> +	bool exclude_guest;
> >>  };
> >
> >hum, is this really needed? I think you could just pass '1' as value,
> >because you care only if the item is hashed, right?
> >
> >in any case the value is the current stack address of the
> >  struct perf_missing_pmu_features pmu_features = { true };
> >
> >so it might as well be just '1' ... I was confused at the beggining
> >and looked for the reason of this struct ;-)
> >
> >we do that already in util/stat.c
> >
> >jirka
> >
> >>  
> >>  extern struct perf_missing_features perf_missing_features;
> >> -- 
> >> 2.33.0.1079.g6e70778dc9-goog
> >> 
> >
> 

