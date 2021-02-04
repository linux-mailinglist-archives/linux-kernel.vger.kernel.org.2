Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D763A30F401
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhBDNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbhBDNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:38:15 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF91EC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:37:33 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id r77so3203473qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3ZkQWsxg3aFYMXeKp6mu4ADWU76FLvBpJNuDV6H2cs=;
        b=bzvy8OMMpnldBw3JqxMuMaAuCUfpmTwsm2yfJLsyusUDfWbOaMA/3mQhf2O/ZWMjDk
         RmpuL3V9q2jcFmfbvKbO1XIq5Uxo+HwVuBQf6hnXdeiXy4jKaL5aJmMRpy1LVC5pXEJD
         dIft5Y8NJlhDknjSWfwvRpaDCkGQ5A0t2VV8bRRe78WmHzXU58lbvDs91CxAR6n25r6d
         stFyt1t9EVvcIwHkwtIUtUsWKX/Lx4cWdbLiwlUYNAjRFTSM4EtMFhkMPxQ387hmmQsw
         0FhxDZW5rgzW0L7+byD+k/e8KknUhndxeFi7L1NxGAvDqxJkqVufSrwCNWgL/RDaZMLn
         NvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3ZkQWsxg3aFYMXeKp6mu4ADWU76FLvBpJNuDV6H2cs=;
        b=p0Oi0nnxbsDUW+lPa17A13xFksy/3c91LkG/qvHnbx/+6YpU1+dkTbqVLZaJCGnGw6
         FcDcgFO2qy9CO9tl3gIddc4B5Yqbc+BGY674W9Odm/OECztstEINqZPsoUuunPaKrcME
         Xikjnps5AUoKi9WX2DN7Wja0MLqdH+bOooLfTT7vgVz/Gm4zFSiX5dpWl8MiSllk2ZPO
         9dyFKOtUC7MnkeCV0HniFpb5gX098YlX10ALGsRKjC62UImTwf2PAsfibPCwjtFKP589
         Cdr3WtCfWLGwu3iRwnXaL28pKujzOp0ZD0KP2VwevaeXf6a0Mwia+6yYedPxaOre/LbQ
         w2uw==
X-Gm-Message-State: AOAM532U13aGB100BQbHGHncz/4Vrjx46NT+9vYr9vS+C0NUw3x2Uc8v
        zdh4qzolGDClWg+SxQC/6+zYYUFV+XenKLIaHbp4gA==
X-Google-Smtp-Source: ABdhPJygk3C1h9Qf1j4zpB6DJXi8B9cZOo8l3AQWm3wGUrBkmgpz+FuXljmdTmsuR67qcjJIjoJHI32MNp0FhhHQOJY=
X-Received: by 2002:a05:620a:711:: with SMTP id 17mr7251292qkc.501.1612445852814;
 Thu, 04 Feb 2021 05:37:32 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net> <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net> <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net> <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
 <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net> <CACT4Y+a17L2pUY1kkRB_v_y3P_sbMpSLb6rVfXmGM7LkbAvj5Q@mail.gmail.com>
 <YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net>
In-Reply-To: <YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Feb 2021 14:37:21 +0100
Message-ID: <CACT4Y+Z+7zGD4_d-snEMLTin1a0C-yYQGKc0n+E6y7dBzY-OgQ@mail.gmail.com>
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

On Thu, Feb 4, 2021 at 2:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 04, 2021 at 01:53:59PM +0100, Dmitry Vyukov wrote:
> > On Thu, Feb 4, 2021 at 1:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > What do we do then? The advantage of IOC_REFRESH is that it disables the
> > > event until it gets explicitly re-armed, avoiding recursion issues etc.
> > > Do you want those semantics? If so, we'd need to have IOC_REFRESH find
> > > the actual event for the current task, which should be doable I suppose.
> >
> > Frankly, I don't know. I didn't use it in my prototype, nor I fully
> > understand what it's doing. Does it make sense for breakpoints?
> > I see IOC_REFRESH has a check for !attr.inherit, so it will fail for
> > my use case currently. I would say we just leave it as is for now.
>
> Well, the way it works is that currently you set event_limit > 0. Then
> each event will decrement, when we hit 0 we disable and raise a signal.
>
> REFRESH will increment event_limit and re-enable.
>
> This means you're guaranteed not to get another signal until you're
> ready for it. It allows leaving the signal handler context to handle the
> signal.
>
> I suppose you're looking for something like this, which goes in top of
> that thread_only thing.
>
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -389,7 +389,8 @@ struct perf_event_attr {
>                                 cgroup         :  1, /* include cgroup events */
>                                 text_poke      :  1, /* include text poke events */
>                                 thread_only    :  1, /* only inherit on threads */
> -                               __reserved_1   : 29;
> +                               sigtrap        :  1, /* foo */
> +                               __reserved_1   : 28;
>
>         union {
>                 __u32           wakeup_events;    /* wakeup every n events */
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6273,6 +6273,13 @@ static void perf_pending_event_disable(s
>
>         if (cpu == smp_processor_id()) {
>                 WRITE_ONCE(event->pending_disable, -1);
> +
> +               if (event->attr.sigtrap) {
> +                       atomic_inc(&event->event_limit); /* rearm */
> +                       send_sig_info(SIGTRAP, SEND_SIG_PRIV, current);
> +                       return;
> +               }
> +
>                 perf_event_disable_local(event);
>                 return;
>         }
> @@ -8936,6 +8943,7 @@ static int __perf_event_overflow(struct
>                                    int throttle, struct perf_sample_data *data,
>                                    struct pt_regs *regs)
>  {
> +       perf_overflow_handler_t ovf;
>         int events = atomic_read(&event->event_limit);
>         int ret = 0;
>
> @@ -8961,7 +8969,15 @@ static int __perf_event_overflow(struct
>                 perf_event_disable_inatomic(event);
>         }
>
> -       READ_ONCE(event->overflow_handler)(event, data, regs);
> +       ovf = READ_ONCE(event->overflow_handler);
> +#ifdef CONFIG_RETPOLINE
> +       if (ovf == perf_event_output_forward) {
> +               perf_event_output_forward(event, data, regs);
> +       } else if (ovf == perf_event_output_backward) {
> +               perf_event_output_backward(event, data, regs);
> +       } else
> +#endif
> +               ovf(event, data, regs);
>
>         if (*perf_event_fasync(event) && event->pending_kill) {
>                 event->pending_wakeup = 1;
> @@ -11281,6 +11297,9 @@ perf_event_alloc(struct perf_event_attr
>
>         event->state            = PERF_EVENT_STATE_INACTIVE;
>
> +       if (event->attr.sigtrap)
> +               event->event_limit = ATOMIC_INIT(1);
> +
>         if (task) {
>                 event->attach_state = PERF_ATTACH_TASK;
>                 /*
> @@ -11556,6 +11575,9 @@ static int perf_copy_attr(struct perf_ev
>         if (attr->thread_only && !attr->inherit)
>                 return -EINVAL;
>
> +       if (attr->sigtrap && attr->inherit && !attr->thread_only)
> +               return -EINVAL;
> +
>  out:
>         return ret;


Thanks. Let me see if this will work for us and test.
