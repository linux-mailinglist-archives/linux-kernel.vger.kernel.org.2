Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5BC430F62
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhJREzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:55:37 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38613 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhJREzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:55:36 -0400
Received: by mail-lj1-f170.google.com with SMTP id n7so6633889ljp.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 21:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWnx7k+YVySp5mJCrWGuUuMFUkiSi/LP4UQ5Tn/5TL4=;
        b=Uo0ecpus6LGEYUFqrFu0ePaFMGCtTX0l6GaXwzLOnQsSmn062rXd3Hf9QvLXxa2Kpn
         LZztysXnQq6NcK3oehTZ2u4cBxWm/yMpoyGQPqfSGR2lhD7ABBnWtpk/F9cGHejIUoTE
         RFgsNMI+Ub/cQ8RC4E15flJbZJnGX7jeSIIPtKIvhegThRaG5us5A1fVj1WIZXwn9q62
         0HhOg5+UHeAu5SC3hoidrif0w36aHRlGDY6tSqS4moxwvIobRvtnUUtgZap+YnY/G0rt
         WfvOF1sRbNbEbDWqC7BCmKXFYYLfZtLMVd60QQiSwzNfLfKBzh1Gf6ASh2wQW7ueoxSr
         3kgQ==
X-Gm-Message-State: AOAM531DkWonJOo+FmxsGGQ4K7xeTLUgrX0AZ/iAPbpqCT1P/5a3OuMv
        54Ja1vK3JjRt6K8cpjNv09KuTpUSs+YIX4VUVKJDEBKr
X-Google-Smtp-Source: ABdhPJyxpN3Z0w8oK4ZC9Ruywu2nnu62L8PcRtejpglCMeILJWH1MVREz1XI45zcB69wrG6dwkg5K0rTWDaGNMPF200=
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr3771742ljp.202.1634532804662;
 Sun, 17 Oct 2021 21:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211016051253.2035821-1-namhyung@kernel.org> <YWx0CgTyyZ4sm/l4@krava>
 <E4C04539-9803-4405-A1EA-5D9517682E08@gmail.com> <YWyQcS5WYFBSeS2F@krava>
In-Reply-To: <YWyQcS5WYFBSeS2F@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 17 Oct 2021 21:53:13 -0700
Message-ID: <CAM9d7cgg=AF6Jgsn8sNqWdf+6VOjiGNjydL_6sJh+47sMHuykg@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Fix missing exclude_{host,guest} setting
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Sun, Oct 17, 2021 at 2:07 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sun, Oct 17, 2021 at 06:03:21PM -0300, Arnaldo Carvalho de Melo wrote:
> >
> >
> > On October 17, 2021 4:05:46 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrote:
> > >On Fri, Oct 15, 2021 at 10:12:53PM -0700, Namhyung Kim wrote:
> > >> The current logic for the perf missing feature has a bug that it can
> > >> wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > >> support any filtering or exclusion while others do.  But we check it
> > >> as a global feature.
> > >>
> > >> For example, the cycles event can have 'G' modifier to enable it only
> > >> in the guest mode on x86.  When you don't run any VMs it'll return 0.
> > >>
> > >>   # perf stat -a -e cycles:G sleep 1
> > >>
> > >>     Performance counter stats for 'system wide':
> > >>
> > >>                     0      cycles:G
> > >>
> > >>           1.000721670 seconds time elapsed
> > >>
> > >> But when it's used with other pmu events that don't support G modifier,
> > >> it'll be reset and return non-zero values.
> > >>
> > >>   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> > >>
> > >>     Performance counter stats for 'system wide':
> > >>
> > >>           538,029,960      cycles:G
> > >>        16,924,010,738      msr/tsc/
> > >>
> > >>           1.001815327 seconds time elapsed
> > >>
> > >> This is because of the missing feature detection logic being global.
> > >> Add a hashmap to set pmu-specific exclude_host/guest features.
> > >>
> > >> Reported-by: Stephane Eranian <eranian@google.com>
> > >> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > >> ---
> > >>  tools/perf/util/evsel.c | 47 +++++++++++++++++++++++++++++++++++------
> > >>  tools/perf/util/evsel.h |  6 ++++++
> > >>  2 files changed, 47 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > >> index dbfeceb2546c..437a28e769fe 100644
> > >> --- a/tools/perf/util/evsel.c
> > >> +++ b/tools/perf/util/evsel.c
> > >> @@ -1434,6 +1434,10 @@ void evsel__delete(struct evsel *evsel)
> > >>  {
> > >>    evsel__exit(evsel);
> > >>    free(evsel);
> > >> +
> > >> +  /* just free it for the first evsel */
> > >> +  hashmap__free(perf_missing_features.pmu);
> > >> +  perf_missing_features.pmu = NULL;
> > >>  }
> > >>
> > >>  void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
> > >> @@ -1791,6 +1795,23 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> > >>    return 0;
> > >>  }
> > >>
> > >> +#define PMU_HASH_BITS  4
> > >> +
> > >> +static size_t pmu_hash(const void *key, void *ctx __maybe_unused)
> > >> +{
> > >> +  const struct evsel *evsel = key;
> > >> +
> > >> +  return hash_bits(evsel->core.attr.type, PMU_HASH_BITS);
> > >> +}
> > >> +
> > >> +static bool pmu_equal(const void *key1, const void *key2, void *ctx __maybe_unused)
> > >> +{
> > >> +  const struct evsel *a = key1;
> > >> +  const struct evsel *b = key2;
> > >> +
> > >> +  return a->core.attr.type == b->core.attr.type;
> > >> +}
> > >> +
> > >>  static void evsel__disable_missing_features(struct evsel *evsel)
> > >>  {
> > >>    if (perf_missing_features.weight_struct) {
> > >> @@ -1807,8 +1828,14 @@ static void evsel__disable_missing_features(struct evsel *evsel)
> > >>            evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
> > >>    if (perf_missing_features.mmap2)
> > >>            evsel->core.attr.mmap2 = 0;
> > >> -  if (perf_missing_features.exclude_guest)
> > >> -          evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
> > >> +  if (perf_missing_features.exclude_guest) {
> > >> +          void *pmu;
> > >
> > >could you just pass NULL in here instead of NULL?
> >
> > ENOPARSE
>
> ugh right... 'instead of &pmu' ;-)

Yes, we can pass NULL for the current code.
Passing the pointer is just for future change.
Maybe I thought too much.. :)

Anyway, I think it should pass the struct itself,
not the pointer to the local variable.
I'm not sure if it's possible to cast a struct literal
to a pointer, will check and update in v2.

Thanks,
Namhyung
