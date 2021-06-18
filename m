Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C63AD0A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhFRQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231977AbhFRQrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:47:17 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9ED610C7;
        Fri, 18 Jun 2021 16:45:06 +0000 (UTC)
Date:   Fri, 18 Jun 2021 12:45:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 05/12] trace/hwlat: Support hotplug operations
Message-ID: <20210618124503.388fe4d4@oasis.local.home>
In-Reply-To: <8899f8a8bec38bc600f7a2c61bc6ca664aa7beeb.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
        <8899f8a8bec38bc600f7a2c61bc6ca664aa7beeb.1623746916.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 11:28:44 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> Enable and disable hwlat thread during cpu hotplug online
> and offline operations, respectivelly.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
> Cc: Clark Willaims <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>  kernel/trace/trace.c       |  6 ++++++
>  kernel/trace/trace_hwlat.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 9299057feb56..c094865e2f71 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5064,7 +5064,13 @@ int tracing_set_cpumask(struct trace_array *tr,
>  	arch_spin_unlock(&tr->max_lock);
>  	local_irq_enable();
>  
> +	/*
> +	 * tracing_cpumask is read by tracers that support CPU
> +	 * hotplug.
> +	 */
> +	get_online_cpus();
>  	cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
> +	put_online_cpus();
>  
>  	return 0;
>  }
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 6c6918e86087..9fcfd588c4f6 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -490,6 +490,35 @@ static int start_cpu_kthread(unsigned int cpu)
>  	return 0;
>  }
>  
> +/*
> + * hwlat_cpu_init - CPU hotplug online callback function
> + */
> +static int hwlat_cpu_init(unsigned int cpu)
> +{
> +	struct trace_array *tr = hwlat_trace;
> +

You need to take the trace_types_lock here, between testing the
hwlat_busy and starting the threads. Otherwise, between the two, the
hwlat tracer could be turned off while a CPU is coming on line, and
then you just started a per cpu thread, while the hwlat tracer is not
enabled.

> +	if (!hwlat_busy)
> +		return 0;
> +
> +	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
> +		return 0;
> +
> +	return start_cpu_kthread(cpu);
> +}
> +
> +/*
> + * hwlat_cpu_die - CPU hotplug offline callback function
> + */
> +static int hwlat_cpu_die(unsigned int cpu)
> +{

Same here.

-- Steve


> +	if (!hwlat_busy)
> +		return 0;
> +
> +	stop_cpu_kthread(cpu);
> +
> +	return 0;
> +}
> +
>  /*
>   * start_per_cpu_kthreads - Kick off the hardware latency sampling/detector kthreads
>   *
> @@ -903,6 +932,11 @@ __init static int init_hwlat_tracer(void)
>  	if (ret)
>  		return ret;
>  
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "trace/hwlat:online",
> +				hwlat_cpu_init, hwlat_cpu_die);
> +	if (ret < 0)
> +		pr_warn(BANNER "Error to init cpu hotplug support\n");
> +
>  	init_tracefs();
>  
>  	return 0;

