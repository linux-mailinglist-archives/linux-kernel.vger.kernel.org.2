Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44CE343352
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 17:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCUQBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhCUQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 12:01:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 09:01:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b83so17461146lfd.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tXKWMMfg8miJA9C0hVkfHJ7swyYrO3tVGxdR8alDg9c=;
        b=cDBvX69OEAFQM1Wux52+NouDAki2GpJR+te8B1J1UyVBcAr9bqjodbn7MzARzG+/Qi
         AsHY9mH6YCqUHhhfPX54ICA6pSmwmOMEihJYnLQhnlhd21Py9V6c7i3EqubX8Ypeu6h6
         VM9LHAsGP7LwqNGYAfyXtWFvld4HL0fvAWyWMG4MMRXGwbOzEtd1PTkQmS3uk2s8SpNl
         WNrzMVbM+kEcSkw8BE6WtMoAFdNlycBflV8C6W/uxMJrPTmPB6iePY7DUK1nk2LOoeqO
         F3FQ08JJKv7E6os6Dm1Fa73sC0TXuGX5Pj+sAq36xE/nlJ9HY2pTyWaFke8HgUGrvmd7
         4WOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tXKWMMfg8miJA9C0hVkfHJ7swyYrO3tVGxdR8alDg9c=;
        b=K7N7DWLLe4jpv9uDVtwqKojhkovvFLKbrMQ4nk3easKr6Tj5RW6Uw9m0hzFr8qWPPk
         Tyg4eqBdFedtkk0ra9MiJrtZKfuQXdoCu9fP146WkDW38hXb0RurmVwDYaeOND1OiTkH
         fmAZnY9b4E35iwZWtIt1oWEQcsCjzK8Itme93fAkkcjS4wa7Cv4CFajpQhIZXc6XawsI
         H1vOc0s6bt315LRe5XE8sG16OGqLE3ubGwupl4bOW+L0mdCraDsl7KB+voaWr/UtnV89
         oLhGCOte3X9Bty3NCHV/J+9Zr3+zeH0ZYX05SS3Gx0DL0b/pXL/MF2t7+h2zmMbYIKtF
         fQ7g==
X-Gm-Message-State: AOAM530ynsqtktBxJTRaFPxqV83BibTvBKV/5EbeMevHkprPo0rXjDzN
        0hFT7T0Wrs4UwNFVcAeFUG6E+RLZpFiiCDhTNIg=
X-Google-Smtp-Source: ABdhPJy0dksQ8xdCJn8MhUWfUSa0D3T3o0U8oOpV+lYq4yTEwtFR+DnK51vO7sd4fpMdLajFjZG84v9ZeMVuPrgm4fw=
X-Received: by 2002:a19:4151:: with SMTP id o78mr6519114lfa.252.1616342459514;
 Sun, 21 Mar 2021 09:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com> <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com> <m1pmzwb7pd.fsf@fess.ebiederm.org>
In-Reply-To: <m1pmzwb7pd.fsf@fess.ebiederm.org>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Mon, 22 Mar 2021 00:00:48 +0800
Message-ID: <CAPx_LQGBJGgZ+zzhJ2U4RpoPKt3hvf8LRfACtj2LPD7senub7A@mail.gmail.com>
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

Hi,Eric,Oleg

> It is a bit tricky to tell if the movement of the decrement of
> signal->live is safe

It is hard to say whether it is safe or not,below are just a few of my thou=
ghts

> That affects current_is_single threaded
> which is used by unshare, setns of the time namespace, and setting
> the selinux part of creds.

I think is ok in current_is_single_threaded,in check_unshare_flags()
and selinux_setprocattr()
change "signal->live--" position won't change the result,There is no
other dependency change to this patch and these function.

> The usage in kernel/cgroup/cgroup.c:css_task_iter_advance seems safe.
> Hmm, Maybe not.  Today cgroup_thread_change_begin is held around
> setting PF_EXITING before signal->live is decremented.  So there seem to
> be some subtle cgroup dependencies.

Moving the decrement position should only affect between new and old
code position of movement of the decrement of
signal->live.In this range,i think
acct_update_integrals(),sync_mm_rss() mainly updated some data,only
exit_signals() and sched_exit() need
attention.
cgroup_threadgroup_change_begin() is called in exit_signals(),and
css_task_iter_advance used "signal->live",it seems like it might be a
little related.
cgroup_threadgroup_change_begin() just give stable threadgroup for
user,and css_task_iter_advance only check if group is dead, decrement
of
signal->live and sets PF_EXITING seems like safe.

> I think if we are going to move the decrement of signal->live that
> should be it's own patch and be accompanied with a good description of
> why it is safe instead of having the decrement of signal->live be there
> as a side effect of another change.

I'm not sure how to describe whether this move is safe or not,from my
analysis, no side effects have been found.
Would you like tell me how to prove that or give me some suggestion?



Thanks

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
