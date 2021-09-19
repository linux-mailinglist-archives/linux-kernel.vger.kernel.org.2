Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D03410C53
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhISQCw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Sep 2021 12:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhISQCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 12:02:51 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6FE6101B;
        Sun, 19 Sep 2021 16:01:26 +0000 (UTC)
Date:   Sun, 19 Sep 2021 12:01:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, bristot@redhat.com
Subject: Re: [PATCH] tracing: fix missing osnoise tracer on max_latency
Message-ID: <20210919120124.3e2b1b7b@rorschach.local.home>
In-Reply-To: <20210918051118.1096575-1-liu.yun@linux.dev>
References: <20210918051118.1096575-1-liu.yun@linux.dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 13:11:18 +0800
Jackie Liu <liu.yun@linux.dev> wrote:

> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> The compiler warns when the data are actually unused:
> 
>   kernel/trace/trace.c:1712:13: error: ‘trace_create_maxlat_file’ defined but not used [-Werror=unused-function]
>    1712 | static void trace_create_maxlat_file(struct trace_array *tr,
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> [Why]
> CONFIG_HWLAT_TRACER=n, CONFIG_TRACER_MAX_TRACE=n, CONFIG_OSNOISE_TRACER=y
> gcc report warns.
> 
> [How]
> Now trace_create_maxlat_file will only take effect when
> CONFIG_HWLAT_TRACER=y or CONFIG_TRACER_MAX_TRACE=y. In fact, after
> adding osnoise trace, it also needs to take effect.
> 
> BTW, Fixed the conflicting defined comment information.

Thanks for the report.

> 
> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  kernel/trace/trace.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7896d30d90f7..d7e3ed82fafd 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1744,11 +1744,7 @@ void latency_fsnotify(struct trace_array *tr)
>  	irq_work_queue(&tr->fsnotify_irqwork);
>  }
>  
> -/*
> - * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> - *  defined(CONFIG_FSNOTIFY)
> - */
> -#else
> +#else /* LATENCY_FS_NOTIFY */
>  
>  #define trace_create_maxlat_file(tr, d_tracer)				\
>  	trace_create_file("tracing_max_latency", 0644, d_tracer,	\

To clean this up even better, we should add here:

#elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
	|| defined(CONFIG_OSNOISE_TRACER)

#  define trace_create_maxlat_file(tr, d_tracer)			\
	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
			  &tr->max_latency, &tracing_max_lat_fops)

#else
# define trace_create_maxlat_file(tr, d_tracer)	 do { } while (0)
#endif

> @@ -9473,7 +9469,8 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  
>  	create_trace_options_dir(tr);
>  
> -#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
> +#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
> +	|| defined(CONFIG_OSNOISE_TRACER)

And remove the #if statement complete from inside the function.

-- Steve

>  	trace_create_maxlat_file(tr, d_tracer);
>  #endif
>  

