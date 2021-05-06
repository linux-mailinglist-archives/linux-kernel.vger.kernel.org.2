Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7D374F0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 07:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhEFFy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 01:54:28 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:42624 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhEFFy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 01:54:26 -0400
Received: by mail-lj1-f181.google.com with SMTP id w4so5513496ljw.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 22:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxuapDkJ8h8w1UrmTgnz+lzQPK4Vf1G94dpavyVSvag=;
        b=uoa+4TnXdmzw1kd/J9I0bud7E8Qj5A7Qq93I/GlvBw8vaNBMvUUFcIMftNcWwgNPlf
         biRG9Zahy15PjkTxlZa8Wx5w7x4E3Qvq4xj9C4l14l2nr36YqMB+S2kgivUQ6YywmvNo
         VwmepFTE+KmnOW5Rrx7o3RPfxcZenOZbigHXypEp3EXagIyncMQq86JGZY0gZkT/owdr
         se0EvtY2P9KYdbramGejY6fzjl9ITaBW9ilVEGFRRfS1CIYYFu5873ww+TDkrnnbcwSD
         gdfNVwQwOftutNXtYlE68ITVdh2Oq3WHy/fbil1p3mJuTizej37hFkQn6C0e/P5qR/Ge
         JHkw==
X-Gm-Message-State: AOAM533MunhKlVonw+33uI2PfA9n5FqFqooRb0cLPuF6NvY68KjtS7eP
        ZcRKNDWQ1HhpVBPYFyZHlpP/89i79oB26hKrCfI=
X-Google-Smtp-Source: ABdhPJw/2jVUUTo+IeF4Y9yPhQUktZUxPj6rn1kPeLRHUeV7GH97zL4//zOALPmvutaqED0PMt2Pcr+DV+ypFIlTqkY=
X-Received: by 2002:a2e:b746:: with SMTP id k6mr1853690ljo.275.1620280407894;
 Wed, 05 May 2021 22:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210210083327.22726-1-namhyung@kernel.org> <20210210083327.22726-3-namhyung@kernel.org>
 <CAM9d7cgWDNiKBj14TA0Yj_aOhAxzF-xGtstOVRJmQnM6RBDdYg@mail.gmail.com>
In-Reply-To: <CAM9d7cgWDNiKBj14TA0Yj_aOhAxzF-xGtstOVRJmQnM6RBDdYg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 May 2021 22:53:16 -0700
Message-ID: <CAM9d7cg4C-fXEquFjttHnx0mqCKA2E1yL19ybKxqATGoPJ5AHw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf tools: Add 'cgroup-switches' software event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Arnaldo,
>
> Could you please pick this up?  The kernel part is landed in the
> tip.git already.

Ping!

Thanks,
Namhyung


> On Wed, Feb 10, 2021 at 5:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It counts how often cgroups are changed actually during the context
> > switches.
> >
> >   # perf stat -a -e context-switches,cgroup-switches -a sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >               11,267      context-switches
> >               10,950      cgroup-switches
> >
> >          1.015634369 seconds time elapsed
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/include/uapi/linux/perf_event.h | 1 +
> >  tools/perf/util/parse-events.c        | 4 ++++
> >  tools/perf/util/parse-events.l        | 1 +
> >  3 files changed, 6 insertions(+)
> >
> > diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> > index b15e3447cd9f..16b9538ad89b 100644
> > --- a/tools/include/uapi/linux/perf_event.h
> > +++ b/tools/include/uapi/linux/perf_event.h
> > @@ -112,6 +112,7 @@ enum perf_sw_ids {
> >         PERF_COUNT_SW_EMULATION_FAULTS          = 8,
> >         PERF_COUNT_SW_DUMMY                     = 9,
> >         PERF_COUNT_SW_BPF_OUTPUT                = 10,
> > +       PERF_COUNT_SW_CGROUP_SWITCHES           = 11,
> >
> >         PERF_COUNT_SW_MAX,                      /* non-ABI */
> >  };
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 42c84adeb2fb..09ff678519f3 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -145,6 +145,10 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
> >                 .symbol = "bpf-output",
> >                 .alias  = "",
> >         },
> > +       [PERF_COUNT_SW_CGROUP_SWITCHES] = {
> > +               .symbol = "cgroup-switches",
> > +               .alias  = "",
> > +       },
> >  };
> >
> >  #define __PERF_EVENT_FIELD(config, name) \
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > index 9db5097317f4..88f203bb6fab 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -347,6 +347,7 @@ emulation-faults                            { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EM
> >  dummy                                          { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
> >  duration_time                                  { return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
> >  bpf-output                                     { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
> > +cgroup-switches                                        { return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
> >
> >         /*
> >          * We have to handle the kernel PMU event cycles-ct/cycles-t/mem-loads/mem-stores separately.
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
