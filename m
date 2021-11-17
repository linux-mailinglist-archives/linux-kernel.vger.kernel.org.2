Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC88455136
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbhKQXli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233586AbhKQXl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:41:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39FE61465;
        Wed, 17 Nov 2021 23:38:29 +0000 (UTC)
Date:   Wed, 17 Nov 2021 18:38:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@openvz.org
Subject: Re: [PATCH] tracing: fix va_list breakage in trace_check_vprintf()
Message-ID: <20211117183827.4989cfab@gandalf.local.home>
In-Reply-To: <20211117183720.15573-1-nikita.yushchenko@virtuozzo.com>
References: <20211117183720.15573-1-nikita.yushchenko@virtuozzo.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 21:37:20 +0300
Nikita Yushchenko <nikita.yushchenko@virtuozzo.com> wrote:

> When trace_check_vprintf() extracts parts of the format string and
> passes those to trace_seq_printf() together with va_list, it expects
> that trace_seq_printf() consumes arguments from va_list, as defined
> by the passed format substring.
> 
> However, trace_seq_printf() has a special path for overflow handling,
> that does not consume any arguments from va_list. This causes va_list
> to get out of sync with format string processing, the next va_arg()
> inside trace_check_vprintf() gets wrong argument, and WARN_ON_ONCE()
> hits.
> 
> This situation easily triggers by ftrace_stress_test from LTP.
> 
> Fix that by adding a dummy vsnprintf() call to the overflow path inside
> trace_seq_printf() to ensure args from va_list are still consumed.

Hi Nikita,

> 
> Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> ---
>  kernel/trace/trace_seq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
> index 9c90b3a7dce2..3551b5e18aa2 100644
> --- a/kernel/trace/trace_seq.c
> +++ b/kernel/trace/trace_seq.c
> @@ -141,9 +141,15 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
>  void trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
>  {
>  	unsigned int save_len = s->seq.len;
> +	char buf[1];
>  
> -	if (s->full)
> +	if (s->full) {
> +		/* Consume args from va_list before returning, some callers
> +		 * expect that.

First, only the networking code uses the /* comment ... for multiline
comments. The rest of the kernel uses:

		/*
		 * Consume ...
		 */

format for multi line comments.

But regardless. Consumers do not expect va_list to be consumed if it is
full. The one use case that does is buggy.

> +		 */
> +		vsnprintf(buf, sizeof(buf), fmt, args);
>  		return;
> +	}
>  
>  	__trace_seq_init(s);
>  

The real fix is:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f9139dc1262c..7aa5ea5ca912 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3654,6 +3654,10 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str)
 	struct trace_event *trace_event;
 	struct trace_event_call *event;
 
+	/* if seq is full, then we can't test it */
+	if (iter->seq->full)
+		return true;
+
 	/* OK if part of the event data */
 	if ((addr >= (unsigned long)iter->ent) &&
 	    (addr < (unsigned long)iter->ent + iter->ent_size))


Cheers,

-- Steve

