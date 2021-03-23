Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6634A345CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhCWLXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhCWLXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:23:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BCDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:23:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o10so26062664lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RYTjPvWFcjPgHsuLD2UPqNJxJUB5dJepCRH2DSuBWrs=;
        b=oWuQf0hZMadFkr2Kau971XhJd5Q9R6LiR3YaYldxRJ0G5ej9G+amPtBvBf1DpVU/RH
         w+HG05Os+4ncTr0uiOaVCizxqV0V5mxd7nBWoEfj9gs84EZCUX7EoeiKxE0qVJWoobe+
         E+G7WdFvCBV2SDxfLDF+BWKhlGnxjLtrWN8uqCll1CIvjthmad8xGyG+4k7nlss6TXji
         +1VMq11SpoVPygU+SEFwueHq18uBbx/h9c1dFyKYJnUeEHysLW8djxvO+1g4In7YfKVz
         SGztJZEFomyK8hO87FO1ynlwuBKzdpG9fscEOzEwIgs33mcluARYfQmevbBJfdqYZCGQ
         fm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RYTjPvWFcjPgHsuLD2UPqNJxJUB5dJepCRH2DSuBWrs=;
        b=qHjAeI5IiHjebE9SBz5LvugsA8Mtnn7dn/cBp1wz9yzV9B+oeXGxWino0yBwPhzAyL
         tSfuafu0Cvho5OvYpxPeFEaHBNw0ioldh/hGjRw2rVSAbmAqEEiggU5UIQwV6PoxKk+W
         /ijxetHGvgYlVFYK5PRECuOs5YMpwqMMpap6HdpW6dvoe9H0ZvzcbASz2kIpw0/7vyzL
         iMtZL4twaGibWxAbAnf2i58r2fiMNj8o0oFJKCtZD3cnx0PxcbOMmWszaJmUOebtBuDw
         0D/RWof074vzEMbOZsEPyp8vKHNIGdpMuy8nczenoSzCAO14BusixBcOiHqmCbvxV4mq
         VRPw==
X-Gm-Message-State: AOAM5315epbah+Ll/QEnTsZGQebgHWU5u+TUgqmnGIVU02K12/6ZP5ig
        96TjtIeOEOf9paDeb9dvSeSt4ifA1HCidx7YJ2Y=
X-Google-Smtp-Source: ABdhPJyYHzqHJtvEz9RprJQZR8T9e+Wo58F9KWU7aBBnu288eO4NufdYclmJRxvklYIqJ6au627bCBj2uycZuNfaKGI=
X-Received: by 2002:a19:4881:: with SMTP id v123mr2376583lfa.276.1616498602634;
 Tue, 23 Mar 2021 04:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com> <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com> <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
 <20210319163225.GB19971@redhat.com> <CAPx_LQGLYx8gKJSkCx9hTyPPbCbU=GJL31TPb3s6zxro522U0Q@mail.gmail.com>
 <20210322163705.GD20390@redhat.com> <CAPx_LQG_5ushJkyymSsYq8FafRj7XOA217JwCyHASEqq0wyMOQ@mail.gmail.com>
 <20210323090035.GA25159@redhat.com>
In-Reply-To: <20210323090035.GA25159@redhat.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Tue, 23 Mar 2021 19:23:11 +0800
Message-ID: <CAPx_LQH0Qx7R9vNb3FHgO7V8uJ9AAh0j_TZV-VnyBF7Ys_7FTQ@mail.gmail.com>
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

> You certainly don't understand me :/

> Please read my email you quoted below. I didn't mean the current logic.
> I meant the logic after your patch which moves atomic_dec_and_test() and
> panic() before exit_signals().

Sorry, I think I see what you mean now.

You mean that after apply my patch,SIGNAL_GROUP_EXIT no longer needs
to be tested or avoid zap_pid_ns_processes()->BUG().
Yes,your consideration is correct.
But,my patch has another purpose,protect some key variables(such
as:task->mm,task->nsproxy,etc) to recover init coredump from
fulldump,if sub-threads finish do_exit(),these variables of sub-task
will be lost,and we cannot parse the coredump of the init process
through the tool normally such as "gcore".


