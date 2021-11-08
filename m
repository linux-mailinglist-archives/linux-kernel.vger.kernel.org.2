Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC5449F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 00:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbhKIAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhKIAB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:01:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BFFC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 15:58:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w1so69768444edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 15:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g80LO7wI/yHNssCPqawa9wLkApUMbxhvKXGgAtntilQ=;
        b=IfhJvM544UQkV2Si8VjL7Sya8UU6I2L8GZswJzJv4OB2WVJ6giH6EtCJyIIw4JRWP0
         xCH6aa0hy2JCyTepQNSY883ZP31pIYh37466SaXgfJ1gb6q0FdsNDMB/2LX69O7BaQKv
         4Goloj3+QFx0LDlphe0KM2+8l/C38gu4LwIuPqNsnqyT7+sbnbVqUnyAF1r98RmvEHzg
         1YnxLBS+sVslBAiAl+jLlRm5c8D6bTQORj9H2hkdDFvRWcy9wH4VmwSsWOY0mljcNliT
         8wbWNqYXQqPsmMByaWB+6240lbT7LufPX70e6WPSqcHdC8xQYg6ONP6C/Ci8HfsVbxKl
         BhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g80LO7wI/yHNssCPqawa9wLkApUMbxhvKXGgAtntilQ=;
        b=Lz/GTgomcogm+QdeGpSK7ghlCGiz9XU9Iy9C1NZribTHoqhmXlpHGDp9uEWw1zao19
         INC/WxY4jgUxSxbNLKCzW5VlyiVPtEuK/DDHVXlKAmAkoZkmLxEbL6pIwF9pQxshp8xr
         Y9DDPGxGu9OkVQKENqfCQZSZKzl7TVpHjff0I36Lo1GwKsPH5AE4wJq7h6hRPccLs2JU
         ZZFaC3rc0Q+f+D/T2f0mIjsVjqRULenQj0QgoojQ9QJZ/m2N1zREt2b+M/t2aKxEfb0L
         WAbAPBEo20voDjkPbvrbaDSgjGuGggh8M1CtSKNF4ZGyOR3i6DiZj+LiADQoR1qnb9/f
         qWZQ==
X-Gm-Message-State: AOAM530UtqFtYrL/1ybouuLyUy9jJ9jIZIJ70OtS2WGRhk6zajqVo4eF
        WD5b3sYH9UVtwtSMOVuzBtgiFrXC7AWaS9FZNqBC2w==
X-Google-Smtp-Source: ABdhPJwBA0NU4Rnpj7ejapZpsVSzbNKRiwaXRr5UKjw+/PeBJYfx+312QGeQDQbpXJG3jx7A/ofkvHTURg5mlKDFrHc=
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr4166316edb.80.1636415919626;
 Mon, 08 Nov 2021 15:58:39 -0800 (PST)
MIME-Version: 1.0
References: <20211101034147.6203-1-khuey@kylehuey.com> <877ddqabvs.fsf@disp2133>
 <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
 <87fsse8maf.fsf@disp2133> <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
