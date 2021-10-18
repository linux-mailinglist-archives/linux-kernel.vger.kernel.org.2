Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85923430F54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhJREqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:46:52 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:42715 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhJREqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:46:51 -0400
Received: by mail-lf1-f44.google.com with SMTP id x27so64339824lfa.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 21:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8xn7y0IdipEExqGs1i/eP9GOE6VJeuA8tx43J6KamE=;
        b=1I7kIplV4fjCQ9jaXwOajpR5kCRpnMxeRfIoEy7eSIebEjiwtjLXUMkCbxhgWmz3u0
         vB+lA/J/Cgn8goXjrvufFzCsZXefXAG4AyvPv7CN7AbxG02IH21A75fw/cux+KCwjEmw
         vTUnTXHUaKr4eMPNoHaaH1lvA0WQ7eJ0/7Y+sIkSM9xNeDgvREufe74tNl1RoWp+fSUt
         +lT5i7MgkvXqK0usjnL2iWnbOWBJ+9a5GBWM6zhTlgAcLD7a8ATOg0kYmTjtUNMO+FXU
         gfmupJ2Fbjt90hlZOsfzWW+uZ6JKTz3GOnkJP2gE8EuMIkQNqr4lwZOlTKevgvNn0OfS
         7ilA==
X-Gm-Message-State: AOAM530C8byUmjFZbd1+yQeNJ7eUZZzs+XlK91bsow0rvIrkHPAby2BM
        4Xt1svTUmVNraQ2d6NJXwXxO3h0ubuX7itnKR3w=
X-Google-Smtp-Source: ABdhPJxAi0E4j5iaAsnCM8xDxiKZ8fatUsZ1AkohJXdwJj4+9D6m6SmzkFXNgVae3DEsGZJ4hzUHpbmu9OAttUwDs/8=
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr27522976lfv.481.1634532279604;
 Sun, 17 Oct 2021 21:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211016051253.2035821-1-namhyung@kernel.org> <YWx0CgTyyZ4sm/l4@krava>
