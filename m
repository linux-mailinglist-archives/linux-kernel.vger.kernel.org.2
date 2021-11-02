Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B20D44327D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhKBQIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhKBQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:04:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2EFC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:01:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ee33so6807340edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agEg3yR2EHtB3USVNLWuj0pxKoD4uaEXVmbjvi+Z3Fg=;
        b=OP1NZ1dY1ZKmBKNTamwnHEvd3PcxefTSJ+udknOEzwQ0zxLuveT+qBcHLzBWF//qKo
         7o0ol8tNgz08NZFvUa1Z6HPRKEc0oRjwdtAeTwa3IY3wio3Nfh7PcqP6Ok09MLO9VsTH
         33WyraL3qNvPTcXLgT+iCMLwfdfivLia9YBBfG7zB0QJFej4iHOHWCZ3vVNF40oZAbOi
         886lI3tfPLu4tFSAh1EKIsP9WUgDms5+pyW30qduQvre27Ul2fuLCGJ0fCqxAg06o6Vj
         7mPFFGa3Hpb2AVsb7/OdUFFHtGtcQTZNlcT6QxnBEfEMAnSmOo8/51dPOm2ZkF32wwEb
         YkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agEg3yR2EHtB3USVNLWuj0pxKoD4uaEXVmbjvi+Z3Fg=;
        b=YfY1GOSa5vP9RpINpbvWHza970cRB4zWdxKtz6J0lIGU8AkndcIJslRgZK0wb/cA4T
         RjFocKLIEycna5VajhdfrU1wxqTvXyqvYeZZxmOgWgUazoNttTombnIRlOAeoE2BnfK6
         aKqhVU/3MNyIfxkOJ0jJADcb36h/RKd6i8vf2URvip8bW+CmprroT8IWeFz8tJMnghqt
         gAjJDNKQuQLGZr6SjfZBHwXJUQ1slfh936ST4GAyyFCpFq0q0fsLCTpdRdFscc0v7bbS
         uZuFq7kDl9OPrLCm+wC9KkbHUkGfwn9SXKw03Q1LKtXa0YFnqfhcCFI/pQ39v2HRLpd7
         VkPw==
X-Gm-Message-State: AOAM530LxwTg0njXkTLM9/lMdcPJrO7/1R2UzdS1NX+MYICwsC3mYu0c
        wWWilds/R3SY4DGvhISrynYQfZaOv2foQjCYVO6OOA==
X-Google-Smtp-Source: ABdhPJzpmmb4yy28bkSIy8imrQLAA15tnlF7goYytwFyF2yQTVFJnhYZ3TwxxYgVrqb9rGBYZrYNnku2t0taRKLZGOE=
X-Received: by 2002:a50:9b07:: with SMTP id o7mr52019020edi.104.1635868894187;
 Tue, 02 Nov 2021 09:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211101034147.6203-1-khuey@kylehuey.com> <877ddqabvs.fsf@disp2133>
In-Reply-To: <877ddqabvs.fsf@disp2133>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 2 Nov 2021 09:01:19 -0700
Message-ID: <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 7:09 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Kyle Huey <me@kylehuey.com> writes:
>
> > rr, a userspace record and replay debugger[0], uses the recorded register
> > state at PTRACE_EVENT_EXIT to find the point in time at which to cease
> > executing the program during replay.
> >
> > If a SIGKILL races with processing another signal in get_signal, it is
> > possible for the kernel to decline to notify the tracer of the original
> > signal. But if the original signal had a handler, the kernel proceeds
> > with setting up a signal handler frame as if the tracer had chosen to
> > deliver the signal unmodified to the tracee. When the kernel goes to
> > execute the signal handler that it has now modified the stack and registers
> > for, it will discover the pending SIGKILL, and terminate the tracee
> > without executing the handler. When PTRACE_EVENT_EXIT is delivered to
> > the tracer, however, the effects of handler setup will be visible to
> > the tracer.
> >
> > Because rr (the tracer) was never notified of the signal, it is not aware
> > that a signal handler frame was set up and expects the state of the program
> > at PTRACE_EVENT_EXIT to be a state that will be reconstructed naturally
> > by allowing the program to execute from the last event. When that fails
> > to happen during replay, rr will assert and die.
> >
> > The following patches add an explicit check for a newly pending SIGKILL
> > after the ptracer has been notified and the siglock has been reacquired.
> > If this happens, we stop processing the current signal and proceed
> > immediately to handling the SIGKILL. This makes the state reported at
> > PTRACE_EVENT_EXIT the unmodified state of the program, and also avoids the
> > work to set up a signal handler frame that will never be used.
> >
> > This issue was originally reported by the credited rr user.
> >
> > [0] https://rr-project.org/
>
> If I read this correctly the problem is not precisely that the rr
> debugger is never notified about the signal, but rather that the program
> is killed with SIGKILL before rr can read the notification and see which
> signal it is.

The precise problem is that the kernel made a modification to the
tracee state (setting up the signal handler frame) without telling the
tracer about it (delivering the ptrace notification for the pending
non-SIGKILL signal). That can be fixed either by not modifying the
tracee state here or by telling the tracer about the signal (that will
never actually run). I suspect we'll all agree that the former seems
preferable.

> This definitely sounds like a quality of implementation issue.
>
> The solution that is proposed in your patches simply drops the signal
> when SIGKILL is pending.

That's right.

> I think we can have a slightly better of quality of implementation
> than that (as well as a simpler implementation) by requeuing the
> signal instead of simply dropping it.  Something like the below.

What is the benefit of requeueing the signal? All pending signals will
be dropped when the SIGKILL is processed, no?

> Can you test that and see if it works for you?

It does not work. This triggers an infinite loop in get_signal, as we
dequeue the signal, attempt to notify the ptracer, see the pending
sigkill, requeue the signal, go around the loop, dequeue the original
signal ...

- Kyle

> Eric
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 056a107e3cbc..0dff366b9129 100644
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
>
