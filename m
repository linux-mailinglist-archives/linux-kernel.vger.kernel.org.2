Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649333E2F07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbhHFRvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241512AbhHFRvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:51:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9124610E7;
        Fri,  6 Aug 2021 17:51:25 +0000 (UTC)
Date:   Fri, 6 Aug 2021 13:51:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] trace: Add migrate-disabled counter to tracing output.
Message-ID: <20210806135124.1279fc94@oasis.local.home>
In-Reply-To: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
References: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 18:49:07 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> migrate_disable() forbids task migration to another CPU. It is available
> since v5.11 and has already users such as highmem or BPF. It is useful
> to observe this task state in tracing which already has other states
> like the preemption counter.
> 
> Add the migrate-disable counter to the trace entry so it shows up in the
> trace. Due to the users mentioned above, it is already possible to
> observe it:
> 
> |  bash-1108    [000] ...21    73.950578: rss_stat: mm_id=2213312838 curr=0 type=MM_ANONPAGES size=8192B
> |  bash-1108    [000] d..31    73.951222: irq_disable: caller=flush_tlb_mm_range+0x115/0x130 parent=ptep_clear_flush+0x42/0x50
> |  bash-1108    [000] d..31    73.951222: tlb_flush: pages:1 reason:local mm shootdown (3)
> 
> The last value is the migrate-disable counter.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: patch description.]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/trace_events.h |  2 ++
>  kernel/trace/trace.c         | 26 +++++++++++++++++++-------
>  kernel/trace/trace_events.c  |  1 +
>  kernel/trace/trace_output.c  |  5 +++++
>  4 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index ad413b382a3ca..7c4280b4c6be7 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -69,6 +69,7 @@ struct trace_entry {
>  	unsigned char		flags;
>  	unsigned char		preempt_count;
>  	int			pid;
> +	unsigned char		migrate_disable;

The only issue I have with this patch is this part. It extends the
header of all events beyond 8 bytes, and actually adds another 4 or 8
bytes despite being just a char in size. That's because this is a
header of a structure, which depending on the first field of an event,
padding may be added to have 4 or 8 byte alignment.

I'll be fine with merging this counter with either flags or
preempt_count (neither needs all 8 bits). I can figure out how to
update libtraceevent to handle this case.

-- Steve


>  };
>  
>  #define TRACE_EVENT_TYPE_MAX						\
> @@ -157,6 +158,7 @@ static inline void tracing_generic_entry_update(struct trace_entry *entry,
>  						unsigned int trace_ctx)
