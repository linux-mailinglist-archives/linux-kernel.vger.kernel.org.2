Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9F443649
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 20:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhKBTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:12:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BF7C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 12:10:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f8so1141131edy.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUAN6NjFzyRpJlcQzxTcmkOxsucW2NmA7hRWMDgfEHw=;
        b=fs766u5JB5/imlZ39MKvF86A65yZhW0g5mX4azy+s518ZRwhlsCsFzwzhBCedHYFgJ
         AcObgdH17BYMhMP0qvsIJuuG8kB7Dg+DqdL9SGl0KqlTr0M1+P54lazdPA6CKblbnSfB
         7ddORTsAFts/15CyY2m/WUHuHIKAyCin9dCmLO1LhRn3cvvLhIFjkfKuuW1X0COFicxq
         2l4eXhafZBY7wVRsszLZBXlHFKYtRxzB8hwrAUHXPcRNJrgCqAIa2841nCLWsBG7Y23r
         grn8AiEF881HZ4auXClH95OBgMmWrP9G9gGRZQ92FLLvM08Dg5SoCmsjVbq6b/mdniRC
         n4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUAN6NjFzyRpJlcQzxTcmkOxsucW2NmA7hRWMDgfEHw=;
        b=Qk1/avHA8IhoodflOky+6+WJK2cdTm3TQCZRMHo3xGaJUhjNtC/GOeAPuJrq2f+tJ+
         iqJLWMX5uceeOF6yJ7Fqvwm9CPfUNdZRuLVXHdTJix0+NAY28A+NF8VCR8+45j/v6HPw
         NMebEW1PnTpzjXrm5MOeyzYubvGhNMo9RYHrT3ZqQU85PH2ImCHgjUnK9lw6eZO0Y6Jc
         K5OHKrkCXE55CgylpEw+/t1XZVNlFqC4wOH3db5FgD9dUEo8EzBRIr6RlnBlkFCn7cm6
         vFmoTa3C5275eUScPsec77nsXYDTDBVVmjZxPwBTrTsje3vyKZ4poM5nbgMbQVZdPr9a
         rM1g==
X-Gm-Message-State: AOAM533bAKBFKuVtjqplg98QJeDulX6WR2ILRxpqSxn11v374H1fhe8U
        IdpWzKVcOuTd2ZHdoPun2I1CyJS+uUHrVIKAx3BGOw==
X-Google-Smtp-Source: ABdhPJw/RWwQHnnMegvZWWgJS89gFslzFB4BsLpSSKtxnCPy6pxnQ4yYncsMaMLBA/KJpZ6ukbx/4acoJyjUne2lQGA=
X-Received: by 2002:a50:9d49:: with SMTP id j9mr52242955edk.39.1635880211097;
 Tue, 02 Nov 2021 12:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211101034147.6203-1-khuey@kylehuey.com> <877ddqabvs.fsf@disp2133>
 <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com> <87fsse8maf.fsf@disp2133>
In-Reply-To: <87fsse8maf.fsf@disp2133>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 2 Nov 2021 12:09:56 -0700
Message-ID: <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
Subject: Re: [PATCH] signal: SIGKILL can cause signal effects to appear at
 PTRACE_EVENT_EXIT without tracer notification
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@mariadb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 11:07 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Kyle Huey <me@kylehuey.com> writes:
>
> > On Tue, Nov 2, 2021 at 7:09 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Kyle Huey <me@kylehuey.com> writes:
> >>
> >> > rr, a userspace record and replay debugger[0], uses the recorded register
> >> > state at PTRACE_EVENT_EXIT to find the point in time at which to cease
> >> > executing the program during replay.
> >> >
> >> > If a SIGKILL races with processing another signal in get_signal, it is
> >> > possible for the kernel to decline to notify the tracer of the original
> >> > signal. But if the original signal had a handler, the kernel proceeds
> >> > with setting up a signal handler frame as if the tracer had chosen to
> >> > deliver the signal unmodified to the tracee. When the kernel goes to
> >> > execute the signal handler that it has now modified the stack and registers
> >> > for, it will discover the pending SIGKILL, and terminate the tracee
> >> > without executing the handler. When PTRACE_EVENT_EXIT is delivered to
> >> > the tracer, however, the effects of handler setup will be visible to
> >> > the tracer.
> >> >
> >> > Because rr (the tracer) was never notified of the signal, it is not aware
> >> > that a signal handler frame was set up and expects the state of the program
> >> > at PTRACE_EVENT_EXIT to be a state that will be reconstructed naturally
> >> > by allowing the program to execute from the last event. When that fails
> >> > to happen during replay, rr will assert and die.
> >> >
> >> > The following patches add an explicit check for a newly pending SIGKILL
> >> > after the ptracer has been notified and the siglock has been reacquired.
> >> > If this happens, we stop processing the current signal and proceed
> >> > immediately to handling the SIGKILL. This makes the state reported at
> >> > PTRACE_EVENT_EXIT the unmodified state of the program, and also avoids the
> >> > work to set up a signal handler frame that will never be used.
> >> >
> >> > This issue was originally reported by the credited rr user.
> >> >
> >> > [0] https://rr-project.org/
> >>
> >> If I read this correctly the problem is not precisely that the rr
> >> debugger is never notified about the signal, but rather that the program
> >> is killed with SIGKILL before rr can read the notification and see which
> >> signal it is.
> >
> > The precise problem is that the kernel made a modification to the
> > tracee state (setting up the signal handler frame) without telling the
> > tracer about it (delivering the ptrace notification for the pending
> > non-SIGKILL signal).
>
> Except the kernel did make it to ptrace_stop.  The stop just did not
> fully happen because of SIGKILL.  I expect SIGCHLD was sent to the
> tracer as part of that stop that never fully happened.

