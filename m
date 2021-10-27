Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37D743C5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbhJ0JBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241123AbhJ0JBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635325122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJzmgdC0VIYyfuN5P7hfz7DtVPKFFXyExRPUfpMEFpA=;
        b=BsG3fO4OzfqtNKNALgVf/usi0TQ16MztXCdRkUeEgHbqlQz0AwoSDyDWr1TJhhxVutu0Z0
        PPh/nzdueEqzNjSpP/8TFmnxZz7BzTx5++m0DFnL2pCve3cAYKP3GOs4WTwkVQWgSBc3R0
        1nRdCYWr5HAj3TWtuS99fz4NUR/2dKQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-opmCYHVAN4W53WI0k0809A-1; Wed, 27 Oct 2021 04:58:40 -0400
X-MC-Unique: opmCYHVAN4W53WI0k0809A-1
Received: by mail-wr1-f72.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so402238wrb.14
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJzmgdC0VIYyfuN5P7hfz7DtVPKFFXyExRPUfpMEFpA=;
        b=V22YYSRAltCeb9IitqIAX3ELixc+iUbsi0MWRMO8xUNz254XZjEZr3cWNF7ivVHJVE
         xKDwqU6EmH7IVNEhZ1KXMuyqU6L0SBiRoaHx4anYv65xlehCkIAPJf210uCxaEXdwZ9K
         ku3JszucHWIkxgnnVOb/KwT/+d+w6E/jnRWvPyM4zJGolv4YnqGLd+2ImHoK+cFEL1wm
         EVQ/7YW8CWDZ4MMCA1W2REfvh8SEyk1RYemCtXcXT5NlDt5MonUW4XiWK9CYE9bYdu1H
         V4e78zleoa2pBioEqfD5GnKiAIxJzT0q5iHO6kH5A/KueUMQwtfcKgx7sSGsGVLcg6h1
         FjQQ==
X-Gm-Message-State: AOAM530RoN/ylg88r5i1jjgJ7XJQoYrT+Hv/Hro/aqlmf9r94X2UghFD
        aspPeRexoFnJwzc85RTOXAwvZ0Wiw6B6Oqld3FWKAXHhCDxQYvwfLL1xb2uDnd+NiCt+FdUPWCV
        O0NbaRHq3ZXu5fJ5urQAbajka
X-Received: by 2002:adf:bd91:: with SMTP id l17mr38584463wrh.261.1635325118991;
        Wed, 27 Oct 2021 01:58:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyO/TSf8g/LjEaTvZkKaHXWxyI3hUByDnIu+8Q8HvVx5jQat6p+GxrsYX7AZD6gArvDjRnGA==
X-Received: by 2002:adf:bd91:: with SMTP id l17mr38584438wrh.261.1635325118726;
        Wed, 27 Oct 2021 01:58:38 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 13sm9950121wrz.38.2021.10.27.01.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:58:38 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:58:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YXkUvGHBaowXqwZ/@krava>
References: <20211026043351.56662-1-namhyung@kernel.org>
 <YXhJn8rtkATcN9ZE@krava>
 <CAM9d7cj8zACP6VxN3e8KGLAS74xrNaDr6-utmti3_9DzyW6rjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj8zACP6VxN3e8KGLAS74xrNaDr6-utmti3_9DzyW6rjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 12:30:42PM -0700, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Tue, Oct 26, 2021 at 11:32 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Oct 25, 2021 at 09:33:51PM -0700, Namhyung Kim wrote:
> > > The current logic for the perf missing feature has a bug that it can
> > > wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > > support any filtering or exclusion while others do.  But we check it
> > > as a global feature.
> > >
> > > For example, the cycles event can have 'G' modifier to enable it only
> > > in the guest mode on x86.  When you don't run any VMs it'll return 0.
> > >
> > >   # perf stat -a -e cycles:G sleep 1
> > >
> > >     Performance counter stats for 'system wide':
> > >
> > >                     0      cycles:G
> > >
> > >           1.000721670 seconds time elapsed
> > >
> > > But when it's used with other pmu events that don't support G modifier,
> > > it'll be reset and return non-zero values.
> > >
> > >   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> > >
> > >     Performance counter stats for 'system wide':
> > >
> > >           538,029,960      cycles:G
> > >        16,924,010,738      msr/tsc/
> > >
> > >           1.001815327 seconds time elapsed
> > >
> > > This is because of the missing feature detection logic being global.
> > > Add a hashmap to set pmu-specific exclude_host/guest features.
> > >
> > > Reported-by: Stephane Eranian <eranian@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > v2 changes)
> > >  * change to enum perf_missing_pmu_features
> > >  * pass NULL to hashmap__find() to skip checking
> > >  * add a blank line after declaration
> > >
> > >  tools/perf/util/evsel.c | 47 +++++++++++++++++++++++++++++++++++------
> > >  tools/perf/util/evsel.h |  7 ++++++
> > >  2 files changed, 48 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index dbfeceb2546c..f33801b4615d 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -1434,6 +1434,10 @@ void evsel__delete(struct evsel *evsel)
> > >  {
> > >       evsel__exit(evsel);
> > >       free(evsel);
> > > +
> > > +     /* just free it for the first evsel */
> > > +     hashmap__free(perf_missing_features.pmu);
> > > +     perf_missing_features.pmu = NULL;
> >
> > should this just remove evsel from perf_missing_features.pmu?
> 
> Nop, it'll release all the hash nodes (pmu).  Each evsel can come
> from a same PMU.
> 
> >
> > I'm not sure when we should actually release this.. what's your rationale
> > for releasing it in here?
> 
> Yeah, that's a problem when we should release it.  Maybe we can
> add a function and call it in the exit path but I didn't want to change
> all the callsites just for this.

yea, I think we probably need it in other places as well,
but that should be separate patchset I think

> 
> As evsel__delete() is called in the exit path, I thought it's a
> place where we can free the hashmap.  But I'm not very happy
> with that either.. Do you have a better idea?

nope ;-)

