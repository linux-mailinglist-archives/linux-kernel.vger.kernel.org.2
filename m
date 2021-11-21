Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD8458547
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbhKURQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbhKURQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:16:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0038C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:13:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d24so28238436wra.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18am7C3o22dEtsLM6QpCM74liMqcTo6tcszveBKI1D0=;
        b=ef/HNa7kZl3rirNxDNr19Dbge1N9SJSbkhg2mFttj38hiB+FEQwzCeyGCjvjz/g45Z
         /4HM1R0YQdUbZ6p0mgOMxuhgxARm1oNjNYfWEWypitSkJS9NLhuGqmQLxzI/ED3Rh8qS
         9aMxKmNzWWgb5xKSggxq8hrB9SU3AheZRQYSOxEgWSQRGjg2VaRzkllzGDifNFsBLeyr
         v8lkSh0fJpkdXagRCvbrwdYS4qDiyzrx4kZkZP0VLpZ+exHBhwc/XNQPJED13M3bKyA9
         b8VUzfontUbqLEmCpUwZ0XgFHyENeKc6z3C9wq1lLqvMMtARYuMcYmyGd9rmU+Q1KI2o
         ro8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18am7C3o22dEtsLM6QpCM74liMqcTo6tcszveBKI1D0=;
        b=d3YsdaO5bmYefF/8IQ8PLQ8mfBH5mc0VRhvWSGaSTbL8OlW4CrPznUFmd6t2ufMEus
         Dm/Ditw0n2/Z6DEwVvj0qjsTDdQ6bC3WOv0CihQdQY3Do8OqGsBu9tR6h8mSYuaIZzls
         5Ll8WD0kS5sabIFQC0LNpvKxg4kqI0wCm++3FP4ONT3x8RKWiLzV6ImCvi/i7B3K5/+q
         Z3y06Xz7htcQnWC30L8UmU5DtBXJKMfkUco3twwxwyUGvlX1RFUz1sokK0w3lmRYqQRW
         Sgxv7VSSSPSMBLDQ4dIT+S5o8X98v0vwgonqprTC/8gMneHiyOmn5vgESjQr/9BegfKi
         /mGw==
X-Gm-Message-State: AOAM533So6Xh9NHLzndu0iKUCkdc1uKWrE6hDgfKiOzu8+jnKRb6BdqB
        97fMZz/KDV4psA88QzeXGqhm9wgZEHGnE0WMPAeMsHaw/QQ=
X-Google-Smtp-Source: ABdhPJxi0DlMYeM+PClahm4gLt0Wjb2D9XrLYMPAVMYr/y/cJcrzUP1ruiOqv4toELPDhPVmc43L5wEUKab17eeHrl4=
X-Received: by 2002:a5d:6147:: with SMTP id y7mr29275875wrt.217.1637514816155;
 Sun, 21 Nov 2021 09:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20211113120632.94754-1-xiehuan09@gmail.com> <20211119230054.5c453319f3d9a044be118fe8@kernel.org>
 <CAEr6+EAnTQnA7m1XUbV+XTkFX7omy+UpnNY3wryjaXJoqdoJwA@mail.gmail.com>
In-Reply-To: <CAEr6+EAnTQnA7m1XUbV+XTkFX7omy+UpnNY3wryjaXJoqdoJwA@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 22 Nov 2021 01:13:23 +0800
Message-ID: <CAEr6+EAccep5i+NryU-VYvEMQRUqBH-+Wet2Uj1DNDZvp1Rw9Q@mail.gmail.com>
Subject: Re: [RFC][PATCH v5 1/4] trace: Add trace any kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Thank you again for you patient guidance!

On Fri, Nov 19, 2021 at 10:58 PM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Hi Masami,
>
> Thank you so much for your patient comments!
> I have been following the kernel mailing list every day recently. and
> know that you and Steve are both super busy.
>
> I have to say that I am really embarrassed (too many mistakes;-) ).
> But now I just want to say that I will spend time
> to correct all the mistakes seriously.
>
> On Fri, Nov 19, 2021 at 10:00 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Jeff,
> >
> > Sorry for replying late!
> >
> > On Sat, 13 Nov 2021 20:06:29 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > > Introduce a method based on function tracer to trace any object and get
> > > the value of the object dynamically. the object can be obtained from the
> > > dynamic event (kprobe_event/uprobe_event) or the static event(tracepoint).
> > >
> > > Usage:
> > > When using the kprobe event, only need to set the objtrace(a new trigger),
> > > we can get the value of the object. The object is from the setting of the
> > > kprobe event.
> > >
> > > For example:
> > > For the function bio_add_page():
> > >
> > > int bio_add_page(struct bio *bio, struct page *page,
> > >       unsigned int len, unsigned int offset)
> > >
> > > Firstly, we can set the base of the object, thus the first string "arg1"
> > > stands for the value of the first parameter of this function bio_add_gage(),
> > >
> > > # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
> > >
> > > Secondly, we can get the value dynamically base the above object.
> > >
> > > find the offset of the bi_size in struct bio:
> > > $ gdb vmlinux
> > > (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > > $1 = (unsigned int *) 0x28
> > >
> > > # echo 'objtrace:0x28(arg1):u32:1 if comm == "cat"' > ./events/kprobes/ \
> > >       p_bio_add_page_0/trigger
> >
> > You may need "objtrace:add:..." right? :-)

