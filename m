Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B673455B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCWCtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCWCtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:49:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25D3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=j0bgVgpsB85/QI3pvBIfOUo7sA8BROzRX5nllPZYhLw=; b=j+iU8HvSWgbIg7rWnoE3jkHGQx
        8+jCYkMc0377Cexx3T4lY64kZ29mc0N6ulbQkfDaKQ/5Z1TIlOtQ8hsb6g4enMYvpMqpv2gwZnWiD
        OfqOmQLinCFqv+gtDZwsslh7cFJTRP1M8998qQc+s4rTiMHNZlS2z0aK4BZEs7uaJMtG+cLQ6RP8h
        Z0qTYc8edkz+6F+OF/dCqJ6Aj/7wBlLX5n9TvQTLeUD387t4D6p1l0XMtcZB45V4qLX4i1mCZ+HAT
        UYKooX5BM6DEkX42DPPhcr1dUc7dH4Mr91wNvAgIAtZWDualbloqmcJNKSyt2GnaZ2msHVYOut6N2
        jCeSgyOw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOX6I-009Qp5-De; Tue, 23 Mar 2021 02:49:02 +0000
Subject: Re: [PATCH] tracing: Fix various typos in comments
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210322224546.GA1981273@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e563a58-2ed6-3a1a-d92d-231fb6eecfa9@infradead.org>
Date:   Mon, 22 Mar 2021 19:48:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322224546.GA1981273@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

A few comments for you:

On 3/22/21 3:45 PM, Ingo Molnar wrote:
> 
> Fix ~59 single-word typos in the tracing code comments.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/microblaze/include/asm/ftrace.h |  2 +-
>  arch/nds32/kernel/ftrace.c           |  2 +-
>  arch/powerpc/include/asm/ftrace.h    |  4 ++--
>  arch/sh/kernel/ftrace.c              |  2 +-
>  arch/sparc/include/asm/ftrace.h      |  2 +-
>  fs/tracefs/inode.c                   |  2 +-
>  include/linux/ftrace.h               |  4 ++--
>  include/linux/trace_events.h         |  2 +-
>  include/linux/tracepoint.h           |  2 +-
>  include/trace/events/io_uring.h      |  2 +-
>  include/trace/events/rcu.h           |  2 +-
>  include/trace/events/sched.h         |  2 +-
>  include/trace/events/timer.h         |  2 +-
>  kernel/trace/bpf_trace.c             |  4 ++--
>  kernel/trace/fgraph.c                |  4 ++--
>  kernel/trace/ftrace.c                |  8 ++++----
>  kernel/trace/ring_buffer.c           |  2 +-
>  kernel/trace/synth_event_gen_test.c  |  2 +-
>  kernel/trace/trace.c                 | 18 +++++++++---------
>  kernel/trace/trace.h                 |  4 ++--
>  kernel/trace/trace_event_perf.c      |  2 +-
>  kernel/trace/trace_events.c          |  4 ++--
>  kernel/trace/trace_events_filter.c   |  4 ++--
>  kernel/trace/trace_events_synth.c    |  2 +-
>  kernel/trace/trace_functions_graph.c |  2 +-
>  kernel/trace/trace_hwlat.c           |  4 ++--
>  kernel/trace/trace_kprobe.c          |  2 +-
>  kernel/trace/trace_probe.c           |  6 +++---
>  kernel/trace/trace_probe.h           |  2 +-
>  kernel/trace/trace_probe_tmpl.h      |  2 +-
>  kernel/trace/trace_selftest.c        |  4 ++--
>  kernel/trace/trace_seq.c             | 12 ++++++------
>  32 files changed, 59 insertions(+), 59 deletions(-)
> 

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b0c45d923f0f..2214cba56e6f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

> @@ -748,7 +748,7 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
>  		fmt_cnt++;
>  	}
>  
> -	/* Maximumly we can have MAX_SEQ_PRINTF_VARARGS parameter, just give
> +	/* Maximum we can have MAX_SEQ_PRINTF_VARARGS parameter, just give

That's awkward either way IMO. How about:

	/* The maximum we can have is MAX_SEQ_PRINTF_VARARGS parameters, so just give

>  	 * all of them to seq_printf().
>  	 */
>  	seq_printf(m, fmt, params[0], params[1], params[2], params[3],
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 29a6ebeebc9e..dc0506314e2e 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -117,7 +117,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  
>  	/*
>  	 * Skip graph tracing if the return location is served by direct trampoline,
> -	 * since call sequence and return addresses is unpredicatable anymore.
> +	 * since call sequence and return addresses is unpredictable anymore.

	                                            are

>  	 * Ex: BPF trampoline may call original function and may skip frame
>  	 * depending on type of BPF programs attached.
>  	 */

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index eccb4e1187cc..b7738d21d840 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3367,7 +3367,7 @@ int trace_array_vprintk(struct trace_array *tr,
>   * buffer (use trace_printk() for that), as writing into the top level
>   * buffer should only have events that can be individually disabled.
>   * trace_printk() is only used for debugging a kernel, and should not
> - * be ever encorporated in normal use.
> + * be ever incorporated in normal use.

preferably
    * ever be

>   *
>   * trace_array_printk() can be used, as it will not add noise to the
>   * top level tracing buffer.

and at first I skipped over these, but I'll go back and mention them anyway:

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a6446c03cfbc..557ec9ce88c6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1343,7 +1343,7 @@ __event_trigger_test_discard(struct trace_event_file *file,
 
 /**
  * event_trigger_unlock_commit - handle triggers and finish event commit
- * @file: The file pointer assoctiated to the event
+ * @file: The file pointer associated to the event

                            associated with the event

  * @buffer: The ring buffer that the event is being written to
  * @event: The event meta data in the ring buffer
  * @entry: The event itself
@@ -1370,7 +1370,7 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 
 /**
  * event_trigger_unlock_commit_regs - handle triggers and finish event commit
- * @file: The file pointer assoctiated to the event
+ * @file: The file pointer associated to the event

                            associated with the event

  * @buffer: The ring buffer that the event is being written to
  * @event: The event meta data in the ring buffer
  * @entry: The event itself


thanks.
-- 
~Randy

