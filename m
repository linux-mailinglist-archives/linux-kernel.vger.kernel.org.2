Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F931A1C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhBLPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232081AbhBLPdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:33:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D3A64E70;
        Fri, 12 Feb 2021 15:33:12 +0000 (UTC)
Date:   Fri, 12 Feb 2021 10:33:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 3/3] tracing: Add ptr-hash option to show the hashed
 pointer value
Message-ID: <20210212103310.791c1f48@gandalf.local.home>
In-Reply-To: <160277372504.29307.14909828808982012211.stgit@devnote2>
References: <160277369795.29307.6792451054602907237.stgit@devnote2>
        <160277372504.29307.14909828808982012211.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Masami,

I noticed theses sitting in my patchwork and I said I was going to hold off
to the next merge window, and these got pushed down in my stack :-/


On Thu, 15 Oct 2020 23:55:25 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add tracefs/options/hash-ptr option to show hashed pointer
> value by %p in event printk format string.
> 
> For the security reason, normal printk will show the hashed
> pointer value (encrypted by random number) with %p to printk
> buffer to hide the real address. But the tracefs/trace always
> shows real address for debug. To bridge those outputs, add an
> option to switch the output format. Ftrace users can use it
> to find the hashed value corresponding to the real address
> in trace log.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Documentation/trace/ftrace.rst |    6 ++++++
>  kernel/trace/trace.c           |    3 +++
>  kernel/trace/trace.h           |    1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 87cf5c010d5d..62c98e9bbdd9 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -1159,6 +1159,12 @@ Here are the available options:
>  	This simulates the original behavior of the trace file.
>  	When the file is closed, tracing will be enabled again.
>  
> +  hash-ptr
> +        When set, "%p" in the event printk format displays the
> +        hashed pointer value instead of real address.
> +        This will be useful if you want to find out which hashed
> +        value is corresponding to the real value in trace log.
> +

I'm thinking of making this the default. I'll add a patch to make it
enabled by default "for security reasons", but still allow people to clear
it this value.

Are you OK with that?

-- Steve



>    record-cmd
>  	When any event or tracer is enabled, a hook is enabled
>  	in the sched_switch trace point to fill comm cache
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 75395293d8df..b88cccf224cd 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3543,6 +3543,9 @@ const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
>  	if (WARN_ON_ONCE(!fmt))
>  		return fmt;
>  
> +	if (iter->tr->trace_flags & TRACE_ITER_HASH_PTR)
> +		return fmt;
> +
>  	p = fmt;
>  	new_fmt = q = iter->fmt;
>  	while (*p) {
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 524502d1f60a..c34187bd22a9 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1347,6 +1347,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  		C(MARKERS,		"markers"),		\
>  		C(EVENT_FORK,		"event-fork"),		\
>  		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
> +		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
>  		FUNCTION_FLAGS					\
>  		FGRAPH_FLAGS					\
>  		STACK_FLAGS					\

