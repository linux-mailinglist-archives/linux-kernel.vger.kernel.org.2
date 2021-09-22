Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655DF413F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhIVCmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhIVCmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:42:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED2A61178;
        Wed, 22 Sep 2021 02:40:49 +0000 (UTC)
Date:   Tue, 21 Sep 2021 22:40:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, bristot@redhat.com
Subject: Re: [PATCH] tracing: fix missing osnoise tracer on max_latency
Message-ID: <20210921224048.4c5b414d@oasis.local.home>
In-Reply-To: <650206a9-500d-2dcf-69d1-946c470dac25@linux.dev>
References: <20210918051118.1096575-1-liu.yun@linux.dev>
        <20210919120124.3e2b1b7b@rorschach.local.home>
        <650206a9-500d-2dcf-69d1-946c470dac25@linux.dev>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 10:26:24 +0800
Jackie Liu <liu.yun@linux.dev> wrote:

> >> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> >> index 7896d30d90f7..d7e3ed82fafd 100644
> >> --- a/kernel/trace/trace.c
> >> +++ b/kernel/trace/trace.c
> >> @@ -1744,11 +1744,7 @@ void latency_fsnotify(struct trace_array *tr)
> >>   	irq_work_queue(&tr->fsnotify_irqwork);
> >>   }
> >>   
> >> -/*
> >> - * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> >> - *  defined(CONFIG_FSNOTIFY)
> >> - */
> >> -#else
> >> +#else /* LATENCY_FS_NOTIFY  >>
> >>   #define trace_create_maxlat_file(tr, d_tracer)				\
> >>   	trace_create_file("tracing_max_latency", 0644, d_tracer,	\  
> > 
> > To clean this up even better, we should add here:
> > 
> > #elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
> > 	|| defined(CONFIG_OSNOISE_TRACER)  
> 
> This place should need to use LATENCY_FS_NOTIFY, because not only these
> three Traces, we also need to pay attention to CONFIG_FSNOTIFY, at
> least, we should not change the original meaning.
> 
> How about this:
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7896d30d90f7..6a88d03c6d3b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1744,16 +1744,14 @@ void latency_fsnotify(struct trace_array *tr)
>          irq_work_queue(&tr->fsnotify_irqwork);
>   }
> 
> -/*
> - * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> - *  defined(CONFIG_FSNOTIFY)
> - */
> -#else
> +#elif defined(LATENCY_FS_NOTIFY)

Um, but isn't the #if before the #else:

  #ifdef LATENCY_FS_NOTIFY

?

Then, here we have:


#ifdef LATENCY_FS_NOTIFY

[..]

#elif defined(LATENCY_FS_NOTIFY)

// this will never be called.

That doesn't make any sense.

-- Steve

> 
>   #define trace_create_maxlat_file(tr, d_tracer)                         \
>          trace_create_file("tracing_max_latency", 0644, d_tracer,        \
>                            &tr->max_latency, &tracing_max_lat_fops)
> 
> +#else
> +#define trace_create_maxlat_file(tr, d_tracer)  do { } while (0)
>   #endif
> 
>   #ifdef CONFIG_TRACER_MAX_TRACE
> @@ -9473,9 +9471,7 @@ init_tracer_tracefs(struct trace_array *tr, struct 
> dentry *d_tracer)
> 
>          create_trace_options_dir(tr);
> 
> -#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>          trace_create_maxlat_file(tr, d_tracer);
> -#endif
> 
>          if (ftrace_create_function_files(tr, d_tracer))
>                  MEM_FAIL(1, "Could not allocate function filter files");
> 
> 
> ==
> What do you think? If there is no problem, I will send V2.
> 
