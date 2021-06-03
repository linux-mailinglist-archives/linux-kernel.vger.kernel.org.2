Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2739739ACDF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFCVav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhFCVau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:30:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33EFB613F9;
        Thu,  3 Jun 2021 21:29:04 +0000 (UTC)
Date:   Thu, 3 Jun 2021 17:29:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 7/9] tracing: Add __print_ns_to_secs() and
 __print_ns_without_secs() helpers
Message-ID: <20210603172902.41648183@gandalf.local.home>
In-Reply-To: <2c59beee3b36b15592bfbb9f26dee7f8b55fd814.1621024265.git.bristot@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <2c59beee3b36b15592bfbb9f26dee7f8b55fd814.1621024265.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 22:51:16 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> +++ b/include/trace/trace_events.h
> @@ -358,6 +358,21 @@ TRACE_MAKE_SYSTEM_STR();
>  	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
>  				 rowsize, groupsize, buf, len, ascii)
>  
> +#undef __print_ns_to_secs
> +#define __print_ns_to_secs(value)			\
> +	({						\
> +		u64 ____val = (u64)value;		\
> +		do_div(____val, NSEC_PER_SEC);		\
> +		____val;				\
> +	})

I know my name is on this, but we need parenthesis around "value".

> +
> +#undef __print_ns_without_secs
> +#define __print_ns_without_secs(value)			\
> +	({						\
> +		u64 ____val = (u64)value;		\

Here too.

> +		(u32) do_div(____val, NSEC_PER_SEC);	\
> +	})
> +
>  #undef DECLARE_EVENT_CLASS
>  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
>  static notrace enum print_line_t					\
> @@ -736,6 +751,16 @@ static inline void ftrace_test_probe_##call(void)			\
>  #undef __print_array
>  #undef __print_hex_dump
>  
> +/*
> + * The below is not executed in the kernel. It is only what is
> + * displayed in the print format for userspace to parse.
> + */
> +#undef __print_ns_to_secs
> +#define __print_ns_to_secs(val) val / 1000000000UL
> +
> +#undef __print_ns_without_secs
> +#define __print_ns_without_secs(val) val % 1000000000UL

And around "val" in the above two macros.

-- Steve

> +
>  #undef TP_printk
>  #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
>  

