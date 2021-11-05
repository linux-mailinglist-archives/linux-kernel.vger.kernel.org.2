Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B61446474
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhKENxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbhKENxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:53:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A12D1611AE;
        Fri,  5 Nov 2021 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636120244;
        bh=DgHYTphOblvhu/6Mk5dKOYqqshseiOGC1RYuQ+OCnbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gn2qBOfcYn2BAv0Dg6jXCmRlzgTFCpjbG0opMcMtXk3ZbAjEfRQDardxAgRICroT+
         a8w7811OqYq/r02xCEZ+abusAyedmOUJrXfcNNmkLuUsGdM1M1HMSF6AowTjyjvSnQ
         7+ueM9IGb58T06z1GxaSHM0Jb26w8e0HN0FFmTLeCqUY3JaNiMAZUg3zIsOnsqK1IF
         lexojdTrThUcuoqEsQXKUsJ4wWAijJYDKcNoMdnBODFVZp3WlCO05IiHEHpjgr9GQ/
         2b+meFcBf+WQkGOPZVE8lFOF5KSZc+F+kNHzcvB1EJ/PHoyGEiwL9iIdzi3XNrM90G
         2QJzB/XGwtJkw==
Date:   Fri, 5 Nov 2021 22:50:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH v3] trace: Add trace any kernel object
Message-Id: <20211105225040.7e3d90b30c735ea72cf78e9b@kernel.org>
In-Reply-To: <CAEr6+EAGnYn337KAS3Sgx4m84vScxdRrS_yscofxErDugXOeSg@mail.gmail.com>
References: <20211028092702.1099653-1-xiehuan09@gmail.com>
        <20211105004704.3f4aa456c2c537a56f64e65a@kernel.org>
        <CAEr6+EAGnYn337KAS3Sgx4m84vScxdRrS_yscofxErDugXOeSg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Fri, 5 Nov 2021 17:11:27 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Hi Masami,
> 
> Thank you very much for your patient guidance and help, It helped me a lot.
> 
> On Thu, Nov 4, 2021 at 11:47 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Jeff,
> >
> > Thank you for updating!
> >
> > On Thu, 28 Oct 2021 17:27:02 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > > Introduce a method based on function tracer and kprobe/uprobe/trace_event/
> > > to trace any object in the linux kernel.
> > >
> > > Usage:
> > > When using kprobe/uprobe/trace_event/ we can use a new trigger(objtrace)
> > > to set object and trigger object trace.
> > >
> > > For example:
> > >
> > > For the function bio_add_page, we can trace the first argument:
> > >
> > > int bio_add_page(struct bio *bio, struct page *page,
> > >                               unsigned int len, unsigned int offset)
> > >
> > > [root@JeffXie ]# cd /sys/kernel/debug/tracing/
> > > [root@JeffXie tracing]# echo 'p bio_add_page arg1=$arg1' > kprobe_events
> > > [root@JeffXie tracing]# cd events/kprobes/p_bio_add_page_0/
> > > [root@JeffXie p_bio_add_page_0]# echo 'objtrace:arg1:1 if comm == "cat"' > ./trigger
> > > [root@JeffXie p_bio_add_page_0]# cat /test.txt
> > > [root@JeffXie p_bio_add_page_0]# cd /sys/kernel/debug/tracing/
> > > [root@JeffXie tracing]# cat ./trace
> > > # tracer: nop
> > > #
> > > # entries-in-buffer/entries-written: 81/81   #P:4
> > > #
> > > #                                _-----=> irqs-off
> > > #                               / _----=> need-resched
> > > #                              | / _---=> hardirq/softirq
> > > #                              || / _--=> preempt-depth
> > > #                              ||| / _-=> migrate-disable
> > > #                              |||| /     delay
> > > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > > #              | |         |   |||||     |         |
> > >              cat-122     [001] .....   111.193997: bio_add_page <-ext4_mpage_readpages object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.193998: __bio_try_merge_page <-bio_add_page object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.193998: __bio_add_page <-bio_add_page object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.193998: submit_bio <-ext4_mpage_readpages object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.193998: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.193999: __submit_bio <-submit_bio_noacct object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.193999: submit_bio_checks <-__submit_bio object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.193999: __cond_resched <-submit_bio_checks object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.193999: rcu_all_qs <-__cond_resched object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.194000: should_fail_bio <-submit_bio_checks object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.194001: blk_mq_submit_bio <-__submit_bio object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.194001: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.194001: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.194002: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.194002: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888102a4b900
> > >              cat-122     [001] .....   111.194003: blk_account_io_start <-blk_mq_submit_bio object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194212: bio_advance <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194213: bio_endio <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194213: mpage_end_io <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194213: __read_end_io <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194218: bio_put <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194218: bio_free <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194218: bio_free <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194218: bvec_free <-bio_free object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194219: mempool_free <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194219: mempool_free <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194219: mempool_free_slab <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194219: mempool_free_slab <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194219: kmem_cache_free <-blk_update_request object:0xffff888102a4b900
> > >           <idle>-0       [001] d....   111.194219: kmem_cache_free <-blk_update_request object:0xffff888102a4b900
> > >
> > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > ---
> > > Currently only showing all the code I have, But I think that there are main three tasks
> > > to be completed next:
> > >
> > > 1. Masami suggested:
> > >
> > > <snip>
> > > objfilter:add:arg1
> > >
> > > and the exit event
> > >
> > > objfilter:del:arg1
> > >
> > > then user will only see the trace between the entrance and exit events.
> > > </snip>
> > >
> > > Actually, I don’t have a good idea to implement it now ;-)
> > > Looking for related existing code logic.
> >
> > Even though, please support 'add' command at least (no problem even if
> > there is only 'add' supported) because it defines its syntax.
> > It seems a bit redundant now, but if there is 'add', we can extend it to
> > support 'del', 'clear' or 'update' etc.
> >
> 
> Thanks, I will add the "add" command.