Oleg Nesterov <oleg@redhat.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On 03/23, qianli zhao wrote:
> >
> > Hi,Oleg
> >
> > > No, there is at least one alive init thread. If they all have exited,=
 we have
> > > the thread which calls panic() above.
> >
> > By current logic, setting PF_EXITING(exit_signals()) is before the
> > panic(),
>
> You certainly don't understand me :/
>
> Please read my email you quoted below. I didn't mean the current logic.
> I meant the logic after your patch which moves atomic_dec_and_test() and
> panic() before exit_signals().
>
> Oleg.
>
> > find_alive_thread() determines the PF_EXITING of all child
> > threads, the panic thread's PF_EXITING has been set before panic(),so
> > find_alive_thread() thinks this thread also dead, resulting in
> > find_alive_thread returning NULL.It is possible to trigger a
> > zap_pid_ns_processes()->BUG() in this case.
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > exit_signals(tsk);  /* sets PF_EXITING */
> > ...
> > group_dead =3D atomic_dec_and_test(&tsk->signal->live);
> > if (group_dead) {
> > if (unlikely(is_global_init(tsk)))
> > panic("Attempted to kill init!
> > exitcode=3D0x%08x\n",-------------------->//PF_EXITING has been set
> > tsk->signal->group_exit_code ?: (int)code);
> >
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > > Why do you think so? It can affect _any_ code which runs under
> > > "if (group_dead)". Again, I don't see anything wrong, but I didn't ev=
en
> > > try to audit these code paths.
> >
> > Yes,all places where checked the "signal->live" may be affected,but
> > even before my changes, each program that checks "signal->live" may
> > get different state(group_dead or not), depending on the timing of the
> > caller,this situation will not change after my change.
> > After my patch,"signal->live--" and other variable are set in a
> > different order(such as signal->live and PF_EXITING),this can cause
> > abnormalities in the logic associated with these two variables,that is
> > my thinking.
> > Of course, check all the "signal->live--" path is definitely
> > necessary,it's just the case above that we need more attention.
> >
> > Thanks
> >
> > Oleg Nesterov <oleg@redhat.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:37=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi,
> > >
> > > It seems that we don't understand each other.
> > >
> > > If we move atomic_dec_and_test(signal->live) and do
> > >
> > >         if (group_dead && is_global_init)
> > >                 panic(...);
> > >
> > >
> > > before setting PF_EXITING like your patch does, then zap_pid_ns_proce=
sses()
> > > simply won't be called.
> > >
> > > Because:
> > >
> > > On 03/21, qianli zhao wrote:
> > > >
> > > > Hi,Oleg
> > > >
> > > > > How? Perhaps I missed something again, but I don't think this is =
possible.
> > > >
> > > > > zap_pid_ns_processes() simply won't be called, find_child_reaper(=
) will
> > > > > see the !PF_EXITING thread which calls panic().
> > > >
> > > > > So I think this should be documented somehow, at least in the cha=
ngelog.
> > > >
> > > > This problem occurs when both two init threads enter the do_exit,
> > > > One of the init thread is syscall sys_exit_group,and set SIGNAL_GRO=
UP_EXIT
> > > > The other init thread perform ret_to_user()->get_signal() and found
> > > > SIGNAL_GROUP_EXIT is set,then do_group_exit()->do_exit(),since ther=
e
> > > > are no alive init threads it finally goes to
> > > > zap_pid_ns_processes()
> > >
> > > No, there is at least one alive init thread. If they all have exited,=
 we have
> > > the thread which calls panic() above.
> > >
> > > > and BUG().
> > >
> > > so we don't need the SIGNAL_GROUP_EXIT check to avoid this BUG().
> > >
> > > What have I missed?
> > >
> > > Oleg.
> > >
> >
>
