Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFBB372A37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhEDMiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEDMiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:38:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9719F613B3;
        Tue,  4 May 2021 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620131836;
        bh=d11EBdMsyqf5oV/eoDEoJpkWqFJSOsmiPOR70QGvZs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbhLTyYAjK3gsEbDRjnYSoTF2Prgup0heZiD/OYl6H3ZE5kpnAuozZVm5ooVCySOy
         8KoRELM31B4/lEw5aYIHo4PzkcgWZDdcfaY+DnaaM4fr8MB0zwE58u5LJRx3OJb6Sv
         fi4/kdLcQkcG8e5qyvlBwar32FbhtqV5np3GSKBzbl1/IMZ7vuE0LjEMaBYeXc44X+
         nmYI+XyARwTeAJio4UUTBZbpBldTX+WHoRxtn3DvM1AUuuenouoSeJh9zC8/zkMk6X
         zioBazxlOBc/1RxMw45Lcc4+Q/YzrbY7W2wixof6cEsHzcLZrwULwcuVb6y56CsuJz
         /Z6V70P2BodmQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A6BCE4034C; Tue,  4 May 2021 09:37:14 -0300 (-03)
Date:   Tue, 4 May 2021 09:37:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf stat: Use aggregated counts directly
Message-ID: <YJE/+m8GUyF2whaV@kernel.org>
References: <20210423023833.1430520-1-namhyung@kernel.org>
 <YIWPr5LFOAmQ0fg7@krava>
 <CAM9d7ciCoPk2tu9=grhdKO=Jo1iq4PvOfEBgW3mmgcn0ju36nA@mail.gmail.com>
 <CAM9d7ciMfPqY+eJsFG36V82wOiNR-2g1Siytc=vRjaZsCdfDWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciMfPqY+eJsFG36V82wOiNR-2g1Siytc=vRjaZsCdfDWQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 03, 2021 at 02:27:36PM -0700, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> I'm not sure it's in your tree, can you please take a look and merge it?

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> On Sun, Apr 25, 2021 at 11:00 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Apr 26, 2021 at 12:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Thu, Apr 22, 2021 at 07:38:33PM -0700, Namhyung Kim wrote:
> > > > The ps->res_stats is for repeated runs, so the interval code should
> > > > not touch it.  Actually the aggregated counts are available in the
> > > > counter->counts->aggr, so we can (and should) use it directly IMHO.
> > > >
> > > > No functional change intended.
> > >
> > > it looks ok, but it should fix the noise output then, right?
> >
> > Yeah, but only if -r and -I options are used at the same time.
> >
> > >
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > Thanks,
> > Namhyung
> >
> > >
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/stat-display.c |  8 ++++----
> > > >  tools/perf/util/stat.c         | 12 ------------
> > > >  2 files changed, 4 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > > index d3137bc17065..a38fa6527586 100644
> > > > --- a/tools/perf/util/stat-display.c
> > > > +++ b/tools/perf/util/stat-display.c
> > > > @@ -807,11 +807,11 @@ static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
> > > >                           bool first __maybe_unused)
> > > >  {
> > > >       struct caggr_data *cd = data;
> > > > -     struct perf_stat_evsel *ps = counter->stats;
> > > > +     struct perf_counts_values *aggr = &counter->counts->aggr;
> > > >
> > > > -     cd->avg += avg_stats(&ps->res_stats[0]);
> > > > -     cd->avg_enabled += avg_stats(&ps->res_stats[1]);
> > > > -     cd->avg_running += avg_stats(&ps->res_stats[2]);
> > > > +     cd->avg += aggr->val;
> > > > +     cd->avg_enabled += aggr->ena;
> > > > +     cd->avg_running += aggr->run;
> > > >  }
> > > >
> > > >  /*
> > > > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > > > index 2db46b9bebd0..d3ec2624e036 100644
> > > > --- a/tools/perf/util/stat.c
> > > > +++ b/tools/perf/util/stat.c
> > > > @@ -437,18 +437,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
> > > >
> > > >       aggr->val = aggr->ena = aggr->run = 0;
> > > >
> > > > -     /*
> > > > -      * We calculate counter's data every interval,
> > > > -      * and the display code shows ps->res_stats
> > > > -      * avg value. We need to zero the stats for
> > > > -      * interval mode, otherwise overall avg running
> > > > -      * averages will be shown for each interval.
> > > > -      */
> > > > -     if (config->interval || config->summary) {
> > > > -             for (i = 0; i < 3; i++)
> > > > -                     init_stats(&ps->res_stats[i]);
> > > > -     }
> > > > -
> > > >       if (counter->per_pkg)
> > > >               evsel__zero_per_pkg(counter);
> > > >
> > > > --
> > > > 2.31.1.498.g6c1eba8ee3d-goog
> > > >
> > >

-- 

- Arnaldo