In-Reply-To: <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 8 Nov 2021 15:58:21 -0800
Message-ID: <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 12:09 PM Kyle Huey <me@kylehuey.com> wrote:
>
> On Tue, Nov 2, 2021 at 11:07 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Kyle Huey <me@kylehuey.com> writes:
> >
> > > On Tue, Nov 2, 2021 at 7:09 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > >>
> > >> Kyle Huey <me@kylehuey.com> writes:
> > >>
> > >> > rr, a userspace record and replay debugger[0], uses the recorded register
> > >> > state at PTRACE_EVENT_EXIT to find the point in time at which to cease
> > >> > executing the program during replay.
> > >> >
> > >> > If a SIGKILL races with processing another signal in get_signal, it is
> > >> > possible for the kernel to decline to notify the tracer of the original
> > >> > signal. But if the original signal had a handler, the kernel proceeds
> > >> > with setting up a signal handler frame as if the tracer had chosen to
> > >> > deliver the signal unmodified to the tracee. When the kernel goes to
> > >> > execute the signal handler that it has now modified the stack and registers
> > >> > for, it will discover the pending SIGKILL, and terminate the tracee
> > >> > without executing the handler. When PTRACE_EVENT_EXIT is delivered to
> > >> > the tracer, however, the effects of handler setup will be visible to
> > >> > the tracer.
> > >> >
> > >> > Because rr (the tracer) was never notified of the signal, it is not aware
> > >> > that a signal handler frame was set up and expects the state of the program
> > >> > at PTRACE_EVENT_EXIT to be a state that will be reconstructed naturally
> > >> > by allowing the program to execute from the last event. When that fails
> > >> > to happen during replay, rr will assert and die.
> > >> >
> > >> > The following patches add an explicit check for a newly pending SIGKILL
> > >> > after the ptracer has been notified and the siglock has been reacquired.
> > >> > If this happens, we stop processing the current signal and proceed
> > >> > immediately to handling the SIGKILL. This makes the state reported at
> > >> > PTRACE_EVENT_EXIT the unmodified state of the program, and also avoids the
> > >> > work to set up a signal handler frame that will never be used.
> > >> >
> > >> > This issue was originally reported by the credited rr user.
> > >> >
> > >> > [0] https://rr-project.org/
> > >>
> > >> If I read this correctly the problem is not precisely that the rr
> > >> debugger is never notified about the signal, but rather that the program
> > >> is killed with SIGKILL before rr can read the notification and see which
> > >> signal it is.
> > >
> > > The precise problem is that the kernel made a modification to the
> > > tracee state (setting up the signal handler frame) without telling the
> > > tracer about it (delivering the ptrace notification for the pending
> > > non-SIGKILL signal).
> >
> > Except the kernel did make it to ptrace_stop.  The stop just did not
> > fully happen because of SIGKILL.  I expect SIGCHLD was sent to the
> > tracer as part of that stop that never fully happened.
>
> I don't know whether SIGCHLD was sent to the tracer (rr doesn't use it
> directly) but waiting on the process does not produce a wait status
> corresponding to the signal delivery stop for the original signal.
> Waiting on the tracee skips immediately from whatever the preceding
> ptrace event was to the PTRACE_EVENT_EXIT.
>
> (In our particular case, if it had been notified of the signal, we
> would have chosen to suppress the signal, because the signal in
> question is a SIGSEGV from an rdtsc instruction that has been disabled
> via prctl(PR_SET_TSC, PR_TSC_SIGSEGV) and we emulate it in the tracer
> due to its non-deterministic behavior. So we really don't expect to
> see the tracee signal handler.)
>
> > > That can be fixed either by not modifying the
> > > tracee state here or by telling the tracer about the signal (that will
> > > never actually run). I suspect we'll all agree that the former seems
> > > preferable.
> > >
> > >> This definitely sounds like a quality of implementation issue.
> > >>
> > >> The solution that is proposed in your patches simply drops the signal
> > >> when SIGKILL is pending.
> > >
> > > That's right.
> > >
> > >> I think we can have a slightly better of quality of implementation
> > >> than that (as well as a simpler implementation) by requeuing the
> > >> signal instead of simply dropping it.  Something like the below.
> > >
> > > What is the benefit of requeueing the signal? All pending signals will
> > > be dropped when the SIGKILL is processed, no?
> >
> > Not before PTRACE_EVENT_EXIT.  In fact the pending signals are not
> > actually flushed until the thread or the entire process is reaped.
> >
> > Further the coredump code makes some attempt to write out the
> > pending signals.  The code appears to predate siginfo support
> > in the kernel so it misses a lot but it is there.
> >
> > The real advantage is that it keeps the logic of dealing with weird
> > ptrace_stop logic in ptrace_signal where it belongs.  It also allows the
> > common (and missing in this case) idiom of goto relock to be used.
> >
> > So I think changing ptrace_signal will be much more maintainable.
>
> Ok.
>
> > >> Can you test that and see if it works for you?
> > >
> > > It does not work. This triggers an infinite loop in get_signal, as we
> > > dequeue the signal, attempt to notify the ptracer, see the pending
> > > sigkill, requeue the signal, go around the loop, dequeue the original
> > > signal ...
> >
> > Apologies I made a bit of a thinko.  That change also needs to change
> > the handling of if (signr == 0) after ptrace_signal.
> >
> > Which means it would need to be something like the below.
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 056a107e3cbc..eddb745b34a7 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2610,7 +2610,8 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
> >         }
> >
> >         /* If the (new) signal is now blocked, requeue it.  */
> > -       if (sigismember(&current->blocked, signr)) {
> > +       if (sigismember(&current->blocked, signr) ||
> > +           signal_group_exit(current->signal)) {
> >                 send_signal(signr, info, current, PIDTYPE_PID);
> >                 signr = 0;
> >         }
> > @@ -2764,8 +2765,10 @@ bool get_signal(struct ksignal *ksig)
> >                 if (unlikely(current->ptrace) && (signr != SIGKILL) &&
> >                     !(sighand->action[signr -1].sa.sa_flags & SA_IMMUTABLE)) {
> >                         signr = ptrace_signal(signr, &ksig->info);
> > -                       if (!signr)
> > -                               continue;
> > +                       if (!signr) {
> > +                               spin_unlock_irq(&sighand->siglock);
> > +                               goto relock;
> > +                       }
> >                 }
> >
> >                 ka = &sighand->action[signr-1];
> >
> > Eric
>
> Yeah that appears to fix the issue.
>
> - Kyle

Is there anything else I need to do here or are you going to take it from here?

- Kyle
