Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC6C36A8B6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 20:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhDYSBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 14:01:18 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36587 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 14:01:17 -0400
Received: by mail-lf1-f51.google.com with SMTP id n138so84980332lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 11:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt7My1IBpJP2EA1l/SHv+IPmhO+PkKbRTxsodKXSMQE=;
        b=nA//pf32F4/9j+K+6v6mrhAekQ2egrQkdPOAAph88QlfSxyou5QXDYTVFdrkBSgzpK
         o3Nrl5zJD7SDZOae/IuW/1oTBtfFBzaQWvbEwTbcZX4G5oIlVB/Un8jH9n+qO2EkYRJl
         sCyVyI/RdFUKGyZyrHaOK1KyDsEu06w/t/dj2ftTGj6V8KgogIIom2RVDzSexOC6jjyX
         LIwkSrDz6sIvCZ917e9QqkpoXhc5Rt4vxC+kum5pMfJvhFkQ5ja/NGxssgWxhOweNeuV
         +0H5W//1eshIZN3Bzi0MqyAYiUcy5aVPHqfj88qFoi4/03iTEJEp6V5Maa0XS+b8mXRz
         VJHw==
X-Gm-Message-State: AOAM533SfeFsH6I0pRpttfsnX5I1Min2Q1LTjHNyqZ7HnFUArfMY7bdJ
        AHgxvFPzK9xRwyhk6E7aAl+bgbR0R3EuYa3QBHU=
X-Google-Smtp-Source: ABdhPJwpDxu/QZPUnbUIHajdlf5Ge5NQZLhQV9mkuVrRfCJtbzfQt8WE0CqYahouSpTcD8om7s6OK7bZjrPJeEQC79E=
X-Received: by 2002:a05:6512:b26:: with SMTP id w38mr10027995lfu.152.1619373635567;
 Sun, 25 Apr 2021 11:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210423023833.1430520-1-namhyung@kernel.org> <YIWPr5LFOAmQ0fg7@krava>
In-Reply-To: <YIWPr5LFOAmQ0fg7@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Apr 2021 03:00:24 +0900
Message-ID: <CAM9d7ciCoPk2tu9=grhdKO=Jo1iq4PvOfEBgW3mmgcn0ju36nA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Use aggregated counts directly
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 12:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Apr 22, 2021 at 07:38:33PM -0700, Namhyung Kim wrote:
> > The ps->res_stats is for repeated runs, so the interval code should
> > not touch it.  Actually the aggregated counts are available in the
> > counter->counts->aggr, so we can (and should) use it directly IMHO.
> >
> > No functional change intended.
>
> it looks ok, but it should fix the noise output then, right?

Yeah, but only if -r and -I options are used at the same time.

>
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks,
Namhyung

>
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/stat-display.c |  8 ++++----
> >  tools/perf/util/stat.c         | 12 ------------
> >  2 files changed, 4 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index d3137bc17065..a38fa6527586 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -807,11 +807,11 @@ static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
> >                           bool first __maybe_unused)
> >  {
> >       struct caggr_data *cd = data;
> > -     struct perf_stat_evsel *ps = counter->stats;
> > +     struct perf_counts_values *aggr = &counter->counts->aggr;
> >
> > -     cd->avg += avg_stats(&ps->res_stats[0]);
> > -     cd->avg_enabled += avg_stats(&ps->res_stats[1]);
> > -     cd->avg_running += avg_stats(&ps->res_stats[2]);
> > +     cd->avg += aggr->val;
> > +     cd->avg_enabled += aggr->ena;
> > +     cd->avg_running += aggr->run;
> >  }
> >
> >  /*
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 2db46b9bebd0..d3ec2624e036 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -437,18 +437,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
> >
> >       aggr->val = aggr->ena = aggr->run = 0;
> >
> > -     /*
> > -      * We calculate counter's data every interval,
> > -      * and the display code shows ps->res_stats
> > -      * avg value. We need to zero the stats for
> > -      * interval mode, otherwise overall avg running
> > -      * averages will be shown for each interval.
> > -      */
> > -     if (config->interval || config->summary) {
> > -             for (i = 0; i < 3; i++)
> > -                     init_stats(&ps->res_stats[i]);
> > -     }
> > -
> >       if (counter->per_pkg)
> >               evsel__zero_per_pkg(counter);
> >
> > --
> > 2.31.1.498.g6c1eba8ee3d-goog
> >
>
