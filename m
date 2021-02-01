Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854BF30A391
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhBAIvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhBAIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:51:13 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B294C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 00:50:33 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id a19so15514611qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 00:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSBocjFB8ge5e5jPAMsyWKRhZbTb68NknA1isWn8UtE=;
        b=pUa4Y0wWpyJb4XG7Z41deXyOPcPT3c0csx5oUwHbbKUUyQdzCpogvBqr3VNSkFyHTP
         x1vhD7kYGTvfbF8XtPUgOh7cvNMFaIEGATHyAvcgAT5M5hRarF3Q3CB9Rw4yNUISu/MF
         Sg0D4ntJetCPXxS0tEbnRLq/e7gulyXWWYTyfpX8iSZOmUdEue86kBdQW0MvAqbraRxb
         2ZP6WvN72zASPapNSCusDhZ65Ruh4NbbdvHgTTIZgi05JWH2IGcgKl8TZHa7m0WWHsK8
         u8uVdZ5jpkXyj3kAdOm2IVcxQTP0pvbfkEfjJOZzD+zyQBXHGCzR2kaH/g+Dk1qmCGez
         7uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSBocjFB8ge5e5jPAMsyWKRhZbTb68NknA1isWn8UtE=;
        b=QALqcXK/C+pdqWFpsLSd3Gy4Cn4HYtXdmBGHLXKgyUoWrqvLPI595TI5XyS7EyERWv
         8jBZx3SeRZNmdDhfGSOfYK9J2RzhT1Tr4cSRi/DqnhvJJnx0h5FF9FQROHRUN2CRgx1V
         H1OOh2sHiFB+UdVn2LRH0NTxXZyjQPrkh3/zB7LvEedkCSrD91mqFKu8zVU0rQpNHGNo
         lywswzOcwYffnHqUJI2EAM7khH2+85Lb0JgG0jVDNEZgt65h9k5ITkC2bJazztwoouSP
         RQKaxPy39YINBEGrRuK+SztdbCOTULvSWmxFvUBqO/OYrYltruc+hyMAgS01uZuYMXnR
         PVCw==
X-Gm-Message-State: AOAM5322bGh3TZULIuT1Y7neWqBGzGSo5RFWOKRKp3RXOUkaJ2XxytCQ
        0UwBkAYTl+uxQezhhjYYr2KQ4+qFI+3bz2xzKlDAaA==
X-Google-Smtp-Source: ABdhPJyRrKPTM4FMrBpwEsc97tjj5Pd/n4h/Q5cc+YSg5kldA7bTjJ5o4FSOao/kw8mDH503MQxNzNRUBRC2E1TLZyE=
X-Received: by 2002:a37:2716:: with SMTP id n22mr15319254qkn.265.1612169431923;
 Mon, 01 Feb 2021 00:50:31 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net> <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com> <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
In-Reply-To: <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 1 Feb 2021 09:50:20 +0100
Message-ID: <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
Subject: Re: Process-wide watchpoints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 11:28 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sun, Jan 31, 2021 at 11:04 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Nov 12, 2020 at 11:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > for sampling race detection),
> > > > > number of threads in the process can be up to, say, ~~10K and the
> > > > > watchpoint is intended to be set for a very brief period of time
> > > > > (~~few ms).
> > > >
> > > > Performance is a consideration here, doing lots of IPIs in such a short
> > > > window, on potentially large machines is a DoS risk.
> > > >
> > > > > This can be done today with both perf_event_open and ptrace.
> > > > > However, the problem is that both APIs work on a single thread level
> > > > > (? perf_event_open can be inherited by children, but not for existing
> > > > > siblings). So doing this would require iterating over, say, 10K
> > > >
> > > > One way would be to create the event before the process starts spawning
> > > > threads and keeping it disabled. Then every thread will inherit it, but
> > > > it'll be inactive.
> > > >
> > > > > I see at least one potential problem: what do we do if some sibling
> > > > > thread already has all 4 watchpoints consumed?
> > > >
> > > > That would be immediately avoided by this, since it will have the
> > > > watchpoint reserved per inheriting the event.
> > > >
> > > > Then you can do ioctl(PERF_EVENT_IOC_{MODIFY_ATTRIBUTES,ENABLE,DISABLE})
> > > > to update the watch location and enable/disable it. This _will_ indeed
> > > > result in a shitload of IPIs if the threads are active, but it should
> > > > work.
> > >
> > > Aha! That's the possibility I missed.
> > > We will try to prototype this and get back with more questions if/when
> > > we have them.
> > > Thanks!
> >
> > Hi Peter,
> >
> > I've tested this approach and it works, but only in half.
> > PERF_EVENT_IOC_{ENABLE,DISABLE} work as advertised.
> > However, PERF_EVENT_IOC_MODIFY_ATTRIBUTES does not work for inherited
> > child events.
> > Does something like this make any sense to you? Are you willing to
> > accept such change?
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 55d18791a72d..f6974807a32c 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3174,7 +3174,7 @@ int perf_event_refresh(struct perf_event *event,
> > int refresh)
> >  }
> >  EXPORT_SYMBOL_GPL(perf_event_refresh);
> >
> > -static int perf_event_modify_breakpoint(struct perf_event *bp,
> > +static int _perf_event_modify_breakpoint(struct perf_event *bp,
> >                                          struct perf_event_attr *attr)
> >  {
> >         int err;
> > @@ -3189,6 +3189,28 @@ static int perf_event_modify_breakpoint(struct
> > perf_event *bp,
> >         return err;
> >  }
> >
> > +static int perf_event_modify_breakpoint(struct perf_event *bp,
> > +                                       struct perf_event_attr *attr)
> > +{
> > +       struct perf_event *child;
> > +       int err;
> > +
> > +       WARN_ON_ONCE(bp->ctx->parent_ctx);
> > +
> > +       mutex_lock(&bp->child_mutex);
> > +       err = _perf_event_modify_breakpoint(bp, attr);
> > +       if (err)
> > +               goto unlock;
> > +       list_for_each_entry(child, &bp->child_list, child_list) {
> > +               err = _perf_event_modify_breakpoint(child, attr);
> > +               if (err)
> > +                       goto unlock;
> > +       }
> > +unlock:
> > +       mutex_unlock(&bp->child_mutex);
> > +       return err;
> > +}
> > +
> >  static int perf_event_modify_attr(struct perf_event *event,
> >                                   struct perf_event_attr *attr)
>
>
> Not directly related to the above question, but related to my use case.
> Could we extend bpf_perf_event_data with some more data re breakpoint events?
>
> struct bpf_perf_event_data {
>     bpf_user_pt_regs_t regs;
>     __u64 sample_period;
>     __u64 addr;
> };
>
> Ideally, I would like to have an actual access address, size and
> read/write type (may not match bp addr/size). Is that info easily
> available at the point of bpf hook call?
> Or, if that's not available at least breakpoint bp_type/bp_size.
>
> Is it correct that we can materialize in bpf_perf_event_data anything
> that's available in bpf_perf_event_data_kern (if it makes sense in the
> public interface of course)?
>
> struct bpf_perf_event_data_kern {
>     bpf_user_pt_regs_t *regs;
>     struct perf_sample_data *data;
>     struct perf_event *event;
> };
>
> Unfortunately I don't see perf_event_attr.bp_type/bp_size
> stored/accessible anywhere in bpf_perf_event_data_kern. What would be
> the right way to expose them in bpf_perf_event_data?

Or, alternatively would it be reasonable for perf to generate SIGTRAP
directly on watchpoint hit (like ptrace does)? That's what I am
ultimately trying to do by attaching a bpf program.
