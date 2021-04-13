Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2335E674
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347840AbhDMSbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347681AbhDMSbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:31:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB0B613C1;
        Tue, 13 Apr 2021 18:31:22 +0000 (UTC)
Date:   Tue, 13 Apr 2021 14:31:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [PATCH v3 2/5] tracing: Add "last_func_repeats" to struct
 trace_array
Message-ID: <20210413143121.236db267@gandalf.local.home>
In-Reply-To: <20210409181031.26772-3-y.karadz@gmail.com>
References: <20210409181031.26772-1-y.karadz@gmail.com>
        <20210409181031.26772-3-y.karadz@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Apr 2021 21:10:28 +0300
"Yordan Karadzhov (VMware)" <y.karadz@gmail.com> wrote:

> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -262,6 +262,17 @@ struct cond_snapshot {
>  	cond_update_fn_t		update;
>  };
>  
> +/*
> + * struct trace_func_repeats - used to keep track of the consecutive
> + * (on the same CPU) calls of a single function.
> + */
> +struct trace_func_repeats {
> +	unsigned long	ip;
> +	unsigned long	parent_ip;
> +	unsigned long	count;
> +	u64		ts_last_call;
> +};
> +
>  /*
>   * The trace array - an array of per-CPU trace arrays. This is the
>   * highest level data structure that individual tracers deal with.
> @@ -358,8 +369,15 @@ struct trace_array {
>  #ifdef CONFIG_TRACER_SNAPSHOT
>  	struct cond_snapshot	*cond_snapshot;
>  #endif
> +	struct trace_func_repeats	__percpu *last_func_repeats;
>  };
>  
> +static inline struct trace_func_repeats __percpu *
> +tracer_alloc_func_repeats(struct trace_array *tr)
> +{
> +	return tr->last_func_repeats = alloc_percpu(struct trace_func_repeats);
> +}

Also, is there a reason this is in the header file? It's only used in one C
file, and should be a static function there.

-- Steve


> +
>  enum {
>  	TRACE_ARRAY_FL_GLOBAL	= (1 << 0)
>  };

