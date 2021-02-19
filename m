Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548A531F6A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBSJi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBSJiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:38:51 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E89C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:38:10 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id j6so16831337ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onNaszrAn+0ylYxcaBf1rtku7X7XqTytT+iqTxrq/FA=;
        b=w8JEwm2SjgxmqafW9pzwZhqJbcq0iBxgumzPw5NdGbnPZKKI5/HT4lUXWjcjJmfqaW
         /BfLWEc1cXxIuor5SfkGB2/cMCNH03MW0AAJd6vPC1Dzbr8cMwtGiuagUAsbucPWZs7m
         IjQ7bTT8dVMNSa+aTKioNUPqqK6XC+CfgTU/oMUR+o4JxZbNB86dSNQMuhIf0OdMZBbQ
         jz4Jd/KTIVzkcQmts88oU4tR8jvHDFnsNxYS+fMUgJXgXk16LbtWa0xt9ZesXksDz/73
         yULOHjr6mksChQw5264AZtwKKbxPjVz8wEBYsxdAsScSQTtoe9HLYddhGoQexXTMKyTb
         Cg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onNaszrAn+0ylYxcaBf1rtku7X7XqTytT+iqTxrq/FA=;
        b=OmEp+GNbrkIREP3Cz4O1l2mEJzVI3QLPmi+zJ32YrF/hxM7ujDURDYwXM8KaK32Sbt
         rx3u7iZBv6QLlnFteQVqb/0c+JDZDyJbWuS/1XHzLyd0rWe5eOGwBHLcer60LfbdNfTB
         lfUF41oktsbLWId8RrcyRKLNC8iWhTpDdIPrsz8M19f2aGxF8zOdUBKUc4WhBG1lFqxQ
         o9NcTmqmkJtHwzcx92FHcnQ0jNscvh+/zja86N5SXuWkmK0mDfQcqRk6yciRtbyTCiol
         sqePxmCSm8jVKI/gFNyf21GXlktLeAFp0dBcJBYCFeX00o8cWjgMR1q5Pwdkj1CRHtiB
         XPbQ==
X-Gm-Message-State: AOAM531lhDgj/N39IiW9CaApjPCSMEfKJKY0L+rFK/lWzTZRglFUTBIi
        za6Gz5sH6sY/chiZ/fw7hHzmGKw50Wvjdydh6PhaFw==
X-Google-Smtp-Source: ABdhPJzcOAgJI7ez4SGABzEbaDoGWvnXT1zrarQpj03xFbF/XP7NNmLmLG9zOzBDjYN11XOu5RMbCapSi3UrMcwUuvE=
X-Received: by 2002:a2e:98da:: with SMTP id s26mr5002994ljj.343.1613727489001;
 Fri, 19 Feb 2021 01:38:09 -0800 (PST)
MIME-Version: 1.0
References: <1610712101-14929-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1610712101-14929-1-git-send-email-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 19 Feb 2021 15:07:57 +0530
Message-ID: <CAFA6WYOL3m6UspT1QG8_DAEFpGxtX=7aT_zTAdntmuUCcBvg5A@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: Enable perf events based hard lockup detector
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Mark,

On Fri, 15 Jan 2021 at 17:32, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> With the recent feature added to enable perf events to use pseudo NMIs
> as interrupts on platforms which support GICv3 or later, its now been
> possible to enable hard lockup detector (or NMI watchdog) on arm64
> platforms. So enable corresponding support.
>
> One thing to note here is that normally lockup detector is initialized
> just after the early initcalls but PMU on arm64 comes up much later as
> device_initcall(). So we need to re-initialize lockup detection once
> PMU has been initialized.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v5:
> - Fix lockup_detector_init() invocation to be rather invoked from CPU
>   binded context as it makes heavy use of per-cpu variables and shouldn't
>   be invoked from preemptible context.
>

Do you have any further comments on this?

Lecopzer,

Does this feature work fine for you now?

-Sumit