Thanks!

> 
> >
> > >
> > > 2. Steven suggested:
> > > <snip>
> > > For example:
> > >
> > >       obj = arg1 + 0x64
> > >       if (copy_from_kernel_nofault(&val, arg1 + 0x64, sizeof(val)))
> > >               // faulted
> > >               return;
> > >
> > > Now val has the content of __bi_cnt and we can print that!
> > > </snip>
> > >
> > > We need to implement a more complex parsing and also record the size of a arg
> > > or other related members.it may change the way I record the object.
> >
> > That can be done in additional patch in a series. I recommend you to send a
> > series of patches, which simply add a feature (or extend existing feature),
> > step by step.
> 
> This is a good suggestion, although I have never submitted a patchset.
> I will try it. ;-）
> 
> > >
> > >
> > > 3. Update trigger documentation
> > >
> > > https://lore.kernel.org/lkml/20211026225234.549ec8e9eb59f1fd1671edbc@kernel.org/T/#t
> > >
> > > I'm very happy to work with you all, and got a lot of knowledge from your help.
> > >
> > > At present, I am the only person writing code using the free time, I usually need to do
> > > other work about linux and take care of a three-month-old boy. unlike a group, the progress
> > > of submitting patches may be slower.
> >
> > That is OK. You can start sowing the seeds, then we can grow it. :-)
> 
> I never thought that my idea might become a relatively large project.
> With my current level of kernel programming, I might not be able to
> complete it alone.
> 
> > And also, please add a (set of) testcase for this feature under
> > tools/testing/selftests/ftrace/test.d/, so that the future changes will not
> > cause any regression. You don't have to check the trace result (if you can,
> > it is recommended) but at least the usage (e.g. accepting correct syntax,
> > and rejecting wrong syntax) test case is helpful.
> 
> ok, I will add a set of testcase.

Good :)


[...]
> > > +static void obj_refill_fn(struct work_struct *refill_work)
> > > +{
> > > +     void **new_obj_element;
> > > +     unsigned long flags;
> > > +     int new_min_nr, new_curr_nr;
> > > +     int used_nr;
> > > +
> > > +     new_min_nr = obj_pool.min_nr * 2;
> >
> > This can easily cause OOM. I think we need a limit to cap.
> > Anyway, at the first step, you can drop this "refill" routine and
> > simply use fixed size array (or hash table?).
> > Anyway if the array becomes huge, your kernel may slow down.
> 
> If we limit the max size, should be able to solve the OOM.
> The logic of this refill should look normal, But in order to simplify
> the implementation of the first step,
> I can remove the refill routine.

I would like to ask you to focus on the performance side, since
the search (object_exist) will be run on every function call.
You can make it a lockless, kretprobe_instance pool (in kernel/kprobes.c)
will be a good example for you.


[...]
> > > +
> > > +static void
> > > +trace_object_trigger(struct event_trigger_data *data,
> > > +                struct trace_buffer *buffer,  void *rec,
> > > +                struct ring_buffer_event *event)
> > > +{
> > > +
> > > +     struct ftrace_event_field *field = data->private_data;
> > > +     void *obj = NULL;
> > > +
> > > +     memcpy(&obj, (char *)rec + field->offset, field->size);
> >
> > Please use 'sizeof(obj)' instead of 'field->size' because 'field->size'
> > can be longer than that.
> >
> This is only one  I can't understand.
> 
> The field->size should be (1(u8/s8), 2(u16/s16), 4(u32/s32),
> 8(u64/s64)) , the sizeof(obj) is 8
> and it should never be longer than sizeof(obj).

You may forget 32bit CPUs..., and you don't need smaller values too,
since it will easily cause false positive. So tracing an object
address is good.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
