Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5542F1BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbhJONKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239258AbhJONKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:10:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07BFB60F9D;
        Fri, 15 Oct 2021 13:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634303314;
        bh=dlB1gAgXUEZBGtvyFhMk2hohC5XLoVh1hRAphcv+4Wk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KDW042BsA41vl8VW7B02yEND55RFG9zakCazj6MirhxKcHT3/s6Ac+cEWfINETF2+
         PZNC00L75lsXCUjA0ISv9EoZyDJbnlbeqiLw6aTTjppaHIrZEBMDBm51Fnst1EW/ju
         PambcP85Ri7dX4xGsz9WPnCS6ecy4P3+2gFjUN7CJItMfJThdjnY9GOEBPGNjRPHOr
         6zz3GGVrkEsmnW/BjacjLSuvufaZTQNQSwSqG4kX4neazbkf+1ZVPS9sdZfPA4yu0c
         fVebjifwlqJpjqi5W4WHg65vATYMOOJfKB3c6UDJvzBwNJ+3i8v3TIJYd1LBP+Zvgc
         ye97FNajrgMtQ==
Date:   Fri, 15 Oct 2021 22:08:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jeff Xie <xiehuan09@gmail.com>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace: Add trace any kernel object
Message-Id: <20211015220832.f9a13bd4ebbc4881b1e68163@kernel.org>
In-Reply-To: <20211013222056.312bec0c@oasis.local.home>
References: <20211014014445.5734-1-xiehuan09@gmail.com>
        <20211013222056.312bec0c@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 22:20:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> [ Added Masami ]
> 
> On Thu, 14 Oct 2021 09:44:45 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
> 
> > Introduce a method based on function tracer and kprobe event 
> > to trace any object in the linux kernel.
> 
> I first want to say that this looks really interesting, and something
> that can help out a lot!
> 
> That said, we are going to have to work with you to come up with a
> better and more flexible interface, and make sure locking and
> synchronization works.

Agreed. This is really interesting. I used to try to add hwbreak event
but the problem is how to set up the hw breakpoint when I found the
interesting one dynamically from kprobes.

> > 
> > Usage:
> > When using the kprobe event, only need to enable trace_object,
> > we can trace any function argument or the return value. When 
> > the object passes through a function, it can be traced.

With this idea, we don't have to have a hwbreak but just focus on
the parameters etc.

> > 
> > For example:
> > 
> > For the function bio_add_page, we can trace the first argument:
> > 
> > int bio_add_page(struct bio *bio, struct page *page,
> > 				unsigned int len, unsigned int offset)
> > 
> > 	#cd /sys/kernel/debug/tracing
> > 	#echo 1 > ./trace_object

Hmm, so what happen if there are several events in parallel?

> > 	#echo 'p bio_add_page arg1=$arg1' > kprobe_events 
> > 	#echo 1 > ./events/kprobes/p_bio_add_page_0/enable

what about adding a "objfilter" trigger action to update the object
list? e.g.

echo objfilter:add:arg1:1 if comm == "sync" >> ./events/kprobes/p_bio_add_page_0/trigger

This will "add the value of 'arg1' to objfilter 1 time if the process
name is sync".

And maybe before that, we need a "objtrace" tracer because
as far as I can see, the trace output below is not compatible
with function/fgraph tracer.

Anyway, this is a great work!

Thank you!

> > 	#sync
> > 	#cat ./trace
> > 
> > 	# tracer: nop
> > 	#
> > 	# entries-in-buffer/entries-written: 367/367   #P:4
> > 	#
> > 	#                                _-----=> irqs-off
> > 	#                               / _----=> need-resched
> > 	#                              | / _---=> hardirq/softirq
> > 	#                              || / _--=> preempt-depth
> > 	#                              ||| / _-=> migrate-disable
> > 	#                              |||| /     delay
> > 	#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > 	#              | |         |   |||||     |         |
> >     kworker/u8:5-89      [000] .....    60.310385: p_bio_add_page_0: (bio_add_page+0x0/0x90) arg1=0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310386: bio_add_page <-ext4_bio_write_page object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310387: __bio_try_merge_page <-bio_add_page object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310387: __bio_add_page <-bio_add_page object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310389: submit_bio <-ext4_io_submit object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310389: submit_bio <-ext4_io_submit object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310389: submit_bio_noacct <-ext4_io_submit object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310389: submit_bio_checks <-submit_bio_noacct object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310390: __cond_resched <-submit_bio_checks object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310390: rcu_all_qs <-__cond_resched object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310390: should_fail_bio <-submit_bio_checks object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310391: blk_mq_submit_bio <-submit_bio_noacct object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310392: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310392: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310392: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310393: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888102bde780
> >     kworker/u8:5-89      [000] .....    60.310394: blk_account_io_start <-blk_mq_submit_bio object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311264: bio_advance <-blk_update_request object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311265: bio_endio <-blk_update_request object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311265: ext4_end_bio <-blk_update_request object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311266: ext4_finish_bio <-ext4_end_bio object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311274: bio_put <-ext4_end_bio object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311274: bio_free <-ext4_end_bio object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311274: bio_free <-ext4_end_bio object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311274: bvec_free <-bio_free object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311275: mempool_free <-bio_free object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311275: mempool_free_slab <-bio_free object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311275: mempool_free <-ext4_end_bio object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311275: mempool_free_slab <-ext4_end_bio object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311275: kmem_cache_free <-ext4_end_bio object:0xffff888102bde780
> >           <idle>-0       [000] d....    60.311276: kmem_cache_free <-ext4_end_bio object:0xffff888102bde780
> >     ...
> > 
> 
> So if I understand the above, if you set this "trace_object" then
> whatever gets placed into a kprobe parameter ($arg1?) or a return value
> of a kretprobe, gets traced at every other function call?
> 
> 
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > ---
> >  include/linux/ftrace.h       |   6 ++
> >  kernel/trace/Kconfig         |   7 ++
> >  kernel/trace/Makefile        |   1 +
> >  kernel/trace/trace.c         |  69 +++++++++++++++++++
> >  kernel/trace/trace.h         |   2 +
> >  kernel/trace/trace_entries.h |  17 +++++
> >  kernel/trace/trace_kprobe.c  |   6 ++
> >  kernel/trace/trace_object.c  | 128 +++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace_output.c  |  40 +++++++++++
> >  9 files changed, 276 insertions(+)
> >  create mode 100644 kernel/trace/trace_object.c
> > 

-- 
Masami Hiramatsu <mhiramat@kernel.org>
