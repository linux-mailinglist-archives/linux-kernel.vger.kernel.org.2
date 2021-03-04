Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8332D7F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbhCDQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236490AbhCDQiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:38:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8535664F52;
        Thu,  4 Mar 2021 16:38:11 +0000 (UTC)
Date:   Thu, 4 Mar 2021 11:38:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [RFC PATCH 1/5] tracing: Define new ftrace event "func_repeats"
Message-ID: <20210304113809.5c2ccceb@gandalf.local.home>
In-Reply-To: <20210304090141.207309-2-y.karadz@gmail.com>
References: <20210304090141.207309-1-y.karadz@gmail.com>
        <20210304090141.207309-2-y.karadz@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Mar 2021 11:01:37 +0200
"Yordan Karadzhov (VMware)" <y.karadz@gmail.com> wrote:

Thanks Yordan for doing this!

I have some comments below.

> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index 4547ac59da61..8007f9b6417f 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -338,3 +338,19 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
>  		 __entry->nmi_total_ts,
>  		 __entry->nmi_count)
>  );
> +
> +FTRACE_ENTRY(func_repeats, func_repeats_entry,
> +
> +	TRACE_FUNC_REPEATS,
> +
> +	F_STRUCT(
> +		__field(	unsigned long,	ip	)
> +		__field(	unsigned long,	pip	)
> +		__field(	unsigned long,	count	)
> +	),
> +
> +	F_printk(" %ps <-%ps\t(repeats:%lu)",
> +		 (void *)__entry->ip,
> +		 (void *)__entry->pip,
> +		 __entry->count)

After playing with this a little, I realized that we should also store the
last timestamp as well. I think that would be interesting information.

           <...>-37      [004] ...1  2022.303820: gc_worker <-process_one_work
           <...>-37      [004] ...1  2022.303820: ___might_sleep <-gc_worker
           <...>-37      [004] ...1  2022.303831: ___might_sleep <-gc_worker (repeats: 127)
           <...>-37      [004] ...1  2022.303831: queue_delayed_work_on <-process_one_work

The above shows that __might_sleep() was called 128 times, but what I don't
get from the above, is when that last call was made. You'll see that the
timestamp for the repeat output is the same as the next function shown
(queue_delayed_work_on()). But the timestamp for the last call to
__might_sleep() is lost, and the repeat event ends up being written when
it is detected that there are no more repeats.

If we had:

           <...>-37      [004] ...1  2022.303820: gc_worker <-process_one_work
           <...>-37      [004] ...1  2022.303820: ___might_sleep <-gc_worker
           <...>-37      [004] ...1  2022.303831: ___might_sleep <-gc_worker (last ts: 2022.303828 repeats: 127)
           <...>-37      [004] ...1  2022.303831: queue_delayed_work_on <-process_one_work

We would know the last time __might_sleep was called.

That is, not only should we save the ip and pip in the trace_func_repeats
structure, but we should also be storing the last time stamp of the last
function event that repeated. Otherwise the above looks like the last
__might_sleep called above happened when the queue_delayed_work_on
happened, where that may not be the case.

-- Steve


