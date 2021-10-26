Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCCF43B61B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhJZPyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbhJZPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:53:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B65BC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:50:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v17so18791928wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6CCQfEwc+Xk+A1+GJCVKvnxyBKdFyVNBsAMYMqOiOM=;
        b=M013hEbZz1wdsFZcYVHUZOiYWESXXXY36LZAj8b+qpvV9+U7HIYjSIPbk2aXJvb36F
         ASiM1GVyUOJNpXgR7TjZkdfOZIn2jxf1PsGaGNMrjezSthvtRKTju1t6ZJlotNF8myjj
         g0yslfi/cjc9Jx8SPCUrOf6xUP4NghUEB0KpFbnFJloFSksw+JuOgcAfVorPH9FrldSD
         gE++SX8lPe2MIhsX7Kwu0RrN+vXBA7CNDhxa6c/nI9fQSfs/kWcdi6gnAxqIqKHyr/ii
         8GTMSxaI00gNjaYjiHk/nibpgQ5/C1Plu8FuRhr5s5k3cLeVwgPHfDIRQM+G73/paurH
         R++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6CCQfEwc+Xk+A1+GJCVKvnxyBKdFyVNBsAMYMqOiOM=;
        b=5aOeryFDV2VFD5xdlnVb9udx4tqMbqDLF0nmYfeH0V2Uwdaz7V23381t+qkCV0oJ2d
         OtA57NtUtWbELS5BRJVDb9xXWjpNMPqb2ObTYcdP+kqBQRCZdkX61QJS1rplOJVfNC1d
         3Tzq77BHFtiJ5r+8DUFeMAkilKWxbmHFlzhc7xsNsNLSCUwJByQY21YmdEFlAL/FCPQP
         LLNtFAoc91k2x7cpQilfqJeT83DThP27lyJW8Km/4gWEqaOcRnd06YlxdXJXfQCivmuE
         ctp4wGDm1al1rjVcFqdlWkiYOsZDDP7lWemLFf6cfb2i9DFno/ohKWturbg2RKQwyuPj
         KSwA==
X-Gm-Message-State: AOAM533Y2IEcZgqtQVqD8AhivGTeWpK3ciVL2T181jF9ZRYx3KszGoiR
        CjgxzuyaP5RwzuXqTE8mqbowzExMfpBAL6dGvTmmTOQQnFuL8TKT
X-Google-Smtp-Source: ABdhPJydCtfajJcp8o6OTLLTWX/y0/p6SInTuZ5qiPQQbrdzg4Nxc4ws6AIDU15XAs5f4HO0rJ+ddbfXwJhoxtSEZrc=
X-Received: by 2002:a05:6000:144c:: with SMTP id v12mr32698847wrx.142.1635263451680;
 Tue, 26 Oct 2021 08:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211021185335.380810-1-xiehuan09@gmail.com> <20211022180752.0ed07b35@gandalf.local.home>
 <20211026225234.549ec8e9eb59f1fd1671edbc@kernel.org>
In-Reply-To: <20211026225234.549ec8e9eb59f1fd1671edbc@kernel.org>
From:   Huan Xie <xiehuan09@gmail.com>
Date:   Tue, 26 Oct 2021 23:50:39 +0800
Message-ID: <CAEr6+EBSaO6JbxYfJbSxzWUD+0GtATyxDnhdoo9wqpe+F5ZeWg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] trace: Add trace any kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 9:52 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Jeff,
>
> On Fri, 22 Oct 2021 18:07:52 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Fri, 22 Oct 2021 02:53:35 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > Hi Jeff!
> >
> >
> > > Introduce a method based on function tracer and kprobe/uprobe/trace_event/
> > > to trace any object in the linux kernel.
> > >
> > > Usage:
> > > When using kprobe/uprobe/trace_event/ we can use a new trigger(objfilter)
> > > to set object and tigger object trace.
> > >
> > > For example:
> > >
> > > For the function bio_add_page, we can trace the first argument:
> > >
> > > int bio_add_page(struct bio *bio, struct page *page,
> > >                             unsigned int len, unsigned int offset)
> > >
> > > [root@JeffXie ]# cd /sys/kernel/debug/tracing/
> > > [root@JeffXie tracing]# echo 'p bio_add_page arg1=$arg1' > kprobe_events
> > > [root@JeffXie tracing]# cd events/kprobes/p_bio_add_page_0/
> > > [root@JeffXie p_bio_add_page_0]# echo 'objfilter:arg1 if comm == "cat"' > ./trigger
>
> thanks for updating to use the trigger action!
>
> BTW, can you add a command to the objfilter syntax?
> I think sometimes we will trace the object in between some events. In that case,
> at the entrance event,
>
> objfilter:add:arg1
>
> and the exit event
>
> objfilter:del:arg1
>
> then user will only see the trace between the entrance and exit events.
>
> Also, please add me to Cc list :-)
>
>
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
> > > So far, it can trace the object from kprobe/uprobe/syscall tracepoint
> > > and now it doesn't yet support the count for objfilter.
>
> That's OK, you can add features step by step (and that is preferrable)

