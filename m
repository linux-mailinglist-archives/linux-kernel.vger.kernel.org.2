Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A4E43AE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhJZIx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhJZIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:53:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EDEC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:51:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 131-20020a1c0489000000b0032cca9883b5so986932wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kt7OMNCn62AJsQj5dATxAh/96GCu3bM8ZDUKtSoxUis=;
        b=BklGAw7C4rhFpX84JUmQpz0e48pkHh+Z/e2MEbCjnrS7YIMM7Wh80NM9Egh1iZoMrp
         mXuhBSxmEEEig9LkeAJRFcU0jcjFlk0jalK/3datXjPwFhlh/7qik6ECNorqN5SxORmh
         qjTuAeMM9myOGJbRdn/73FVcBoR5tBS6GQXoHCrJX6MpniHkODOjWZJ/AumlktERuy3S
         qpSvTs8dC3aVJbJDJcpQzSJeEzAICP+p77v/iwl5ygPXhlzkZ9dF3vpfcXn1yC/HLAa5
         2VUzMNAXTszd+mnGbyw+KTjPC1WAre7EY1/vyK7MoT3JlT2IRWowny0dZQtqtWQ6Zlaw
         2kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kt7OMNCn62AJsQj5dATxAh/96GCu3bM8ZDUKtSoxUis=;
        b=b3USOWhi0FW0BLnCpM5hlbwqlBmXxGxcJEK39+i8TQrXwRW/7kcXHdl0YVq+5400bj
         6HFjYI25ueumLglVRG9lFkduWZWiDGlkYDweA7Q8vTd6TTOSeOCjLqEbXSyQyL06ZJYk
         v6aXR9emufOCuItCVato69u74dL78D+6h6tVHMDVwmqOMW7yGkUShRjvKkznvG82iFo0
         71zy/x9Gozr61NJm4FPDBc8iqIVoqtXJOEuFJgOiaYW7hI0LZaDKAx5GqDWvKzchLDTk
         TNkgK1gUvTUGrdXOiEFa4o+Esvb/1XQhMzT/4W68Mb+Kl89rO1w8qPh4SdLg4AM/dR5S
         wnMg==
X-Gm-Message-State: AOAM533Rqinco7rXaowdk3IRxys27RWvESgZZThVwS5vgP5PU6l3Jhoz
        EiZ9F34u6HsIyrLOW6iO9NJE0jhstiRyrrjfOSoQjoEK4YQqAD07
X-Google-Smtp-Source: ABdhPJz/JwCDXK+p0ZaibSTyC9BNp2b2eli04KbzyO9vxfvOlwrbCNlwncbOOfaGHsQrQ/go0VMmY4qskkH90hk/0Mo=
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr12683888wms.18.1635238259062;
 Tue, 26 Oct 2021 01:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211021185335.380810-1-xiehuan09@gmail.com> <20211022180752.0ed07b35@gandalf.local.home>
