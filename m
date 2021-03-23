Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74581345A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCWJBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhCWJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616490044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWw3kWdtENu9t9xPM4vhY+e28wrcAVHEu4+nKAflgTk=;
        b=RvO40N0vvJYDygLOLCdcAc71mqG9jppRwSpfhzwSryhfAf0XR9jEvIakqKi7A/WLbup+ri
        FNXvnl77/6+zFlUs6dnYdzXznz1oE2sgW0FtkPEkDzFcSXVYcGZ8ivWnd2XVOLVWPKeWeY
        GZXW+Qjb9VD0hhgswA7J2ONXjdNlqVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-PDnnolU_Ph24SbrMaHgqWQ-1; Tue, 23 Mar 2021 05:00:41 -0400
X-MC-Unique: PDnnolU_Ph24SbrMaHgqWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1008800D53;
        Tue, 23 Mar 2021 09:00:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.86])
        by smtp.corp.redhat.com (Postfix) with SMTP id 37B8110023B2;
        Tue, 23 Mar 2021 09:00:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 23 Mar 2021 10:00:39 +0100 (CET)
Date:   Tue, 23 Mar 2021 10:00:36 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qianli zhao <zhaoqianligood@gmail.com>
Cc:     christian@brauner.io, axboe@kernel.dk,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
Message-ID: <20210323090035.GA25159@redhat.com>
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com>
 <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com>
 <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
 <20210319163225.GB19971@redhat.com>
 <CAPx_LQGLYx8gKJSkCx9hTyPPbCbU=GJL31TPb3s6zxro522U0Q@mail.gmail.com>
 <20210322163705.GD20390@redhat.com>
 <CAPx_LQG_5ushJkyymSsYq8FafRj7XOA217JwCyHASEqq0wyMOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx_LQG_5ushJkyymSsYq8FafRj7XOA217JwCyHASEqq0wyMOQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, qianli zhao wrote:
>
> Hi,Oleg
>
> > No, there is at least one alive init thread. If they all have exited, we have
> > the thread which calls panic() above.
>
> By current logic, setting PF_EXITING(exit_signals()) is before the
> panic(),

You certainly don't understand me :/

Please read my email you quoted below. I didn't mean the current logic.
I meant the logic after your patch which moves atomic_dec_and_test() and
panic() before exit_signals().

Oleg.

> find_alive_thread() determines the PF_EXITING of all child
> threads, the panic thread's PF_EXITING has been set before panic(),so
> find_alive_thread() thinks this thread also dead, resulting in
> find_alive_thread returning NULL.It is possible to trigger a
> zap_pid_ns_processes()->BUG() in this case.
> ========
> exit_signals(tsk);  /* sets PF_EXITING */
> ...
> group_dead = atomic_dec_and_test(&tsk->signal->live);
> if (group_dead) {
> if (unlikely(is_global_init(tsk)))
> panic("Attempted to kill init!
> exitcode=0x%08x\n",-------------------->//PF_EXITING has been set
> tsk->signal->group_exit_code ?: (int)code);
> 
> =======
> 
> > Why do you think so? It can affect _any_ code which runs under
> > "if (group_dead)". Again, I don't see anything wrong, but I didn't even
> > try to audit these code paths.
> 
> Yes,all places where checked the "signal->live" may be affected,but
> even before my changes, each program that checks "signal->live" may
> get different state(group_dead or not), depending on the timing of the
> caller,this situation will not change after my change.
> After my patch,"signal->live--" and other variable are set in a
> different order(such as signal->live and PF_EXITING),this can cause
> abnormalities in the logic associated with these two variables,that is
> my thinking.
> Of course, check all the "signal->live--" path is definitely
> necessary,it's just the case above that we need more attention.
> 
> Thanks
> 
> Oleg Nesterov <oleg@redhat.com> 于2021年3月23日周二 上午12:37写道：
> >
> > Hi,
> >
> > It seems that we don't understand each other.
> >
> > If we move atomic_dec_and_test(signal->live) and do
> >
> >         if (group_dead && is_global_init)
> >                 panic(...);
> >
> >
> > before setting PF_EXITING like your patch does, then zap_pid_ns_processes()
> > simply won't be called.
> >
> > Because:
> >
> > On 03/21, qianli zhao wrote:
> > >
> > > Hi,Oleg
> > >
> > > > How? Perhaps I missed something again, but I don't think this is possible.
> > >
> > > > zap_pid_ns_processes() simply won't be called, find_child_reaper() will
> > > > see the !PF_EXITING thread which calls panic().
> > >
> > > > So I think this should be documented somehow, at least in the changelog.
> > >
> > > This problem occurs when both two init threads enter the do_exit,
> > > One of the init thread is syscall sys_exit_group,and set SIGNAL_GROUP_EXIT
> > > The other init thread perform ret_to_user()->get_signal() and found
> > > SIGNAL_GROUP_EXIT is set,then do_group_exit()->do_exit(),since there
> > > are no alive init threads it finally goes to
> > > zap_pid_ns_processes()
> >
> > No, there is at least one alive init thread. If they all have exited, we have
> > the thread which calls panic() above.
> >
> > > and BUG().
> >
> > so we don't need the SIGNAL_GROUP_EXIT check to avoid this BUG().
> >
> > What have I missed?
> >
> > Oleg.
> >
> 