Yes, I will correct it. ;-)

> >
> > BTW, this value support is done in [2/4], you should focus on what this patch
> > does, not the entire series does. It seems what you need is a cover mail
> > for this series. The description like this must be done in the cover mail.
> > (For example, long trace output etc.)

I agree, I will add the cover mail.

> > >
> > > The best way to use this is that we can set the entrance event and exit
> > > event, for example, the following example is to set the read_papes as
> > > the entrance event, and set the blk_account_io_start as the exit event.
> > >
> > > # dd if=/dev/zero of=/test.txt bs=4k count=3
> > > # cd /sys/kernel/debug/tracing/
> > > # echo 0 > ./tracing_on
> > > # echo 'p read_pages' >> ./kprobe_events
> > > # echo 'p blk_account_io_start' >> ./kprobe_events
> > > # echo 'traceon if comm == "cat"' > ./events/kprobes/p_read_pages_0/trigger
> > > # echo 'traceoff if comm == "cat"' > ./events/kprobes/p_blk_account_io_start_0/trigger
> > > # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
> > > # echo 'objtrace:0x28(arg1):u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> > >
> > > # du -sh /test.txt
> > > 12.0K   /test.txt
> > >
> > > # cat  /test.txt > /dev/null
> > > # cat ./trace
> > >
> > > # tracer: nop
> > > #
> > > # entries-in-buffer/entries-written: 50/50   #P:1
> > > #
> > > #                                _-----=> irqs-off
> > > #                               / _----=> need-resched
> > > #                              | / _---=> hardirq/softirq
> > > #                              || / _--=> preempt-depth
> > > #                              ||| / _-=> migrate-disable
> > > #                              |||| /     delay
> > > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > > #              | |         |   |||||     |         |
> > >              cat-95      [000] .....     1.412065: _raw_spin_unlock_irqrestore <-event_triggers_call object:0xffff888108af6328 value:0x0
> > >              cat-95      [000] .....     1.412066: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x0
> > >              cat-95      [000] .....     1.412066: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x0
> > >              cat-95      [000] .....     1.412066: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x1000
> > >              cat-95      [000] .....     1.412066: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x1000
> > >              cat-95      [000] .....     1.412066: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x1000
> > >              cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x1000
> > >              cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x1000
> > >              cat-95      [000] .....     1.412067: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x1000
> > >              cat-95      [000] .....     1.412067: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x2000
> > >              cat-95      [000] .....     1.412067: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x2000
> > >              cat-95      [000] .....     1.412067: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x2000
> > >              cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x2000
> > >              cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x2000
> > >              cat-95      [000] .....     1.412068: submit_bio <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412068: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412068: __submit_bio <-submit_bio_noacct object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412068: blk_try_enter_queue <-__submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412068: submit_bio_checks <-__submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412068: __cond_resched <-submit_bio_checks object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412068: rcu_all_qs <-__cond_resched object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412068: should_fail_bio <-submit_bio_checks object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412069: create_task_io_context <-submit_bio_checks object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412069: kmem_cache_alloc_node <-create_task_io_context object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412069: should_failslab <-kmem_cache_alloc_node object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412069: _raw_spin_lock <-create_task_io_context object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412069: blk_mq_submit_bio <-__submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412069: __blk_queue_split <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412069: bvec_split_segs <-__blk_queue_split object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412069: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412070: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412070: dd_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412070: _raw_spin_lock <-dd_bio_merge object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412070: blk_mq_sched_try_merge <-dd_bio_merge object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412070: elv_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412070: elv_rqhash_find <-elv_merge object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412070: dd_request_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412070: elv_rb_find <-dd_request_merge object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412070: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412071: dd_limit_depth <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412071: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412071: __blk_mq_get_tag <-blk_mq_get_tag object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412071: blk_mq_rq_ctx_init.isra.0 <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412071: ktime_get <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412071: dd_prepare_request <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412071: blk_account_io_start <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412071: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x3000
> > >              cat-95      [000] .....     1.412071: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x3000
> > >
> > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > ---
> > >  include/linux/trace_events.h        |   1 +
> > >  kernel/trace/Kconfig                |  10 +
> > >  kernel/trace/Makefile               |   1 +
> > >  kernel/trace/trace.h                |   8 +
> > >  kernel/trace/trace_entries.h        |  17 +
> > >  kernel/trace/trace_events_trigger.c |   1 +
> > >  kernel/trace/trace_object.c         | 532 ++++++++++++++++++++++++++++
> > >  kernel/trace/trace_output.c         |  40 +++
> > >  8 files changed, 610 insertions(+)
> > >  create mode 100644 kernel/trace/trace_object.c
> > >
> > > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > > index 3e475eeb5a99..84b5c12c7f44 100644
> > > --- a/include/linux/trace_events.h
> > > +++ b/include/linux/trace_events.h
> > > @@ -684,6 +684,7 @@ enum event_trigger_type {
> > >       ETT_EVENT_HIST          = (1 << 4),
> > >       ETT_HIST_ENABLE         = (1 << 5),
> > >       ETT_EVENT_EPROBE        = (1 << 6),
> > > +     ETT_TRACE_OBJECT        = (1 << 7),
> > >  };
> > >
> > >  extern int filter_match_preds(struct event_filter *filter, void *rec);
> > > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > > index 420ff4bc67fd..f69761cbfaaa 100644
> > > --- a/kernel/trace/Kconfig
> > > +++ b/kernel/trace/Kconfig
> > > @@ -237,6 +237,16 @@ config FUNCTION_PROFILER
> > >
> > >         If in doubt, say N.
> > >
> > > +config TRACE_OBJECT
> > > +     bool "Trace kernel object in function parameter"
> > > +     depends on FUNCTION_TRACER
> > > +     depends on HAVE_FUNCTION_ARG_ACCESS_API
> > > +     select TRACING
> > > +     default y
> > > +     help
> > > +      You can trace the kernel object in the kernel function parameter.
> > > +      The kernel object is dynamically specified via event trigger.
> > > +
> > >  config STACK_TRACER
> > >       bool "Trace max stack"
> > >       depends on HAVE_FUNCTION_TRACER
> > > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > > index 6de5d4d63165..6d9e78a488aa 100644
> > > --- a/kernel/trace/Makefile
> > > +++ b/kernel/trace/Makefile
> > > @@ -66,6 +66,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
> > >  obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
> > >  obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
> > >  obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
> > > +obj-$(CONFIG_TRACE_OBJECT) += trace_object.o
> > >  ifeq ($(CONFIG_BLOCK),y)
> > >  obj-$(CONFIG_EVENT_TRACING) += blktrace.o
> > >  endif
> > > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > > index b7c0f8e160fb..d2508f977fe6 100644
> > > --- a/kernel/trace/trace.h
> > > +++ b/kernel/trace/trace.h
> > > @@ -49,6 +49,7 @@ enum trace_type {
> > >       TRACE_TIMERLAT,
> > >       TRACE_RAW_DATA,
> > >       TRACE_FUNC_REPEATS,
> > > +     TRACE_OBJECT,
> > >
> > >       __TRACE_LAST_TYPE,
> > >  };
> > > @@ -460,6 +461,7 @@ extern void __ftrace_bad_type(void);
> > >                         TRACE_GRAPH_RET);             \
> > >               IF_ASSIGN(var, ent, struct func_repeats_entry,          \
> > >                         TRACE_FUNC_REPEATS);                          \
> > > +             IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
> > >               __ftrace_bad_type();                                    \
> > >       } while (0)
> > >
> > > @@ -1510,6 +1512,12 @@ static inline int register_trigger_hist_cmd(void) { return 0; }
> > >  static inline int register_trigger_hist_enable_disable_cmds(void) { return 0; }
> > >  #endif
> > >
> > > +#ifdef CONFIG_TRACE_OBJECT
> > > +extern int register_trigger_object_cmd(void);
> > > +#else
> > > +static inline int register_trigger_object_cmd(void) { return 0; }
> > > +#endif
> > > +
> > >  extern int register_trigger_cmds(void);
> > >  extern void clear_event_triggers(struct trace_array *tr);
> > >
> > > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > > index cd41e863b51c..bb120d9498a9 100644
> > > --- a/kernel/trace/trace_entries.h
> > > +++ b/kernel/trace/trace_entries.h
> > > @@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
> > >                __entry->context,
> > >                __entry->timer_latency)
> > >  );
> > > +
> > > +/*
> > > + * trace object entry:
> > > + */
> > > +FTRACE_ENTRY(object, trace_object_entry,
> > > +
> > > +     TRACE_OBJECT,
> > > +
> > > +     F_STRUCT(
> > > +             __field(        unsigned long,          ip              )
> > > +             __field(        unsigned long,          parent_ip       )
> > > +             __field(        unsigned long,          object          )
> > > +     ),
> > > +
> > > +     F_printk(" %ps <-- %ps object:%lx\n",
> > > +              (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> > > +);
> > > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> > > index 3d5c07239a2a..da2d871fa809 100644
> > > --- a/kernel/trace/trace_events_trigger.c
> > > +++ b/kernel/trace/trace_events_trigger.c
> > > @@ -1687,6 +1687,7 @@ __init int register_trigger_cmds(void)
> > >       register_trigger_enable_disable_cmds();
> > >       register_trigger_hist_enable_disable_cmds();
> > >       register_trigger_hist_cmd();
> > > +     register_trigger_object_cmd();
> > >
> > >       return 0;
> > >  }
> > > diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> > > new file mode 100644
> > > index 000000000000..69465c2ffb7e
> > > --- /dev/null
> > > +++ b/kernel/trace/trace_object.c
> > > @@ -0,0 +1,532 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * trace any object
> > > + * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
> > > + */
> > > +
> > > +#define pr_fmt(fmt) "trace_object: " fmt
> > > +
> > > +#include "trace_output.h"
> > > +#include <linux/freelist.h>
> > > +
> > > +static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);
> > > +static struct trace_event_file event_trace_file;
> > > +static const int max_args_num = 6;
> > > +static const int max_obj_pool = 10;
> > > +static atomic_t trace_object_ref;
> > > +static int exit_trace_object(void);
> > > +static int init_trace_object(void);
> > > +
> > > +struct object_instance {
> > > +     void *object;
> > > +     struct freelist_node freelist;
> > > +};
> > > +
> > > +struct obj_pool {
> > > +     int maxactive;
> >
> > It seems that 'maxactive' is used only in the init_object_pool(), so
> > we may not need this.

I agree, thanks.

> >
> > > +     atomic_t nobject;
> > > +     struct freelist_head product_freelist;
> > > +     struct freelist_head customer_freelist;
> >
> > Sorry, I might confuse you. You shouldn't use the freelist for active
> > list, which searches a specific entry in the list. The freelist is good
> > for pooling the unused object_instances but not good for search an entry.
> > So please use normal "list_head" for the list for active objects. And
> > in that case, we can use rcu_list operation on it.
> >
> > BTW, I rather like calling those "active_list" and "free_list", because
> > product/customer are unclear what it means.

I agree, thanks.

> >
> > > +};
> > > +static struct obj_pool *obj_pool;
> > > +
> > > +static bool object_exist(void *obj)
> > > +{
> > > +     struct freelist_node *node;
> > > +     struct object_instance *inst;
> > > +     bool ret = false;
> > > +
> > > +     node = obj_pool->customer_freelist.head;
> > > +
> > > +     while (node) {
> >
> > Then, you can use list_for_each_entry_rcu() here.
> >
> > > +             inst = container_of(node, struct object_instance, freelist);
> > > +             if (inst->object == obj) {
> > > +                     ret = true;
> > > +                     goto out;
> > > +             }
> > > +             node = node->next;
> > > +     }
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static bool object_empty(void)
> > > +{
> > > +     bool ret;
> > > +
> > > +     ret = atomic_read(&obj_pool->nobject) == 0;
> > > +
> > > +     return ret;
> >
> > Instead of use atomic_read(), you can check the list itself by
> >
> >         return !list_empty_rcu(&obj_pool->active_list);

Maybe should be list_empty_rcu(&obj_pool->active_list) for object_empty() -;)

> >
> > > +}
> > > +
> > > +
> > > +static void set_trace_object(void *obj)
> > > +{
> > > +     struct freelist_node *fn;
> > > +     struct object_instance *ins;
> > > +
> > > +     if (!obj)
> > > +             return;
> > > +
> > > +     if (object_exist(obj))
> > > +             goto out;
> >
> > No need to use goto. Just return is OK.

I agree ,thanks.

> >
> > > +
> > > +     fn = freelist_try_get(&obj_pool->product_freelist);
> > > +     if (!fn) {
> > > +             trace_printk("object_pool is full, can't trace object:0x%px\n", obj);
> > > +             return;
> > > +     }
> > > +
> > > +     ins = container_of(fn, struct object_instance, freelist);
> > > +     ins->object = obj;
> > > +
> > > +     freelist_add(&ins->freelist, &obj_pool->customer_freelist);
> > > +     atomic_inc(&obj_pool->nobject);
> >
> > Here, you can use list_add_rcu().

This place may need to add a
raw_spin_lock_irqsave/raw_spin_unlock_irqrestore to protect
list_add_rcu
and should exit when in nmi context for the function set_trace_object.

> >
> > > +
> > > +out:
> > > +     return;
> > > +}
> > > +
> > > +static inline void free_objects(struct freelist_node *node)
> >
> > Usually, this kind of function will get the freelist_head, since
> > node can be a node in the middle of the list.

