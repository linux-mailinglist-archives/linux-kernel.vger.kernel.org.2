Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956B4309BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 13:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhAaL6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 06:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhAaK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:29:25 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A60FC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:28:45 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 19so13392799qkh.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKo6hWmrmqC7F16U7mMf06mWlIWvxjQU7OJAP6vComs=;
        b=Th3JAXV5yW9v1wq8EOPIhgACbrSJKi4kbI2Sx9TlQZR5YC0UWDhHD+RwqdyuQL70N7
         HvPrsNHWlJ11Z+ICilgPrOu7ouJ87VBg7tB1f+qvzteVNww2PdcYGMhCl38McBAtypZj
         q1mAN9E8twB9IZAq/NGytit1ObrDHF+NQfP4pJQpIXNEWphCp1vi1whEZ4MrrOipLNQ2
         nJGdT0kyYmf/AimUZKt+xcy2/na0MMl63o02sUBdc1hGXLf22lSElACCVo3IQc2HnBCE
         PO5dlI/lFSDdztL+bQY0tS8JrVIHF/1ycy1s7CNfTFf8fdrxDBlhsVBno8cInrUyf0eY
         7ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKo6hWmrmqC7F16U7mMf06mWlIWvxjQU7OJAP6vComs=;
        b=nYdB+no2sK1/Ze6WozwkiWI/11bEj6AVJkbKRpxpnm1bIzB2D3B7TVaJgjiKp+Aaep
         towL8FK5bWvObINFyOSnTDf95NABkG0BraH1qmEmJs7iinEq3xwI2kpWv5R0XKwFEMUr
         9qcmZ80B8wuUOGQHK/h9J6srqbj5XLMJC3xpA6K559W8656ErZCr7yPXCwJ9OPGJI+Bm
         VKkq1QREPJUGZj0o+pWWEZdd7jikyUGFCk69tFPuopQNAVKbXjr5YY1jNOlEXKI3sZzW
         5wj2hJTUyIcsiIaZ+cnKeS4R6g1b/yAGLz3FVXPmUrN6jX82ZDou+0QF/uokEx2mAVXT
         Fmsw==
X-Gm-Message-State: AOAM530F0NKKeueY0H/r3BFDxUf+hZwSrGg885Pp3luozN+UmV7vxOZL
        P+0m6gubHwfzIpZQcHAS+r7twQ7MxMm2kkbBVeNPRQ==
X-Google-Smtp-Source: ABdhPJxlUnWQEYnlFhqNuBOyVebIh4+3fcWFMsBqM0N5cU3a0V04VizmXJ40Rg3Y4B938LLa2Z4bjrqFKGfzRY2yc5w=
X-Received: by 2002:a05:620a:49:: with SMTP id t9mr11849421qkt.231.1612088924507;
 Sun, 31 Jan 2021 02:28:44 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net> <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
In-Reply-To: <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 31 Jan 2021 11:28:32 +0100
Message-ID: <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
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

On Sun, Jan 31, 2021 at 11:04 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Nov 12, 2020 at 11:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > for sampling race detection),
> > > > number of threads in the process can be up to, say, ~~10K and the
> > > > watchpoint is intended to be set for a very brief period of time
> > > > (~~few ms).
> > >
> > > Performance is a consideration here, doing lots of IPIs in such a short
> > > window, on potentially large machines is a DoS risk.
> > >
> > > > This can be done today with both perf_event_open and ptrace.
> > > > However, the problem is that both APIs work on a single thread level
> > > > (? perf_event_open can be inherited by children, but not for existing
> > > > siblings). So doing this would require iterating over, say, 10K
> > >
> > > One way would be to create the event before the process starts spawning
> > > threads and keeping it disabled. Then every thread will inherit it, but
> > > it'll be inactive.
> > >
> > > > I see at least one potential problem: what do we do if some sibling
> > > > thread already has all 4 watchpoints consumed?
> > >
> > > That would be immediately avoided by this, since it will have the
> > > watchpoint reserved per inheriting the event.
> > >
> > > Then you can do ioctl(PERF_EVENT_IOC_{MODIFY_ATTRIBUTES,ENABLE,DISABLE})
> > > to update the watch location and enable/disable it. This _will_ indeed
> > > result in a shitload of IPIs if the threads are active, but it should
> > > work.
> >
> > Aha! That's the possibility I missed.
> > We will try to prototype this and get back with more questions if/when
> > we have them.
> > Thanks!
>
> Hi Peter,
>
> I've tested this approach and it works, but only in half.
> PERF_EVENT_IOC_{ENABLE,DISABLE} work as advertised.
> However, PERF_EVENT_IOC_MODIFY_ATTRIBUTES does not work for inherited
> child events.
> Does something like this make any sense to you? Are you willing to
> accept such change?
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 55d18791a72d..f6974807a32c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3174,7 +3174,7 @@ int perf_event_refresh(struct perf_event *event,
> int refresh)
>  }
>  EXPORT_SYMBOL_GPL(perf_event_refresh);
>
> -static int perf_event_modify_breakpoint(struct perf_event *bp,
> +static int _perf_event_modify_breakpoint(struct perf_event *bp,
>                                          struct perf_event_attr *attr)
>  {
>         int err;
> @@ -3189,6 +3189,28 @@ static int perf_event_modify_breakpoint(struct
> perf_event *bp,
>         return err;
>  }
>
> +static int perf_event_modify_breakpoint(struct perf_event *bp,
> +                                       struct perf_event_attr *attr)
> +{
> +       struct perf_event *child;
> +       int err;
> +
> +       WARN_ON_ONCE(bp->ctx->parent_ctx);
> +
> +       mutex_lock(&bp->child_mutex);
> +       err = _perf_event_modify_breakpoint(bp, attr);
> +       if (err)
> +               goto unlock;
> +       list_for_each_entry(child, &bp->child_list, child_list) {
> +               err = _perf_event_modify_breakpoint(child, attr);
> +               if (err)
> +                       goto unlock;
> +       }
> +unlock:
> +       mutex_unlock(&bp->child_mutex);
> +       return err;
> +}
> +
>  static int perf_event_modify_attr(struct perf_event *event,
>                                   struct perf_event_attr *attr)


Not directly related to the above question, but related to my use case.
Could we extend bpf_perf_event_data with some more data re breakpoint events?

struct bpf_perf_event_data {
    bpf_user_pt_regs_t regs;
    __u64 sample_period;
    __u64 addr;
};

Ideally, I would like to have an actual access address, size and
read/write type (may not match bp addr/size). Is that info easily
available at the point of bpf hook call?
Or, if that's not available at least breakpoint bp_type/bp_size.

Is it correct that we can materialize in bpf_perf_event_data anything
that's available in bpf_perf_event_data_kern (if it makes sense in the
public interface of course)?

struct bpf_perf_event_data_kern {
    bpf_user_pt_regs_t *regs;
    struct perf_sample_data *data;
    struct perf_event *event;
};

Unfortunately I don't see perf_event_attr.bp_type/bp_size
stored/accessible anywhere in bpf_perf_event_data_kern. What would be
the right way to expose them in bpf_perf_event_data?

Thanks
