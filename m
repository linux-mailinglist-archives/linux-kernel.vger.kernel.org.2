Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7C3415DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 07:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhCSGd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhCSGdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:33:35 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58478C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 23:33:35 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z136so4966391iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8JMFDnlbiquBJQkcZ6h8oNyX/u+0OOMYSlAiqQdHt08=;
        b=pYiz6NEg6Z0fSu5Ki/lR+PH5sdV7XtjAylrQEhan2ILZCxm1vNpsjrDWcHfTY8FLIc
         /gdBlm+1DsXJbVP4WL9Fw7tQaEgznATxuw/C8SSpOF5AgLHexKQWJi2L04bVPtq4mUjt
         qYs9JnZRfdKC5VmNHkuMgg1tq9q0quJqy0Q/OXS7ngIUYHx0V4Hj7bXoz1g0jzd1nHDQ
         dsjNXvTAL5GRqFRKx4gfgYjXcEAHy2PjpRIv0RT8Ji+K7qO9jQsFPNeL1zqktnmkfSmM
         //VAiJK2XsaCO4l7SaJOCoBdW6N4Nzz+BMdRisWqgQE0YISutRfX1JXo5I07izRQzCsV
         5Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8JMFDnlbiquBJQkcZ6h8oNyX/u+0OOMYSlAiqQdHt08=;
        b=Y/Gm8BhhlKx6WxpAZAy9KW4Zz9aIBeT+dzNYS/MmziNPAOJIiB/28F+xYJ3T7Np9t0
         FC927DxLnP1TzACyLs1xpc/A4RPzzzjShyVI5AT+hcMU5rSInxXeAce8fRjZ6iKynfgG
         eLbpKFcMzA8rLLhLHqJGgMYMKO47MBbwZAvzctV+4dqIdEpCpHPp3Z/DjY9AX7RT2q4L
         edIIo2l0uqnC++u2mhn1CroPA9NDm+iq8mVTQFilAT95b0AANGPS+epnMqEjp/3jC3YQ
         KIB9M0Gr2L2gYt/hvLc5XTK6uYq1/QzA2zNE82TAfXJDs1znJ4IXqGmxBieOduTi0L2B
         yA0g==
X-Gm-Message-State: AOAM530FXwuB1SqKVMplKKVAcqGALOEDBsrc2TZIyorV/lifWjsby5Tr
        dfrDKHzJ76lNTCr61RY6F7OTBMhDb4hSdiIPaps=
X-Google-Smtp-Source: ABdhPJxlD9ePR573gboSQuP4pVF+ng+tUDrShxsfNOD95SpC+4SlYehsqqwvaGLGyMaUy0EI8SKATk9/ngH5WPB8sk4=
X-Received: by 2002:a5d:87d5:: with SMTP id q21mr1612851ios.105.1616135614826;
 Thu, 18 Mar 2021 23:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com> <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com> <m1pmzwb7pd.fsf@fess.ebiederm.org>
In-Reply-To: <m1pmzwb7pd.fsf@fess.ebiederm.org>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Fri, 19 Mar 2021 14:33:23 +0800
Message-ID: <CAPx_LQHahNDvUkv08RZgUvbKZtdHNaSNRA1XqVDkNiwv5D=fXg@mail.gmail.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, christian@brauner.io,
        axboe@kernel.dk, Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Eric

> As I understand it this patch has two purposes:
> 1. Avoid the BUG_ON in zap_pid_ns_processes when !CONFIG_PID_NS
> 2. panic as early as possible so exiting threads don't removing
>   interesting debugging state.

Your understanding is very correct,this is what my patch wants to do

> I think if we are going to move the decrement of signal->live that
> should be it's own patch and be accompanied with a good description of
> why it is safe instead of having the decrement of signal->live be there
> as a side effect of another change.

I will think about the risks of movement of the decrement of
signal->live before exit_signal().
If is difficult to judge movement of the decrement of signal->live is
safe,how about only test 'signal->live=3D=3D1' not use group_dead?