I agree, thanks.

> >
> > > +{
> > > +
> > > +     struct object_instance *inst;
> > > +
> > > +     while (node) {
> > > +             inst = container_of(node, struct object_instance, freelist);
> > > +             node = node->next;
> > > +             kfree(inst);
> > > +     }
> > > +}
> > > +
> > > +static inline void free_object_pool(void)
> > > +{
> > > +     free_objects(obj_pool->product_freelist.head);
> > > +     free_objects(obj_pool->customer_freelist.head);
> > > +     kfree(obj_pool);
> > > +}
> > > +
> > > +
> > > +static int init_object_pool(void)
> > > +{
> > > +     struct object_instance *inst;
> > > +     int i, ret = 0;
> > > +
> > > +     obj_pool = kzalloc(sizeof(*obj_pool), GFP_KERNEL);
> > > +     if (!obj_pool) {
> > > +             ret = -ENOMEM;
> > > +             goto out;
> > > +     }
> > > +     obj_pool->maxactive = max_obj_pool;
> > > +     obj_pool->product_freelist.head = NULL;
> > > +     obj_pool->customer_freelist.head = NULL;
> >
> > You don't need to these because you already allocated a zero-filled
> > object by kzalloc().

Thanks for your reminder.

> >
> > > +
> > > +     for (i = 0; i < obj_pool->maxactive; i++) {
> > > +             inst = kzalloc(sizeof(*inst), GFP_KERNEL);
> > > +             if (!inst) {
> > > +                     free_object_pool();
> > > +                     ret = -ENOMEM;
> > > +                     goto out;
> > > +             }
> > > +             freelist_add(&inst->freelist, &obj_pool->product_freelist);
> > > +     }
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> > > +                              unsigned long object)
> > > +{
> > > +
> > > +     struct trace_buffer *buffer;
> > > +     struct ring_buffer_event *event;
> > > +     struct trace_object_entry *entry;
> > > +     int pc;
> > > +
> > > +     pc = preempt_count();
> > > +     event = trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
> > > +                     TRACE_OBJECT, sizeof(*entry), pc);
> > > +     if (!event)
> > > +             return;
> > > +     entry   = ring_buffer_event_data(event);
> > > +     entry->ip                       = ip;
> > > +     entry->parent_ip                = parent_ip;
> > > +     entry->object                   = object;
> > > +
> > > +     event_trigger_unlock_commit(&event_trace_file, buffer, event,
> > > +             entry, pc);
> > > +}
> > > +
> > > +static void
> > > +trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> > > +             struct ftrace_ops *op, struct ftrace_regs *fregs)
> > > +{
> > > +     struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> > > +     unsigned long obj;
> > > +     long disabled;
> > > +     int cpu, n;
> > > +
> > > +     preempt_disable_notrace();
> > > +
> > > +     cpu = raw_smp_processor_id();
> > > +     disabled = atomic_inc_return(&per_cpu(trace_object_event_disable, cpu));
> >
> > What is the purpose of this?
> > (BTW, if you use per_cpu variable, you don't need atomic ops, because there is
> > no racing with other cpus.)

The atomic ops can avoid the interrupt context or the nmi context on
the same cpu to preempt it.

> >
> > > +
> > > +     if (disabled != 1)
> > > +             goto out;
> > > +
> > > +     if (object_empty())
> > > +             goto out;
> > > +
> > > +     for (n = 0; n < max_args_num; n++) {
> > > +             obj = regs_get_kernel_argument(pt_regs, n);
> > > +             if (object_exist((void *)obj))
> > > +                     submit_trace_object(ip, parent_ip, obj);
> > > +     }
> > > +
> > > +out:
> > > +     atomic_dec(&per_cpu(trace_object_event_disable, cpu));
> > > +     preempt_enable_notrace();
> > > +}
> > > +
> > > +static struct ftrace_ops trace_ops = {
> > > +     .func  = trace_object_events_call,
> > > +     .flags = FTRACE_OPS_FL_SAVE_REGS,
> > > +};
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
> > > +     memcpy(&obj, rec + field->offset, sizeof(obj));
> > > +     set_trace_object(obj);
> > > +}
> > > +
> > > +static void
> > > +trace_object_trigger_free(struct event_trigger_ops *ops,
> > > +                struct event_trigger_data *data)
> > > +{
> > > +     if (WARN_ON_ONCE(data->ref <= 0))
> > > +             return;
> > > +
> > > +     data->ref--;
> > > +     if (!data->ref)
> > > +             trigger_data_free(data);
> > > +}
> > > +
> > > +static void
> > > +trace_object_count_trigger(struct event_trigger_data *data,
> > > +                      struct trace_buffer *buffer, void *rec,
> > > +                      struct ring_buffer_event *event)
> > > +{
> > > +     if (!data->count)
> > > +             return;
> > > +
> > > +     if (data->count != -1)
> > > +             (data->count)--;
> > > +
> > > +     trace_object_trigger(data, buffer, rec, event);
> > > +}
> > > +
> > > +static int event_object_trigger_init(struct event_trigger_ops *ops,
> > > +                    struct event_trigger_data *data)
> > > +{
> > > +     data->ref++;
> > > +     return 0;
> > > +}
> > > +
> > > +static int
> > > +event_trigger_print(const char *name, struct seq_file *m,
> > > +                 void *data, char *filter_str)
> > > +{
> > > +     long count = (long)data;
> > > +
> > > +     seq_puts(m, name);
> > > +
> > > +     if (count == -1)
> > > +             seq_puts(m, ":unlimited");
> > > +     else
> > > +             seq_printf(m, ":count=%ld", count);
> > > +
> > > +     if (filter_str)
> > > +             seq_printf(m, " if %s\n", filter_str);
> > > +     else
> > > +             seq_putc(m, '\n');
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int
> > > +trace_object_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
> > > +                      struct event_trigger_data *data)
> > > +{
> > > +     return event_trigger_print("objtrace", m, (void *)data->count,
> > > +                                data->filter_str);
> > > +}
> > > +
> > > +
> > > +static struct event_trigger_ops objecttrace_trigger_ops = {
> > > +     .func                   = trace_object_trigger,
> > > +     .print                  = trace_object_trigger_print,
> > > +     .init                   = event_object_trigger_init,
> > > +     .free                   = trace_object_trigger_free,
> > > +};
> > > +
> > > +static struct event_trigger_ops objecttrace_count_trigger_ops = {
> > > +     .func                   = trace_object_count_trigger,
> > > +     .print                  = trace_object_trigger_print,
> > > +     .init                   = event_object_trigger_init,
> > > +     .free                   = trace_object_trigger_free,
> > > +};
> > > +
> > > +static struct event_trigger_ops *
> > > +objecttrace_get_trigger_ops(char *cmd, char *param)
> > > +{
> > > +     return param ? &objecttrace_count_trigger_ops : &objecttrace_trigger_ops;
> > > +}
> > > +
> > > +static int register_object_trigger(char *glob, struct event_trigger_ops *ops,
> > > +                         struct event_trigger_data *data,
> > > +                         struct trace_event_file *file)
> > > +{
> > > +     struct event_trigger_data *test;
> > > +     int ret = 0;
> > > +
> > > +     lockdep_assert_held(&event_mutex);
> > > +
> > > +     list_for_each_entry(test, &file->triggers, list) {
> > > +             if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type) {
> > > +                     ret = -EEXIST;
> > > +                     goto out;
> > > +             }
> > > +     }
> > > +
> > > +     if (data->ops->init) {
> > > +             ret = data->ops->init(data->ops, data);
> > > +             if (ret < 0)
> > > +                     goto out;
> > > +     }
> > > +
> > > +     list_add_rcu(&data->list, &file->triggers);
> > > +     ret++;
> > > +
> > > +     update_cond_flag(file);
> > > +     if (trace_event_trigger_enable_disable(file, 1) < 0) {
> > > +             list_del_rcu(&data->list);
> > > +             update_cond_flag(file);
> > > +             ret--;
> > > +     }
> > > +     init_trace_object();
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static void unregister_object_trigger(char *glob, struct event_trigger_ops *ops,
> > > +                            struct event_trigger_data *test,
> > > +                            struct trace_event_file *file)
> > > +{
> > > +     struct event_trigger_data *data;
> > > +     bool unregistered = false;
> > > +
> > > +     lockdep_assert_held(&event_mutex);
> > > +
> > > +     list_for_each_entry(data, &file->triggers, list) {
> > > +             if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
> > > +                     unregistered = true;
> > > +                     list_del_rcu(&data->list);
> > > +                     trace_event_trigger_enable_disable(file, 0);
> > > +                     update_cond_flag(file);
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     if (unregistered && data->ops->free) {
> > > +             data->ops->free(data->ops, data);
> > > +             exit_trace_object();
> > > +     }
> > > +}
> > > +
> > > +static int
> > > +event_object_trigger_callback(struct event_command *cmd_ops,
> > > +                    struct trace_event_file *file,
> > > +                    char *glob, char *cmd, char *param)
> > > +{
> > > +     struct event_trigger_data *trigger_data;
> > > +     struct event_trigger_ops *trigger_ops;
> > > +     struct trace_event_call *call;
> > > +     struct ftrace_event_field *field;
> > > +     char *objtrace_cmd;
> > > +     char *trigger = NULL;
> > > +     char *arg;
> > > +     char *number;
> > > +     int ret;
> > > +
> > > +     ret = -EINVAL;
> > > +     if (!param)
> > > +             goto out;
> > > +
> > > +     /* separate the trigger from the filter (c:a:n [if filter]) */
> > > +     trigger = strsep(&param, " \t");
> > > +     if (!trigger)
> > > +             goto out;
> > > +     if (param) {
> > > +             param = skip_spaces(param);
> > > +             if (!*param)
> > > +                     param = NULL;
> > > +     }
> > > +
> > > +     objtrace_cmd = strsep(&trigger, ":");
> > > +     if (!objtrace_cmd || strcmp(objtrace_cmd, "add"))
> > > +             goto out;
> > > +
> > > +     arg = strsep(&trigger, ":");
> > > +     if (!arg)
> > > +             goto out;
> > > +     call = file->event_call;
> > > +     field = trace_find_event_field(call, arg);
> > > +     if (!field)
> > > +             goto out;
> >
> > As I pointed in v3, please ensure the field->size == sizeof(void *).
> > (Note that memcpy() is available only if the both size is same.
> > For example, on the big endian architecture, copying 8bit 0x12 on 64bit
> > pointer will be 0x1200000000000000.)
> >

I agree, thanks for your detailed explanation.

> > Thank you,
> >

Thank you again.

> >
> > > +
> > > +     trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
> > > +
> > > +     ret = -ENOMEM;
> > > +     trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> > > +     if (!trigger_data)
> > > +             goto out;
> > > +
> > > +     trigger_data->count = -1;
> > > +     trigger_data->ops = trigger_ops;
> > > +     trigger_data->cmd_ops = cmd_ops;
> > > +     trigger_data->private_data = field;
> > > +     INIT_LIST_HEAD(&trigger_data->list);
> > > +     INIT_LIST_HEAD(&trigger_data->named_list);
> > > +
> > > +     if (glob[0] == '!') {
> > > +             cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
> > > +             kfree(trigger_data);
> > > +             ret = 0;
> > > +             goto out;
> > > +     }
> > > +
> > > +     if (trigger) {
> > > +             number = strsep(&trigger, ":");
> > > +
> > > +             ret = -EINVAL;
> > > +             if (!strlen(number))
> > > +                     goto out_free;
> > > +
> > > +             /*
> > > +              * We use the callback data field (which is a pointer)
> > > +              * as our counter.
> > > +              */
> > > +             ret = kstrtoul(number, 0, &trigger_data->count);
> > > +             if (ret)
> > > +                     goto out_free;
> > > +     }
> > > +
> > > +     if (!param) /* if param is non-empty, it's supposed to be a filter */
> > > +             goto out_reg;
> > > +
> > > +     if (!cmd_ops->set_filter)
> > > +             goto out_reg;
> > > +
> > > +     ret = cmd_ops->set_filter(param, trigger_data, file);
> > > +     if (ret < 0)
> > > +             goto out_free;
> > > +
> > > + out_reg:
> > > +     /* Up the trigger_data count to make sure reg doesn't free it on failure */
> > > +     event_object_trigger_init(trigger_ops, trigger_data);
> > > +     ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> > > +     /*
> > > +      * The above returns on success the # of functions enabled,
> > > +      * but if it didn't find any functions it returns zero.
> > > +      * Consider no functions a failure too.
> > > +      */
> > > +     if (!ret) {
> > > +             cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
> > > +             ret = -ENOENT;
> > > +     } else if (ret > 0)
> > > +             ret = 0;
> > > +
> > > +     /* Down the counter of trigger_data or free it if not used anymore */
> > > +     trace_object_trigger_free(trigger_ops, trigger_data);
> > > + out:
> > > +     return ret;
> > > +
> > > + out_free:
> > > +     if (cmd_ops->set_filter)
> > > +             cmd_ops->set_filter(NULL, trigger_data, NULL);
> > > +     kfree(trigger_data);
> > > +     goto out;
> > > +}
> > > +
> > > +static struct event_command trigger_object_cmd = {
> > > +     .name                   = "objtrace",
> > > +     .trigger_type           = ETT_TRACE_OBJECT,
> > > +     .flags                  = EVENT_CMD_FL_NEEDS_REC,
> > > +     .func                   = event_object_trigger_callback,
> > > +     .reg                    = register_object_trigger,
> > > +     .unreg                  = unregister_object_trigger,
> > > +     .get_trigger_ops        = objecttrace_get_trigger_ops,
> > > +     .set_filter             = set_trigger_filter,
> > > +};
> > > +
> > > +__init int register_trigger_object_cmd(void)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret = register_event_command(&trigger_object_cmd);
> > > +     WARN_ON(ret < 0);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int init_trace_object(void)
> > > +{
> > > +     int ret;
> > > +
> > > +     if (atomic_inc_return(&trace_object_ref) != 1) {
> > > +             ret = 0;
> > > +             goto out;
> > > +     }
> > > +
> > > +     ret = init_object_pool();
> > > +     if (ret)
> > > +             goto out;
> > > +
> > > +     event_trace_file.tr = top_trace_array();
> > > +     if (WARN_ON(!event_trace_file.tr)) {
> > > +             ret = -1;
> > > +             goto out;
> > > +     }
> > > +     ret = register_ftrace_function(&trace_ops);
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static int exit_trace_object(void)
> > > +{
> > > +     int ret;
> > > +
> > > +     if (WARN_ON_ONCE(atomic_read(&trace_object_ref) <= 0))
> > > +             goto out;
> > > +
> > > +     if (atomic_dec_return(&trace_object_ref) != 0) {
> > > +             ret = 0;
> > > +             goto out;
> > > +     }
> > > +
> > > +     ret = unregister_ftrace_function(&trace_ops);
> > > +     if (ret) {
> > > +             pr_err("can't unregister ftrace for trace object\n");
> > > +             goto out;
> > > +     }
> > > +     free_object_pool();
> > > +out:
> > > +     return ret;
> > > +}
> > > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > > index c2ca40e8595b..76ca560af693 100644
> > > --- a/kernel/trace/trace_output.c
> > > +++ b/kernel/trace/trace_output.c
> > > @@ -1552,6 +1552,45 @@ static struct trace_event trace_func_repeats_event = {
> > >       .funcs          = &trace_func_repeats_funcs,
> > >  };
> > >
> > > +/* TRACE_OBJECT */
> > > +static enum print_line_t trace_object_print(struct trace_iterator *iter, int flags,
> > > +                                     struct trace_event *event)
> > > +{
> > > +     struct trace_object_entry *field;
> > > +     struct trace_seq *s = &iter->seq;
> > > +
> > > +     trace_assign_type(field, iter->ent);
> > > +     print_fn_trace(s, field->ip, field->parent_ip, flags);
> > > +     trace_seq_printf(s, " object:0x%lx", field->object);
> > > +     trace_seq_putc(s, '\n');
> > > +
> > > +     return trace_handle_return(s);
> > > +}
> > > +
> > > +static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags,
> > > +                                   struct trace_event *event)
> > > +{
> > > +     struct trace_object_entry *field;
> > > +
> > > +     trace_assign_type(field, iter->ent);
> > > +
> > > +     trace_seq_printf(&iter->seq, "%lx %lx\n",
> > > +                      field->ip,
> > > +                      field->parent_ip);
> > > +
> > > +     return trace_handle_return(&iter->seq);
> > > +}
> > > +
> > > +static struct trace_event_functions trace_object_funcs = {
> > > +     .trace          = trace_object_print,
> > > +     .raw            = trace_object_raw,
> > > +};
> > > +
> > > +static struct trace_event trace_object_event = {
> > > +     .type           = TRACE_OBJECT,
> > > +     .funcs          = &trace_object_funcs,
> > > +};
> > > +
> > >  static struct trace_event *events[] __initdata = {
> > >       &trace_fn_event,
> > >       &trace_ctx_event,
> > > @@ -1566,6 +1605,7 @@ static struct trace_event *events[] __initdata = {
> > >       &trace_timerlat_event,
> > >       &trace_raw_data_event,
> > >       &trace_func_repeats_event,
> > > +     &trace_object_event,
> > >       NULL
> > >  };
> > >
> > > --
> > > 2.25.1
> > >
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
>
> Thanks,
> ---
> JeffXie