I don't know whether SIGCHLD was sent to the tracer (rr doesn't use it
directly) but waiting on the process does not produce a wait status
corresponding to the signal delivery stop for the original signal.
Waiting on the tracee skips immediately from whatever the preceding
ptrace event was to the PTRACE_EVENT_EXIT.

(In our particular case, if it had been notified of the signal, we
would have chosen to suppress the signal, because the signal in
question is a SIGSEGV from an rdtsc instruction that has been disabled
via prctl(PR_SET_TSC, PR_TSC_SIGSEGV) and we emulate it in the tracer
due to its non-deterministic behavior. So we really don't expect to
see the tracee signal handler.)

> > That can be fixed either by not modifying the
> > tracee state here or by telling the tracer about the signal (that will
> > never actually run). I suspect we'll all agree that the former seems
> > preferable.
> >
> >> This definitely sounds like a quality of implementation issue.
> >>
> >> The solution that is proposed in your patches simply drops the signal
> >> when SIGKILL is pending.
> >
> > That's right.
> >
> >> I think we can have a slightly better of quality of implementation
> >> than that (as well as a simpler implementation) by requeuing the
> >> signal instead of simply dropping it.  Something like the below.
> >
> > What is the benefit of requeueing the signal? All pending signals will
> > be dropped when the SIGKILL is processed, no?
>
> Not before PTRACE_EVENT_EXIT.  In fact the pending signals are not
> actually flushed until the thread or the entire process is reaped.
>
> Further the coredump code makes some attempt to write out the
> pending signals.  The code appears to predate siginfo support
> in the kernel so it misses a lot but it is there.
>
> The real advantage is that it keeps the logic of dealing with weird
> ptrace_stop logic in ptrace_signal where it belongs.  It also allows the
> common (and missing in this case) idiom of goto relock to be used.
>
> So I think changing ptrace_signal will be much more maintainable.

Ok.

> >> Can you test that and see if it works for you?
> >
> > It does not work. This triggers an infinite loop in get_signal, as we
> > dequeue the signal, attempt to notify the ptracer, see the pending
> > sigkill, requeue the signal, go around the loop, dequeue the original
> > signal ...
>
> Apologies I made a bit of a thinko.  That change also needs to change
> the handling of if (signr == 0) after ptrace_signal.
>
> Which means it would need to be something like the below.
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 056a107e3cbc..eddb745b34a7 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2610,7 +2610,8 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
>         }
>
>         /* If the (new) signal is now blocked, requeue it.  */
> -       if (sigismember(&current->blocked, signr)) {
> +       if (sigismember(&current->blocked, signr) ||
> +           signal_group_exit(current->signal)) {
>                 send_signal(signr, info, current, PIDTYPE_PID);
>                 signr = 0;
>         }
> @@ -2764,8 +2765,10 @@ bool get_signal(struct ksignal *ksig)
>                 if (unlikely(current->ptrace) && (signr != SIGKILL) &&
>                     !(sighand->action[signr -1].sa.sa_flags & SA_IMMUTABLE)) {
>                         signr = ptrace_signal(signr, &ksig->info);
> -                       if (!signr)
> -                               continue;
> +                       if (!signr) {
> +                               spin_unlock_irq(&sighand->siglock);
> +                               goto relock;
> +                       }
>                 }
>
>                 ka = &sighand->action[signr-1];
>
> Eric

Yeah that appears to fix the issue.

- Kyle