Thank you so much for your encouragement!

>
> > >
> > >  include/linux/ftrace.h              |  16 +++
> > >  include/linux/trace_events.h        |   1 +
> > >  kernel/trace/Kconfig                |   7 +
> > >  kernel/trace/Makefile               |   1 +
> > >  kernel/trace/trace.h                |   7 +
> > >  kernel/trace/trace_entries.h        |  17 +++
> > >  kernel/trace/trace_events_trigger.c | 122 ++++++++++++++++++
> > >  kernel/trace/trace_kprobe.c         |   1 +
> > >  kernel/trace/trace_object.c         | 191 ++++++++++++++++++++++++++++
> > >  kernel/trace/trace_output.c         |  40 ++++++
> > >  kernel/trace/trace_syscalls.c       |   1 +
> > >  kernel/trace/trace_uprobe.c         |   1 +
> > >  12 files changed, 405 insertions(+)
> > >  create mode 100644 kernel/trace/trace_object.c
> > >
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index 832e65f06754..2d7e62bff6c5 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -1078,4 +1078,20 @@ unsigned long arch_syscall_addr(int nr);
> > >
> > >  #endif /* CONFIG_FTRACE_SYSCALLS */
> > >
> > > +struct trace_event_file;
> > > +
> > > +#ifdef CONFIG_TRACE_OBJECT
> > > +int init_trace_object(void);
> > > +int exit_trace_object(void);
> > > +void set_trace_object(void *obj);
> > > +void record_trace_object(struct trace_event_file *trace_file,
> > > +           struct pt_regs *regs);
> > > +#else
> > > +static inline int init_trace_object(void) { return 0; }
> > > +static inline int exit_trace_object(void) { return 0; }
> > > +static inline void set_trace_object(void *obj) { }
> > > +static inline void record_trace_object(struct trace_event_file *trace_file,
> > > +           struct pt_regs *regs) { }
> > > +#endif /* CONFIG_TRACE_OBJECT */
> > > +
> > >  #endif /* _LINUX_FTRACE_H */
> > > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > > index 3e475eeb5a99..f6dcaca9c3fe 100644
> > > --- a/include/linux/trace_events.h
> > > +++ b/include/linux/trace_events.h
> > > @@ -684,6 +684,7 @@ enum event_trigger_type {
> > >     ETT_EVENT_HIST          = (1 << 4),
> > >     ETT_HIST_ENABLE         = (1 << 5),
> > >     ETT_EVENT_EPROBE        = (1 << 6),
> > > +   ETT_TRACE_OBJECT        = (1 << 7),
> > >  };
> > >
> > >  extern int filter_match_preds(struct event_filter *filter, void *rec);
> > > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > > index 420ff4bc67fd..d302a0f085f9 100644
> > > --- a/kernel/trace/Kconfig
> > > +++ b/kernel/trace/Kconfig
> > > @@ -237,6 +237,13 @@ config FUNCTION_PROFILER
> > >
> > >       If in doubt, say N.
> > >
> > > +config TRACE_OBJECT
> > > +   bool "Trace kernel object"
> > > +   depends on FUNCTION_TRACER
> > > +   default y
> > > +   help
> > > +    This help kernel developer to trace any kernel object.
>
> It is better to add more comment for this feature.
>
> Could you also add another patch to update the trigger documentation
> (or add a new document) under Documents/trace for this feature?

Okay, I will finish this part next.