In-Reply-To: <20211022180752.0ed07b35@gandalf.local.home>
From:   Huan Xie <xiehuan09@gmail.com>
Date:   Tue, 26 Oct 2021 16:50:46 +0800
Message-ID: <CAEr6+EBq_v+DGSDeiX5Dqc0RgD0sPpbhzpi=T2=r7M2oh90Fpg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] trace: Add trace any kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Sat, Oct 23, 2021 at 6:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 22 Oct 2021 02:53:35 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Hi Jeff!
>
>
> > Introduce a method based on function tracer and kprobe/uprobe/trace_event/
> > to trace any object in the linux kernel.
> >
> > Usage:
> > When using kprobe/uprobe/trace_event/ we can use a new trigger(objfilter)
> > to set object and tigger object trace.
> >
> > For example:
> >
> > For the function bio_add_page, we can trace the first argument:
> >
> > int bio_add_page(struct bio *bio, struct page *page,
> >                               unsigned int len, unsigned int offset)
> >
> > [root@JeffXie ]# cd /sys/kernel/debug/tracing/
> > [root@JeffXie tracing]# echo 'p bio_add_page arg1=$arg1' > kprobe_events
> > [root@JeffXie tracing]# cd events/kprobes/p_bio_add_page_0/
> > [root@JeffXie p_bio_add_page_0]# echo 'objfilter:arg1 if comm == "cat"' > ./trigger
> > [root@JeffXie p_bio_add_page_0]# cat /test.txt
> > [root@JeffXie p_bio_add_page_0]# cd /sys/kernel/debug/tracing/
> > [root@JeffXie tracing]# cat ./trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 81/81   #P:4
> > #
> > #                                _-----=> irqs-off
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| / _-=> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >              cat-122     [001] .....   111.193997: bio_add_page <-ext4_mpage_readpages object:0xffff888102a4b900
> >              cat-122     [001] .....   111.193998: __bio_try_merge_page <-bio_add_page object:0xffff888102a4b900
> >              cat-122     [001] .....   111.193998: __bio_add_page <-bio_add_page object:0xffff888102a4b900
> >              cat-122     [001] .....   111.193998: submit_bio <-ext4_mpage_readpages object:0xffff888102a4b900
> >              cat-122     [001] .....   111.193998: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888102a4b900
> >              cat-122     [001] .....   111.193999: __submit_bio <-submit_bio_noacct object:0xffff888102a4b900
> >              cat-122     [001] .....   111.193999: submit_bio_checks <-__submit_bio object:0xffff888102a4b900
> >              cat-122     [001] .....   111.193999: __cond_resched <-submit_bio_checks object:0xffff888102a4b900
> >              cat-122     [001] .....   111.193999: rcu_all_qs <-__cond_resched object:0xffff888102a4b900
> >              cat-122     [001] .....   111.194000: should_fail_bio <-submit_bio_checks object:0xffff888102a4b900
> >              cat-122     [001] .....   111.194001: blk_mq_submit_bio <-__submit_bio object:0xffff888102a4b900
> >              cat-122     [001] .....   111.194001: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888102a4b900
> >              cat-122     [001] .....   111.194001: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888102a4b900
> >              cat-122     [001] .....   111.194002: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888102a4b900
> >              cat-122     [001] .....   111.194002: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888102a4b900
> >              cat-122     [001] .....   111.194003: blk_account_io_start <-blk_mq_submit_bio object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194212: bio_advance <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194213: bio_endio <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194213: mpage_end_io <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194213: __read_end_io <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194218: bio_put <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194218: bio_free <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194218: bio_free <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194218: bvec_free <-bio_free object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194219: mempool_free <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194219: mempool_free <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194219: mempool_free_slab <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194219: mempool_free_slab <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194219: kmem_cache_free <-blk_update_request object:0xffff888102a4b900
> >           <idle>-0       [001] d....   111.194219: kmem_cache_free <-blk_update_request object:0xffff888102a4b900
> >
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > ---
> > So far, it can trace the object from kprobe/uprobe/syscall tracepoint
> > and now it doesn't yet support the count for objfilter.
> >
> >  include/linux/ftrace.h              |  16 +++
> >  include/linux/trace_events.h        |   1 +
> >  kernel/trace/Kconfig                |   7 +
> >  kernel/trace/Makefile               |   1 +
> >  kernel/trace/trace.h                |   7 +
> >  kernel/trace/trace_entries.h        |  17 +++
> >  kernel/trace/trace_events_trigger.c | 122 ++++++++++++++++++
> >  kernel/trace/trace_kprobe.c         |   1 +
> >  kernel/trace/trace_object.c         | 191 ++++++++++++++++++++++++++++
> >  kernel/trace/trace_output.c         |  40 ++++++
> >  kernel/trace/trace_syscalls.c       |   1 +
> >  kernel/trace/trace_uprobe.c         |   1 +
> >  12 files changed, 405 insertions(+)
> >  create mode 100644 kernel/trace/trace_object.c
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 832e65f06754..2d7e62bff6c5 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -1078,4 +1078,20 @@ unsigned long arch_syscall_addr(int nr);
> >
> >  #endif /* CONFIG_FTRACE_SYSCALLS */
> >
> > +struct trace_event_file;
> > +
> > +#ifdef CONFIG_TRACE_OBJECT
> > +int init_trace_object(void);
> > +int exit_trace_object(void);
> > +void set_trace_object(void *obj);
> > +void record_trace_object(struct trace_event_file *trace_file,
> > +             struct pt_regs *regs);
> > +#else
> > +static inline int init_trace_object(void) { return 0; }
> > +static inline int exit_trace_object(void) { return 0; }
> > +static inline void set_trace_object(void *obj) { }
> > +static inline void record_trace_object(struct trace_event_file *trace_file,
> > +             struct pt_regs *regs) { }
> > +#endif /* CONFIG_TRACE_OBJECT */
> > +
> >  #endif /* _LINUX_FTRACE_H */
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 3e475eeb5a99..f6dcaca9c3fe 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -684,6 +684,7 @@ enum event_trigger_type {
> >       ETT_EVENT_HIST          = (1 << 4),
> >       ETT_HIST_ENABLE         = (1 << 5),
> >       ETT_EVENT_EPROBE        = (1 << 6),
> > +     ETT_TRACE_OBJECT        = (1 << 7),
> >  };
> >
> >  extern int filter_match_preds(struct event_filter *filter, void *rec);
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 420ff4bc67fd..d302a0f085f9 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -237,6 +237,13 @@ config FUNCTION_PROFILER
> >
> >         If in doubt, say N.
> >
> > +config TRACE_OBJECT
> > +     bool "Trace kernel object"
> > +     depends on FUNCTION_TRACER
> > +     default y
> > +     help
> > +      This help kernel developer to trace any kernel object.
> > +
> >  config STACK_TRACER
> >       bool "Trace max stack"
> >       depends on HAVE_FUNCTION_TRACER
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index 6de5d4d63165..6d9e78a488aa 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -66,6 +66,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
> >  obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
> >  obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
> >  obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
> > +obj-$(CONFIG_TRACE_OBJECT) += trace_object.o
> >  ifeq ($(CONFIG_BLOCK),y)
> >  obj-$(CONFIG_EVENT_TRACING) += blktrace.o
> >  endif
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index b7c0f8e160fb..6ac8f5aca070 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -49,6 +49,7 @@ enum trace_type {
> >       TRACE_TIMERLAT,
> >       TRACE_RAW_DATA,
> >       TRACE_FUNC_REPEATS,
> > +     TRACE_OBJECT,
> >
> >       __TRACE_LAST_TYPE,
> >  };
> > @@ -460,6 +461,7 @@ extern void __ftrace_bad_type(void);
> >                         TRACE_GRAPH_RET);             \
> >               IF_ASSIGN(var, ent, struct func_repeats_entry,          \
> >                         TRACE_FUNC_REPEATS);                          \
> > +             IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
> >               __ftrace_bad_type();                                    \
> >       } while (0)
> >
> > @@ -1950,6 +1952,11 @@ struct trace_min_max_param {
> >       u64             *max;
> >  };
> >
> > +struct object_trigger_param {
> > +     struct pt_regs *regs;
> > +     int param;
> > +};
> > +
> >  #define U64_STR_SIZE         24      /* 20 digits max */
> >
> >  extern const struct file_operations trace_min_max_fops;
> > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > index cd41e863b51c..bb120d9498a9 100644
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
> >                __entry->context,
> >                __entry->timer_latency)
> >  );
> > +
> > +/*
> > + * trace object entry:
> > + */
> > +FTRACE_ENTRY(object, trace_object_entry,
> > +
> > +     TRACE_OBJECT,
> > +
> > +     F_STRUCT(
> > +             __field(        unsigned long,          ip              )
> > +             __field(        unsigned long,          parent_ip       )
> > +             __field(        unsigned long,          object          )
> > +     ),
> > +
> > +     F_printk(" %ps <-- %ps object:%lx\n",
> > +              (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> > +);
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> > index 3d5c07239a2a..d823854445e6 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
>
> OK, so you shouldn't be modifying this file.
>
> Look at how the histograms are done:
>
>  kernel/trace/trace_events_hist.c
>
> All your code should be in your trace_object.c file.
>
> Although, looking at the trace_events_hist.c file myself, I see a lot of
> duplicate code in event_hist_trigger_func() where we can add helper
> functions to handle that.
>
> But for now, just duplicate the code ;-)
>
> I added Tom to the Cc, so that he knows where he needs to clean up his code!
>
>
> > @@ -756,12 +756,36 @@ int set_trigger_filter(char *filter_str,
> >       struct event_filter *filter = NULL, *tmp;
> >       int ret = -EINVAL;
> >       char *s;
> > +     unsigned long param;
> > +     struct object_trigger_param *obj_param;
> > +     int len;
> >
> >       if (!filter_str) /* clear the current filter */
> >               goto assign;
> >
> >       s = strsep(&filter_str, " \t");
> >
> > +     if (data->cmd_ops->trigger_type == ETT_TRACE_OBJECT) {
> > +             obj_param = data->private_data;
> > +             len = str_has_prefix(s, "arg");
> > +             if (!len)
> > +                     goto out;
> > +             ret = kstrtoul(s + len, 10, &param);
> > +             if (ret || param == 0)
> > +                     goto out;
> > +             obj_param = kmalloc(sizeof(*obj_param), GFP_KERNEL);
> > +             if (!obj_param) {
> > +                     ret = -ENOMEM;
> > +                     goto out;
> > +             }
> > +             data->private_data = obj_param;
> > +             obj_param->param = param;
> > +             init_trace_object();
> > +     }
> > +     if (!strlen(s) || !filter_str)
> > +             goto out;
> > +
> > +     s = strsep(&filter_str, " \t");
> >       if (!strlen(s) || strcmp(s, "if") != 0)
> >               goto out;
> >
> > @@ -1679,6 +1703,103 @@ static __init int register_trigger_traceon_traceoff_cmds(void)
> >       return ret;
> >  }
> >
> > +#ifdef CONFIG_TRACE_OBJECT
> > +
> > +static void
> > +trace_object_trigger(struct event_trigger_data *data,
> > +                struct trace_buffer *buffer,  void *rec,
> > +                struct ring_buffer_event *event)
> > +{
> > +
> > +     struct object_trigger_param *obj_param = data->private_data;
> > +     unsigned long param;
> > +
> > +     param = regs_get_kernel_argument(obj_param->regs, obj_param->param - 1);
> > +     set_trace_object((void *)param);
> > +}
> > +
> > +static void
> > +trace_object_trigger_free(struct event_trigger_ops *ops,
> > +                struct event_trigger_data *data)
> > +{
> > +     if (WARN_ON_ONCE(data->ref <= 0))
> > +             return;
> > +
> > +     data->ref--;
> > +     if (!data->ref) {
> > +             exit_trace_object();
> > +             trigger_data_free(data);
> > +             kfree(data->private_data);
> > +     }
> > +}
> > +
> > +static void
> > +trace_object_count_trigger(struct event_trigger_data *data,
> > +                      struct trace_buffer *buffer, void *rec,
> > +                      struct ring_buffer_event *event)
> > +{
> > +     if (!data->count)
> > +             return;
> > +
> > +     if (data->count != -1)
> > +             (data->count)--;
> > +
> > +     trace_object_trigger(data, buffer, rec, event);
> > +}
> > +
> > +static int
> > +trace_object_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
> > +                      struct event_trigger_data *data)
> > +{
> > +     return event_trigger_print("objfilter", m, (void *)data->count,
> > +                                data->filter_str);
> > +}
> > +
> > +static struct event_trigger_ops objecttrace_trigger_ops = {
> > +     .func                   = trace_object_trigger,
> > +     .print                  = trace_object_trigger_print,
> > +     .init                   = event_trigger_init,
> > +     .free                   = trace_object_trigger_free,
> > +};
> > +
> > +static struct event_trigger_ops objecttrace_count_trigger_ops = {
> > +     .func                   = trace_object_count_trigger,
> > +     .print                  = trace_object_trigger_print,
> > +     .init                   = event_trigger_init,
> > +     .free                   = trace_object_trigger_free,
> > +};
> > +
> > +static struct event_trigger_ops *
> > +objecttrace_get_trigger_ops(char *cmd, char *param)
> > +{
> > +     return param ? &objecttrace_count_trigger_ops : &objecttrace_trigger_ops;
> > +}
> > +
> > +static struct event_command trigger_object_cmd = {
> > +     .name                   = "objfilter",
> > +     .trigger_type           = ETT_TRACE_OBJECT,
> > +     .flags                  = EVENT_CMD_FL_NEEDS_REC,
> > +     .func                   = event_trigger_callback,
> > +     .reg                    = register_trigger,
> > +     .unreg                  = unregister_trigger,
> > +     .get_trigger_ops        = objecttrace_get_trigger_ops,
> > +     .set_filter             = set_trigger_filter,
> > +};
> > +
> > +static __init int register_trigger_object_cmd(void)
> > +{
> > +     int ret;
> > +
> > +     ret = register_event_command(&trigger_object_cmd);
> > +     WARN_ON(ret < 0);
> > +
> > +     return ret;
> > +}
> > +
> > +#else
> > +static __init int register_trigger_object_cmd(void) { return 0; }
> > +#endif
>
> All the above should be in the trace_object.c file.
>
> In kernel/trace/trace.h you can add:
>
> #ifdef CONFIG_TRACE_OBJECT
> extern int register_trigger_object_cmd(void);
> #else
> static inline int register_trigger_object_cmd(void) { return 0; }
> #endif
>
> Just below where the CONFIG_HIST_TRIGGERS is.
>
> And make the above "register_trace_object_cmd()" not static.
>
>
> > +
> >  __init int register_trigger_cmds(void)
> >  {
> >       register_trigger_traceon_traceoff_cmds();
> > @@ -1687,6 +1808,7 @@ __init int register_trigger_cmds(void)
> >       register_trigger_enable_disable_cmds();
> >       register_trigger_hist_enable_disable_cmds();
> >       register_trigger_hist_cmd();
> > +     register_trigger_object_cmd();
> >
> >       return 0;
> >  }
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 3a64ba4bbad6..f80e86ff3d26 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1380,6 +1380,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
> >
> >       WARN_ON(call != trace_file->event_call);
> >
> > +     record_trace_object(trace_file, regs);
> >       if (trace_trigger_soft_disabled(trace_file))
> >               return;
> >
> > diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> > new file mode 100644
> > index 000000000000..33eef0a10809
> > --- /dev/null
> > +++ b/kernel/trace/trace_object.c
> > @@ -0,0 +1,191 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * trace any object
> > + * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
> > + */
> > +
> > +#define pr_fmt(fmt) "trace_object: " fmt
> > +
> > +#include "trace_output.h"
> > +
> > +static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);
> > +static DEFINE_RAW_SPINLOCK(object_spin_lock);
> > +static struct trace_event_file event_trace_file;
> > +static LIST_HEAD(obj_head);
> > +static const int max_args_num = 6;
> > +static unsigned long trace_object_ref;
> > +
> > +struct trace_obj {
> > +     struct list_head head;
> > +     unsigned long obj;
> > +};
> > +
> > +void set_trace_object(void *obj)
> > +{
> > +     struct trace_obj *trace_obj;
> > +     struct trace_obj *new_obj;
> > +     unsigned long flags;
> > +
> > +     if (!obj)
> > +             goto out;
> > +
> > +     list_for_each_entry_rcu(trace_obj, &obj_head, head) {
> > +             if (trace_obj->obj == (unsigned long)obj)
> > +                     goto out;
> > +     }
> > +
> > +     new_obj = kmalloc(sizeof(*new_obj), GFP_KERNEL);
> > +     if (!new_obj) {
> > +             pr_warn("allocate trace object fail\n");
>
> You shouldn't print because of allocation failure.
>
> But that doesn't matter, because you can't allocate here anyway. This is
> called from where the trace happens, and the kprobe could be inside the
> memory allocator, and if it is, you just deadlocked the machine.
>
> What you will need to do in this situation, is when the trigger is created,
> you need to allocate a pool of objects that you can get to. If that pool
> starts to fill up to some point, you will need to execute a work queue of
> some kind to add more objects to the pool.
>
> If you run out of objects before the pool can be refilled, then we can add
> a message to the ring buffer saying that happened.
>
> > +             goto out;
> > +     }
> > +
>
> The beginning of the function will have to have some kind of:
>
>         if (in_nmi())
>                 return;
>
> Because we can't grab locks in nmi, and I believe a kprobe can be attached
> to one.
>
> > +     raw_spin_lock_irqsave(&object_spin_lock, flags);
> > +
> > +     new_obj->obj = (unsigned long)obj;
> > +
> > +     list_add_rcu(&new_obj->head, &obj_head);
> > +
> > +     raw_spin_unlock_irqrestore(&object_spin_lock, flags);
> > +out:
> > +     return;
> > +}
> > +
> > +void record_trace_object(struct trace_event_file *trace_file,
> > +             struct pt_regs *regs)
> > +{
> > +
> > +     struct object_trigger_param *obj_param;
> > +     struct event_trigger_data *data;
> > +
> > +     list_for_each_entry_rcu(data, &trace_file->triggers, list) {
> > +             if (data->cmd_ops->trigger_type == ETT_TRACE_OBJECT) {
> > +                     obj_param = data->private_data;
> > +                     obj_param->regs = regs;
> > +             }
> > +     }
> > +
> > +}
> > +
> > +static inline void free_trace_object(void)
> > +{
> > +     struct trace_obj *trace_obj;
> > +
> > +     list_for_each_entry_rcu(trace_obj, &obj_head, head)
> > +             kfree(trace_obj);
> > +}
> > +
> > +static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> > +                              unsigned long object)
> > +{
> > +
> > +     struct trace_buffer *buffer;
> > +     struct ring_buffer_event *event;
> > +     struct trace_object_entry *entry;
> > +     int pc;
> > +
> > +     pc = preempt_count();
> > +     event = trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
> > +                     TRACE_OBJECT, sizeof(*entry), pc);
> > +     if (!event)
> > +             return;
> > +     entry   = ring_buffer_event_data(event);
> > +     entry->ip                       = ip;
> > +     entry->parent_ip                = parent_ip;
> > +     entry->object                   = object;
>
> So here we are just recording the value we saw at the kprobe (not very
> interesting).
>
> I think we want the content of the object:
>
>         long val;
>
>         ret = copy_from_kernel_nofault(&val, object, sizeof(val));
>         if (ret)
>                 val = 0;

