Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C270397CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhFAWsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:48:10 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36599 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhFAWsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:48:07 -0400
Received: by mail-lf1-f52.google.com with SMTP id q1so247583lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 15:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqzW4S/94UactTJsae+wym3/GhMDKAFyYiQ95IlEm8s=;
        b=RnuObdfbxVmgKRmXLZaMM7qcdc0UGB0yL7Z74eDIha5RJj2GwnzcQG3Np1MfRyev6D
         XtCVVc+//aF3Ff1IEVNDOUEFbYq7PLk3l8T1kSqVVceKWZL6QT5y+7sTDmDqu15/KZTp
         0YcjduqefiTHN9a+WRPzD3X0smFHpCRpzm5DgOudd18KWeHvFcOnabhOuJEaHcMn4kVE
         LJ/keUcgdw2DR54uQ94UwjHmG4LzXk6KGYctyFUa5KpccBHve4W39pA5+DvksP11bAN3
         3nY7DowmNWFnP5uAOxhNC00yMatwQRdWUQmUYNHH/DEs/9rkilMOImzncxRQKBZli5J2
         QeDg==
X-Gm-Message-State: AOAM5324yYad9UHf01zSC8Oazn12loCgwcqcovU/JkB62rQr79hpzkDr
        rqwQmuPFjsHOT5IU5VTaSr17Hy1szfl1cKnaGEU=
X-Google-Smtp-Source: ABdhPJzAyTytpb1iB6wi75KC1UbD6aIIR/Zr2+Dy6FFydQBJqRoTCODmJkvMDltCqhzVKVXkDOsLKCxB2iaOY0cUdwc=
X-Received: by 2002:a05:6512:208a:: with SMTP id t10mr20412129lfr.509.1622587583799;
 Tue, 01 Jun 2021 15:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210527182835.1634339-1-namhyung@kernel.org> <YLY2cdeQec5bH5Jc@kernel.org>
 <YLY3fOxkKsKi/iIS@kernel.org>
In-Reply-To: <YLY3fOxkKsKi/iIS@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 1 Jun 2021 15:46:11 -0700
Message-ID: <CAM9d7cgvuxtFa1o-CXbqqZfMUqM=1An_dCNZ46tMmxHiGzhPQw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Move probing cgroup sampling support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Jun 1, 2021 at 6:34 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Tue, Jun 01, 2021 at 10:30:25AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, May 27, 2021 at 11:28:35AM -0700, Namhyung Kim escreveu:
> > > I found that checking cgroup sampling support using the missing
> > > features doesn't work on old kernels.  Because it added both
> > > attr.cgroup bit and PERF_SAMPLE_CGROUP bit, it needs to check
> > > whichever comes first (usually the actual event, not dummy).
> > >
> > > But it only checks the attr.cgroup bit which is set only in the dummy
> > > event so cannot detect failtures due the sample bits.  Also we don't
> > > ignore the missing feature and retry, it'd be better checking it with
> > > the API probing logic.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/builtin-record.c      |  6 ++++++
> > >  tools/perf/util/evsel.c          |  6 +-----
> > >  tools/perf/util/evsel.h          |  1 -
> > >  tools/perf/util/perf_api_probe.c | 10 ++++++++++
> > >  tools/perf/util/perf_api_probe.h |  1 +
> > >  5 files changed, 18 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
> > > index 829af17a0867..020411682a3c 100644
> > > --- a/tools/perf/util/perf_api_probe.c
> > > +++ b/tools/perf/util/perf_api_probe.c
> > > @@ -103,6 +103,11 @@ static void perf_probe_build_id(struct evsel *evsel)
> > >     evsel->core.attr.build_id = 1;
> > >  }
> > >
> > > +static void perf_probe_cgroup(struct evsel *evsel)
> > > +{
> > > +   evsel->core.attr.cgroup = 1;
> > > +}
> > > +
> > >  bool perf_can_sample_identifier(void)
> > >  {
> > >     return perf_probe_api(perf_probe_sample_identifier);
> > > @@ -182,3 +187,8 @@ bool perf_can_record_build_id(void)
> > >  {
> > >     return perf_probe_api(perf_probe_build_id);
> > >  }
> > > +
> > > +bool perf_can_record_cgroup(void)
> > > +{
> > > +   return perf_probe_api(perf_probe_cgroup);
> > > +}
> > > diff --git a/tools/perf/util/perf_api_probe.h b/tools/perf/util/perf_api_probe.h
> > > index f12ca55f509a..b104168efb15 100644
> > > --- a/tools/perf/util/perf_api_probe.h
> > > +++ b/tools/perf/util/perf_api_probe.h
> > > @@ -12,5 +12,6 @@ bool perf_can_record_switch_events(void);
> > >  bool perf_can_record_text_poke_events(void);
> > >  bool perf_can_sample_identifier(void);
> > >  bool perf_can_record_build_id(void);
> > > +bool perf_can_record_cgroup(void);
> > >
> > >  #endif // __PERF_API_PROBE_H
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index bc3dd379eb67..71efe6573ee7 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -2733,6 +2733,12 @@ int cmd_record(int argc, const char **argv)
> > >             rec->no_buildid = true;
> > >     }
> > >
> > > +   if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> > > +           pr_err("Kernel has no cgroup sampling support.\n");
> > > +           err = -EINVAL;
> > > +           goto out_opts;
> > > +   }
> > > +
> > >     if (rec->opts.kcore)
> > >             rec->data.is_dir = true;
> > >
> >
> > The above is perf/urgent material and should fix your issue, right?
> >
> > The part below is a separate patch and can be left for later, or maybe
> > remain in the codebase, as simple tools that use just one evsel and
> > request a cgroup will continue probing the kernel, etc. I.e. it
> > shouldn't get in the way for cases with dummies, etc.
> >
> > Simple tools then won't have to get that !perf_can_record_cgroup() call.
>
> I did it tentatively in my local branch, i.e. removed the removal of the
> fallback part, thus is just for it to be tested by the containers setup,
> etc, we can change this before it hits acme/perf/core externally.

Sure, thanks for doing this!

Thanks,
Namhyung
