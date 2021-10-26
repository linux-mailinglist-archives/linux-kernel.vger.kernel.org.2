Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C53E43BAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbhJZTdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:33:19 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:43835 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhJZTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:33:18 -0400
Received: by mail-lf1-f43.google.com with SMTP id bq11so1009116lfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogwoOmc1SQUXuuWLRlF2IZYGbg/iNnRmnw9XzJ5EZ2U=;
        b=pYZM5UxY+ZjzW+STTUdDIgGgzScgSNo8r3sTC6mMPRnH9/6kCrErboRbkuGK1ZU6h0
         dWqhU3RugOk51lvjyZROBj0Msf4VuqdqUxga6xyafwYT3rDLeZtPS0UJhTOwX5AFTVOV
         PE2/z3++kQF4Go5zTXo4cyywQmIVbuhUc5Brj0bOYiRKpIdK32GpJyuGETy6ShXYWYzz
         qCA2Gn70pqDNYWJveL+PvE2DcoH6jvDL2oLcszYPHhEC5M0UUiowCqVH/FN/f9XCXf41
         cc1jYA15Rl+A1Ksi4ZuFB7io6gynnqO1YbZMjxwf2TZt1mql4Mfur5s8bcZt6TgYJ8iD
         Vcrw==
X-Gm-Message-State: AOAM532e9sl2y0xPXdcTPmtFMdc5rRI+s8G+9qdglOvtgx1LuasueMIi
        8rOVZ+zh5OlT/kN1DtAnBjFtUxhGCTHyylE54qI=
X-Google-Smtp-Source: ABdhPJyEFE5Mgu887bjJI30lFI3LYjj4w0/KcAnAjL8E018K6I7FY4C2j5cQVxrEpvoYgLh9nAOFjKFE2O+AVeQx8HE=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr25181964lfb.71.1635276653145;
 Tue, 26 Oct 2021 12:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211026043351.56662-1-namhyung@kernel.org> <YXhJn8rtkATcN9ZE@krava>
In-Reply-To: <YXhJn8rtkATcN9ZE@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 26 Oct 2021 12:30:42 -0700
Message-ID: <CAM9d7cj8zACP6VxN3e8KGLAS74xrNaDr6-utmti3_9DzyW6rjw@mail.gmail.com>
Subject: Re: [PATCH v2] perf evsel: Fix missing exclude_{host,guest} setting
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

On Tue, Oct 26, 2021 at 11:32 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Oct 25, 2021 at 09:33:51PM -0700, Namhyung Kim wrote:
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
> > v2 changes)
> >  * change to enum perf_missing_pmu_features
> >  * pass NULL to hashmap__find() to skip checking
> >  * add a blank line after declaration
> >
> >  tools/perf/util/evsel.c | 47 +++++++++++++++++++++++++++++++++++------
> >  tools/perf/util/evsel.h |  7 ++++++
> >  2 files changed, 48 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index dbfeceb2546c..f33801b4615d 100644
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
>
> should this just remove evsel from perf_missing_features.pmu?

Nop, it'll release all the hash nodes (pmu).  Each evsel can come
from a same PMU.

>
> I'm not sure when we should actually release this.. what's your rationale
> for releasing it in here?

Yeah, that's a problem when we should release it.  Maybe we can
add a function and call it in the exit path but I didn't want to change
all the callsites just for this.

As evsel__delete() is called in the exit path, I thought it's a
place where we can free the hashmap.  But I'm not very happy
with that either.. Do you have a better idea?

If another evsel is open after this function, I think it should
be fine since it will create a new hash map and check the
missing feature again.


>
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
> > @@ -1807,8 +1828,13 @@ static void evsel__disable_missing_features(struct evsel *evsel)
> >               evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
> >       if (perf_missing_features.mmap2)
> >               evsel->core.attr.mmap2 = 0;
> > -     if (perf_missing_features.exclude_guest)
> > -             evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
> > +     if (perf_missing_features.exclude_guest) {
> > +             /* we only have EXCLUDE_GUEST bit, let's skip checking  */
> > +             if (hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> > +                     evsel->core.attr.exclude_guest = 0;
> > +                     evsel->core.attr.exclude_host = 0;
> > +             }
> > +     }
> >       if (perf_missing_features.lbr_flags)
> >               evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
> >                                    PERF_SAMPLE_BRANCH_NO_CYCLES);
> > @@ -1840,6 +1866,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> >
> >  bool evsel__detect_missing_features(struct evsel *evsel)
> >  {
> > +     if (perf_missing_features.pmu == NULL)
> > +             perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);
>
> missing allocation fail check

Ok, will change.

Thanks for your review,
Namhyung


>
> > +
> >       /*
> >        * Must probe features in the order they were added to the
> >        * perf_event_attr interface.
> > @@ -1900,10 +1929,16 @@ bool evsel__detect_missing_features(struct evsel *evsel)
> >               perf_missing_features.mmap2 = true;
> >               pr_debug2_peo("switching off mmap2\n");
> >               return true;
> > -     } else if (!perf_missing_features.exclude_guest &&
> > -                (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> > -             perf_missing_features.exclude_guest = true;
> > -             pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> > +     } else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
> > +                !hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> > +             uintptr_t pmu_features = PERF_MISSING_PMU_EXCLUDE_GUEST;
> > +
> > +             hashmap__add(perf_missing_features.pmu, evsel, (void *)pmu_features);
> > +
> > +             if (!perf_missing_features.exclude_guest) {
> > +                     perf_missing_features.exclude_guest = true;
> > +                     pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> > +             }
> >               return true;
> >       } else if (!perf_missing_features.sample_id_all) {
> >               perf_missing_features.sample_id_all = true;
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 1f7edfa8568a..11b5ece19f0e 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -172,6 +172,13 @@ struct perf_missing_features {
> >       bool data_page_size;
> >       bool code_page_size;
> >       bool weight_struct;
> > +
> > +     /* contains enum perf_missing_pmu_features below */
> > +     struct hashmap *pmu;
> > +};
> > +
> > +enum perf_missing_pmu_features {
> > +     PERF_MISSING_PMU_EXCLUDE_GUEST          = 1UL << 0,
> >  };
> >
> >  extern struct perf_missing_features perf_missing_features;
> > --
> > 2.33.0.1079.g6e70778dc9-goog
> >
>
