Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C69409D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbhIMT4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238899AbhIMT4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:56:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E67F60F9F;
        Mon, 13 Sep 2021 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631562903;
        bh=vGKfjjDfDec9WldA+5DUvMQ59cJ2thvElgtPVGGM9NE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7usgVzHe0tZiqiMRhF/hiWcc/+CpnnW35nfQWkeSFRK47MKQiee9+w6vyAJLQffj
         UDgArdj+jSYVOJV99+p9J2O2RMn4vOFEyGXSQZ1tq2wg+6ZsG7rcL2zKXfDeYJeSan
         kU3DsDbfHogmSd8sWgvY7PLGOrMdpE5D+e9hEnhjuiIAvK1qim1UONQFSeVaM4ndRN
         kE9PW4eVajxPONBtlMROyurHVBgQNOSyNtPgiZNbSIph5mN+6m/iiG87X6euqSWPRP
         Fms3p6WmSLk6lJghKsCqPQKV0cQLdft9Hi551InMyvjxN/onabLSl8e8gagwJUINX3
         BElb5g8DzgTDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E9DC4038F; Mon, 13 Sep 2021 16:55:00 -0300 (-03)
Date:   Mon, 13 Sep 2021 16:55:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Fix ip display when type != attr->type
Message-ID: <YT+slLB++HpvtZ3w@kernel.org>
References: <20210911133053.15682-1-adrian.hunter@intel.com>
 <a961928d-41a5-6dce-75e1-25ae260f3e12@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a961928d-41a5-6dce-75e1-25ae260f3e12@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 13, 2021 at 11:13:56AM -0400, Liang, Kan escreveu:
> 
> 
> On 9/11/2021 9:30 AM, Adrian Hunter wrote:
> > set_print_ip_opts() was not being called when type != attr->type
> > because there is not a one-to-one relationship between output types
> > and attr->type. That resulted in ip not printing.
> > 
> > The attr_type() function is removed, and the match of attr->type to
> > output type is corrected.
> > 
> > Example on ADL using taskset to select an atom cpu:
> > 
> >   # perf record -e cpu_atom/cpu-cycles/ taskset 0x1000 uname
> >   Linux
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.003 MB perf.data (7 samples) ]
> > 
> >   Before:
> > 
> >    # perf script | head
> >           taskset   428 [-01] 10394.179041:          1 cpu_atom/cpu-cycles/:
> >           taskset   428 [-01] 10394.179043:          1 cpu_atom/cpu-cycles/:
> >           taskset   428 [-01] 10394.179044:         11 cpu_atom/cpu-cycles/:
> >           taskset   428 [-01] 10394.179045:        407 cpu_atom/cpu-cycles/:
> >           taskset   428 [-01] 10394.179046:      16789 cpu_atom/cpu-cycles/:
> >           taskset   428 [-01] 10394.179052:     676300 cpu_atom/cpu-cycles/:
> >             uname   428 [-01] 10394.179278:    4079859 cpu_atom/cpu-cycles/:
> > 
> >   After:
> > 
> >    # perf script | head
> >           taskset   428 10394.179041:          1 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
> >           taskset   428 10394.179043:          1 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
> >           taskset   428 10394.179044:         11 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
> >           taskset   428 10394.179045:        407 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
> >           taskset   428 10394.179046:      16789 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
> >           taskset   428 10394.179052:     676300 cpu_atom/cpu-cycles/:      7f829ef73800 cfree+0x0 (/lib/libc-2.32.so)
> >             uname   428 10394.179278:    4079859 cpu_atom/cpu-cycles/:  ffffffff95bae912 vma_interval_tree_remove+0x1f2 ([kernel.kallsyms])
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >   tools/perf/builtin-script.c | 24 +++++++++++++-----------
> >   1 file changed, 13 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 0e824f7d8b19..6211d0b84b7a 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -368,16 +368,6 @@ static inline int output_type(unsigned int type)
> >   	return OUTPUT_TYPE_OTHER;
> >   }
> > -static inline unsigned int attr_type(unsigned int type)
> > -{
> > -	switch (type) {
> > -	case OUTPUT_TYPE_SYNTH:
> > -		return PERF_TYPE_SYNTH;
> > -	default:
> > -		return type;
> > -	}
> > -}
> > -
> >   static bool output_set_by_user(void)
> >   {
> >   	int j;
> > @@ -556,6 +546,18 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
> >   		output[type].print_ip_opts |= EVSEL__PRINT_SRCLINE;
> >   }
> > +static struct evsel *find_first_output_type(struct evlist *evlist,
> > +					    unsigned int type)
> > +{
> > +	struct evsel *evsel;
> > +
> > +	evlist__for_each_entry(evlist, evsel) {
> > +		if (output_type(evsel->core.attr.type) == (int)type)
> > +			return evsel;
> > +	}
> > +	return NULL;
> > +}
> > +
> >   /*
> >    * verify all user requested events exist and the samples
> >    * have the expected data
> > @@ -567,7 +569,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
> >   	struct evsel *evsel;
> >   	for (j = 0; j < OUTPUT_TYPE_MAX; ++j) {
> > -		evsel = perf_session__find_first_evtype(session, attr_type(j));
> 
> I think the only consumer of perf_session__find_first_evtype() will only be
> in session.c. Seems we can further clean up the function and make it static.
> Other than that, the patch looks good to me.
> 
>   Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

