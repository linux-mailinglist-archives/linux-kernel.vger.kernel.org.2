Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1675033340D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 05:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhCJD75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhCJD7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:59:53 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 19:59:53 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u20so16428499iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g+PUdBI5sognOgUxq+6tbYVzMh+UAoLj7i4Ltt5RzF0=;
        b=N3bmi9IFB6bvizGWtxJL8FvwDvGSclZfc1LE1HB5G4fbxLI/GdBmMjn56om90aR0Nk
         JYqFwoDQPJUatJzrrb70LfxLsYtZ9Xo4mhO4I8ahrtm8ZYfaDdPJv/Qd54Eo68yxHudB
         /sPiHCcfILcFBiNQIA8RIXByv2MLXCGKeN3ILqVCFW7XCXTWKai0ak/AbKOjCbWZ21zm
         7qX33XhIj1+KuIhCNR4DP5ONbsnuIxqLMwN6oBcj3q5SLOl8gtCeS9RBJvOUP2epiIxy
         EeaeDYg+0c3fuGXdGVHvaYbqnI0fNum1BkzlAyHPdt7YaYbgKHsS9XIAl5HHAz9I+SP7
         lRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g+PUdBI5sognOgUxq+6tbYVzMh+UAoLj7i4Ltt5RzF0=;
        b=dOI8tG7CFiRcUFTeYzE0n8c+6oRzcFVuYFQ1zGphQYrDfYa7HieuJO0aZA9qIyNLr1
         mkJDqAMDZiNu3U1l6mDjJmNG1ks6AMoUDLloIvw/NJHQK75k9qHS2k+G+qw9gtrx+Xm6
         OswcevCyVdgq+A7iK8AncwtWSCmhA7M1ZN7A9WRtFEmwFkopcfr8bdSh+ysWUOAhLv1y
         lXtds0t68CpMxwJZwQJ+uIy6np8tIKftCqVW/hs1DUrOU3vPFwwKFQFch/RMde0JwPzZ
         cJC0L1vPiXQW3v3Nu+qOx4q9Jop8TS9ai5ERGEdXXNsJncId3OFLrjFv4NRhtvmHVaQI
         4Fqw==
X-Gm-Message-State: AOAM532e0HtzL2gYWU7LoLVuT8kqc8benrCCQAuxYoPSX9zHgjYOMojj
        WYH7tVyo8up1QRztltwPEYdMFRYl/ZUS41+1u1s=
X-Google-Smtp-Source: ABdhPJyKRfdzd4/w6ZTKX4OrDr7HlPd8xb7ZyaT6GSlTJwPu7Ihl7akk5mI4EdGA+GljFLEAkpBJ5Fl3Wik79DLM9jI=
X-Received: by 2002:a05:6602:280f:: with SMTP id d15mr1057833ioe.127.1615348792812;
 Tue, 09 Mar 2021 19:59:52 -0800 (PST)
MIME-Version: 1.0
References: <1615296712-175334-1-git-send-email-zhaoqianligood@gmail.com> <20210309182657.GA1408@redhat.com>
In-Reply-To: <20210309182657.GA1408@redhat.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Wed, 10 Mar 2021 11:59:41 +0800
Message-ID: <CAPx_LQEQto2fget=kCnfjSCdAp9XCwc2AWgzwxpbxdyCgNs5Mg@mail.gmail.com>
Subject: Re: [PATCH] exit: trigger panic when init process is set to SIGNAL_GROUP_EXIT
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     christian@brauner.io, axboe@kernel.dk, ebiederm@xmission.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Oleg

Thanks for your replay.

> To be honest, I don't understand the changelog. It seems that you want
> to uglify the kernel to simplify the debugging of buggy init? Or what?

