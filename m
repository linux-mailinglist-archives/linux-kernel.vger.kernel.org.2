Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75B397467
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhFANgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233797AbhFANgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:36:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D8B861159;
        Tue,  1 Jun 2021 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622554494;
        bh=csoc1f4pPPdREvTk3g6EFKsFTV8ISl9/45FduPUi1BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VO5EG9ul97MoVTLedsST7fxQ3BXlgx768xOE5p1DSWzCskpkzvHrbUhe1REhn11/q
         Pa8YWU20adH8y7z3r+DQSLXjmdqNB6XkGrcabuVqPZX5c6e5Dy/QzjQnxgNSQ8iJ7z
         CSRSliBGWh4lr6mThwIt8wC8gAWTt9IQ/4OrrDguEKAxV4GwFefEu6c+9tEUSJOoPD
         mLJVwvKfpxA15YzhGnvmKNips0S4sDNWz0rsAq14cqFhrZ99dwbx+238d+inALzsav
         0u6s92GdyLmdN91LAQu218uINhMnEBMw18EL4DUkVIS9iBBcwDZKM/hpUEw5fuG8Q5
         5oOkfW0+9pI5w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0965A4011C; Tue,  1 Jun 2021 10:34:52 -0300 (-03)
Date:   Tue, 1 Jun 2021 10:34:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf tools: Move probing cgroup sampling support
Message-ID: <YLY3fOxkKsKi/iIS@kernel.org>
References: <20210527182835.1634339-1-namhyung@kernel.org>
 <YLY2cdeQec5bH5Jc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLY2cdeQec5bH5Jc@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 01, 2021 at 10:30:25AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, May 27, 2021 at 11:28:35AM -0700, Namhyung Kim escreveu:
> > I found that checking cgroup sampling support using the missing
> > features doesn't work on old kernels.  Because it added both
> > attr.cgroup bit and PERF_SAMPLE_CGROUP bit, it needs to check
> > whichever comes first (usually the actual event, not dummy).
> > 
> > But it only checks the attr.cgroup bit which is set only in the dummy
> > event so cannot detect failtures due the sample bits.  Also we don't
> > ignore the missing feature and retry, it'd be better checking it with
> > the API probing logic.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-record.c      |  6 ++++++
> >  tools/perf/util/evsel.c          |  6 +-----
> >  tools/perf/util/evsel.h          |  1 -
> >  tools/perf/util/perf_api_probe.c | 10 ++++++++++
> >  tools/perf/util/perf_api_probe.h |  1 +
> >  5 files changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
> > index 829af17a0867..020411682a3c 100644
> > --- a/tools/perf/util/perf_api_probe.c
> > +++ b/tools/perf/util/perf_api_probe.c
> > @@ -103,6 +103,11 @@ static void perf_probe_build_id(struct evsel *evsel)
> >  	evsel->core.attr.build_id = 1;
> >  }
> >  
> > +static void perf_probe_cgroup(struct evsel *evsel)
> > +{
> > +	evsel->core.attr.cgroup = 1;
> > +}
> > +
> >  bool perf_can_sample_identifier(void)
> >  {
> >  	return perf_probe_api(perf_probe_sample_identifier);
> > @@ -182,3 +187,8 @@ bool perf_can_record_build_id(void)
> >  {
> >  	return perf_probe_api(perf_probe_build_id);
> >  }
> > +
> > +bool perf_can_record_cgroup(void)
> > +{
> > +	return perf_probe_api(perf_probe_cgroup);
> > +}
> > diff --git a/tools/perf/util/perf_api_probe.h b/tools/perf/util/perf_api_probe.h
> > index f12ca55f509a..b104168efb15 100644
> > --- a/tools/perf/util/perf_api_probe.h
> > +++ b/tools/perf/util/perf_api_probe.h
> > @@ -12,5 +12,6 @@ bool perf_can_record_switch_events(void);
> >  bool perf_can_record_text_poke_events(void);
> >  bool perf_can_sample_identifier(void);
> >  bool perf_can_record_build_id(void);
> > +bool perf_can_record_cgroup(void);
> >  
> >  #endif // __PERF_API_PROBE_H
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index bc3dd379eb67..71efe6573ee7 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -2733,6 +2733,12 @@ int cmd_record(int argc, const char **argv)
> >  		rec->no_buildid = true;
> >  	}
> >  
> > +	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> > +		pr_err("Kernel has no cgroup sampling support.\n");
> > +		err = -EINVAL;
> > +		goto out_opts;
> > +	}
> > +
> >  	if (rec->opts.kcore)
> >  		rec->data.is_dir = true;
> >  
> 
> The above is perf/urgent material and should fix your issue, right?
> 
> The part below is a separate patch and can be left for later, or maybe
> remain in the codebase, as simple tools that use just one evsel and
> request a cgroup will continue probing the kernel, etc. I.e. it
> shouldn't get in the way for cases with dummies, etc.
> 
> Simple tools then won't have to get that !perf_can_record_cgroup() call.

I did it tentatively in my local branch, i.e. removed the removal of the
fallback part, thus is just for it to be tested by the containers setup,
etc, we can change this before it hits acme/perf/core externally.

- Arnaldo
