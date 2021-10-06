Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0928C42423E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhJFQLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:11:52 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:35620 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhJFQLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:11:51 -0400
Received: by mail-lf1-f41.google.com with SMTP id m3so12781027lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UF+niHfshFUxICHDMKnqYtVzDlY57F0pVhxtGj50BbY=;
        b=ug/VDINr+TBkReCUkD8oBpZQfqwr1Xe7N9enPpb71Cigzitwo8cg6p/Uo+4v5ksPvM
         Tk+ocjOP6zWf95OyG9VpUPpZCUUxOh6vbQJGcYNRCYIC3/fdNsMpnpS2BtFcxJOHdk4f
         SZjUEEw65eYXgc/5vTbvGE11Ay6n8Brglit5fQqYiR/e/nVJhUpWJmAgAmaZyaCUHJQ/
         Y74p6ttK67cWy84MkAk9kJD25DijzxyLHc1IL/nsqVMGa8pKReCvkeI+TVcgzpDn+G+x
         8x64PF2DX8n4LF92u6C90mJtAf551JfkgaFnfoIWusSRscQwlaUI/UTVqSIMzqQcd71H
         7iNA==
X-Gm-Message-State: AOAM530e+JMrbD+nkICjtyRvy9B7ACvYbKlhEgQRV2EUv0mFFQvnSt/4
        Fdsb6yUjtoJKACvowsya8SA6hOuqbB8GABb3/iI=
X-Google-Smtp-Source: ABdhPJwAAC9t9dkveeJtJg4Lbojshuf3aa0BpFT0otxM6+CvM6smyAv4OMjkr+BUBBvWLnollbH/W0QrhIWW+nhMraI=
X-Received: by 2002:a05:6512:114e:: with SMTP id m14mr10316078lfg.99.1633536598086;
 Wed, 06 Oct 2021 09:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210916001748.1525291-1-namhyung@kernel.org> <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
 <20210923142305.GA603008@leoy-ThinkPad-X240s> <363c4107-fc6f-51d0-94d8-a3f579c8f5a2@arm.com>
 <20211004062638.GB174271@leoy-ThinkPad-X240s> <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
 <20211006093620.GA14400@leoy-ThinkPad-X240s>
In-Reply-To: <20211006093620.GA14400@leoy-ThinkPad-X240s>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Oct 2021 09:09:46 -0700
Message-ID: <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo and German,

On Wed, Oct 6, 2021 at 2:36 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi German,
>
> On Tue, Oct 05, 2021 at 11:06:12AM +0100, German Gomez wrote:
>
> [...]
>
> > Yesterday we did some testing and found that there seems to be an exact
> > match between using context packets and switch events. However this only
> > applies when tracing in userspace (by adding the 'u' suffix to the perf
> > event). Otherwise we still see as much as 2% of events having the wrong
> > PID around the time of the switch.
>
> This result sounds reasonable for me, if we only trace the userspace,
> the result should have no any difference between using context packets
> and switch events.
>
> It's a bit high deviation with switch events (1.30% as shown in below
> result) after enable kernel tracing.

Yes, it's bigger than I expected, but it'd be workload specific.

>
> > In order to measure this I applied Namhyung's patch and James's patch
> > from [1]. Then added a printf line to the function arm_spe_prep_sample
> > where I have access to both PID values, as a quick way to compare them
> > later in a perf-report run. This is the diff of the printf patch:
> >
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 41385ab96fbc..591985c66ac4 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -247,6 +247,8 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
> >     event->sample.header.type = PERF_RECORD_SAMPLE;
> >     event->sample.header.misc = sample->cpumode;
> >     event->sample.header.size = sizeof(struct perf_event_header);
> > +
> > +       printf(">>>>>> %d / %lu\n", speq->tid, record->context_id & 0x7fff);
> >  }
> >
> > The differences obtained as error % were obtained by running the
> > following perf-record commands for different configurations:
> >
> > $ sudo ./perf record -e arm_spe/ts_enable=1,load_filter=1,store_filter=1/u -a -- sleep 60
> > $ sudo ./perf report --stdio \
> >     | grep ">>>>>>" \
> >     | awk '{total++; if($2!=$4) miss++} END {print "Error: " (100*miss/total) "% out of " total " samples"}'
> >
> > Error: 0% out of 11839328 samples
> >
> > $ sudo ./perf record -e arm_spe/ts_enable=1,load_filter=1,store_filter=1/ -a -- sleep 10
> > $ sudo ./perf report --stdio \
> >     | grep ">>>>>>" \
> >     | awk '{total++; if($2!=$4) miss++} END {print "Error: " (100*miss/total) "% out of " total " samples"}'
> >
> > Error: 1.30624% out of 3418731 samples
>
> Thanks for sharing this!
>
> > I think the fallback to using switch when we can't use the CONTEXTIDR
> > register is a viable option for userspace events, but maybe not so much
> > for non-userspace.
>
> Agreed.
>
> If so, it's good to check the variable
> 'evsel->core.attr.exclude_kernel' when decode Arm SPE trace data, and
> only use context switch event when 'exclude_kernel' is set.

I think it'd be better to check it in perf record and not set
evsel->core.attr.context_switch if possible.

Or it can ignore the context switch once it sees a context packet.

>
> Here should note one thing is the perf tool needs to have knowledge to
> decide if the bit 3 'CX' (macro 'SYS_PMSCR_EL1_CX_SHIFT' in kernel) has
> been set in register PMSCR or not.  AFAIK, Arm SPE driver doesn't
> expose any interface (or config) to userspace for the context tracing,
> so one method is to add an extra config in Arm SPE driver for this
> bit, e.g. 'ATTR_CFG_FLD_cx_enable_CFG' can be added in Arm SPE driver.
>
> Alternatively, rather than adding new config, I am just wandering we
> simply use two flags in perf's decoding: 'use_switch_event_for_pid' and
> 'use_ctx_packet_for_pid', the first variable will be set if detects
> the tracing is userspace only, the second varaible will be set when
> detects the hardware tracing containing context packet.  So if the
> variable 'use_ctx_packet_for_pid' has been set, then the decoder will
> always use context packet for sample's PID, otherwise, it falls back
> to check 'use_switch_event_for_pid' and set sample PID based on switch
> events.
>
> If have any other idea, please feel free bring up.

If it's just kernel config, we can check /proc/config.gz or
/boot/config-$(uname -r).  When it knows for sure it can just use
the context packet, otherwise it needs the context switch.

Thanks,
Namhyung