> > > +
> > >  config STACK_TRACER
> > >     bool "Trace max stack"
> > >     depends on HAVE_FUNCTION_TRACER
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
> > > index b7c0f8e160fb..6ac8f5aca070 100644
> > > --- a/kernel/trace/trace.h
> > > +++ b/kernel/trace/trace.h
> > > @@ -49,6 +49,7 @@ enum trace_type {
> > >     TRACE_TIMERLAT,
> > >     TRACE_RAW_DATA,
> > >     TRACE_FUNC_REPEATS,
> > > +   TRACE_OBJECT,
> > >
> > >     __TRACE_LAST_TYPE,
> > >  };
> > > @@ -460,6 +461,7 @@ extern void __ftrace_bad_type(void);
> > >                       TRACE_GRAPH_RET);             \
> > >             IF_ASSIGN(var, ent, struct func_repeats_entry,          \
> > >                       TRACE_FUNC_REPEATS);                          \
> > > +           IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
> > >             __ftrace_bad_type();                                    \
> > >     } while (0)
> > >
> > > @@ -1950,6 +1952,11 @@ struct trace_min_max_param {
> > >     u64             *max;
> > >  };
> > >
> > > +struct object_trigger_param {
> > > +   struct pt_regs *regs;
> > > +   int param;
> > > +};
> > > +
> > >  #define U64_STR_SIZE               24      /* 20 digits max */
> > >
> > >  extern const struct file_operations trace_min_max_fops;
> > > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > > index cd41e863b51c..bb120d9498a9 100644
> > > --- a/kernel/trace/trace_entries.h
> > > +++ b/kernel/trace/trace_entries.h
> > > @@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
> > >              __entry->context,
> > >              __entry->timer_latency)
> > >  );
> > > +
> > > +/*
> > > + * trace object entry:
> > > + */
> > > +FTRACE_ENTRY(object, trace_object_entry,
> > > +
> > > +   TRACE_OBJECT,
> > > +
> > > +   F_STRUCT(
> > > +           __field(        unsigned long,          ip              )
> > > +           __field(        unsigned long,          parent_ip       )
> > > +           __field(        unsigned long,          object          )
> > > +   ),
> > > +
> > > +   F_printk(" %ps <-- %ps object:%lx\n",
> > > +            (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> > > +);
> > > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> > > index 3d5c07239a2a..d823854445e6 100644
> > > --- a/kernel/trace/trace_events_trigger.c
> > > +++ b/kernel/trace/trace_events_trigger.c
> >
> > OK, so you shouldn't be modifying this file.
> >
> > Look at how the histograms are done:
> >
> >  kernel/trace/trace_events_hist.c
> >
> > All your code should be in your trace_object.c file.
> >
> > Although, looking at the trace_events_hist.c file myself, I see a lot of
> > duplicate code in event_hist_trigger_func() where we can add helper
> > functions to handle that.
> >
> > But for now, just duplicate the code ;-)
> >
> > I added Tom to the Cc, so that he knows where he needs to clean up his code!
> >
> >
> > > @@ -756,12 +756,36 @@ int set_trigger_filter(char *filter_str,
> > >     struct event_filter *filter = NULL, *tmp;
> > >     int ret = -EINVAL;
> > >     char *s;
> > > +   unsigned long param;
> > > +   struct object_trigger_param *obj_param;
> > > +   int len;
> > >
> > >     if (!filter_str) /* clear the current filter */
> > >             goto assign;
> > >
> > >     s = strsep(&filter_str, " \t");
> > >
> > > +   if (data->cmd_ops->trigger_type == ETT_TRACE_OBJECT) {
> > > +           obj_param = data->private_data;
> > > +           len = str_has_prefix(s, "arg");
>
> This seems that you only accept the "argN" instead of the parameter name.
> kprobes event automatically use such name, but the normal events usually
> have named parameters.
> You can use trace_find_event_field(file->event_call, s) to find the field
> by name, instead of using argN. And you can record the field offset and size.
>
> > > +           if (!len)
> > > +                   goto out;
> > > +           ret = kstrtoul(s + len, 10, &param);
> > > +           if (ret || param == 0)
> > > +                   goto out;
> > > +           obj_param = kmalloc(sizeof(*obj_param), GFP_KERNEL);
> > > +           if (!obj_param) {
> > > +                   ret = -ENOMEM;
> > > +                   goto out;
> > > +           }
> > > +           data->private_data = obj_param;
> > > +           obj_param->param = param;
> > > +           init_trace_object();
> > > +   }
> > > +   if (!strlen(s) || !filter_str)
> > > +           goto out;
> > > +
> > > +   s = strsep(&filter_str, " \t");
> > >     if (!strlen(s) || strcmp(s, "if") != 0)
> > >             goto out;
> > >
> > > @@ -1679,6 +1703,103 @@ static __init int register_trigger_traceon_traceoff_cmds(void)
> > >     return ret;
> > >  }
> > >
> > > +#ifdef CONFIG_TRACE_OBJECT
> > > +
> > > +static void
> > > +trace_object_trigger(struct event_trigger_data *data,
> > > +              struct trace_buffer *buffer,  void *rec,
> > > +              struct ring_buffer_event *event)
> > > +{
> > > +
> > > +   struct object_trigger_param *obj_param = data->private_data;
> > > +   unsigned long param;
> > > +
> > > +   param = regs_get_kernel_argument(obj_param->regs, obj_param->param - 1);
> > > +   set_trace_object((void *)param);
>
> What I meant was to get the object from the trace buffer, not from
> the pt_regs. Using this regs_get_kernel_argument() will narrow the objfilter
> (or "objtrace", I reconsider the name) only for the function entry.
>
> But if you get the object parameter from the recorded event, your tracer
> can trace the object which is recorded by the embedded (static) events too.
> That will make this feature more useful :)
>
> Using the size and the offset, you can get the data from the @rec parameter
> (@rec is the binary data and you can find the field by the offset).

I sounds very great, I will take some time to understand all your
suggestions in depth  ;-)

> Thank you,
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

--
JeffXie
