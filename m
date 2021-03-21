Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863353432AC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 14:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCUNEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 09:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCUNER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 09:04:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CAFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 06:04:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b83so17055346lfd.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HISt0bdHgknAN5YjfAuKO1vta/pfu++BrUzF9yGDG34=;
        b=ufvEJ6t2C3Vyw+eK33Xg3KtCdmxN/sLdhmil/jIwF7qZ/cGow+lnCUbXgi2lZxR5zj
         hRy3xJRmpb9YXO9XerYb8Lzh5rEnWWK2v599M0daxCR7JlqmlI/xawnFgY6MR20ecfVH
         cuOxbDrsJXYW6Dmnd2X5fmM1VvipDX7EKri5bcaQaKDJK++iS9JP8qe7X2wcdOk9TGoN
         DP5NlfQkoIA1IGjrlp8HHTpFA8ItlyWKT34yppLIjJxwKCrZaelSfuNNbCR6KWLXf20H
         TZypn9avVHFltyXdvxoT0faxYsnZDeCTZcFINQKcZmrMUH5+QTbPKtDhJsZbVGKNW5qM
         qFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HISt0bdHgknAN5YjfAuKO1vta/pfu++BrUzF9yGDG34=;
        b=JyGWWfYnW0S8MX/exJRNwz7UVTqUgHYrfCZCwdDtU78Q76kEX9uOwb+uhJXuJdIp7q
         4xnV5JPjmosoNpkQL+z2DEAMGh+ooU7mkfPVcIA+A6UkbPf7XQo1212S9vwOtfIPEqGs
         iOBHKVlN8xLaAk36NiW3w6vrF42qWX37t6UVKQgq28ewIO9OIqGKzuS4ih5cHzKoWrGy
         wZ9EgxE6iXVQd6thXVxKThBfjq/oZJD6hM9cx7wicHdwdQcqUr03xZdDA51N9dvv6uuF
         foj1aurh7RG2mVlAeNT9RpJPN1dTv9WTjEOevLzW3WUgiz35Tt9AFNdKEgvWEo7heo4L
         KKWA==
X-Gm-Message-State: AOAM531Y/tISyvVFn3cLVF+pGfeah+acbqTG4erqcEx64BEeASskSMMk
        jyODkMVM4aJ3VE5Q0hCO4cQOvi+GbYScK29mvfbojPPeHPVQFQ==
X-Google-Smtp-Source: ABdhPJwqgjLUfNR8AZV4RG5lP82C+NRgPmTAH5y+OKBm4wrwMxbFU9BPPzjMrhyRr++z8Lc3z97poJesIwk0HqCvLgc=
X-Received: by 2002:ac2:5b5a:: with SMTP id i26mr6324966lfp.182.1616331855890;
 Sun, 21 Mar 2021 06:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com> <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com> <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
 <20210319163225.GB19971@redhat.com>
In-Reply-To: <20210319163225.GB19971@redhat.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Sun, 21 Mar 2021 21:04:04 +0800
Message-ID: <CAPx_LQGLYx8gKJSkCx9hTyPPbCbU=GJL31TPb3s6zxro522U0Q@mail.gmail.com>
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

> How? Perhaps I missed something again, but I don't think this is possible=
.

> zap_pid_ns_processes() simply won't be called, find_child_reaper() will
> see the !PF_EXITING thread which calls panic().

> So I think this should be documented somehow, at least in the changelog.

This problem occurs when both two init threads enter the do_exit,
One of the init thread is syscall sys_exit_group,and set SIGNAL_GROUP_EXIT
The other init thread perform ret_to_user()->get_signal() and found
SIGNAL_GROUP_EXIT is set,then do_group_exit()->do_exit(),since there
are no alive init threads it finally goes to
zap_pid_ns_processes() and BUG().

Please refer to the sequence diagram below(that has been written into
the changelog),and callstack is also below:
kernel log:
[   24.705376] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x00007f00
[   24.705382] CPU: 4 PID: 552 Comm: init Tainted: G S         O
4.14.180-perf-g4483caa8ae80-dirty #1
[   24.705390] kernel BUG at include/linux/pid_namespace.h:98!

