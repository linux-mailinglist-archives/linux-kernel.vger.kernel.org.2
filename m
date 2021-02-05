Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC5310BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBENUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBENSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:18:01 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817BEC061793
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:17:21 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so4325309pfk.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGl5QvDDHgC//J3R2heUd9zM8QAt0Urk2mqst+PqVFU=;
        b=FeLt7PpqB4su9mNu1d6Ht0TZItma/g79Lz9Iaeqjd643FTdOWA8msJhcaYL/TuEHqL
         cA0594D8Wt28lmNM6C10ea7ydMujLM3QIon0pKEKxDDRzTNnHRzxHCYXcCD6iEY5EmJk
         BSUqXRg+LLo6dJ3DxN2unD46TYAB4h5DH/Vv+c0rPN+kgW/r9AM3jkufXgVB7qcainBC
         M5kOmoy3AYn2xQXEw2HGiwa13MhGcaPG7BfFrxrCFg6912fGWEraJqGRXUhjqAV7J/RU
         1dfkwYSTUGH2A4uK/ZBnBj4DmnTKFny7YiMbl7/X/CxcseF86MqQflA1pg3okTtEfG3U
         bJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGl5QvDDHgC//J3R2heUd9zM8QAt0Urk2mqst+PqVFU=;
        b=rhJb93GtzXwWgHi5s2VDNRIX8JjEUfFQWhwQ1sVBTYwUNvXicEXWdkF9/Cfa6iiP8l
         A4fZuBHBLkAtb5jLJKlrjgeC3b5Y+Aj+8jgrf0k9c5cE2v7Ez2yYgae3dtOUFfuD7vFs
         gDlKvBfZQNx6AZ6Ms0MsY5MiRGSIZnbd9vTGu0KxFIKrAV0PkKcm8CSNuZ3ZFyMB1Qly
         KzfL/xcnYvmcxIkdQPraDfyOh9c4e4meaXHtdLpexs3GaL2wkpm2Gj5Z82vC7A6LLBRL
         pPHtbUCdi0PbdlMDd1h47RKnouZbMg/jrp6QZmJYUHjpQdVgO/PwaaPdadsos3zuk56T
         munQ==
X-Gm-Message-State: AOAM531S2A6zyoAdlxZTwwcIkLygHlma+EWixJvGM850up0kWTvDqw0q
        JhRGeIM2xsnlZLn7MP15VtjUrMuMU5VJs6VxnpavMy9C/UUeUA==
X-Google-Smtp-Source: ABdhPJz1QxBczGuGaV/g7gacpu3XqWOCUR+Anis0wamffT2pXgWuAhz0uQuyH0lPk2jjtHJyO609Nv1DO8EfYAHEHbI=
X-Received: by 2002:a63:de0e:: with SMTP id f14mr4215483pgg.273.1612531040985;
 Fri, 05 Feb 2021 05:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20210201102601.87168-1-songmuchun@bytedance.com> <YB0nggSa7a95UCIK@alley>