Such as:
diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e3..87f3595 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -767,6 +767,17 @@ void __noreturn do_exit(long code)
        validate_creds_for_do_exit(tsk);

        /*
+        * If global init has exited,
+        * panic immediately to get a useable coredump.
+        */
+       if (unlikely(is_global_init(tsk) &&
+           ((atomic_read(&tsk->signal->live) =3D=3D 1) ||    /*current is
last init thread*/
+            (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
+                       panic("Attempted to kill init! exitcode=3D0x%08x\n"=
,
+                               tsk->signal->group_exit_code ?: (int)code);
+       }
+
+       /*
         * We're taking recursive faults here in do_exit. Safest is to just
         * leave this task alone and wait for reboot.
         */
@@ -784,16 +795,9 @@ void __noreturn do_exit(long code)
        if (tsk->mm)
                sync_mm_rss(tsk->mm);
        acct_update_integrals(tsk);
+
        group_dead =3D atomic_dec_and_test(&tsk->signal->live);
        if (group_dead) {
-               /*
-                * If the last thread of global init has exited, panic
-                * immediately to get a useable coredump.
-                */
-               if (unlikely(is_global_init(tsk)))
-                       panic("Attempted to kill init! exitcode=3D0x%08x\n"=
,
-                               tsk->signal->group_exit_code ?: (int)code);
-

Eric W. Biederman <ebiederm@xmission.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=883:09=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 03/18, qianli zhao wrote:
> >>
> >> Hi,Oleg
> >>
> >> Thank you for your reply.
> >>
> >> >> When init sub-threads running on different CPUs exit at the same ti=
me,
> >> >> zap_pid_ns_processe()->BUG() may be happened.
> >>
> >> > and why do you think your patch can't prevent this?
> >>
> >> > Sorry, I must have missed something. But it seems to me that you are=
 trying
> >> > to fix the wrong problem. Yes, zap_pid_ns_processes() must not be ca=
lled in
> >> > the root namespace, and this has nothing to do with CONFIG_PID_NS.
> >>
> >> Yes, i try to fix this exception by test SIGNAL_GROUP_EXIT and call
> >> panic before setting PF_EXITING to prevent zap_pid_ns_processes()
> >> being called when init do_exit().
> >
> > Ah, I didn't notice your patch does atomic_dec_and_test(signal->live)
> > before exit_signals() which sets PF_EXITING. Thanks for correcting me.
> >
> > So yes, I was wrong, your patch can prevent this. Although I'd like to
> > recheck if every do-something-if-group-dead action is correct in the
> > case we have a non-PF_EXITING thread...
> >
> > But then I don't understand the SIGNAL_GROUP_EXIT check added by your
> > patch. Do we really need it if we want to avoid zap_pid_ns_processes()
> > when the global init exits?
> >
> >> In addition, the patch also protects the init process state to
> >> successfully get usable init coredump.
> >
> > Could you spell please?
> >
> > Does this connect to SIGNAL_GROUP_EXIT check? Do you mean that you want
> > to panic earlier, before other init's sub-threads exit?
>
> That is my understanding.
>
> As I understand it this patch has two purposes:
> 1. Avoid the BUG_ON in zap_pid_ns_processes when !CONFIG_PID_NS
> 2. panic as early as possible so exiting threads don't removing
>    interesting debugging state.
>
>
> It is a bit tricky to tell if the movement of the decrement of
> signal->live is safe.  That affects current_is_single threaded
> which is used by unshare, setns of the time namespace, and setting
> the selinux part of creds.
>
> The usage in kernel/cgroup/cgroup.c:css_task_iter_advance seems safe.
> Hmm, Maybe not.  Today cgroup_thread_change_begin is held around
> setting PF_EXITING before signal->live is decremented.  So there seem to
> be some subtle cgroup dependencies.
>
> The usages of group_dead in do_exit seem safe, as except for the new
> one everything is the same.
>
> We could definitely take advantage of knowing group_dead in exit_signals
> to simplify it's optimization to not rerouting signals to living
> threads.
>
>
> I think if we are going to move the decrement of signal->live that
> should be it's own patch and be accompanied with a good description of
> why it is safe instead of having the decrement of signal->live be there
> as a side effect of another change.
>
> Eric
