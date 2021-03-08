Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B5F3315B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCHSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:16:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhCHSQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:16:01 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F33652B8;
        Mon,  8 Mar 2021 18:16:00 +0000 (UTC)
Date:   Mon, 8 Mar 2021 13:15:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [RFC PATCH 1/5] tracing: Define new ftrace event "func_repeats"
Message-ID: <20210308131558.6ee6f98e@gandalf.local.home>
In-Reply-To: <6f4083f2-6c71-e404-9000-b08ff94ab328@gmail.com>
References: <20210304090141.207309-1-y.karadz@gmail.com>
        <20210304090141.207309-2-y.karadz@gmail.com>
        <20210304113809.5c2ccceb@gandalf.local.home>
        <6f4083f2-6c71-e404-9000-b08ff94ab328@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 16:57:29 +0200
"Yordan Karadzhov (VMware)" <y.karadz@gmail.com> wrote:

> > If we had:
> > 
> >             <...>-37      [004] ...1  2022.303820: gc_worker <-process_one_work
> >             <...>-37      [004] ...1  2022.303820: ___might_sleep <-gc_worker
> >             <...>-37      [004] ...1  2022.303831: ___might_sleep <-gc_worker (last ts: 2022.303828 repeats: 127)
> >             <...>-37      [004] ...1  2022.303831: queue_delayed_work_on <-process_one_work
> > 
> > We would know the last time __might_sleep was called.
> > 
> > That is, not only should we save the ip and pip in the trace_func_repeats
> > structure, but we should also be storing the last time stamp of the last
> > function event that repeated. Otherwise the above looks like the last
> > __might_sleep called above happened when the queue_delayed_work_on
> > happened, where that may not be the case.  
> 
> If we store the last timestamp, this means we will need to use 
> additional 64b on the buffer, every time we record the "func_repeats" 
> event. This looks like an overkill to me.
> Can we store only the duration of the repeats (the difference between 
> the timestamp)? This way we can use less memory at the price of having 
> one extra arithmetic operation.
> Alternative approach can be to store only the least-significant bits of 
> the timestamp.
> 
> What do you think?

I like the way you're thinking ;-)

Let's take a look at the current event sizes.

The function event is defined as:

name: function
ID: 1
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:unsigned long ip;	offset:8;	size:8;	signed:0;
	field:unsigned long parent_ip;	offset:16;	size:8;	signed:0;

Showing that it's total size is 24 bytes (offset:16 + size:8)

and your current repeat event has:

ID: 17
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:unsigned long ip;	offset:8;	size:8;	signed:0;
	field:unsigned long pip;	offset:16;	size:8;	signed:0;
	field:unsigned long count;	offset:24;	size:8;	signed:0;

Which is 32 bytes. Adding another 8 would make it 40. It's bigger than one
function event, but still smaller than two, and adding just 4 bytes is
still some size more than a single function event.

Since this event is new, we could even do another trick (one that the
preemptirq events do:

ID: 434
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:s32 caller_offs;	offset:8;	size:4;	signed:1;
	field:s32 parent_offs;	offset:12;	size:4;	signed:1;

print fmt: "caller=%pS parent=%pS", (void *)((unsigned long)(_stext) + REC->caller_offs), (void *)((unsigned long)(_stext) + REC->parent_offs)

The (_stext) is defined in /proc/kallsyms:

# grep stext /proc/kallsyms 
ffffffff8d000000 T _stext

And the offsets are off of that, which we could do the same thing here.

	field:s32 ip;	offset:8;	size:4;	signed:1;
	field:s32 pip;	offset:12;	size:4;	signed:1;
	field:s16 count;	offset:20;	size:2;	signed:1;
	field:u16 top_ts;	offset:22;	size:2; signed:0;
	field:u32 bottom_ts;	offset:24;	size:4; signed:0;

By putting count down to 2 bytes. Having more than 64K repeats is
probably not going to happen, and if it does, we could inject this more
than once ;-)

And as all events must be 4 byte aligned, we could use 6 bytes for the
offset, giving us: 2^40 bits instead of just 2^32 bits, that is, making the
time go from 4 seconds (2^32 nanoseconds) to 18 minutes (2^40 nanoseconds).

I would grab the time stamp after saving the event to make sure that it
doesn't go backwards. It may be a little racy (if an interrupt comes in
between), but it's still a "best effort" approach.

-- Steve