In-Reply-To: <YB0nggSa7a95UCIK@alley>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 5 Feb 2021 21:16:43 +0800
Message-ID: <CAMZfGtXwuk5dAruhQ7+fhP6nhrOC4zF1Ad07MS-FsyaTcCMSow@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] printk: fix deadlock when kernel panic
To:     Petr Mladek <pmladek@suse.com>
Cc:     sergey.senozhatsky@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        john.ogness@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 7:09 PM Petr Mladek <pmladek@suse.com> wrote:
>
> Hi,
>
> first, I am sorry for the late reply. I have been somehow distracted
> this week.
>
> On Mon 2021-02-01 18:26:01, Muchun Song wrote:
> > We found a deadlock bug on our server when the kernel panic. It can be
> > described in the following diagram.
> >
> > CPU0:                                         CPU1:
> > panic                                         rcu_dump_cpu_stacks
> >   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
> >     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
> >                                                     __printk_safe_flush
> >                                                       raw_spin_lock_irqsave(&read_lock)
> >     // send NMI to other processors
> >     apic_send_IPI_allbutself(NMI_VECTOR)
> >                                                         // NMI interrupt, dead loop
> >                                                         crash_nmi_callback
> >   printk_safe_flush_on_panic
> >     printk_safe_flush
> >       __printk_safe_flush
> >         // deal lock
> >         raw_spin_lock_irqsave(&read_lock)
>
> Great catch!
>
> >  kernel/printk/printk_safe.c | 58 ++++++++++++++++++++++++++-------------------
> >  1 file changed, 34 insertions(+), 24 deletions(-)
> >
> > diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> > index a0e6f746de6c..86d9fa74ac5c 100644
> > --- a/kernel/printk/printk_safe.c
> > +++ b/kernel/printk/printk_safe.c
> > @@ -174,30 +174,13 @@ static void report_message_lost(struct printk_safe_seq_buf *s)
> >               printk_deferred("Lost %d message(s)!\n", lost);
> >  }
> >
> > -/*
> > - * Flush data from the associated per-CPU buffer. The function
> > - * can be called either via IRQ work or independently.
> > - */
> > -static void __printk_safe_flush(struct irq_work *work)
> > +static void __printk_safe_flush_work(struct irq_work *work)
> >  {
> > -     static raw_spinlock_t read_lock =
> > -             __RAW_SPIN_LOCK_INITIALIZER(read_lock);
> >       struct printk_safe_seq_buf *s =
> >               container_of(work, struct printk_safe_seq_buf, work);
> > -     unsigned long flags;
> >       size_t len;
> > -     int i;
> > +     int i = 0;
> >
> > -     /*
> > -      * The lock has two functions. First, one reader has to flush all
> > -      * available message to make the lockless synchronization with
> > -      * writers easier. Second, we do not want to mix messages from
> > -      * different CPUs. This is especially important when printing
> > -      * a backtrace.
> > -      */
> > -     raw_spin_lock_irqsave(&read_lock, flags);
> > -
> > -     i = 0;
> >  more:
> >       len = atomic_read(&s->len);
> >
> > @@ -232,6 +215,26 @@ static void __printk_safe_flush(struct irq_work *work)
> >
> >  out:
> >       report_message_lost(s);
> > +}
> > +
> > +/*
> > + * Flush data from the associated per-CPU buffer. The function
> > + * can be called either via IRQ work or independently.
> > + */
> > +static void printk_safe_flush_work(struct irq_work *work)
> > +{
> > +     unsigned long flags;
> > +     static DEFINE_RAW_SPINLOCK(read_lock);
> > +
> > +     /*
> > +      * The lock has two functions. First, one reader has to flush all
> > +      * available message to make the lockless synchronization with
> > +      * writers easier. Second, we do not want to mix messages from
> > +      * different CPUs. This is especially important when printing
> > +      * a backtrace.
> > +      */
> > +     raw_spin_lock_irqsave(&read_lock, flags);
> > +     __printk_safe_flush_work(work);
> >       raw_spin_unlock_irqrestore(&read_lock, flags);
> >  }
> >
> > @@ -248,9 +251,9 @@ void printk_safe_flush(void)
> >
> >       for_each_possible_cpu(cpu) {
> >  #ifdef CONFIG_PRINTK_NMI
> > -             __printk_safe_flush(&per_cpu(nmi_print_seq, cpu).work);
> > +             printk_safe_flush_work(&per_cpu(nmi_print_seq, cpu).work);
> >  #endif
> > -             __printk_safe_flush(&per_cpu(safe_print_seq, cpu).work);
> > +             printk_safe_flush_work(&per_cpu(safe_print_seq, cpu).work);
> >       }
> >  }
> >
> > @@ -266,6 +269,8 @@ void printk_safe_flush(void)
> >   */
> >  void printk_safe_flush_on_panic(void)
> >  {
> > +     int cpu;
> > +
> >       /*
> >        * Make sure that we could access the main ring buffer.
> >        * Do not risk a double release when more CPUs are up.
> > @@ -278,7 +283,12 @@ void printk_safe_flush_on_panic(void)
> >               raw_spin_lock_init(&logbuf_lock);
> >       }
> >
> > -     printk_safe_flush();
> > +     for_each_possible_cpu(cpu) {
> > +#ifdef CONFIG_PRINTK_NMI
> > +             __printk_safe_flush_work(&per_cpu(nmi_print_seq, cpu).work);
> > +#endif
> > +             __printk_safe_flush_work(&per_cpu(safe_print_seq, cpu).work);
> > +     }
>
> There might be two CPUs running this code when more CPUs are still running.
> The might definitely be the case here:
>
>         if (!_crash_kexec_post_notifiers) {
>                 printk_safe_flush_on_panic();
>                 __crash_kexec(NULL);
>
> __printk_safe_flush_work() is relatively safe even in this case.
> It accesses only data that are limited by s->len that is updated
> atomically.
>
> But it calls:
>
>   + printk_safe_flush_on_panic()
>     + __printk_safe_flush_work()
>       +  printk_safe_flush_buffer()
>         + printk_safe_flush_line()
>           + printk_deferred()
>
> where printk_deferred() used logbuf_lock() until v5.11-rc1, see
> the commit b031a684bfd01d633c ("printk: remove logbuf_lock
> writer-protection of ringbuffer").
>
> We need a solution that might be backported back to v4.7-rc1
> where logbuf_lock() might cause a deadlock.

Agree.

>
> Also we really want to call printk_safe_flush_on_panic()
> in panic(). It is trying hard but it should not cause
> deadlock.
>
> Therefore, I suggest to handle read_lock the same way in
> printk_safe_flush_on_panic() as we handle logbuf_lock there.
>
> I mean to make it global in printk_safe.c:
>
> static DEFINE_RAW_SPINLOCK(safe_read_lock);
>
> and do something like this in printk_safe_flush_on_panic()
>
>         if (raw_spin_is_locked(&safe_read_lock)) {
>                 if (num_online_cpus() > 1)
>                         return;
>
>                 debug_locks_off();
>                 raw_spin_lock_init(&safe_read_lock);
>         }
>
> How does that sound, please?

Great. It is also a solution. It seems simple. I will do this.
Thanks.

>
> Best Regards,
> Petr