> Changes in v4:
> - Rebased to latest pmu v7 NMI patch-set [1] and in turn use "has_nmi"
>   hook to know if PMU IRQ has been requested as an NMI.
> - Add check for return value prior to initializing hard-lockup detector.
>
> [1] https://lkml.org/lkml/2020/9/24/458
>
> Changes in v3:
> - Rebased to latest pmu NMI patch-set [1].
> - Addressed misc. comments from Stephen.
>
> [1] https://lkml.org/lkml/2020/8/19/671
>
> Changes since RFC:
> - Rebased on top of Alex's WIP-pmu-nmi branch.
> - Add comment for safe max. CPU frequency.
> - Misc. cleanup.
>
>  arch/arm64/Kconfig             |  2 ++
>  arch/arm64/kernel/perf_event.c | 48 ++++++++++++++++++++++++++++++++++++++++--
>  drivers/perf/arm_pmu.c         |  5 +++++
>  include/linux/perf/arm_pmu.h   |  2 ++
>  4 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f39568b..05e1735 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -174,6 +174,8 @@ config ARM64
>         select HAVE_NMI
>         select HAVE_PATA_PLATFORM
>         select HAVE_PERF_EVENTS
> +       select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI && HW_PERF_EVENTS
> +       select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
>         select HAVE_PERF_REGS
>         select HAVE_PERF_USER_STACK_DUMP
>         select HAVE_REGS_AND_STACK_ACCESS_API
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 3605f77a..bafb7c8 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -23,6 +23,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/sched_clock.h>
>  #include <linux/smp.h>
> +#include <linux/nmi.h>
> +#include <linux/cpufreq.h>
>
>  /* ARMv8 Cortex-A53 specific event types. */
>  #define ARMV8_A53_PERFCTR_PREF_LINEFILL                                0xC2
> @@ -1246,12 +1248,30 @@ static struct platform_driver armv8_pmu_driver = {
>         .probe          = armv8_pmu_device_probe,
>  };
>
> +static int __init lockup_detector_init_fn(void *data)
> +{
> +       lockup_detector_init();
> +       return 0;
> +}
> +
>  static int __init armv8_pmu_driver_init(void)
>  {
> +       int ret;
> +
>         if (acpi_disabled)
> -               return platform_driver_register(&armv8_pmu_driver);
> +               ret = platform_driver_register(&armv8_pmu_driver);
>         else
> -               return arm_pmu_acpi_probe(armv8_pmuv3_init);
> +               ret = arm_pmu_acpi_probe(armv8_pmuv3_init);
> +
> +       /*
> +        * Try to re-initialize lockup detector after PMU init in
> +        * case PMU events are triggered via NMIs.
> +        */
> +       if (ret == 0 && arm_pmu_irq_is_nmi())
> +               smp_call_on_cpu(raw_smp_processor_id(), lockup_detector_init_fn,
> +                               NULL, false);
> +
> +       return ret;
>  }
>  device_initcall(armv8_pmu_driver_init)
>
> @@ -1309,3 +1329,27 @@ void arch_perf_update_userpage(struct perf_event *event,
>         userpg->cap_user_time_zero = 1;
>         userpg->cap_user_time_short = 1;
>  }
> +
> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> +/*
> + * Safe maximum CPU frequency in case a particular platform doesn't implement
> + * cpufreq driver. Although, architecture doesn't put any restrictions on
> + * maximum frequency but 5 GHz seems to be safe maximum given the available
> + * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
> + * hand, we can't make it much higher as it would lead to a large hard-lockup
> + * detection timeout on parts which are running slower (eg. 1GHz on
> + * Developerbox) and doesn't possess a cpufreq driver.
> + */
> +#define SAFE_MAX_CPU_FREQ      5000000000UL // 5 GHz
> +u64 hw_nmi_get_sample_period(int watchdog_thresh)
> +{
> +       unsigned int cpu = smp_processor_id();
> +       unsigned long max_cpu_freq;
> +
> +       max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
> +       if (!max_cpu_freq)
> +               max_cpu_freq = SAFE_MAX_CPU_FREQ;
> +
> +       return (u64)max_cpu_freq * watchdog_thresh;
> +}
> +#endif
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index cb2f55f..794a37d 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -726,6 +726,11 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
>         return per_cpu(hw_events->irq, cpu);
>  }
>
> +bool arm_pmu_irq_is_nmi(void)
> +{
> +       return has_nmi;
> +}
> +
>  /*
>   * PMU hardware loses all context when a CPU goes offline.
>   * When a CPU is hotplugged back in, since some hardware registers are
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 5054802..bf79667 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -163,6 +163,8 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
>  static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
>  #endif
>
> +bool arm_pmu_irq_is_nmi(void);
> +
>  /* Internal functions only for core arm_pmu code */
>  struct arm_pmu *armpmu_alloc(void);
>  struct arm_pmu *armpmu_alloc_atomic(void);
> --
> 2.7.4
>
