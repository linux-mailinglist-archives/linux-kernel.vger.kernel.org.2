Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC39833FD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCRCr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhCRCrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:47:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:47:14 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id v26so748066iox.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qPVyx2Zj7Jz7L2q9LituDEUkZFg2AExxKoUQizZswl8=;
        b=vPA+c27Rr4Q5LEYngrDZMZaLtqMYGxV/pfLVhMPRDa745imC7hcIVsouMjsAtAZoDU
         tf3r0sCTnYepOn+kZesd/lV87F5LIlZayuxS5LrZvF90sU2E4p26pzMlV4P/x/t0w9ku
         TYuhNEzFRg0GcUi4Ev773RhEIIMprsE2t0NhfQyhCo9I3tS8nF8tySKE27xLRnOwE/zQ
         AwT9ozskIKxIiAFNGXQ9holn0GGxtRBKgdRwraY0njZIxPhg3JMHVB3Q2Z9E8bcvV8Sd
         0F4zr2qqdpKDlpwOb3OIArd5gpcAn8fEv0nI+pfjZtE4oHYyYc10V3IzzMDOYxHO5oXj
         O8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qPVyx2Zj7Jz7L2q9LituDEUkZFg2AExxKoUQizZswl8=;
        b=lwRZgY91BB1x74vXfapgs6zs72QXFYcy4YMQNgvmp4Whm5Kwu8MUbsM42tUgBQup3z
         dNkPOas58+QLFZvqxmbH1kzg2BkW6qICfOoiZgKv7NxmR22VKGp0qokbvVRXxfl9J8ye
         pjDPfsqfnFuV99FwhrSb/c/uT88QJNHl7qCSOSe97d1DEzup30qGz5XsjqDlnzYvW49N
         4NILP7DovI5qfGRCdNM26WvFHr3LuUX1fMup0KAmjovkQ/0O15MyDO6v4Dpl/wix4tSG
         dJy75+TYDFvQ5IjGqauUfzfYnG0LbpExLItrmWKSbnqT2NJDa4PV3j8YjX48XQQjMn16
         5C3w==
X-Gm-Message-State: AOAM533KyhqDEDj+Xpfeh2lccbRBmo25RHyVo3D6CzQkQJJS9wXyC37e
        DCNTdxe6b8LBa4H/wVO0Jbncy1IBUjBCya0GPDQ=
X-Google-Smtp-Source: ABdhPJyYFeksrbH4PseEjbtYOkLLXaeqjq9jFvosX8uYo3HFZlsT4xqPc/P2y2SIE4AJinelkP9UjYqfK+57ldXYfg4=
X-Received: by 2002:a05:6602:280f:: with SMTP id d15mr8549512ioe.127.1616035634039;
 Wed, 17 Mar 2021 19:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com> <20210317143805.GA5610@redhat.com>
In-Reply-To: <20210317143805.GA5610@redhat.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Thu, 18 Mar 2021 10:47:02 +0800
Message-ID: <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     christian@brauner.io, axboe@kernel.dk,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Oleg

Thank you for your reply.

>> When init sub-threads running on different CPUs exit at the same time,
>> zap_pid_ns_processe()->BUG() may be happened.

> and why do you think your patch can't prevent this?

> Sorry, I must have missed something. But it seems to me that you are tryi=
ng
> to fix the wrong problem. Yes, zap_pid_ns_processes() must not be called =
in
> the root namespace, and this has nothing to do with CONFIG_PID_NS.

Yes, i try to fix this exception by test SIGNAL_GROUP_EXIT and call
panic before setting PF_EXITING to prevent zap_pid_ns_processes()
being called when init do_exit().
In addition, the patch also protects the init process state to
successfully get usable init coredump.

In my test,this patch works.

Oleg Nesterov <oleg@redhat.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On 03/17, Qianli Zhao wrote:
> >
> > From: Qianli Zhao <zhaoqianli@xiaomi.com>
> >
> > When init sub-threads running on different CPUs exit at the same time,
> > zap_pid_ns_processe()->BUG() may be happened.
>
> and why do you think your patch can't prevent this?
>
> Sorry, I must have missed something. But it seems to me that you are tryi=
ng
> to fix the wrong problem. Yes, zap_pid_ns_processes() must not be called =
in
> the root namespace, and this has nothing to do with CONFIG_PID_NS.
>
> > And every thread status is abnormal after exit(PF_EXITING set,task->mm=
=3DNULL etc),
> > which makes it difficult to parse coredump from fulldump normally.
> > In order to fix the above problem, when any one init has been set to SI=
GNAL_GROUP_EXIT,
> > trigger panic immediately, and prevent other init threads from continui=
ng to exit
> >
> > [   24.705376] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00007f00
> > [   24.705382] CPU: 4 PID: 552 Comm: init Tainted: G S         O    4.1=
4.180-perf-g4483caa8ae80-dirty #1
> > [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
> >
> > PID: 552   CPU: 4   COMMAND: "init"
> > PID: 1     CPU: 7   COMMAND: "init"
> > core4                           core7
> > ...                             sys_exit_group()
> >                                 do_group_exit()
> >                                    - sig->flags =3D SIGNAL_GROUP_EXIT
> >                                    - zap_other_threads()
> >                                 do_exit() //PF_EXITING is set
> > ret_to_user()
> > do_notify_resume()
> > get_signal()
> >     - signal_group_exit
> >     - goto fatal;
> > do_group_exit()
> > do_exit() //PF_EXITING is set
> >     - panic("Attempted to kill init! exitcode=3D0x%08x\n")
> >                                 exit_notify()
> >                                 find_alive_thread() //no alive sub-thre=
ads
> >                                 zap_pid_ns_processes()//CONFIG_PID_NS i=
s not set
> >                                 BUG()
> >
> > Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> > ---
> > V3:
> > - Use group_dead instead of thread_group_empty() to test single init ex=
it.
> >
> > V2:
> > - Changelog update
> > - Remove wrong useage of SIGNAL_UNKILLABLE.
> > - Add thread_group_empty() test to handle single init thread exit
> > ---
> >  kernel/exit.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index 04029e3..32b74e4 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -766,6 +766,17 @@ void __noreturn do_exit(long code)
> >
> >       validate_creds_for_do_exit(tsk);
> >
> > +     group_dead =3D atomic_dec_and_test(&tsk->signal->live);
> > +     /*
> > +      * If global init has exited,
> > +      * panic immediately to get a useable coredump.
> > +      */
> > +     if (unlikely(is_global_init(tsk) &&
> > +         (group_dead || (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
> > +                     panic("Attempted to kill init! exitcode=3D0x%08x\=
n",
> > +                             tsk->signal->group_exit_code ?: (int)code=
);
> > +     }
> > +
> >       /*
> >        * We're taking recursive faults here in do_exit. Safest is to ju=
st
> >        * leave this task alone and wait for reboot.
> > @@ -784,16 +795,7 @@ void __noreturn do_exit(long code)
> >       if (tsk->mm)
> >               sync_mm_rss(tsk->mm);
> >       acct_update_integrals(tsk);
> > -     group_dead =3D atomic_dec_and_test(&tsk->signal->live);
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
