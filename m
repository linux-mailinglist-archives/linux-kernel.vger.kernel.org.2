Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20ED3ED970
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhHPPE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhHPPEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:04:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCACB61038;
        Mon, 16 Aug 2021 15:04:22 +0000 (UTC)
Date:   Mon, 16 Aug 2021 11:04:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [GIT PULL v2] tracing: Fixes and clean ups for v5.14
Message-ID: <20210816110416.6fb6d54d@oasis.local.home>
In-Reply-To: <20210812141636.35e41575@oasis.local.home>
References: <20210812141636.35e41575@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Did this one fall though the cracks?

It's the same pull request but without the "main" variable change.

-- Steve


On Thu, 12 Aug 2021 14:16:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Linus,
> 
> [
>   Note. This version was only tested with one config and it passed the
>   ftracetests in the selftests directory. I didn't run my full test
>   suite as that takes forever to run, and the only thing that's
>   different from the version that went through that test suite is that
>   I dropped the "main" variable "fix" patch.
> ]
> 
> Fixes and clean ups to tracing:
> 
> - Fix header alignment when PREEMPT_RT is enabled for osnoise tracer
> 
> - Inject "stop" event to see where osnoise stopped the trace
> 
> - Define DYNAMIC_FTRACE_WITH_ARGS as some code had an #ifdef for it
> 
> - Fix erroneous message for bootconfig cmdline parameter
> 
> - Fix crash caused by not found variable in histograms
> 
> 
> Please pull the latest trace-v5.14-rc5-2 tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> trace-v5.14-rc5-2
> 
> Tag SHA1: 26ba5d9bdfa88208677132efa9e64b488420b461
> Head SHA1: 5acce0bff2a0420ce87d4591daeb867f47d552c2
> 
> 
> Daniel Bristot de Oliveira (3):
>       trace/osnoise: Add a header with PREEMPT_RT additional fields
>       trace/timerlat: Add a header with PREEMPT_RT additional fields
>       trace/osnoise: Print a stop tracing message
> 
> Lukas Bulwahn (1):
>       tracing: define needed config DYNAMIC_FTRACE_WITH_ARGS
> 
> Masami Hiramatsu (1):
>       init: Suppress wrong warning for bootconfig cmdline parameter
> 
> Steven Rostedt (VMware) (1):
>       tracing / histogram: Fix NULL pointer dereference on strcmp() on NULL event name
> 
> ----
>  init/main.c                      |  9 +++++--
>  kernel/trace/Kconfig             |  5 ++++
>  kernel/trace/trace_events_hist.c |  2 ++
>  kernel/trace/trace_osnoise.c     | 56 +++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 69 insertions(+), 3 deletions(-)
> ---------------------------
> diff --git a/init/main.c b/init/main.c
> index f5b8246e8aa1..8d97aba78c3a 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -397,6 +397,12 @@ static int __init bootconfig_params(char *param, char *val,
>  	return 0;
>  }
>  
> +static int __init warn_bootconfig(char *str)
> +{
> +	/* The 'bootconfig' has been handled by bootconfig_params(). */
> +	return 0;
> +}
> +
>  static void __init setup_boot_config(void)
>  {
>  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> @@ -475,9 +481,8 @@ static int __init warn_bootconfig(char *str)
>  	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
>  	return 0;
>  }
> -early_param("bootconfig", warn_bootconfig);
> -
>  #endif
> +early_param("bootconfig", warn_bootconfig);
>  
>  /* Change NUL term back to "=", to make "param" the whole string. */
>  static void __init repair_env_string(char *param, char *val)
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d567b1717c4c..3ee23f4d437f 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -219,6 +219,11 @@ config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	depends on DYNAMIC_FTRACE_WITH_REGS
>  	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  
> +config DYNAMIC_FTRACE_WITH_ARGS
> +	def_bool y
> +	depends on DYNAMIC_FTRACE
> +	depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +
>  config FUNCTION_PROFILER
>  	bool "Kernel function profiler"
>  	depends on FUNCTION_TRACER
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 949ef09dc537..a48aa2a2875b 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3430,6 +3430,8 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
>  			event = data->match_data.event;
>  		}
>  
> +		if (!event)
> +			goto free;
>  		/*
>  		 * At this point, we're looking at a field on another
>  		 * event.  Because we can't modify a hist trigger on
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index a7e3c24dee13..b61eefe5ccf5 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -253,10 +253,40 @@ static struct osnoise_data {
>   */
>  static bool osnoise_busy;
>  
> +#ifdef CONFIG_PREEMPT_RT
>  /*
>   * Print the osnoise header info.
>   */
>  static void print_osnoise_headers(struct seq_file *s)
> +{
> +	if (osnoise_data.tainted)
> +		seq_puts(s, "# osnoise is tainted!\n");
> +
> +	seq_puts(s, "#                                _-------=> irqs-off\n");
> +	seq_puts(s, "#                               / _------=> need-resched\n");
> +	seq_puts(s, "#                              | / _-----=> need-resched-lazy\n");
> +	seq_puts(s, "#                              || / _----=> hardirq/softirq\n");
> +	seq_puts(s, "#                              ||| / _---=> preempt-depth\n");
> +	seq_puts(s, "#                              |||| / _--=> preempt-lazy-depth\n");
> +	seq_puts(s, "#                              ||||| / _-=> migrate-disable\n");
> +
> +	seq_puts(s, "#                              |||||| /          ");
> +	seq_puts(s, "                                     MAX\n");
> +
> +	seq_puts(s, "#                              ||||| /                         ");
> +	seq_puts(s, "                    SINGLE      Interference counters:\n");
> +
> +	seq_puts(s, "#                              |||||||               RUNTIME   ");
> +	seq_puts(s, "   NOISE  %% OF CPU  NOISE    +-----------------------------+\n");
> +
> +	seq_puts(s, "#           TASK-PID      CPU# |||||||   TIMESTAMP    IN US    ");
> +	seq_puts(s, "   IN US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD\n");
> +
> +	seq_puts(s, "#              | |         |   |||||||      |           |      ");
> +	seq_puts(s, "       |    |            |      |      |      |      |      |\n");
> +}
> +#else /* CONFIG_PREEMPT_RT */
> +static void print_osnoise_headers(struct seq_file *s)
>  {
>  	if (osnoise_data.tainted)
>  		seq_puts(s, "# osnoise is tainted!\n");
> @@ -279,6 +309,7 @@ static void print_osnoise_headers(struct seq_file *s)
>  	seq_puts(s, "#              | |         |   ||||      |           |      ");
>  	seq_puts(s, "       |    |            |      |      |      |      |      |\n");
>  }
> +#endif /* CONFIG_PREEMPT_RT */
>  
>  /*
>   * osnoise_taint - report an osnoise error.
> @@ -323,6 +354,24 @@ static void trace_osnoise_sample(struct osnoise_sample *sample)
>  /*
>   * Print the timerlat header info.
>   */
> +#ifdef CONFIG_PREEMPT_RT
> +static void print_timerlat_headers(struct seq_file *s)
> +{
> +	seq_puts(s, "#                                _-------=> irqs-off\n");
> +	seq_puts(s, "#                               / _------=> need-resched\n");
> +	seq_puts(s, "#                              | / _-----=> need-resched-lazy\n");
> +	seq_puts(s, "#                              || / _----=> hardirq/softirq\n");
> +	seq_puts(s, "#                              ||| / _---=> preempt-depth\n");
> +	seq_puts(s, "#                              |||| / _--=> preempt-lazy-depth\n");
> +	seq_puts(s, "#                              ||||| / _-=> migrate-disable\n");
> +	seq_puts(s, "#                              |||||| /\n");
> +	seq_puts(s, "#                              |||||||             ACTIVATION\n");
> +	seq_puts(s, "#           TASK-PID      CPU# |||||||   TIMESTAMP    ID     ");
> +	seq_puts(s, "       CONTEXT                LATENCY\n");
> +	seq_puts(s, "#              | |         |   |||||||      |         |      ");
> +	seq_puts(s, "            |                       |\n");
> +}
> +#else /* CONFIG_PREEMPT_RT */
>  static void print_timerlat_headers(struct seq_file *s)
>  {
>  	seq_puts(s, "#                                _-----=> irqs-off\n");
> @@ -336,6 +385,7 @@ static void print_timerlat_headers(struct seq_file *s)
>  	seq_puts(s, "#              | |         |   ||||      |         |      ");
>  	seq_puts(s, "            |                       |\n");
>  }
> +#endif /* CONFIG_PREEMPT_RT */
>  
>  /*
>   * Record an timerlat_sample into the tracer buffer.
> @@ -1025,9 +1075,13 @@ diff_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *
>  /*
>   * osnoise_stop_tracing - Stop tracing and the tracer.
>   */
> -static void osnoise_stop_tracing(void)
> +static __always_inline void osnoise_stop_tracing(void)
>  {
>  	struct trace_array *tr = osnoise_trace;
> +
> +	trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
> +			"stop tracing hit on cpu %d\n", smp_processor_id());
> +
>  	tracer_tracing_off(tr);
>  }
>  

