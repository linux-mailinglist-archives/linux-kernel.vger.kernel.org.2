Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD53BDE32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGFTxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229793AbhGFTxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625601073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KD/nFtPKzzaehoLBwu24EojRDDCS0FChBm++HFWjNI0=;
        b=EEcFKKGdvAah50sz7/MeQkStIPv/4x46sG+kJ6Gl3c+WBk5GnC2vjfTUKamzkc/Vwikshg
        1TKmb+RpiJf+69CpuA+m1E43loNDATvJzyc13XFhp5nlZTR+hKoBXDg1J56C3dp6/ghgBF
        BJQxT3sK28+aU1R67ejNnx41QAZbSyA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-IFQHTD30MCiuxRGCnhfskg-1; Tue, 06 Jul 2021 15:51:12 -0400
X-MC-Unique: IFQHTD30MCiuxRGCnhfskg-1
Received: by mail-wr1-f72.google.com with SMTP id p6-20020a5d45860000b02901258b6ae8a5so53145wrq.15
        for <Linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 12:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KD/nFtPKzzaehoLBwu24EojRDDCS0FChBm++HFWjNI0=;
        b=IAcRksYhhCiTnfaozW2k+WtJxbn1Ogex2lkUJYv68pzvo3TW6r8eZrvdf+ITuruFYq
         QwNS+zQkiQwDOeTLVIpR1QgOkK3c3HDs3AjAw6TQZn6E/bVFuD72M0n95SCzfDhVfZO2
         2FE8T2akQHMJxAJD9mM3oAcnG0LXUSK0i2lPeIQP9CagER1F/lyITHvqGl+u/dS+A021
         MlGArfDU+8P7WikvmVFhJ9hmFCndrvMYh5OQw0QHZu1vkcCb3wzNg6RL9TOcxhez4alD
         tk8y8HVQnQdK2CFSRwA5ZjDCI75of+vn3Q4I6CZSyDVfZcZ2jrBe7qn8DZZsz/2jWzSm
         XxpA==
X-Gm-Message-State: AOAM531NQNhCnQBx/mXkJhP4v+gAPJJADz/sB50tlnSfbX3G+cLb0zXH
        73wU7v4sLumKtFPbGAY7f0V/D/DeV07T8WjBL88ymyPDaHfW+15heQs3ieUVDN8lgNGKMMMNjrR
        QVn+2TTN0tCVYQ1TE0xVbVmAB
X-Received: by 2002:a05:600c:2482:: with SMTP id 2mr2559861wms.174.1625601071417;
        Tue, 06 Jul 2021 12:51:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwJRCUStq9O0+B+mBjfj4o6KshwQ9dO9xLRf5wU1TyWxHOFc3Zntv4aZffa++6+JwdJa+o/A==
X-Received: by 2002:a05:600c:2482:: with SMTP id 2mr2559840wms.174.1625601071192;
        Tue, 06 Jul 2021 12:51:11 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id i15sm17581582wro.3.2021.07.06.12.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 12:51:10 -0700 (PDT)
Date:   Tue, 6 Jul 2021 21:51:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Merge uncore events by default for hybrid
 platform
Message-ID: <YOS0K0f+cAKdCHe+@krava>
References: <20210616063004.2824-1-yao.jin@linux.intel.com>
 <ac00637c-af58-6dba-67b7-95887bae3b99@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac00637c-af58-6dba-67b7-95887bae3b99@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 10:32:57AM +0800, Jin, Yao wrote:
