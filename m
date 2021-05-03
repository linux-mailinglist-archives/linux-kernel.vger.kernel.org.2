Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79D337226A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhECV2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:28:43 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:37542 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECV2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:28:42 -0400
Received: by mail-lj1-f169.google.com with SMTP id b7so4814081ljr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 14:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFUf0b2x1L4iAYh3lFnkYgcpxKjwkZYWQZTwCl+dp6E=;
        b=fnDy52xGwanh6XC3P7xdJVqSCy3rWtAHGBH+3uWL3JQAEGyS9YKmP1lhvDCtEe7kLj
         V6uUecSAs00CHRxYcWNempbdbins9WE7Y8tG21nM6ARlB3biT5vPUm3DVAPNiVbRX7SQ
         A1DhlPG86q71/1VsEM2sd2OiIh8Tu5Jfb6WyDFhtCHNK6blfkjYF0PotOWOE4vvwjtNe
         EkcyW6Xdmwo50CMPERmrx6IGr75PQt3kz1f7ST6wfPqv6KZBRbNC9S+Fe4eP/J4Z8Lj0
         H5Lhfpb5WjtFWb0jxj0iow7lF4FpOQE187GX9WVYTO8EuNyGtBzdsfO7CqDSDmsNjSvI
         4T+w==
X-Gm-Message-State: AOAM53332KPrqiFxKNdppxTg3FHCoaa+9hFNNJWzUvkkA1fAz+BUppDP
        7v5xjM5FNVsf053jtt9ddW6nq+okS0I00kjFuqQ=
X-Google-Smtp-Source: ABdhPJyAEDqSZctXIXrjvPOCFWnKT4MqUsWV9MHm3WmRnJi2MOmHaW+vfFzKHuDdzbV/96r6ghWKNffhlzgalxW4xHU=
X-Received: by 2002:a2e:b746:: with SMTP id k6mr13913911ljo.275.1620077267973;
 Mon, 03 May 2021 14:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210423023833.1430520-1-namhyung@kernel.org> <YIWPr5LFOAmQ0fg7@krava>
 <CAM9d7ciCoPk2tu9=grhdKO=Jo1iq4PvOfEBgW3mmgcn0ju36nA@mail.gmail.com>
In-Reply-To: <CAM9d7ciCoPk2tu9=grhdKO=Jo1iq4PvOfEBgW3mmgcn0ju36nA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 3 May 2021 14:27:36 -0700
Message-ID: <CAM9d7ciMfPqY+eJsFG36V82wOiNR-2g1Siytc=vRjaZsCdfDWQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Use aggregated counts directly
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

I'm not sure it's in your tree, can you please take a look and merge it?

Thanks,
Namhyung

On Sun, Apr 25, 2021 at 11:00 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 12:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Apr 22, 2021 at 07:38:33PM -0700, Namhyung Kim wrote:
> > > The ps->res_stats is for repeated runs, so the interval code should
> > > not touch it.  Actually the aggregated counts are available in the
> > > counter->counts->aggr, so we can (and should) use it directly IMHO.
> > >
> > > No functional change intended.
> >
> > it looks ok, but it should fix the noise output then, right?
>
> Yeah, but only if -r and -I options are used at the same time.
>
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> Thanks,
> Namhyung
>
> >
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/stat-display.c |  8 ++++----
> > >  tools/perf/util/stat.c         | 12 ------------
> > >  2 files changed, 4 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > index d3137bc17065..a38fa6527586 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -807,11 +807,11 @@ static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
> > >                           bool first __maybe_unused)
> > >  {
> > >       struct caggr_data *cd = data;
> > > -     struct perf_stat_evsel *ps = counter->stats;
> > > +     struct perf_counts_values *aggr = &counter->counts->aggr;
> > >
> > > -     cd->avg += avg_stats(&ps->res_stats[0]);
> > > -     cd->avg_enabled += avg_stats(&ps->res_stats[1]);
> > > -     cd->avg_running += avg_stats(&ps->res_stats[2]);
> > > +     cd->avg += aggr->val;
> > > +     cd->avg_enabled += aggr->ena;
> > > +     cd->avg_running += aggr->run;
> > >  }
> > >
> > >  /*
> > > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > > index 2db46b9bebd0..d3ec2624e036 100644
> > > --- a/tools/perf/util/stat.c
> > > +++ b/tools/perf/util/stat.c
> > > @@ -437,18 +437,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
> > >
> > >       aggr->val = aggr->ena = aggr->run = 0;
> > >
> > > -     /*
> > > -      * We calculate counter's data every interval,
> > > -      * and the display code shows ps->res_stats
> > > -      * avg value. We need to zero the stats for
> > > -      * interval mode, otherwise overall avg running
> > > -      * averages will be shown for each interval.
> > > -      */
> > > -     if (config->interval || config->summary) {
> > > -             for (i = 0; i < 3; i++)
> > > -                     init_stats(&ps->res_stats[i]);
> > > -     }
> > > -
> > >       if (counter->per_pkg)
> > >               evsel__zero_per_pkg(counter);
> > >
> > > --
> > > 2.31.1.498.g6c1eba8ee3d-goog
> > >
> >
