Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B113F421F38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJEHFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:05:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45058 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEHFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:05:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0571D1FE37;
        Tue,  5 Oct 2021 07:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633417401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJzanskWVV3j7+XNGt4NLM5ATeulaEMUdbY78QfwQk8=;
        b=ar2P+TAzqqXOqAYxlhmM4uGh7nC/AD/G42oeMi1XBuJHP7RXIeVOaKe3AjX/kuQ5yCZsLq
        ecUvVYwv+5gA4fMCpfVY3lxCuVZZykjc4wt+NhAXtwX7MAoul7QZam4r/w53pZjghwVz4N
        xw9H6HcWyTzG0L2uek/C66v27fCvvKs=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A611EA3B84;
        Tue,  5 Oct 2021 07:03:20 +0000 (UTC)
Date:   Tue, 5 Oct 2021 09:03:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 3/4] kernel/watchdog: adapt the watchdog_hld interface
 for async model
Message-ID: <YVv4tT3WXrKvPe0g@alley>
References: <20210923140951.35902-1-kernelfans@gmail.com>
 <20210923140951.35902-4-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923140951.35902-4-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-09-23 22:09:50, Pingfan Liu wrote:
> When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> yet. E.g. on arm64, PMU is not ready until
> device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> with the driver model and cpuhp. Hence it is hard to push this
> initialization before smp_init().
> 
> But it is easy to take an opposite approach by enabling watchdog_hld to
> get the capability of PMU async.
> 
> The async model is achieved by expanding watchdog_nmi_probe() with
> -EBUSY, and a re-initializing work_struct which waits on a wait_queue_head.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
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
> Cc: linux-arm-kernel@lists.infradead.org
> To: linux-kernel@vger.kernel.org
> ---
>  include/linux/nmi.h |  3 +++
>  kernel/watchdog.c   | 37 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index b7bcd63c36b4..270d440fe4b7 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -118,6 +118,9 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
>  
>  void watchdog_nmi_stop(void);
>  void watchdog_nmi_start(void);
> +
> +extern bool hld_detector_delay_initialized;
> +extern struct wait_queue_head hld_detector_wait;
>  int watchdog_nmi_probe(void);
>  void watchdog_nmi_enable(unsigned int cpu);
>  void watchdog_nmi_disable(unsigned int cpu);
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 6e6dd5f0bc3e..bd4ae1839b72 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -103,7 +103,10 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
>  	hardlockup_detector_perf_disable();
>  }
>  
> -/* Return 0, if a NMI watchdog is available. Error code otherwise */
> +/*
> + * Return 0, if a NMI watchdog is available. -EBUSY if not ready.
> + * Other negative value if not support.
> + */
>  int __weak __init watchdog_nmi_probe(void)
>  {
>  	return hardlockup_detector_perf_init();
> @@ -739,15 +742,45 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
>  }
>  #endif /* CONFIG_SYSCTL */
>  
> +static void lockup_detector_delay_init(struct work_struct *work);
> +bool hld_detector_delay_initialized __initdata;
> +
> +struct wait_queue_head hld_detector_wait __initdata =
> +		__WAIT_QUEUE_HEAD_INITIALIZER(hld_detector_wait);
> +
> +static struct work_struct detector_work __initdata =
> +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> +
> +static void __init lockup_detector_delay_init(struct work_struct *work)
> +{
> +	int ret;
> +
> +	wait_event(hld_detector_wait, hld_detector_delay_initialized);
> +	ret = watchdog_nmi_probe();
> +	if (!ret) {
> +		nmi_watchdog_available = true;
> +		lockup_detector_setup();

Is it really safe to call the entire lockup_detector_setup()
later?

It manipulates also softlockup detector. And more importantly,
the original call is before smp_init(). It means that it was
running when only single CPU was on.

It seems that x86 has some problem with hardlockup detector as
well. It later manipulates only the hardlockup detector. Also it uses
cpus_read_lock() to prevent races with CPU hotplug, see
fixup_ht_bug().


> +	} else {
> +		WARN_ON(ret == -EBUSY);
> +		pr_info("Perf NMI watchdog permanently disabled\n");
> +	}
> +}
> +
>  void __init lockup_detector_init(void)
>  {
> +	int ret;
> +
>  	if (tick_nohz_full_enabled())
>  		pr_info("Disabling watchdog on nohz_full cores by default\n");
>  
>  	cpumask_copy(&watchdog_cpumask,
>  		     housekeeping_cpumask(HK_FLAG_TIMER));
>  
> -	if (!watchdog_nmi_probe())
> +	ret = watchdog_nmi_probe();
> +	if (!ret)
>  		nmi_watchdog_available = true;
> +	else if (ret == -EBUSY)
> +		queue_work_on(smp_processor_id(), system_wq, &detector_work);

IMHO, this is not acceptable. It will block one worker until someone
wakes it. Only arm64 will have a code to wake up the work and only
when pmu is successfully initialized. In all other cases, the worker
will stay blocked forever.

The right solution is to do it the other way. Queue the work
from arm64-specific code when armv8_pmu_driver_init() succeeded.

Also I suggest to flush the work to make sure that it is finished
before __init code gets removed.


The open question is what code the work will call. As mentioned
above, I am not sure that lockup_detector_delay_init() is safe.
IMHO, we need to manipulate only hardlockup detector and
we have to serialize it against CPU hotplug.

Best Regards,
Petr