> Hi,
> 
> On 6/16/2021 2:30 PM, Jin Yao wrote:
> > On hybrid platform, by default stat aggregates and reports the event counts
> > per pmu. For example,
> > 
> >    # perf stat -e cycles -a true
> > 
> >     Performance counter stats for 'system wide':
> > 
> >             1,400,445      cpu_core/cycles/
> >               680,881      cpu_atom/cycles/
> > 
> >           0.001770773 seconds time elapsed
> > 
> > While for uncore events, that's not a suitable method. Uncore has nothing
> > to do with hybrid. So for uncore events, we aggregate event counts from all
> > PMUs and report the counts without PMUs.
> > 
> > Before:
> > 
> >    # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ -a true
> > 
> >     Performance counter stats for 'system wide':
> > 
> >                 2,058      uncore_arb_0/event=0x81,umask=0x1/
> >                 2,028      uncore_arb_1/event=0x81,umask=0x1/
> >                     0      uncore_arb_0/event=0x84,umask=0x1/
> >                     0      uncore_arb_1/event=0x84,umask=0x1/
> > 
> >           0.000614498 seconds time elapsed
> > 
> > After:
> > 
> >    # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ -a true
> > 
> >     Performance counter stats for 'system wide':
> > 
> >                 3,996      arb/event=0x81,umask=0x1/
> >                     0      arb/event=0x84,umask=0x1/
> > 
> >           0.000630046 seconds time elapsed
> > 
> > Of course, we also keep the '--no-merge' still works for uncore events.
> > 
> >    # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ --no-merge true
> > 
> >     Performance counter stats for 'system wide':
> > 
> >                 1,952      uncore_arb_0/event=0x81,umask=0x1/
> >                 1,921      uncore_arb_1/event=0x81,umask=0x1/
> >                     0      uncore_arb_0/event=0x84,umask=0x1/
> >                     0      uncore_arb_1/event=0x84,umask=0x1/
> > 
> >           0.000575536 seconds time elapsed
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> >   tools/perf/builtin-stat.c      |  3 ---
> >   tools/perf/util/stat-display.c | 29 +++++++++++++++++++++++++----
> >   2 files changed, 25 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index f9f74a514315..b67a44982b61 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2442,9 +2442,6 @@ int cmd_stat(int argc, const char **argv)
> >   	evlist__check_cpu_maps(evsel_list);
> > -	if (perf_pmu__has_hybrid())
> > -		stat_config.no_merge = true;
> > -
> >   	/*
> >   	 * Initialize thread_map with comm names,
> >   	 * so we could print it out on output.
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index b759dfd633b4..c6070f4684ca 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -595,6 +595,19 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
> >   	}
> >   }
> > +static bool is_uncore(struct evsel *evsel)
> > +{
> > +	struct perf_pmu *pmu;
> > +
> > +	if (evsel->pmu_name) {
> > +		pmu = perf_pmu__find(evsel->pmu_name);

evsel__find_pmu might be one line shorter? ;-)


> > +		if (pmu)
> > +			return pmu->is_uncore;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >   static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
> >   			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
> >   				       bool first),
> > @@ -603,10 +616,18 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
> >   	if (counter->merged_stat)
> >   		return false;
> >   	cb(config, counter, data, true);
> > -	if (config->no_merge)
> > -		uniquify_event_name(counter);
> > -	else if (counter->auto_merge_stats)
> > -		collect_all_aliases(config, counter, cb, data);
> > +	if (perf_pmu__has_hybrid()) {
> > +		if (config->no_merge || !is_uncore(counter))

hum, this is all the same except for the !is_uncore condition, right?

could we just add 'config->no_merge || hybrid_uniquify(count)'

that would cover both perf_pmu__has_hybrid and !is_uncore conditions?

jirka

> > +			uniquify_event_name(counter);
> > +		else if (counter->auto_merge_stats)
> > +			collect_all_aliases(config, counter, cb, data);
> > +	} else {
> > +		if (config->no_merge)
> > +			uniquify_event_name(counter);
> > +		else if (counter->auto_merge_stats)
> > +			collect_all_aliases(config, counter, cb, data);
> > +	}
> > +
> >   	return true;
> >   }
> > 
> 
> Any comments for this patch? :)
> 
> Thanks
> Jin Yao
> 