This place is the only thing I don't understand, don't know  why and
where to use the copy_from_kernel_nofault.

we can only get the struct pt_regs from the  __kprobe_trace_fun() ,
and use it on the  trace_object_trigger() ,
so need to save the pt_regs using a struct:

struct object_trigger_param {
        struct pt_regs *regs;
        int param;
};

/* Kprobe handler */
static nokprobe_inline void __kprobe_trace_func(struct trace_kprobe
*tk, struct pt_regs *regs,
                    struct trace_event_file *trace_file)


static void trace_object_trigger(struct event_trigger_data *data,
struct trace_buffer *buffer,  void *rec,
                   struct ring_buffer_event *event)

> Then we can see what changed during this time.
>
> I think there's really a lot of potential here. Don't get discouraged,
> because kernel programming is not easy, and there's a lot you need to
> understand that is required knowledge in the kernel, but not a problem in
> user space.
>
> I'm happy to work with you to help you navigate through these waters. If
> you want to learn more about kernel programming, this is the perfect
> project to do so. I'll just let you know the pitfalls you make, so you
> learn from them and can correct them.
>
> Looking forward for updates from you ;-)
>
> -- Steve

I have spent all my free time on this these days and am very excited.

Now, it supports:  echo 'objfilter:arg1:1 if comm == "cat"' > ./trigger
and don't allocate memory in the kprobe context, using the way you suggested.

