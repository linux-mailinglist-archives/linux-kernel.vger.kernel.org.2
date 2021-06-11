Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF88D3A4214
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFKMjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231270AbhFKMjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:39:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49A3D613DD;
        Fri, 11 Jun 2021 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623415062;
        bh=4/xWLj/LFkupupWnBhy5p1HAWNHssEzAMsG9I6fJOfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueylYbEOtQCwRupx7J5SIztteqKvORqpO3efm/0bJUaulGT+QQ0MRHepoo4T9UKwg
         DLmqUvGVpAVhBZ3VKEbaTc/1KErSroH05dG+OpPjo799VY8SjXnTqpUvFFneNpl/Yi
         jnjojqXg6e8FL9sutLcwpUE5ss95BUKOMqepH09Xa7mMqqDLI1Q5s6fCfR7dJNWos5
         az6Gx7dp7lWqHRHe5hQ2MjKF8kr3youpMZ3rU6eiLIjfgvfsbjUk9/h00tE5yzC9/+
         ObpehnuiNmOR1FtaoIyMZRFPeI9ruMVu7Kj56fixpUvKwhO4PDZC5HKw/bgqRDgaD1
         uGjegWjUnmc/A==
Date:   Fri, 11 Jun 2021 14:37:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/6] posix-cpu-timers: Fix rearm racing against process
 tick
Message-ID: <20210611123740.GA143945@lothringen>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-2-frederic@kernel.org>
 <20210609115400.GD104634@lothringen>
 <YMNNtOTN9u3eC0n0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMNNtOTN9u3eC0n0@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 01:49:08PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 09, 2021 at 01:54:00PM +0200, Frederic Weisbecker wrote:
> > On Fri, Jun 04, 2021 at 01:31:54PM +0200, Frederic Weisbecker wrote:
> > > Since the process wide cputime counter is started locklessly from
> > > posix_cpu_timer_rearm(), it can be concurrently stopped by operations
> > > on other timers from the same thread group, such as in the following
> > > unlucky scenario:
> > > 
> > >          CPU 0                                CPU 1
> > >          -----                                -----
> > >                                            timer_settime(TIMER B)
> > >    posix_cpu_timer_rearm(TIMER A)
> > >        cpu_clock_sample_group()
> > >            (pct->timers_active already true)
> > > 
> > >                                            handle_posix_cpu_timers()
> > >                                                check_process_timers()
> > >                                                    stop_process_timers()
> > >                                                        pct->timers_active = false
> > >        arm_timer(TIMER A)
> > > 
> > >    tick -> run_posix_cpu_timers()
> > >        // sees !pct->timers_active, ignore
> > >        // our TIMER A
> > > 
> > > Fix this with simply locking process wide cputime counting start and
> > > timer arm in the same block.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > 
> > Fixes: 60f2ceaa8111 ("posix-cpu-timers: Remove unnecessary locking around cpu_clock_sample_group")
> > Cc: stable@vger.kernel.org
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> 
> Problem seems to be calling cpu_clock_sample_group(.start = true)
> without sighand locked. Do we want a lockdep assertion for that?

It's part of the problem. The other part is that it must be locked in the
same sequence than arm_timer(). So yes, a lockdep assertion would already be
a good indicator that something goes wrong.

Thanks.
