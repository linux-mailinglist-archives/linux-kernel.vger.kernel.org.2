Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16843E44B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJ1O4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhJ1O4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:56:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EFFB60C40;
        Thu, 28 Oct 2021 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635432825;
        bh=1b32YnGOeCfSOi4v14DG2S7TPp3ZV0ponCRXhoZ1mek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4xwiTUjJIoQplVWFWHtJyVpcWr1Ls10RX0Jy214OzMgQreVN+WM391nRMn9vi+Mh
         zCrPRMYbhoGMbrbySTAEghqA6273i6WsosAo4pkpRRUUMIp1FqNYHwZKoeZ5CQZZt8
         cdjDsO8Ywb1uPqLsyHfT0GqWNtkrhYN2MkRtKcA+1uBZri/eg+kWJmQIdcpNzb/HwD
         IsB5/9aWhaaEy4+C4412h/0AQAzhQ4/OAaPgRGjQbKJ3m23RQNQNreU8V0WA6NSq1k
         Pnuq3yo3P3lewfs7g5ULbWynYv+rrT2YwRNI+1ww+4aSwmj/PxNUCwbNn7UuPn4K/V
         2r6jm6FtrDBMg==
Date:   Thu, 28 Oct 2021 16:53:43 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v5 2/8] add prctl task isolation prctl docs and samples
Message-ID: <20211028145343.GB77014@lothringen>
References: <20211019152431.885037499@fedora.localdomain>
 <20211019154210.706067872@fedora.localdomain>
 <20211027123806.GA70141@lothringen>
 <20211027175247.GA296917@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027175247.GA296917@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 02:52:47PM -0300, Marcelo Tosatti wrote:
> On Wed, Oct 27, 2021 at 02:38:06PM +0200, Frederic Weisbecker wrote:
> > > +        The 'pmask' argument specifies the location of an 8 byte mask
> > > +        containing which features should be activated. Features whose
> > > +        bits are cleared will be deactivated. The possible
> > > +        bits for this mask are:
> > > +
> > > +                - ``ISOL_F_QUIESCE``:
> > > +
> > > +                Activate quiescing of background kernel activities.
> > > +                Quiescing happens on return to userspace from this
> > > +                system call, and on return from subsequent
> > > +                system calls (unless quiesce_oneshot_mask is configured,
> > > +                see below).
> > > +
> > > +        If the arg3 argument is non-zero, it specifies a pointer to::
> > > +
> > > +         struct task_isol_activate_control {
> > > +                 __u64 flags;
> > > +                 __u64 quiesce_oneshot_mask;
> > 
> > So you are using an entire argument here to set a single feature (ISOL_F_QUIESCE).
> 
> Yes, but there is room at "struct task_isol_activate_control" for other features 
> to use (and additional space in the remaining prctl arguments, if necessary).

Ok but we have a configuration syscall and an activation syscall. Why bothering
with config parts on activation syscall?


> 
> > It looks like the oneshot VS every syscall behaviour should be defined at
> > configuration time for individual ISOL_F_QUIESCE features.
> 
> It seems one-shot selection is dependent on the 
> application logic:
> 
> 	configure task isolation
> 	enable oneshot quiescing of kernel activities
> 	do {
> 		process data (no system calls)
> 		if (event) {
> 			process event with syscalls
> 			enable oneshot quiescing of kernel activities
> 		}
>        } while (!exit_condition);
> 
> Considering configuration performed outside the application (by chisol),
> is the administrator supposed to know the internals of the application
> at this level ?

If the launcher doesn't know about details, just leave them to the isolated
app. I mean we have a syscall to get the configured features, it's easy to
modify their configuration and set the oneshot mode on the place wanted
by the isolated app.

> 
> What if the application desires to use one-shot in a section
> (of code) and "all syscalls" for another section.

Doesn't sound like a problem.

> 
> > Also do we want that to always apply to all syscalls? Should we expect corner
> > cases with some of them? 
> 
> What type of corner cases do you think of?

I don't trust my imagination enough to display all possible user workloads.

> 
> > What about exceptions and interrupts?
> 
> Should move the isolation_exit_to_user_mode_prepare call from
> __syscall_exit_to_user_mode_work to exit_to_user_mode_prepare.
> Good point.
> 
> About your question. Think so, because otherwise: 
> 
>      enable oneshot quiescing of kernel activities
>      do {
>              process data (no system calls)	    <--- 1. IRQ/exception
>              if (event) {
>                      process event with syscalls
>                      enable oneshot quiescing of kernel activities
>              }
>      } while (exit_condition == false);
> 
> 
> If either an interrupt or exception occurs at point 1 above, userspace
> might not be notified, and the interrupt/exception handler might 
> change state in the kernel which makes the current CPU a target
> for IPIs, for example changing per-CPU vm statistics.

Ok but please leave configuration space to modify that in the future just in case.

Thanks.