I will update this patch soon.

It is indeed a challenge for me, but life is like this, with
challenges, the world is wonderful.
and actually I want to be a good kernel programmer ;-)

Very thanks for your detailed guidance.

>
> > +
> > +     event_trigger_unlock_commit(&event_trace_file, buffer, event,
> > +             entry, pc);
> > +}
> > +
> > +static void
> > +trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> > +             struct ftrace_ops *op, struct ftrace_regs *fregs)
> > +{
> > +     struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> > +     unsigned long obj;
> > +     struct trace_obj *trace_obj;
> > +     long disabled;
> > +     int cpu, n;
> > +
> > +     preempt_disable_notrace();
> > +
> > +     cpu = raw_smp_processor_id();
> > +     disabled = atomic_inc_return(&per_cpu(trace_object_event_disable, cpu));
> > +
> > +     if (disabled != 1)
> > +             goto out;
> > +
> > +     if (list_empty(&obj_head))
> > +             goto out;
> > +
> > +     for (n = 0; n < max_args_num; n++) {
> > +             obj = regs_get_kernel_argument(pt_regs, n);
> > +             list_for_each_entry_rcu(trace_obj, &obj_head, head) {
> > +                     if (trace_obj->obj == (unsigned long)obj)
> > +                             submit_trace_object(ip, parent_ip, obj);
> > +             }
> > +     }
> > +
> > +out:
> > +     atomic_dec(&per_cpu(trace_object_event_disable, cpu));
> > +     preempt_enable_notrace();
> > +}
> > +
> > +static struct ftrace_ops trace_ops = {
> > +     .func  = trace_object_events_call,
> > +     .flags = FTRACE_OPS_FL_SAVE_REGS,
> > +};
> > +
> > +int init_trace_object(void)
> > +{
> > +     unsigned long flags;
> > +     int ret;
> > +
> > +     raw_spin_lock_irqsave(&object_spin_lock, flags);
> > +
> > +     if (++trace_object_ref != 1) {
> > +             ret = 0;
> > +             goto out_lock;
> > +     }
> > +
> > +     raw_spin_unlock_irqrestore(&object_spin_lock, flags);
> > +
> > +     event_trace_file.tr = top_trace_array();
> > +     if (WARN_ON(!event_trace_file.tr)) {
> > +             ret = -1;
> > +             goto out;
> > +     }
> > +     ret = register_ftrace_function(&trace_ops);
> > +
> > +     return ret;
> > +
> > +out_lock:
> > +     raw_spin_unlock_irqrestore(&object_spin_lock, flags);
> > +out:
> > +     return ret;
> > +}
> > +
> > +int exit_trace_object(void)
> > +{
> > +     int ret;
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&object_spin_lock, flags);
> > +
> > +     if (--trace_object_ref > 0) {
> > +             ret = 0;
> > +             goto out_lock;
> > +     }
> > +
> > +     raw_spin_unlock_irqrestore(&object_spin_lock, flags);
> > +
> > +     free_trace_object();
> > +     ret = unregister_ftrace_function(&trace_ops);
> > +
> > +     return ret;
> > +
> > +out_lock:
> > +     raw_spin_unlock_irqrestore(&object_spin_lock, flags);
> > +     return ret;
> > +}
> > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > index c2ca40e8595b..76ca560af693 100644
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -1552,6 +1552,45 @@ static struct trace_event trace_func_repeats_event = {
> >       .funcs          = &trace_func_repeats_funcs,
> >  };
> >
> > +/* TRACE_OBJECT */
> > +static enum print_line_t trace_object_print(struct trace_iterator *iter, int flags,
> > +                                     struct trace_event *event)
> > +{
> > +     struct trace_object_entry *field;
> > +     struct trace_seq *s = &iter->seq;
> > +
> > +     trace_assign_type(field, iter->ent);
> > +     print_fn_trace(s, field->ip, field->parent_ip, flags);
> > +     trace_seq_printf(s, " object:0x%lx", field->object);
> > +     trace_seq_putc(s, '\n');
> > +
> > +     return trace_handle_return(s);
> > +}
> > +
> > +static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags,
> > +                                   struct trace_event *event)
> > +{
> > +     struct trace_object_entry *field;
> > +
> > +     trace_assign_type(field, iter->ent);
> > +
> > +     trace_seq_printf(&iter->seq, "%lx %lx\n",
> > +                      field->ip,
> > +                      field->parent_ip);
> > +
> > +     return trace_handle_return(&iter->seq);
> > +}
> > +
> > +static struct trace_event_functions trace_object_funcs = {
> > +     .trace          = trace_object_print,
> > +     .raw            = trace_object_raw,
> > +};
> > +
> > +static struct trace_event trace_object_event = {
> > +     .type           = TRACE_OBJECT,
> > +     .funcs          = &trace_object_funcs,
> > +};
> > +
> >  static struct trace_event *events[] __initdata = {
> >       &trace_fn_event,
> >       &trace_ctx_event,
> > @@ -1566,6 +1605,7 @@ static struct trace_event *events[] __initdata = {
> >       &trace_timerlat_event,
> >       &trace_raw_data_event,
> >       &trace_func_repeats_event,
> > +     &trace_object_event,
> >       NULL
> >  };
> >
> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> > index 8bfcd3b09422..5d4b09996414 100644
> > --- a/kernel/trace/trace_syscalls.c
> > +++ b/kernel/trace/trace_syscalls.c
> > @@ -312,6 +312,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
> >       if (!trace_file)
> >               return;
> >
> > +     record_trace_object(trace_file, regs);
> >       if (trace_trigger_soft_disabled(trace_file))
> >               return;
> >
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 225ce569bf8f..3811c07b9fa3 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -960,6 +960,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
> >       if (WARN_ON_ONCE(tu->tp.size + dsize > PAGE_SIZE))
> >               return;
> >
> > +     record_trace_object(trace_file, regs);
> >       if (trace_trigger_soft_disabled(trace_file))
> >               return;
> >
>
--
JeffXie