My patch is for the following purpose:
1. I hope to fix the occurrence of unexpected panic
- [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
This problem occurs when both two init threads enter the do_exit,
One of the init thread is syscall sys_exit_group,and set SIGNAL_GROUP_EXIT
The other init thread perform ret_to_user()->get_signal() and found
SIGNAL_GROUP_EXIT is set,then do_group_exit()->do_exit()
Since there are no alive init threads it finally goes to
zap_pid_ns_processes() and BUG().
Timing details are in the changelog.

2. I hope to fix the problem that coredump cannot be parsed after init cras=
h
Before my patch,ever init sub-thread will finish do_exit(),the last
thread will trigger panic().
Except for the thread that triggered the panic,the state(such as
PF_EXITING etc) of the other threads is already exiting,so we can't
parse coredump from fulldump
In fact, when any one init has been set to SIGNAL_GROUP_EXIT, then we
can trigger panic,and prevent other init threads from continuing to
exit

> Nor can I understand the patch. I fail to understand the games with
> SIGNAL_UNKILLABLE and ->siglock.

When first init thread panic,i don't want other init threads to still
exit,this will destroy the state of other init threads.
so i use SIGNAL_UNKILLABLE to mark this stat,prevent other init
threads from continuing to exit
In addition i use siglock to protect tsk->signal->flags.

> And iiuc with this patch the kernel will crash if init's sub-thread execs=
,
> signal_group_exit() returns T in this case.

Oleg Nesterov <oleg@redhat.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8810=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On 03/09, Qianli Zhao wrote:
> >
> > From: Qianli Zhao <zhaoqianli@xiaomi.com>
> >
> > Once any init thread finds SIGNAL_GROUP_EXIT, trigger panic immediately
> > instead of last thread of global init has exited, and do not allow othe=
r
> > init threads to exit, protect task/memory state of all sub-threads for
> > get reliable init coredump
>
> To be honest, I don't understand the changelog. It seems that you want
> to uglify the kernel to simplify the debugging of buggy init? Or what?
>
> Nor can I understand the patch. I fail to understand the games with
> SIGNAL_UNKILLABLE and ->siglock.
>
> And iiuc with this patch the kernel will crash if init's sub-thread execs=
,
> signal_group_exit() returns T in this case.
>
> Oleg.
>
> > [   24.705376] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00007f00
> > [   24.705382] CPU: 4 PID: 552 Comm: init Tainted: G S         O    4.1=
4.180-perf-g4483caa8ae80-dirty #1
> > [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
> >
> > PID: 552   CPU: 4   COMMAND: "init"
> > PID: 1     CPU: 7   COMMAND: "init"
> > core4                         core7
> > ...                           sys_exit_group()
> >                               do_group_exit()
> >                                   - sig->flags =3D SIGNAL_GROUP_EXIT
> >                                   - zap_other_threads()
> >                               do_exit()
> >                                   - PF_EXITING is set
> > ret_to_user()
> > do_notify_resume()
> > get_signal()
> >     - signal_group_exit
> >     - goto fatal;
> > do_group_exit()
> > do_exit()
> >     - PF_EXITING is set
> >     - panic("Attempted to kill init! exitcode=3D0x%08x\n")
> >                               exit_notify()
> >                               find_alive_thread() //no alive sub-thread=
s
> >                               zap_pid_ns_processes()//CONFIG_PID_NS is =
not set
> >                               BUG()
> >
> > Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> > ---
> > We got an init crash issue, but we can't get init coredump from fulldum=
p, we also
> > see BUG() triggered which calling in zap_pid_ns_processes().
> >
> > From crash dump we can get the following information:
> > 1. "Attempted to kill init",init process is killed.
> > - Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000=
7f00
> > 2. At the same time as init crash, a BUG() triggered in other core.
> > - [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
> > 3. When init thread calls exit_mm, the corresponding thread task->mm wi=
ll be empty, which is not conducive to extracting coredump
> >
> > To fix the issue and save complete coredump, once find init thread is s=
et to SIGNAL_GROUP_EXIT
> > trigger panic immediately,and other child threads are not allowed to ex=
it just wait for reboot
> >
> > PID: 1      TASK: ffffffc973126900  CPU: 7   COMMAND: "init"
> >  #0 [ffffff800805ba60] perf_trace_kernel_panic_late at ffffff99ac0bcbcc
> >  #1 [ffffff800805bac0] die at ffffff99ac08dc64
> >  #2 [ffffff800805bb10] bug_handler at ffffff99ac08e398
> >  #3 [ffffff800805bbc0] brk_handler at ffffff99ac08529c
> >  #4 [ffffff800805bc80] do_debug_exception at ffffff99ac0814e4
> >  #5 [ffffff800805bdf0] el1_dbg at ffffff99ac083298
> > ->Exception
> >     /home/work/courbet-r-stable-build/kernel/msm-4.14/include/linux/pid=
_namespace.h: 98
> >  #6 [ffffff800805be20] do_exit at ffffff99ac0c22e8
> >  #7 [ffffff800805be80] do_group_exit at ffffff99ac0c2658
> >  #8 [ffffff800805beb0] sys_exit_group at ffffff99ac0c266c
> >  #9 [ffffff800805bff0] el0_svc_naked at ffffff99ac083cf
> > ->SYSCALLNO: 5e (__NR_exit_group)
> >
> > PID: 552    TASK: ffffffc9613c8f00  CPU: 4   COMMAND: "init"
> >  #0 [ffffff801455b870] __delay at ffffff99ad32cc14
> >  #1 [ffffff801455b8b0] __const_udelay at ffffff99ad32cd10
> >  #2 [ffffff801455b8c0] msm_trigger_wdog_bite at ffffff99ac5d5be0
> >  #3 [ffffff801455b980] do_msm_restart at ffffff99acccc3f8
> >  #4 [ffffff801455b9b0] machine_restart at ffffff99ac085dd0
> >  #5 [ffffff801455b9d0] emergency_restart at ffffff99ac0eb6dc
> >  #6 [ffffff801455baf0] panic at ffffff99ac0bd008
> >  #7 [ffffff801455bb70] do_exit at ffffff99ac0c257c
> >     /home/work/courbet-r-stable-build/kernel/msm-4.14/kernel/exit.c: 84=
2
> >  #8 [ffffff801455bbd0] do_group_exit at ffffff99ac0c2644
> >  #9 [ffffff801455bcc0] get_signal at ffffff99ac0d1384
> > #10 [ffffff801455be60] do_notify_resume at ffffff99ac08b2a8
> > #11 [ffffff801455bff0] work_pending at ffffff99ac083b8c
> >
> > ---
> >  kernel/exit.c | 29 +++++++++++++++++++++--------
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index ef2fb929..6b2da22 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -758,6 +758,27 @@ void __noreturn do_exit(long code)
> >       validate_creds_for_do_exit(tsk);
> >
> >       /*
> > +      * Once init group is marked for death,
> > +      * panic immediately to get a useable coredump
> > +      */
> > +     if (unlikely(is_global_init(tsk) &&
> > +         signal_group_exit(tsk->signal))) {
> > +             spin_lock_irq(&tsk->sighand->siglock);
> > +             if (!(tsk->signal->flags & SIGNAL_UNKILLABLE)) {
> > +                     tsk->signal->flags |=3D SIGNAL_UNKILLABLE;
> > +                     spin_unlock_irq(&tsk->sighand->siglock);
> > +                     panic("Attempted to kill init! exitcode=3D0x%08x\=
n",
> > +                             tsk->signal->group_exit_code ?: (int)code=
);
> > +             } else {
> > +                     /* init sub-thread is dying, just wait for reboot=
 */
> > +                     spin_unlock_irq(&tsk->sighand->siglock);
> > +                     futex_exit_recursive(tsk);
> > +                     set_current_state(TASK_UNINTERRUPTIBLE);
> > +                     schedule();
> > +             }
> > +     }
> > +
> > +     /*
> >        * We're taking recursive faults here in do_exit. Safest is to ju=
st
> >        * leave this task alone and wait for reboot.
> >        */
> > @@ -776,14 +797,6 @@ void __noreturn do_exit(long code)
> >       acct_update_integrals(tsk);
> >       group_dead =3D atomic_dec_and_test(&tsk->signal->live);
> >       if (group_dead) {
> > -             /*
> > -              * If the last thread of global init has exited, panic
> > -              * immediately to get a useable coredump.
> > -              */
> > -             if (unlikely(is_global_init(tsk)))
> > -                     panic("Attempted to kill init! exitcode=3D0x%08x\=
n",
> > -                             tsk->signal->group_exit_code ?: (int)code=
);
> > -
> >  #ifdef CONFIG_POSIX_TIMERS
> >               hrtimer_cancel(&tsk->signal->real_timer);
> >               exit_itimers(tsk->signal);
> > --
> > 1.9.1
> >
>
