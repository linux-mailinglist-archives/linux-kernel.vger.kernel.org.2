Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB0C40FB68
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhIQPMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233325AbhIQPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631891485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZ8dkSCptA0z39PCYyh0C/dLiTp7lzy6Z+ojRYvJsr4=;
        b=GU7pkysqYO7NrwASLphLGzlGfY3OPg6CTI85yfaFYxA+AWBEYxIhUrLBbnF7H1y8SDnT93
        ZgsLOxIGU4CF4qELRgTEu3x4OuTW+VmEpONvUScUYPfqb2Bg3uv1VGhjuY83WgiAvH9uRy
        VTP0zsFbdxp8VH4nVDSKMgiTxHUXLPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-X8SP87lrMf-DxCqZz4_gEA-1; Fri, 17 Sep 2021 11:11:24 -0400
X-MC-Unique: X8SP87lrMf-DxCqZz4_gEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7716C835DEC;
        Fri, 17 Sep 2021 15:11:22 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C79895C1A1;
        Fri, 17 Sep 2021 15:11:15 +0000 (UTC)
Date:   Fri, 17 Sep 2021 23:11:09 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64/watchdog_hld: enable hard lockup on arm64
 platform
Message-ID: <YUSwDbKelqkj7Yyp@piliu.users.ipa.redhat.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-6-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915035103.15586-6-kernelfans@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:51:03AM +0800, Pingfan Liu wrote:

+ Petr Mladek

> With watchdog_hld armed with the async model, arm64 can probe and enable
> perf NMI after smp_init(). At the boot stage, all of cpus arm hard
> lockup detector in the async model.
> 
> In this patch, the function hw_nmi_get_sample_period() is borrowed from
> [1], credit goes to Sumit.
> 
> [1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Julien Thierry <jthierry@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm64/Kconfig                  |  3 ++
>  arch/arm64/include/asm/perf_event.h |  5 ++
>  arch/arm64/kernel/Makefile          |  1 +
>  arch/arm64/kernel/perf_event.c      | 14 ++++-
>  arch/arm64/kernel/watchdog_hld.c    | 83 +++++++++++++++++++++++++++++
>  drivers/perf/arm_pmu.c              |  5 ++
>  6 files changed, 109 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/kernel/watchdog_hld.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 62c3c1d2190f..0f49e58a9dd8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -193,6 +193,9 @@ config ARM64
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_PERF_EVENTS_NMI
> +	select HAVE_HARDLOCKUP_DETECTOR_PERF \
> +		if PERF_EVENTS && HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_FUNCTION_ARG_ACCESS_API
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index 4ef6f19331f9..712a75f432f0 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -6,6 +6,7 @@
>  #ifndef __ASM_PERF_EVENT_H
>  #define __ASM_PERF_EVENT_H
>  
> +#include <linux/wait.h>
>  #include <asm/stack_pointer.h>
>  #include <asm/ptrace.h>
>  
> @@ -259,4 +260,8 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>  	(regs)->pstate = PSR_MODE_EL1h;	\
>  }
>  
> +extern bool arm_pmu_initialized;
> +extern wait_queue_head_t arm_pmu_wait;
> +extern bool check_pmu_nmi_ability(void);
> +
>  #endif
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 3f1490bfb938..789c2fe5bb90 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_MODULES)			+= module.o
>  obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
>  obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
>  obj-$(CONFIG_HW_PERF_EVENTS)		+= perf_event.o
> +obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF)	+= watchdog_hld.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
>  obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
>  obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index d07788dad388..c4144cea0d55 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -24,6 +24,9 @@
>  #include <linux/sched_clock.h>
>  #include <linux/smp.h>
>  
> +bool arm_pmu_initialized;
> +DECLARE_WAIT_QUEUE_HEAD(arm_pmu_wait);
> +
>  /* ARMv8 Cortex-A53 specific event types. */
>  #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
>  
> @@ -1284,10 +1287,17 @@ static struct platform_driver armv8_pmu_driver = {
>  
>  static int __init armv8_pmu_driver_init(void)
>  {
> +	int ret;
> +
>  	if (acpi_disabled)
> -		return platform_driver_register(&armv8_pmu_driver);
> +		ret = platform_driver_register(&armv8_pmu_driver);
>  	else
> -		return arm_pmu_acpi_probe(armv8_pmuv3_init);
> +		ret = arm_pmu_acpi_probe(armv8_pmuv3_init);
> +
> +	arm_pmu_initialized = true;
> +	wake_up_all(&arm_pmu_wait);
> +
> +	return ret;
>  }
>  device_initcall(armv8_pmu_driver_init)
>  
> diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
> new file mode 100644
> index 000000000000..18bfa62f1058
> --- /dev/null
> +++ b/arch/arm64/kernel/watchdog_hld.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kthread.h>
> +#include <linux/sched.h>
> +#include <linux/nmi.h>
> +#include <linux/cpufreq.h>
> +#include <asm/perf_event.h>
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
> +#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
> +u64 hw_nmi_get_sample_period(int watchdog_thresh)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	unsigned long max_cpu_freq;
> +
> +	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
> +	if (!max_cpu_freq)
> +		max_cpu_freq = SAFE_MAX_CPU_FREQ;
> +
> +	return (u64)max_cpu_freq * watchdog_thresh;
> +}
> +
> +static watchdog_nmi_status_reporter status_reporter;
> +
> +static int hld_enabled_thread_fun(void *unused)
> +{
> +	struct watchdog_nmi_status status;
> +	watchdog_nmi_status_reporter local_reporter;
> +	int ret;
> +
> +	wait_event(arm_pmu_wait, arm_pmu_initialized);
> +	status.cpu = raw_smp_processor_id();
> +
> +	if (!check_pmu_nmi_ability()) {
> +		status.status = -ENODEV;
> +		goto report;
> +	}
> +
> +	ret = hardlockup_detector_perf_enable();
> +	status.status = ret;
> +
> +report:
> +	local_reporter = (watchdog_nmi_status_reporter)atomic64_fetch_and(0,
> +				(atomic64_t *)&status_reporter);
> +	if (local_reporter)
> +		(*local_reporter)(&status);
> +
> +	return 0;
> +}
> +
> +/* As for watchdog_nmi_disable(), using the default implement */
> +void watchdog_nmi_enable(unsigned int cpu)
> +{
> +	struct task_struct *t;
> +
> +	/* PMU is not ready */
> +	if (!arm_pmu_initialized) {
> +		t = kthread_create_on_cpu(hld_enabled_thread_fun, NULL, cpu,
> +			       "arm64_hld.%u");
> +		if (IS_ERR(t))
> +			return;
> +		wake_up_process(t);
> +		return;
> +	}
> +
> +	/* For hotplug in cpu */
> +	hardlockup_detector_perf_enable();
> +}
> +
> +int __init watchdog_nmi_probe(watchdog_nmi_status_reporter notifier)
> +{
> +	/* On arm64, arm pmu is not ready at this stage */
> +	status_reporter = notifier;
> +	return -EBUSY;
> +}
> +
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 3cbc3baf087f..e08961b37922 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -105,6 +105,11 @@ static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
>  
>  static bool has_nmi;
>  
> +bool check_pmu_nmi_ability(void)
> +{
> +	return has_nmi;
> +}
> +
>  static inline u64 arm_pmu_event_max_period(struct perf_event *event)
>  {
>  	if (event->hw.flags & ARMPMU_EVT_64BIT)
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

