Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB79416B28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 07:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbhIXFUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 01:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbhIXFUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 01:20:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294F7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 22:19:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i25so35736224lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 22:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifWkwX7JCoVIJ4c5r2rky++BfvxJwbQVONOFF3jbrB0=;
        b=K65ImhUNJsOnQs+RT6OD8n7Dum1t8Pr4Avere7qpXPP7vRebDFeXJw/V5p4WWQvqnH
         Ltp7PX0FnhpeSpPw+zMlkjJ/I4BfLDsdt4dkRseX7fvk2HJyXFPZNQpakNQftIVsIO1d
         T2SoxqvSQPsspx70of5M6jTr0B2xU6yykCONaNAVnCVtqbLsZzvfMAvW6Du+hLmHFYKX
         Kk5shJzlTezWiYsAODLsngXvpx+71lOlEt+5h/waO+77W0q7FUaZeYDAL0pqIdE5ijtX
         KErKODJKBiZ8hqMNMbEK6cf6BGhPm5TjmxqHUby31hTdppTWkebB1EMiey+4yWQhGgDb
         TYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifWkwX7JCoVIJ4c5r2rky++BfvxJwbQVONOFF3jbrB0=;
        b=ygZUCUoR6MLV8ZN1se4Pzo9gBnVSaTv18IsdrcipJ52h89C/cthFbSfH0cZkzjbgmW
         fR2L/VHNvHC6SWNZnRAHZ+ZJ8d5jPYwMB0MJbpLlNUwq7J+7vI4pTxc2sBpSsanb2QOp
         6oY7UFMzea6c4MWZ/6sbzVF3nomsqOJPU+L0lUJM7+BO7eazk58QAIQtNPZNrYZ9jT0l
         FyE07Spv4QsrBhZjhge2npkBRQtXtJdc1GVVBP6Ng0ouUcbGJDub8ecKufLHudSXGIyq
         2zkbqNlQ1dVgqUeHf/VcKjNsoTMk7M8RTlUKILKKunLPE8HituK+msW+0yMIuuElma67
         EniA==
X-Gm-Message-State: AOAM532rD6Q72Y1mjQIJcQz4zBsRZsptHynwqFYOge3soP2yB4+6h+Bw
        9U3Vbih04C+sfaXCshVg3SynWeVqWM+7XL9oCItmhg==
X-Google-Smtp-Source: ABdhPJxUwmHGFnPv4tPRyb1H3+40Os4sF2P5m0jXUix+1E7Q3WnwnjggRpQO9GJqFKD6YEqjkcn7ADt4Ep60RXc+yaU=
X-Received: by 2002:ac2:4ac6:: with SMTP id m6mr7394584lfp.513.1632460744320;
 Thu, 23 Sep 2021 22:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210923140951.35902-1-kernelfans@gmail.com> <20210923140951.35902-5-kernelfans@gmail.com>
 <CAFgQCTsvrGSzxZKFOiE+yqLdFZTnXkh72G0pVbp2q_sEW_pjEQ@mail.gmail.com>
In-Reply-To: <CAFgQCTsvrGSzxZKFOiE+yqLdFZTnXkh72G0pVbp2q_sEW_pjEQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 24 Sep 2021 10:48:51 +0530
Message-ID: <CAFA6WYO01=4KmE=MJFL9btSvP8-RmQHMO49pLwUrgR9-LFm5+Q@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] arm64: Enable perf events based hard lockup detector
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pingfan,

On Thu, 23 Sept 2021 at 19:59, Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Thu, Sep 23, 2021 at 10:10 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> To Sumit, I think credits should go to you and keep you as the author.
>

Thanks, I am fine with it. If you like then you can add your
"Co-developed-by" as well.

> Please let me know if you dislike it.
>
> Thanks,
>
> Pingfan
> > With the recent feature added to enable perf events to use pseudo NMIs
> > as interrupts on platforms which support GICv3 or later, its now been
> > possible to enable hard lockup detector (or NMI watchdog) on arm64
> > platforms. So enable corresponding support.
> >
> > One thing to note here is that normally lockup detector is initialized
> > just after the early initcalls but PMU on arm64 comes up much later as
> > device_initcall(). So we need to re-initialize lockup detection once
> > PMU has been initialized.

This needs to be updated to reflect delayed initialization instead.

-Sumit

