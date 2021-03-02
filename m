Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFFE32A627
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573048AbhCBOIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 09:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383923AbhCBMct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:32:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 833DA64F18;
        Tue,  2 Mar 2021 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614687927;
        bh=iMTKkjvmai0YQxS9qK3uVLomwfQQauK44g9tNmkpkVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFlLXYO2qPW2eWpB3Z5gjYVACXH/b7tPqqMwhXGp/SeQ/H/0VEkAOXTxTB9d1OHNA
         0bjZ1JsOZn0BLVEVlKBAoiDNZwXN/KGKeNzRBRrUNxzkfXtoZeqUNJrN6zd9jahx2x
         zCG1LtpDMfsLTc9wzQwwRPUoEU7Hq9lkzaXti4t3sCptPaRtvQuuZK35DQDiSnRhNf
         nhgGWFzFsdXWtE6sS2ZlaTG4h635RPMJH9m/NSbgWxd6m5iEFhyw2iP4dynBJYDJr9
         zwLdxi8I6PQJwyVd5pGtOLD9vuWj0ZAVq6OaFBhOT947L6cHpa+uWSnyNd7ahNEx6j
         s04q0hgoX1JRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 664FB40CD9; Tue,  2 Mar 2021 09:25:24 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:25:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf stat: improve readability of shadow stats
Message-ID: <YD4utPd12bVhH7Nx@kernel.org>
References: <20210301172402.6794-1-changbin.du@gmail.com>
 <YD0+OAH9Ytii3b3V@krava>
 <CAM9d7chzOv1cbu2i_6gc+C=yJ=P0VJbsYvEOvEKkXeunjYc3rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chzOv1cbu2i_6gc+C=yJ=P0VJbsYvEOvEKkXeunjYc3rw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 02, 2021 at 11:08:40AM +0900, Namhyung Kim escreveu:
> On Tue, Mar 2, 2021 at 4:19 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Mar 02, 2021 at 01:24:02AM +0800, Changbin Du wrote:
> > > This does follow two changes:
> > >   1) Select appropriate unit between K/M/G.
> > >   2) Use 'cpu-sec' instead of 'sec' to state this is not the wall-time.
> > >
> > > $ sudo ./perf stat -a -- sleep 1
> > >
> > > Before: Unit 'M' is selected even the number is very small.
> > >  Performance counter stats for 'system wide':
> > >
> > >           4,003.06 msec cpu-clock                 #    3.998 CPUs utilized
> > >             16,179      context-switches          #    0.004 M/sec
> > >                161      cpu-migrations            #    0.040 K/sec
> > >              4,699      page-faults               #    0.001 M/sec
> > >      6,135,801,925      cycles                    #    1.533 GHz                      (83.21%)
> > >      5,783,308,491      stalled-cycles-frontend   #   94.26% frontend cycles idle     (83.21%)
> > >      4,543,694,050      stalled-cycles-backend    #   74.05% backend cycles idle      (66.49%)
> > >      4,720,130,587      instructions              #    0.77  insn per cycle
> > >                                                   #    1.23  stalled cycles per insn  (83.28%)
> > >        753,848,078      branches                  #  188.318 M/sec                    (83.61%)
> > >         37,457,747      branch-misses             #    4.97% of all branches          (83.48%)
> > >
> > >        1.001283725 seconds time elapsed
> > >
> > > After:
> > > $ sudo ./perf stat -a -- sleep 2
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >           8,003.20 msec cpu-clock                 #    3.998 CPUs utilized
> > >              9,768      context-switches          #    1.221 K/cpu-sec
> > >                164      cpu-migrations            #   20.492  /cpu-sec
> >
> > should you remove also the leading '/' in ' /cpu-sec' ?
> 
> The change looks good.  And I think we should keep '/' otherwise it'd be
> more confusing.

Perhaps:

           8,003.20 msec cpu-clock                 #    3.998 CPUs utilized
              9,768      context-switches          #    1.221 K/cpu-sec
                164      cpu-migrations            #   20.492 /cpu-sec

?

- Arnaldo
 
> >
> >
> > SNIP
> >
> > > @@ -1270,18 +1271,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> > >               generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> > >                               evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
> > >       } else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> > > -             char unit = 'M';
> > > +             char unit = ' ';
> > >               char unit_buf[10];
> > >
> > >               total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
> > > -
> > >               if (total)
> > > -                     ratio = 1000.0 * avg / total;
> > > -             if (ratio < 0.001) {
> > > -                     ratio *= 1000;
> > > -                     unit = 'K';
> > > -             }
> > > -             snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> > > +                     ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
> > > +
> > > +             snprintf(unit_buf, sizeof(unit_buf), "%c/cpu-sec", unit);
> > >               print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
> >
> > hum this will change -x output that people parse, so I don't think we can do that
> 
> Agreed.
> 
> >
> > >       } else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
> > >               print_smi_cost(config, cpu, out, st, &rsd);
> > > diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
> > > index a46762aec4c9..ac13b5ecde31 100644
> > > --- a/tools/perf/util/units.c
> > > +++ b/tools/perf/util/units.c
> > > @@ -55,6 +55,28 @@ unsigned long convert_unit(unsigned long value, char *unit)
> > >       return value;
> > >  }
> > >
> > > +double convert_unit_double(double value, char *unit)
> > > +{
> > > +     *unit = ' ';
> > > +
> > > +     if (value > 1000.0) {
> > > +             value /= 1000.0;
> > > +             *unit = 'K';
> > > +     }
> > > +
> > > +     if (value > 1000.0) {
> > > +             value /= 1000.0;
> > > +             *unit = 'M';
> > > +     }
> > > +
> > > +     if (value > 1000.0) {
> > > +             value /= 1000.0;
> > > +             *unit = 'G';
> > > +     }
> > > +
> > > +     return value;
> > > +}
> >
> > we have convert_unit function just above doing the same only with
> > unsigned long.. let's have one base function with double values and
> > another one casting the result to unsigned long
> 
> Sounds good.
> 
> Thanks,
> Namhyung

-- 

- Arnaldo
