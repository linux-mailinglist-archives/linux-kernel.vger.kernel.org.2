Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB5345615
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCWDO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCWDOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:14:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B3CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:14:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a198so24477839lfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W/V8+kwFSxa0gro/RcRlWHUGi2iXmSIttEMFik4sZJ8=;
        b=AKZEpRx7Ktbj8qkcXoni9RdWNbrQUF37/565x6vrk2sYoKncssmc6mFgqIzRs2MiaH
         MqyGsbBgrueeZMo33BL1KWqcKZOKGfI39FLXJET6NhUTOhf3e4OYlXwdAEUYXOIVhaYd
         fUnsEo4Kl/qxT7Gr18Usa1f3uexGTNnPm4yuAN3YgMiznDSdolJP2ABlvdTKf4YNssnd
         OgNqv8YsjJUPMtkdES0aF8Sf9OaSjxNQ1bbjEU5ZtOgeAu1Z95/ObFrQ1sBrTkH/RPrM
         Egu3tEd+h9yQ7SXhIxKWpaZVPQRS8Ygccw2nUC8l2BGpL57D9LmcqBXkiJKYVZ+TMqTw
         FwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W/V8+kwFSxa0gro/RcRlWHUGi2iXmSIttEMFik4sZJ8=;
        b=T924Bom10HZ0pc/bEZVdR9xaj0ns4XfFaTqe8XcpvSkqziVLgYkOe0FSAh2iBW6a2n
         AgJiyaRKLi3h7rE7JjjSVzVYREa/O/hXIcJUuIP/KpXirowzNiVzqhOSUNzFC4DXhvcg
         dWKYc7O2XkTHkCu46bwjoeEnLHf7QrcVGWcgGk52vi/1Vt5PtaG64iiR3Kc51OqQFRbw
         tsSzSRAPqU8z0XktgSgwso4vNu6ho8mwsmKLvrCd8LPQ5czZ1xS5K9L2FxXYO8lYO7DT
         3wtCHlUDzqKAxQ2PkTZ4XC1uMOp+ejjsAIMbNSxP8S6L6dzh36qioDtY5S4mL4iGW4DH
         tFnQ==
X-Gm-Message-State: AOAM5336e0t4Pb+HZ9579MesS6p2ZzBhxtEZ65RMicvaiJZcuDGv2xHu
        c4pbLkB1ZoFXJ21rApx5ZIzRWijO4ln7BQozCjk=
X-Google-Smtp-Source: ABdhPJzmxqDy8CYuzKjgu795Xmj/0DHzOWypFVwALPOEYakVrc15St2ZfklVFap+AB820LUbxykqKAQPXL7zKEDYsss=
X-Received: by 2002:ac2:4298:: with SMTP id m24mr1370197lfh.429.1616469270517;
 Mon, 22 Mar 2021 20:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com> <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com> <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
 <20210319163225.GB19971@redhat.com> <CAPx_LQGLYx8gKJSkCx9hTyPPbCbU=GJL31TPb3s6zxro522U0Q@mail.gmail.com>
 <20210322163705.GD20390@redhat.com>
In-Reply-To: <20210322163705.GD20390@redhat.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Tue, 23 Mar 2021 11:14:19 +0800
Message-ID: <CAPx_LQG_5ushJkyymSsYq8FafRj7XOA217JwCyHASEqq0wyMOQ@mail.gmail.com>
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

> No, there is at least one alive init thread. If they all have exited, we =
have
> the thread which calls panic() above.

By current logic, setting PF_EXITING(exit_signals()) is before the
panic(),find_alive_thread() determines the PF_EXITING of all child
threads, the panic thread's PF_EXITING has been set before panic(),so
find_alive_thread() thinks this thread also dead, resulting in
find_alive_thread returning NULL.It is possible to trigger a
zap_pid_ns_processes()->BUG() in this case.
=3D=3D=3D=3D=3D=3D=3D=3D
exit_signals(tsk);  /* sets PF_EXITING */
...
group_dead =3D atomic_dec_and_test(&tsk->signal->live);
if (group_dead) {
if (unlikely(is_global_init(tsk)))
panic("Attempted to kill init!
exitcode=3D0x%08x\n",-------------------->//PF_EXITING has been set
tsk->signal->group_exit_code ?: (int)code);

=3D=3D=3D=3D=3D=3D=3D

> Why do you think so? It can affect _any_ code which runs under
> "if (group_dead)". Again, I don't see anything wrong, but I didn't even
> try to audit these code paths.

Yes,all places where checked the "signal->live" may be affected,but
even before my changes, each program that checks "signal->live" may
get different state(group_dead or not), depending on the timing of the
caller,this situation will not change after my change.
After my patch,"signal->live--" and other variable are set in a
different order(such as signal->live and PF_EXITING),this can cause
abnormalities in the logic associated with these two variables,that is
my thinking.
Of course, check all the "signal->live--" path is definitely
necessary,it's just the case above that we need more attention.

Thanks

Oleg Nesterov <oleg@redhat.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> It seems that we don't understand each other.
>
> If we move atomic_dec_and_test(signal->live) and do
>
>         if (group_dead && is_global_init)
>                 panic(...);
>
>
> before setting PF_EXITING like your patch does, then zap_pid_ns_processes=
()
> simply won't be called.
>
> Because:
>
> On 03/21, qianli zhao wrote:
> >
> > Hi,Oleg
> >
> > > How? Perhaps I missed something again, but I don't think this is poss=
ible.
> >
> > > zap_pid_ns_processes() simply won't be called, find_child_reaper() wi=
ll
> > > see the !PF_EXITING thread which calls panic().
> >
> > > So I think this should be documented somehow, at least in the changel=
og.
> >
> > This problem occurs when both two init threads enter the do_exit,
> > One of the init thread is syscall sys_exit_group,and set SIGNAL_GROUP_E=
XIT
> > The other init thread perform ret_to_user()->get_signal() and found
> > SIGNAL_GROUP_EXIT is set,then do_group_exit()->do_exit(),since there
> > are no alive init threads it finally goes to
> > zap_pid_ns_processes()
>
> No, there is at least one alive init thread. If they all have exited, we =
have
> the thread which calls panic() above.
>
> > and BUG().
>
> so we don't need the SIGNAL_GROUP_EXIT check to avoid this BUG().
>
> What have I missed?
>
> Oleg.
>