> 
> If another evsel is open after this function, I think it should
> be fine since it will create a new hash map and check the
> missing feature again.

I think let's keep it as it is for now and we'll see

thanks,
jirka

> 
> 
> >
> > >  }
> > >
> > >  void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
> > > @@ -1791,6 +1795,23 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> > >       return 0;
> > >  }
> > >
> > > +#define PMU_HASH_BITS  4
> > > +
> > > +static size_t pmu_hash(const void *key, void *ctx __maybe_unused)
> > > +{
> > > +     const struct evsel *evsel = key;
> > > +
> > > +     return hash_bits(evsel->core.attr.type, PMU_HASH_BITS);
> > > +}
> > > +
> > > +static bool pmu_equal(const void *key1, const void *key2, void *ctx __maybe_unused)
> > > +{
> > > +     const struct evsel *a = key1;
> > > +     const struct evsel *b = key2;
> > > +
> > > +     return a->core.attr.type == b->core.attr.type;
> > > +}
> > > +
> > >  static void evsel__disable_missing_features(struct evsel *evsel)
> > >  {
> > >       if (perf_missing_features.weight_struct) {
> > > @@ -1807,8 +1828,13 @@ static void evsel__disable_missing_features(struct evsel *evsel)
> > >               evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
> > >       if (perf_missing_features.mmap2)
> > >               evsel->core.attr.mmap2 = 0;
> > > -     if (perf_missing_features.exclude_guest)
> > > -             evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
> > > +     if (perf_missing_features.exclude_guest) {
> > > +             /* we only have EXCLUDE_GUEST bit, let's skip checking  */
> > > +             if (hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> > > +                     evsel->core.attr.exclude_guest = 0;
> > > +                     evsel->core.attr.exclude_host = 0;
> > > +             }
> > > +     }
> > >       if (perf_missing_features.lbr_flags)
> > >               evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
> > >                                    PERF_SAMPLE_BRANCH_NO_CYCLES);
> > > @@ -1840,6 +1866,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> > >
> > >  bool evsel__detect_missing_features(struct evsel *evsel)
> > >  {
> > > +     if (perf_missing_features.pmu == NULL)
> > > +             perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);
> >
> > missing allocation fail check
> 
> Ok, will change.
> 
> Thanks for your review,
> Namhyung
> 
> 
> >
> > > +
> > >       /*
> > >        * Must probe features in the order they were added to the
> > >        * perf_event_attr interface.
> > > @@ -1900,10 +1929,16 @@ bool evsel__detect_missing_features(struct evsel *evsel)
> > >               perf_missing_features.mmap2 = true;
> > >               pr_debug2_peo("switching off mmap2\n");
> > >               return true;
> > > -     } else if (!perf_missing_features.exclude_guest &&
> > > -                (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> > > -             perf_missing_features.exclude_guest = true;
> > > -             pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> > > +     } else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
> > > +                !hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> > > +             uintptr_t pmu_features = PERF_MISSING_PMU_EXCLUDE_GUEST;
> > > +
> > > +             hashmap__add(perf_missing_features.pmu, evsel, (void *)pmu_features);
> > > +
> > > +             if (!perf_missing_features.exclude_guest) {
> > > +                     perf_missing_features.exclude_guest = true;
> > > +                     pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> > > +             }
> > >               return true;
> > >       } else if (!perf_missing_features.sample_id_all) {
> > >               perf_missing_features.sample_id_all = true;
> > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > index 1f7edfa8568a..11b5ece19f0e 100644
> > > --- a/tools/perf/util/evsel.h
> > > +++ b/tools/perf/util/evsel.h
> > > @@ -172,6 +172,13 @@ struct perf_missing_features {
> > >       bool data_page_size;
> > >       bool code_page_size;
> > >       bool weight_struct;
> > > +
> > > +     /* contains enum perf_missing_pmu_features below */
> > > +     struct hashmap *pmu;
> > > +};
> > > +
> > > +enum perf_missing_pmu_features {
> > > +     PERF_MISSING_PMU_EXCLUDE_GUEST          = 1UL << 0,
> > >  };
> > >
> > >  extern struct perf_missing_features perf_missing_features;
> > > --
> > > 2.33.0.1079.g6e70778dc9-goog
> > >
> >
> 

