Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E81416104
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbhIWObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbhIWObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:31:15 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4DAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:29:44 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d11so6810071ilc.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mvJsVwupgDCXw685Zjl4MSMOOQvCiNNAE28W4A4rDw=;
        b=BPinD2cnlRVIh8ZnKnESCW9Mu+lchBRyRjai+VlYGGy92pxYTAJx1o/YyQforWfwgR
         q8BkfLvwLGTYyi6tI9Wb6esUDTPuHmz80ELCPuaSXmv2tUbl10nu1jdHvBn/kshZdbho
         XfWkB9VXdR24oNwW2LFHX/XPdhnTdi6kvP2YS1fRZXMY3+3WdHW6U637QwxOYC/IkoXS
         ke9y/+m5uH+t4bNHm2vfocp5r9xllgs3L1i0ql+obydutYNAi/sgQfKWQCHhscC+caAf
         RsnauL0hGLr97RjXt7flVsobRK84wEDsI7f4ARcSx6sczeqp4kEXItKNvB2YNEK7nQcg
         jaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mvJsVwupgDCXw685Zjl4MSMOOQvCiNNAE28W4A4rDw=;
        b=TsV6LROgeItFSoYl2biZyR7RuwzMdVkbcuS0giMRNZQ8VZvuPC3Grj8EYYtCBMyBym
         vU5oOz88vipuO8gIGiD9ohqbai2qaBAZ0JbFdqXIrKLxToDNsVk6zj9KbOHkO7SMp9EK
         q6hozgt9bw+KpT9296OwAJZ4ZCYh95kosKg4DfjdJValdzvI4eNATfAMV2nfwmXoOaFb
         dWnqfHyEWMNL0iJUMdTVfCMcmtowENWR0He2VHAagxlGG+HrIOU8fQFZrdb6YiRF9eeH
         Evw6BWULRc+mwJKNSAUMEnpRfBDANmmDGtoLw1riMw66DKN1g/4ocw3x799aTOBpyOSA
         bKDA==
X-Gm-Message-State: AOAM530S5bcnMZuR2MO3VCl+wiOvOxpUyq2doKrEIbLHpe1UBCQQG+A4
        l9ZLQhuyUej/XlgvFMZJHTyz1Mq9MBDVAJ0cdr82rZc=
X-Google-Smtp-Source: ABdhPJx5g/P7WznzL0yHwepOYxexsc2HOYLen225vJhco5wKGV4dhezvMKfv4DcCBUFJDMZjdr4EWCh9LzHfqvJeYI8=
X-Received: by 2002:a05:6e02:1bed:: with SMTP id y13mr3821949ilv.249.1632407383095;
 Thu, 23 Sep 2021 07:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210923140951.35902-1-kernelfans@gmail.com> <20210923140951.35902-5-kernelfans@gmail.com>
In-Reply-To: <20210923140951.35902-5-kernelfans@gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 23 Sep 2021 22:29:31 +0800
Message-ID: <CAFgQCTsvrGSzxZKFOiE+yqLdFZTnXkh72G0pVbp2q_sEW_pjEQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] arm64: Enable perf events based hard lockup detector
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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

On Thu, Sep 23, 2021 at 10:10 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> From: Sumit Garg <sumit.garg@linaro.org>
>
To Sumit, I think credits should go to you and keep you as the author.

Please let me know if you dislike it.

Thanks,

Pingfan
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
> [1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> (Pingfan: adapt it to watchdog_hld async model based on [1])
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Wang Qing <wangqing@vivo.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Santosh Sivaraj <santosh@fossix.org>
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/Kconfig               |  2 ++
>  arch/arm64/kernel/Makefile       |  1 +
>  arch/arm64/kernel/perf_event.c   | 11 ++++++++--
>  arch/arm64/kernel/watchdog_hld.c | 36 ++++++++++++++++++++++++++++++++
>  drivers/perf/arm_pmu.c           |  5 +++++
>  include/linux/perf/arm_pmu.h     |  2 ++
>  6 files changed, 55 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/kernel/watchdog_hld.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5c7ae4c3954b..8287e9e1d28d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -189,6 +189,8 @@ config ARM64
>         select HAVE_NMI
>         select HAVE_PATA_PLATFORM
>         select HAVE_PERF_EVENTS
> +       select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
> +       select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
>         select HAVE_PERF_REGS
>         select HAVE_PERF_USER_STACK_DUMP
>         select HAVE_REGS_AND_STACK_ACCESS_API
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 3f1490bfb938..789c2fe5bb90 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_MODULES)                 += module.o
>  obj-$(CONFIG_ARM64_MODULE_PLTS)                += module-plts.o
>  obj-$(CONFIG_PERF_EVENTS)              += perf_regs.o perf_callchain.o
>  obj-$(CONFIG_HW_PERF_EVENTS)           += perf_event.o
> +obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)       += hw_breakpoint.o
>  obj-$(CONFIG_CPU_PM)                   += sleep.o suspend.o
>  obj-$(CONFIG_CPU_IDLE)                 += cpuidle.o
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index b4044469527e..a34343d0f418 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -23,6 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sched_clock.h>
>  #include <linux/smp.h>
> +#include <linux/nmi.h>
>
>  /* ARMv8 Cortex-A53 specific event types. */
>  #define ARMV8_A53_PERFCTR_PREF_LINEFILL                                0xC2
> @@ -1284,10 +1285,16 @@ static struct platform_driver armv8_pmu_driver = {
>
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
> +       hld_detector_delay_initialized = true;
> +       wake_up(&hld_detector_wait);
> +       return ret;
>  }
>  device_initcall(armv8_pmu_driver_init)
>
> diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
> new file mode 100644
> index 000000000000..379743e0d001
> --- /dev/null
> +++ b/arch/arm64/kernel/watchdog_hld.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/nmi.h>
> +#include <linux/cpufreq.h>
> +#include <linux/perf/arm_pmu.h>
> +
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
> +
> +int __init watchdog_nmi_probe(void)
> +{
> +       if (!hld_detector_delay_initialized)
> +               return -EBUSY;
> +       else if (!arm_pmu_irq_is_nmi())
> +               return -ENODEV;
> +
> +       return hardlockup_detector_perf_init();
> +}
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 3cbc3baf087f..2aecb0c34290 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -697,6 +697,11 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
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
> index 505480217cf1..bf7966776c55 100644
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
> 2.31.1
>
