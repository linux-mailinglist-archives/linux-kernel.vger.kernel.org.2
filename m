Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44FC40EBEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhIPVC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:02:56 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42753 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhIPVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:02:54 -0400
Received: by mail-lf1-f47.google.com with SMTP id bq5so23880581lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lh/g9O9FeL09Lf0YdCKHSaBVJAsgIhPbExscrbybvw=;
        b=Sn2vbLxFEJyUJd3RphcXzWvWtRDka1vWscVJVaBdrdwKtBXAW/RF1D23cj805ZWSDm
         qAJVMrxdKJaU1LgkYpjfkbZWONwMR85IgVBTKqOjxZM5H5V3Nn58vzQTs8GXPj72qXxv
         2YxG1VK5/O3r0aWvjYCdBDeWAxqW1qUvG6D7GL+vWRPZCJeYNOt1UrxZ02g+C+juHLh3
         N/zaoXDk65pgwq7uPZtRVeQKffmfYOsBklbAzPRBxg7KHbsFxhA9XByrhpxkCwKFWD3m
         9oS5KezCd+1eb2Pl2psaPztdk35P5a7+ngPqlOCoNJN1u/iPiPueN6wbFPimStvi+hf5
         V2mQ==
X-Gm-Message-State: AOAM533EM9lOddCA4WIM/lHRINvWfj1R75IXWJLyqcq2viOfbIMK1If2
        wIzThlkHX6VC3ZdCW14gZaIrCCrinvziTHX9Q7c=
X-Google-Smtp-Source: ABdhPJyyJ2f9AEJnLToxBLZZfzGpvbxD9P4/c5UZyAWnAp0N3Ppb5ut+Q9dVs0eG5+vXh/WXI7xqcF+gyRDSL5XHEpQ=
X-Received: by 2002:a05:651c:a12:: with SMTP id k18mr6546638ljq.90.1631826092625;
 Thu, 16 Sep 2021 14:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210916001748.1525291-1-namhyung@kernel.org> <20210916135418.GA383600@leoy-ThinkPad-X240s>
In-Reply-To: <20210916135418.GA383600@leoy-ThinkPad-X240s>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 16 Sep 2021 14:01:21 -0700
Message-ID: <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

(Removing Tan as the email bounced)

On Thu, Sep 16, 2021 at 6:54 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Namhyung,
>
> On Wed, Sep 15, 2021 at 05:17:48PM -0700, Namhyung Kim wrote:
> > When perf report synthesize events from ARM SPE data, it refers to
> > current cpu, pid and tid in the machine.  But there's no place to set
> > them in the ARM SPE decoder.  I'm seeing all pid/tid is set to -1 and
> > user symbols are not resolved in the output.
> >
> >   # perf record -a -e arm_spe_0/ts_enable=1/ sleep 1
> >
> >   # perf report -q | head
> >      8.77%     8.77%  :-1      [kernel.kallsyms]  [k] format_decode
> >      7.02%     7.02%  :-1      [kernel.kallsyms]  [k] seq_printf
> >      7.02%     7.02%  :-1      [unknown]          [.] 0x0000ffff9f687c34
> >      5.26%     5.26%  :-1      [kernel.kallsyms]  [k] vsnprintf
> >      3.51%     3.51%  :-1      [kernel.kallsyms]  [k] string
> >      3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f66ae20
> >      3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f670b3c
> >      3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f67c040
> >      1.75%     1.75%  :-1      [kernel.kallsyms]  [k] ___cache_free
> >      1.75%     1.75%  :-1      [kernel.kallsyms]  [k] __count_memcg_events
> >
> > Like Intel PT, add context switch records to track task info.  As ARM
> > SPE support was added later than PERF_RECORD_SWITCH_CPU_WIDE, I think
> > we can safely set the attr.context_switch bit and use it.
>
> Thanks for the patch.
>
> Before we had discussion for enabling PID/TID for SPE samples; in the patch
> set [1], patches 07, 08 set sample's pid/tid based on the Arm SPE context
> packets.  To enable hardware tracing context ID, you also needs to enable
> kernel config CONFIG_PID_IN_CONTEXTIDR.

Thanks for sharing this.

Yeah I also look at the context info but having a dependency on a kconfig
looks limiting its functionality.  Also the kconfig says it has some overhead
in the critical path (even if perf is not running, right?) - but not sure how
much it can add.

config PID_IN_CONTEXTIDR
    bool "Write the current PID to the CONTEXTIDR register"
    help
      Enabling this option causes the kernel to write the current PID to
      the CONTEXTIDR register, at the expense of some additional
      instructions during context switch. Say Y here only if you are
      planning to use hardware trace tools with this kernel.

>
> At that time, there have a concern is the hardware context ID might
> introduce confusion for non-root namespace.

Sounds like a problem.

>
> We also considered to use PERF_RECORD_SWITCH_CPU_WIDE event for setting
> pid/tid, the Intel PT implementation uses two things to set sample's
> pid/tid: one is PERF_RECORD_SWITCH_CPU_WIDE event and another is to detect
> the branch instruction is the symbol "__switch_to".  Since the trace
> event PERF_RECORD_SWITCH_CPU_WIDE is coarse, so it only uses the new
> pid/tid after the branch instruction for "__switch_to".  Arm SPE is
> 'statistical', thus it cannot promise the trace data must contain the
> branch instruction for "__switch_to", please see details [2].

I can see the need in the Intel PT as it needs to trace all (branch)
instructions, but is it really needed for ARM SPE too?
Maybe I am missing something, but it seems enough to have a
coarse-grained context switch for sampling events..

>
> I think the feasible way is to use CONTEXTIDR to trace PID/TID _only_
> for root namespace, and the perf tool uses context packet to set
> pid/tid for samples.  So except we need patches 07 and 08, we also
> need a change in Arm SPE driver as below:
>
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index d44bcc29d99c..2553d53d3772 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -272,7 +272,9 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>         if (!attr->exclude_kernel)
>                 reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
>
> -       if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
> +       /* Only enable context ID tracing for root namespace */
> +       if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable() &&
> +           (task_active_pid_ns(current) == &init_pid_ns))
>                 reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
>
>         return reg;
>
> Could you confirm if this works for you?  If it's okay for you, I will
> sync with James for upstreaming the changes.

Let me think about this more..

Thanks,
Namhyung


>
> Thanks,
> Leo
>
> [1] https://lore.kernel.org/lkml/20210119144658.793-8-james.clark@arm.com/
> [2] https://lore.kernel.org/lkml/20210204102734.GA4737@leoy-ThinkPad-X240s/
