Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEA93A4781
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhFKRMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFKRMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76FC360C40;
        Fri, 11 Jun 2021 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431408;
        bh=ijiuVjoEU8Sjqwi+JOdgiIT8OiTYDBpfgfcUmyy69Oo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lq7btG2JOWJwsHk5i52/GzHYPF7HpTobZVUhCQWu8H/6NqWS1fEpjzh/ZmW7GJfzF
         syjufNNDjycvkGNj3AXlmitGWQ9HEAHOHovb4qs3hKP6VGf8KdXXuJw9+ox4p2E0ES
         5FrvJwSWOiXg8D+0qzUkEBDX+IPqmRkk9j9/0r0MrHWelmbjT9NQhMz8q+UwHA/ANz
         ahUyDfxjYjvSmYpEcaomG5vEM0frF0RQQfIlYaQCivnrOGw9EvgO2Fwd2ILLRR00U1
         0zF5SbfF9f9HjCU1KbkDH4mMv62plVK0NGTl1tEJf6rOqgxrw4IHlxZRMT1b7BQ1JJ
         Vz2yKtEyitSbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2C2205C0990; Fri, 11 Jun 2021 10:10:08 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:10:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about a8ea6fc9b089 ("sched: Stop PF_NO_SETAFFINITY from
 being inherited by various init system threads")
Message-ID: <20210611171008.GE4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210610170435.GA2187550@paulmck-ThinkPad-P17-Gen-1>
 <8735tpd15i.mognet@arm.com>
 <20210610201713.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <87zgvwbtgy.mognet@arm.com>
 <20210611135207.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <87r1h8bi1a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1h8bi1a.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 03:19:29PM +0100, Valentin Schneider wrote:
> On 11/06/21 06:52, Paul E. McKenney wrote:
> > On Fri, Jun 11, 2021 at 11:12:29AM +0100, Valentin Schneider wrote:
> >>
> >> The way I see 570a752b7a9b is that, if a task is pinned to a single CPU but
> >> doesn't have PF_NO_SETAFFINITY, then userspace can unpin it. This means it
> >> ought to have entered check_preemption_disabled() with preemption disabled
> >> - right now it may be pinned, but that can change at any minute, and
> >> whatever code it is running needs to cope with that.
> >
> > Thank you for catching me up on this topic!
> >
> >> Could you share some details on which tasks you are hitting this with?
> >
> > Let's start with ref_scale_reader() in kernel/rcu/refscale.c.  This
> > is for fine-grained in-kernel benchmarking, so it really wants kthreads
> > running this function to be pinned.
> >
> > I took a look at kthread_bind(), but it is not intended to be called by
> > the kthread itself.  Looking elsewhere in the kernel, it looks like I
> > just do this right after invoking set_cpus_allowed_ptr():
> >
> >       current->flags != PF_NO_SETAFFINITY;
> >
> > Or am I missing a better way to handle this?
> 
> Looking at ref_scale_reader(), ISTM the initial configuration (affinity,
> niceness) should be done by its parent thread, not by itself. i.e.:
> 
>   p = kthread_create(ref_scale_reader);
>   kthread_bind(p, cpu); // Does the pinning + sets PF_NO_SETAFFINITY
>   set_user_nice(p, MAX_NICE);
>   wake_up_process(p);
> 
> (kthread_create_on_cpu() is also an option)
> 
> >From what I can see, torture_create_kthread() immediately wakes the
> newly-created kthread, we'd need a version that calls kthread_create()
> instead of kthread_run() for the above. Would that be an issue?

It sounds much simpler for me to just continue using raw_smp_processor_id()
instead of trying to switch back to smp_processor_id().  ;-)

							Thanx, Paul
