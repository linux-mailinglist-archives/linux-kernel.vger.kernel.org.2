Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E683A4361
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFKNyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230129AbhFKNyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:54:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B642613F4;
        Fri, 11 Jun 2021 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623419527;
        bh=VPDnYEcXBaAP73z7e3H1wrxz0g6huN2/P3YXTvT+CZw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ldleo5BlVFqa+4KPD7zKCRBwm+wwzKxMMxU5XdC06AAMJ9J8ViBX1PnH//GDn8Kxn
         +JwvgQcTWFTfETJdZl7PznQ2p7b/KK/zfwdBeVggjzuIEE5WseVdnaV2jMa4wefKct
         dmv4kc21O4jWq/WZjEjJ0MZf1D5Fs0MuQVfIrq/5AN0yik0DLr0xAhSg6DtsSN6eNH
         IuUZLSEw8ypRSGQtvI8e87neLlfM0fXtAwtAgN0VBg0bnzL6pb3ka9QSVDEC3lkjvZ
         fqs7q/8ancJNNPGNcrA6wCWOlBhLKMDG4s2zyv32t7bTCOGLsSS+gXWUcd/9W3UEQx
         npl9MI+Q5TodA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 079E55C0990; Fri, 11 Jun 2021 06:52:07 -0700 (PDT)
Date:   Fri, 11 Jun 2021 06:52:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about a8ea6fc9b089 ("sched: Stop PF_NO_SETAFFINITY from
 being inherited by various init system threads")
Message-ID: <20210611135207.GB4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210610170435.GA2187550@paulmck-ThinkPad-P17-Gen-1>
 <8735tpd15i.mognet@arm.com>
 <20210610201713.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <87zgvwbtgy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgvwbtgy.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 11:12:29AM +0100, Valentin Schneider wrote:
> On 10/06/21 13:17, Paul E. McKenney wrote:
> > On Thu, Jun 10, 2021 at 07:28:57PM +0100, Valentin Schneider wrote:
> >> On 10/06/21 10:04, Paul E. McKenney wrote:
> >>
> >> Hi,
> >> > Hello, Frederic,
> >> >
> >> > This commit works well, but has the unfortunate side-effect of making
> >> > smp_processor_id() complain when used in a preemptible region even
> >> > though the kthread has been pinned onto a single CPU by a call to
> >> > set_cpus_allowed_ptr().  (Which did return success.)
> >> >
> >>
> >> On which tree are you encountering this?
> >
> > I bisected to this commit in -next tag next-20210609, and this commit
> > could of course be an innocent bystander caught in the crossfire.
> >
> >> Looking at check_preemption_disabled() and CPU affinity, v5.13-rc5 has:
> >>
> >>         /*
> >>          * Kernel threads bound to a single CPU can safely use
> >>          * smp_processor_id():
> >>          */
> >>         if (current->nr_cpus_allowed == 1)
> >>                 goto out;
> >>
> >> tip/sched/core additionally hinges that on PF_NO_SETAFFINITY:
> >>
> >>   570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed")
> >>
> >> The former shouldn't be affected by Frederic's patch, and the latter should
> >> only cause warnings if the pinned task isn't a "proper" kthread (thus
> >> doesn't have PF_NO_SETAFFINITY)... Exceptions that come to mind are things
> >> like UMH which doesn't use kthread_create().
> >
> > And reverting 570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread()
> > instead of nr_cpus_allowed") causes the kernel to once again be OK with
> > smp_processor_id(), so thank you!  And apologies to Frederic for the
> > false alarm.
> >
> > Added Yejune on CC.  Thoughts?
> >
> 
> The way I see 570a752b7a9b is that, if a task is pinned to a single CPU but
> doesn't have PF_NO_SETAFFINITY, then userspace can unpin it. This means it
> ought to have entered check_preemption_disabled() with preemption disabled
> - right now it may be pinned, but that can change at any minute, and
> whatever code it is running needs to cope with that.

Thank you for catching me up on this topic!

> Could you share some details on which tasks you are hitting this with?

Let's start with ref_scale_reader() in kernel/rcu/refscale.c.  This
is for fine-grained in-kernel benchmarking, so it really wants kthreads
running this function to be pinned.

I took a look at kthread_bind(), but it is not intended to be called by
the kthread itself.  Looking elsewhere in the kernel, it looks like I
just do this right after invoking set_cpus_allowed_ptr():

	current->flags != PF_NO_SETAFFINITY;

Or am I missing a better way to handle this?

							Thanx, Paul