PID: 1      TASK: ffffffc973126900  CPU: 7   COMMAND: "init"
 #0 [ffffff800805ba60] perf_trace_kernel_panic_late at ffffff99ac0bcbcc
 #1 [ffffff800805bac0] die at ffffff99ac08dc64
 #2 [ffffff800805bb10] bug_handler at ffffff99ac08e398
 #3 [ffffff800805bbc0] brk_handler at ffffff99ac08529c
 #4 [ffffff800805bc80] do_debug_exception at ffffff99ac0814e4
->exception
    /home/work/courbet-r-stable-build/kernel/msm-4.14/include/linux/pid_nam=
espace.h:
98
96static inline void zap_pid_ns_processes(struct pid_namespace *ns)
97{
98 BUG();
99}
 #5 [ffffff800805bdf0] el1_dbg at ffffff99ac083298
 #6 [ffffff800805be20] do_exit at ffffff99ac0c22e8
 #7 [ffffff800805be80] do_group_exit at ffffff99ac0c2658
 #8 [ffffff800805beb0] sys_exit_group at ffffff99ac0c266c
 #9 [ffffff800805bff0] el0_svc_naked at ffffff99ac083cfc

PID: 552    TASK: ffffffc9613c8f00  CPU: 4   COMMAND: "init"
 #0 [ffffff801455b870] __delay at ffffff99ad32cc14
 #1 [ffffff801455b8b0] __const_udelay at ffffff99ad32cd10
 #2 [ffffff801455b8c0] msm_trigger_wdog_bite at ffffff99ac5d5be0
 #3 [ffffff801455b980] do_msm_restart at ffffff99acccc3f8
 #4 [ffffff801455b9b0] machine_restart at ffffff99ac085dd0
 #5 [ffffff801455b9d0] emergency_restart at ffffff99ac0eb6dc
 #6 [ffffff801455baf0] panic at ffffff99ac0bd008
   =3D=3D=3D=3D=3D=3D=3D=3D> /home/work/courbet-r-stable-build/kernel/msm-4=
.14/kernel/exit.c:
842
836 if (group_dead) {
837 /*
838 * If the last thread of global init has exited, panic
839 * immediately to get a useable coredump.
840 */
841 if (unlikely(is_global_init(tsk)))
842 panic("Attempted to kill init! exitcode=3D0x%08x\n",
843 tsk->signal->group_exit_code ?: (int)code);

 #7 [ffffff801455bb70] do_exit at ffffff99ac0c257c
#8 [ffffff801455bbd0] do_group_exit at ffffff99ac0c2644
#9 [ffffff801455bcc0] get_signal at ffffff99ac0d1384
#10 [ffffff801455be60] do_notify_resume at ffffff99ac08b2a8
#11 [ffffff801455bff0] work_pending at ffffff99ac083b8c

core4                                  core7
...                                     sys_exit_group()
                                        do_group_exit()
                                          - sig->flags =3D SIGNAL_GROUP_EXI=
T
                                          - zap_other_threads()
                                       do_exit() //PF_EXITING is set
ret_to_user()
do_notify_resume()
get_signal()
    - signal_group_exit
    - goto fatal;
do_group_exit()
do_exit() //PF_EXITING is set
    - panic("Attempted to kill init! exitcode=3D0x%08x\n")
                                        exit_notify()
                                        find_alive_thread() //no alive
sub-threads
                                       zap_pid_ns_processes()
//CONFIG_PID_NS is not set
                                       BUG()

Oleg Nesterov <oleg@redhat.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8820=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 03/19, qianli zhao wrote:
> >
> > > But then I don't understand the SIGNAL_GROUP_EXIT check added by your
> > > patch. Do we really need it if we want to avoid zap_pid_ns_processes(=
)
> > > when the global init exits?
> >
> > I think check SIGNAL_GROUP_EXIT is necessary,or panic() will happen
> > after all init sub-threads do_exit(),so the following two situations
> > will happen:
> > 1.According to the timing in the changelog,
> > zap_pid_ns_processes()->BUG() maybe happened.
>
> How? Perhaps I missed something again, but I don't think this is possible=
.
>
> zap_pid_ns_processes() simply won't be called, find_child_reaper() will
> see the !PF_EXITING thread which calls panic().
>
> So I think this should be documented somehow, at least in the changelog.
>
> Oleg.
>
