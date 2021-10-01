Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36B41EDE9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhJAM5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhJAM53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:57:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75367C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 05:55:45 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n64so11347888oih.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/AsC9gcA0XJYYcAhr4WuFM8I+wFJ70cZAqi3ig1sGiA=;
        b=HMEBWtnYLt6yISbEs4Q2Cwz1m3UQ1yulNvJ0hhpfERgJvtdLzIh9+EDAk3UocHZhDw
         +zxT3mO1C/LFAzlH8Ndvye/XMNFjGM5/UWXaBl2Ix17uXm65Of7eZtFk9/wF7S0F3hHT
         oVtdO4ywSBRBOP+7FYWCVaDdE36KJy7GUxqWAX/Ti4HZlw8bfD81t1vO20Q0K6ZhPdk9
         7EijYtT2HxV/tSyl21XiAmdNDtGgLYgW8oowAbvJYtWf8CNC1mCwrKV/XXiUKvubFpVg
         5dJRkd8VAvhj0WowVcz6SA4nXqmhVa+TovbEnklwBrIH9ojZBF+t5OKbORYUTVtqibtq
         JAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/AsC9gcA0XJYYcAhr4WuFM8I+wFJ70cZAqi3ig1sGiA=;
        b=7SIUkTKfQu74e5fq2FKTNSFtmxwjM9pwl8b6YQa3C5nwTV9h9qv30WahLbc4uDt2iH
         +YcIKrbZ+9TRvEDbDH2CauqVl1bjrhqxw1CqPih9hgD6jPs+lqqywpIg39V/BPU6fU+R
         kgEBKC+6RiFZZibT5IuzNelVdIhtlhqyoLcwzIkT+c8nLX1VE4/pz4WG0nit7z5yUP+o
         XLm2Pg+T6p4F1AP/Ezap4l+L7anvytW8h13CX2JPvI2foMSQPlO0kFWn7GdsDsR+Q6b5
         vEZKP5RjDozVNWARQe6rzOd9lef4Ptd4xEY7vero6naaIcR9cDQwy0ELwBraHEhGSMbs
         5CEw==
X-Gm-Message-State: AOAM533MtXdgvt2krbEili4FB8iYX1of+Ff/Q5VoKCqQFpJ5VYOlZiwD
        pdIhPAUXu/6XUHcd7nTFPVqcCcOJPqjjadZhkTpS4Q==
X-Google-Smtp-Source: ABdhPJygP7v+PRffHzXphUuOnN9ZUMARt4j5LSx+5wlRW/HRRgSzprzdwAptSS4dz+u7zDMbH+qHGrPh8RkgGOWupWc=
X-Received: by 2002:aca:f189:: with SMTP id p131mr3753772oih.128.1633092944540;
 Fri, 01 Oct 2021 05:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+bgzorbDgYw=cguZ4WuZeLbqsdyKUeGiyQq3Vo9jyjs6Q@mail.gmail.com>
 <YVXCzW+JHvClGG76@hirez.programming.kicks-ass.net>
In-Reply-To: <YVXCzW+JHvClGG76@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Oct 2021 14:55:33 +0200
Message-ID: <CACT4Y+aJJPhDKB51U3d=Jq5HLAupsP+giNKqi67jgpXoPg=4oQ@mail.gmail.com>
Subject: Re: rseq with syscall as the last instruction
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sept 2021 at 16:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Sep 28, 2021 at 11:09:24AM +0200, Dmitry Vyukov wrote:
> > Hi rseq maintainers,
> >
> > I wonder if rseq can be used in the following scenario (or extended to be used).
> > I want to pass extra arguments to syscalls using a kind of
> > side-channel, for example, to say "do fault injection for the next
> > system call", or "trace the next system call". But what is "next"
> > system call should be atomic with respect to signals.
> > Let's say there is shared per-task memory location known to the kernel
> > where these arguments can be stored:
> >
> > __thread struct trace_descriptor desk;
> > prctl(REGISTER_PER_TASK_TRACE_DESCRIPTOR, &desk);
> >
> > then before a system call I can setup the descriptor to enable tracing:
> >
> > desk = ...
> > SYSCALL;
> >
> > The problem is that if a signal arrives in between we setup desk and
> > SYSCALL instruction, we will actually trace some unrelated syscall in
> > the signal handler.
> > Potentially the kernel could switch/restore 'desk' around syscall
> > delivery, but it becomes tricky/impossible for signal handlers that do
> > longjmp or mess with PC in other ways; and also would require
> > extending ucontext to include the desc information (not sure if it's
> > feasible).
> >
> > So instead the idea is to protect this sequence with rseq that will be
> > restarted on signal delivery:
> >
> > enter rseq critical section with end right after SYSCALL instruction;
> > desk = ...
> > SYSCALL;
> >
> > Then, the kernel can simply clear 'desc', on syscall delivery.
> >
> > rseq docs seem to suggest that this can work:
> >
> > https://lwn.net/Articles/774098/
> > +Restartable sequences are atomic with respect to preemption (making it
> > +atomic with respect to other threads running on the same CPU), as well
> > +as signal delivery (user-space execution contexts nested over the same
> > +thread). They either complete atomically with respect to preemption on
> > +the current CPU and signal delivery, or they are aborted.
> >
> > But the doc also says that the sequence must not do syscalls:
> >
> > +Restartable sequences must not perform system calls. Doing so may result
> > +in termination of the process by a segmentation fault.
> >
> > The question is:
> > Can this restriction be weakened to allow syscalls as the last instruction?
> > For flags in this case we would pass
> > RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT and
> > RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE, but no
> > RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL.
> >
> > I don't see any fundamental reasons why this couldn't work b/c if we
> > restart only on signals, then once we reach the syscall, rseq critical
> > section is committed, right?
> >
> > Do you have any feeling of how hard it would be to support or if there
> > can be some implementation issues?
>
> IIRC the only enforcement of this constraint is rseq_syscall() (which is
> a NOP when !CONFIG_DEBUG_RSEQ, because performance).
>
> However, since we use regs->ip, which for SYSCALL points to right
> *after* the SYSCALL instruction (for obvious reasons), it will not in
> fact match in_rseq_cs().
>
> And as such, I think your scheme should just work as is. Did you try?

Well, no, I did not try (wasn't sure how to interpret results).
Thanks, we will consider this option as well then.
