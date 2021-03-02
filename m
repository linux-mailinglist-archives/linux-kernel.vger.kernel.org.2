Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4EA32A0C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576566AbhCBEbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:31:08 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:40042 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbhCBCJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:09:33 -0500
Received: by mail-qt1-f179.google.com with SMTP id h9so3855094qtq.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 18:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRMBD8h6oAIsL/m8XzTtVcoB4yVeXYIjQfLY606bHgM=;
        b=MwqxLV4ikMaFM6tX+mDBaSj7kArdF8Op6547UP+mkJktr4JgqcrX0eabNvWxStbaDK
         L+iXoZmVQfu7yKqjf91hy7SRoexwRvsxkDYc6Vi7Hb3QJrSg3dv8YGCBsdnijz9JuyAt
         G2itpuLQ0LHBzTfA8xCPlGnzB0dnViqS1IRZUPpE3Bexb+0A7VBvTv4b1qD5Ra4F3uXg
         pq7pafBvEJfSG47ikOVIRmUnFmLY008AQyVqrwJ4duS1NJoCGntLqgSMRRtsD1jM8gzG
         MYHjeUQ4M+vDTj5FTh11AvMDCyVQX3eI/mvjop7jIM6evfuISygleGGCRNIly4vqTnqJ
         1Guw==
X-Gm-Message-State: AOAM530RvSopH+OjWpdXZq6RlnZw+QcRiCLpDR17lPfo5VpssYm+/U+A
        w9TE3LNfN77q/jY13l3x3e1FE2RekJAcEgrl7BA=
X-Google-Smtp-Source: ABdhPJx3rMSZDMR+pL8uzf//WSC7aJqM89y0do5ZJ50AhiSGnuogoc9/tkWWRpWkG+CrbA20LMivQhWSNPBaBOSjFOc=
X-Received: by 2002:ac8:6f31:: with SMTP id i17mr7344258qtv.292.1614650931897;
 Mon, 01 Mar 2021 18:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20210301172402.6794-1-changbin.du@gmail.com> <YD0+OAH9Ytii3b3V@krava>
In-Reply-To: <YD0+OAH9Ytii3b3V@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Mar 2021 11:08:40 +0900
Message-ID: <CAM9d7chzOv1cbu2i_6gc+C=yJ=P0VJbsYvEOvEKkXeunjYc3rw@mail.gmail.com>
Subject: Re: [PATCH] perf stat: improve readability of shadow stats
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 4:19 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Mar 02, 2021 at 01:24:02AM +0800, Changbin Du wrote:
> > This does follow two changes:
> >   1) Select appropriate unit between K/M/G.
> >   2) Use 'cpu-sec' instead of 'sec' to state this is not the wall-time.
> >
> > $ sudo ./perf stat -a -- sleep 1
> >
> > Before: Unit 'M' is selected even the number is very small.
> >  Performance counter stats for 'system wide':
> >
> >           4,003.06 msec cpu-clock                 #    3.998 CPUs utilized
> >             16,179      context-switches          #    0.004 M/sec
> >                161      cpu-migrations            #    0.040 K/sec
> >              4,699      page-faults               #    0.001 M/sec
> >      6,135,801,925      cycles                    #    1.533 GHz                      (83.21%)
> >      5,783,308,491      stalled-cycles-frontend   #   94.26% frontend cycles idle     (83.21%)
> >      4,543,694,050      stalled-cycles-backend    #   74.05% backend cycles idle      (66.49%)
> >      4,720,130,587      instructions              #    0.77  insn per cycle
> >                                                   #    1.23  stalled cycles per insn  (83.28%)
> >        753,848,078      branches                  #  188.318 M/sec                    (83.61%)
> >         37,457,747      branch-misses             #    4.97% of all branches          (83.48%)
> >
> >        1.001283725 seconds time elapsed
> >
> > After:
> > $ sudo ./perf stat -a -- sleep 2
> >
> >  Performance counter stats for 'system wide':
> >
> >           8,003.20 msec cpu-clock                 #    3.998 CPUs utilized
> >              9,768      context-switches          #    1.221 K/cpu-sec
> >                164      cpu-migrations            #   20.492  /cpu-sec
>
> should you remove also the leading '/' in ' /cpu-sec' ?

The change looks good.  And I think we should keep '/' otherwise it'd be
more confusing.

>
>
> SNIP
>
> > @@ -1270,18 +1271,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >               generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> >                               evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
> >       } else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> > -             char unit = 'M';
> > +             char unit = ' ';
> >               char unit_buf[10];
> >
> >               total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
> > -
> >               if (total)
> > -                     ratio = 1000.0 * avg / total;
> > -             if (ratio < 0.001) {
> > -                     ratio *= 1000;
> > -                     unit = 'K';
> > -             }
> > -             snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> > +                     ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
> > +
> > +             snprintf(unit_buf, sizeof(unit_buf), "%c/cpu-sec", unit);
> >               print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
>
> hum this will change -x output that people parse, so I don't think we can do that

Agreed.

>
> >       } else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
> >               print_smi_cost(config, cpu, out, st, &rsd);
> > diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
> > index a46762aec4c9..ac13b5ecde31 100644
> > --- a/tools/perf/util/units.c
> > +++ b/tools/perf/util/units.c
> > @@ -55,6 +55,28 @@ unsigned long convert_unit(unsigned long value, char *unit)
> >       return value;
> >  }
> >
> > +double convert_unit_double(double value, char *unit)
> > +{
> > +     *unit = ' ';
> > +
> > +     if (value > 1000.0) {
> > +             value /= 1000.0;
> > +             *unit = 'K';
> > +     }
> > +
> > +     if (value > 1000.0) {
> > +             value /= 1000.0;
> > +             *unit = 'M';
> > +     }
> > +
> > +     if (value > 1000.0) {
> > +             value /= 1000.0;
> > +             *unit = 'G';
> > +     }
> > +
> > +     return value;
> > +}
>
> we have convert_unit function just above doing the same only with
> unsigned long.. let's have one base function with double values and
> another one casting the result to unsigned long

Sounds good.

Thanks,
Namhyung