> >
> > [1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > (Pingfan: adapt it to watchdog_hld async model based on [1])
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Wang Qing <wangqing@vivo.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Santosh Sivaraj <santosh@fossix.org>
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> > ---
> >  arch/arm64/Kconfig               |  2 ++
> >  arch/arm64/kernel/Makefile       |  1 +
> >  arch/arm64/kernel/perf_event.c   | 11 ++++++++--
> >  arch/arm64/kernel/watchdog_hld.c | 36 ++++++++++++++++++++++++++++++++
> >  drivers/perf/arm_pmu.c           |  5 +++++
> >  include/linux/perf/arm_pmu.h     |  2 ++
> >  6 files changed, 55 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm64/kernel/watchdog_hld.c
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 5c7ae4c3954b..8287e9e1d28d 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -189,6 +189,8 @@ config ARM64
> >         select HAVE_NMI
> >         select HAVE_PATA_PLATFORM
> >         select HAVE_PERF_EVENTS
> > +       select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
> > +       select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> >         select HAVE_PERF_REGS
> >         select HAVE_PERF_USER_STACK_DUMP
> >         select HAVE_REGS_AND_STACK_ACCESS_API
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index 3f1490bfb938..789c2fe5bb90 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -46,6 +46,7 @@ obj-$(CONFIG_MODULES)                 += module.o
> >  obj-$(CONFIG_ARM64_MODULE_PLTS)                += module-plts.o
> >  obj-$(CONFIG_PERF_EVENTS)              += perf_regs.o perf_callchain.o
> >  obj-$(CONFIG_HW_PERF_EVENTS)           += perf_event.o
> > +obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
> >  obj-$(CONFIG_HAVE_HW_BREAKPOINT)       += hw_breakpoint.o
> >  obj-$(CONFIG_CPU_PM)                   += sleep.o suspend.o
> >  obj-$(CONFIG_CPU_IDLE)                 += cpuidle.o
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index b4044469527e..a34343d0f418 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/sched_clock.h>
> >  #include <linux/smp.h>
> > +#include <linux/nmi.h>
> >
> >  /* ARMv8 Cortex-A53 specific event types. */
> >  #define ARMV8_A53_PERFCTR_PREF_LINEFILL                                0xC2
> > @@ -1284,10 +1285,16 @@ static struct platform_driver armv8_pmu_driver = {
> >
> >  static int __init armv8_pmu_driver_init(void)
> >  {
> > +       int ret;
> > +
> >         if (acpi_disabled)
> > -               return platform_driver_register(&armv8_pmu_driver);
> > +               ret = platform_driver_register(&armv8_pmu_driver);
> >         else
> > -               return arm_pmu_acpi_probe(armv8_pmuv3_init);
> > +               ret = arm_pmu_acpi_probe(armv8_pmuv3_init);
> > +
> > +       hld_detector_delay_initialized = true;
> > +       wake_up(&hld_detector_wait);
> > +       return ret;
> >  }
> >  device_initcall(armv8_pmu_driver_init)
> >
> > diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
> > new file mode 100644
> > index 000000000000..379743e0d001
> > --- /dev/null
> > +++ b/arch/arm64/kernel/watchdog_hld.c
> > @@ -0,0 +1,36 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/nmi.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/perf/arm_pmu.h>
> > +
> > +/*
> > + * Safe maximum CPU frequency in case a particular platform doesn't implement
> > + * cpufreq driver. Although, architecture doesn't put any restrictions on
> > + * maximum frequency but 5 GHz seems to be safe maximum given the available
> > + * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
> > + * hand, we can't make it much higher as it would lead to a large hard-lockup
> > + * detection timeout on parts which are running slower (eg. 1GHz on
> > + * Developerbox) and doesn't possess a cpufreq driver.
> > + */
> > +#define SAFE_MAX_CPU_FREQ      5000000000UL // 5 GHz
> > +u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > +{
> > +       unsigned int cpu = smp_processor_id();
> > +       unsigned long max_cpu_freq;
> > +
> > +       max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > +       if (!max_cpu_freq)
> > +               max_cpu_freq = SAFE_MAX_CPU_FREQ;
> > +
> > +       return (u64)max_cpu_freq * watchdog_thresh;
> > +}
> > +
> > +int __init watchdog_nmi_probe(void)
> > +{
> > +       if (!hld_detector_delay_initialized)
> > +               return -EBUSY;
> > +       else if (!arm_pmu_irq_is_nmi())
> > +               return -ENODEV;
> > +
> > +       return hardlockup_detector_perf_init();
> > +}
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 3cbc3baf087f..2aecb0c34290 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -697,6 +697,11 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
> >         return per_cpu(hw_events->irq, cpu);
> >  }
> >
> > +bool arm_pmu_irq_is_nmi(void)
> > +{
> > +       return has_nmi;
> > +}
> > +
> >  /*
> >   * PMU hardware loses all context when a CPU goes offline.
> >   * When a CPU is hotplugged back in, since some hardware registers are
> > diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> > index 505480217cf1..bf7966776c55 100644
> > --- a/include/linux/perf/arm_pmu.h
> > +++ b/include/linux/perf/arm_pmu.h
> > @@ -163,6 +163,8 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
> >  static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
> >  #endif
> >
> > +bool arm_pmu_irq_is_nmi(void);
> > +
> >  /* Internal functions only for core arm_pmu code */
> >  struct arm_pmu *armpmu_alloc(void);
> >  struct arm_pmu *armpmu_alloc_atomic(void);
> > --
> > 2.31.1
> >