In-Reply-To: <YWx0CgTyyZ4sm/l4@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 17 Oct 2021 21:44:28 -0700
Message-ID: <CAM9d7chp04jr09LQmLk9jEPBnNSSsjX=BrDcuFa1q-svAmR2ew@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Fix missing exclude_{host,guest} setting
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sun, Oct 17, 2021 at 12:06 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 15, 2021 at 10:12:53PM -0700, Namhyung Kim wrote:
> > The current logic for the perf missing feature has a bug that it can
> > wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > support any filtering or exclusion while others do.  But we check it
> > as a global feature.
> >
> > For example, the cycles event can have 'G' modifier to enable it only
> > in the guest mode on x86.  When you don't run any VMs it'll return 0.
> >
> >   # perf stat -a -e cycles:G sleep 1
> >
> >     Performance counter stats for 'system wide':
> >
> >                     0      cycles:G
> >
> >           1.000721670 seconds time elapsed
> >
> > But when it's used with other pmu events that don't support G modifier,
> > it'll be reset and return non-zero values.
> >
> >   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> >
> >     Performance counter stats for 'system wide':
> >
> >           538,029,960      cycles:G
> >        16,924,010,738      msr/tsc/
> >
> >           1.001815327 seconds time elapsed
> >
> > This is because of the missing feature detection logic being global.
> > Add a hashmap to set pmu-specific exclude_host/guest features.
> >
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 47 +++++++++++++++++++++++++++++++++++------
> >  tools/perf/util/evsel.h |  6 ++++++
> >  2 files changed, 47 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index dbfeceb2546c..437a28e769fe 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1434,6 +1434,10 @@ void evsel__delete(struct evsel *evsel)
> >  {
> >       evsel__exit(evsel);
> >       free(evsel);
> > +
> > +     /* just free it for the first evsel */
> > +     hashmap__free(perf_missing_features.pmu);
> > +     perf_missing_features.pmu = NULL;
> >  }
> >
> >  void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
> > @@ -1791,6 +1795,23 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> >       return 0;
> >  }
> >
> > +#define PMU_HASH_BITS  4
> > +
> > +static size_t pmu_hash(const void *key, void *ctx __maybe_unused)
> > +{
> > +     const struct evsel *evsel = key;
> > +
> > +     return hash_bits(evsel->core.attr.type, PMU_HASH_BITS);
> > +}
> > +
> > +static bool pmu_equal(const void *key1, const void *key2, void *ctx __maybe_unused)
> > +{
> > +     const struct evsel *a = key1;
> > +     const struct evsel *b = key2;
> > +
> > +     return a->core.attr.type == b->core.attr.type;
> > +}
> > +
> >  static void evsel__disable_missing_features(struct evsel *evsel)
> >  {
> >       if (perf_missing_features.weight_struct) {
> > @@ -1807,8 +1828,14 @@ static void evsel__disable_missing_features(struct evsel *evsel)
> >               evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
> >       if (perf_missing_features.mmap2)
> >               evsel->core.attr.mmap2 = 0;
> > -     if (perf_missing_features.exclude_guest)
> > -             evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
> > +     if (perf_missing_features.exclude_guest) {
> > +             void *pmu;
>
> could you just pass NULL in here instead of NULL?
>
> > +
> > +             if (hashmap__find(perf_missing_features.pmu, evsel, &pmu)) {
> > +                     evsel->core.attr.exclude_guest = 0;
> > +                     evsel->core.attr.exclude_host = 0;
> > +             }
> > +     }
> >       if (perf_missing_features.lbr_flags)
> >               evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
> >                                    PERF_SAMPLE_BRANCH_NO_CYCLES);
> > @@ -1840,6 +1867,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> >
> >  bool evsel__detect_missing_features(struct evsel *evsel)
> >  {
> > +     if (perf_missing_features.pmu == NULL)
> > +             perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);
> > +
> >       /*
> >        * Must probe features in the order they were added to the
> >        * perf_event_attr interface.
> > @@ -1900,10 +1930,15 @@ bool evsel__detect_missing_features(struct evsel *evsel)
> >               perf_missing_features.mmap2 = true;
> >               pr_debug2_peo("switching off mmap2\n");
> >               return true;
> > -     } else if (!perf_missing_features.exclude_guest &&
> > -                (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> > -             perf_missing_features.exclude_guest = true;
> > -             pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> > +     } else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
> > +                !hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> > +             struct perf_missing_pmu_features pmu_features = { true };
>
> missing new line after declaration

ok

>
> > +             hashmap__add(perf_missing_features.pmu, evsel, &pmu_features);
> > +
> > +             if (!perf_missing_features.exclude_guest) {
> > +                     perf_missing_features.exclude_guest = true;
> > +                     pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> > +             }
> >               return true;
> >       } else if (!perf_missing_features.sample_id_all) {
> >               perf_missing_features.sample_id_all = true;
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 1f7edfa8568a..8dd11c8e022d 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -172,6 +172,12 @@ struct perf_missing_features {
> >       bool data_page_size;
> >       bool code_page_size;
> >       bool weight_struct;
> > +
> > +     struct hashmap *pmu;
> > +};
> > +
> > +struct perf_missing_pmu_features {
> > +     bool exclude_guest;
> >  };
>
> hum, is this really needed? I think you could just pass '1' as value,
> because you care only if the item is hashed, right?

It's not really needed, but I thought it might be useful to extend
if we want to add another pmu-specific feature check later.
But at this point I don't have a specific feature to add though.

>
> in any case the value is the current stack address of the
>   struct perf_missing_pmu_features pmu_features = { true };
>
> so it might as well be just '1' ... I was confused at the beggining
> and looked for the reason of this struct ;-)

Right, as I said it's not need to be a struct and we can pass a
scalar value instead if you want.

Thanks,
Namhyung
