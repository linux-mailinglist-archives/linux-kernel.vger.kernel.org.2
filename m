Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5393C3D2540
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhGVNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhGVNbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9687C6128D;
        Thu, 22 Jul 2021 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626963104;
        bh=V+sLG4qAXAhb4gZ8Cas6iEjPeFVyhWhtpTlGXEov5Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jN3HspfSGQrcBDlVWnOQq3eXWx4ndzEz0xp2E9yZsR8SpacrmA5QoUbdA6hhl89mD
         zmJ74NCQojb5GKkcdVTrQEuFt3TqlT9st9AHgcrvqOWQ9OEY8EP4go0U/i0f+B1RgL
         V6uqIem/q9mWdBniNzOgU2c2VkABNKNIi9y8KQac=
Date:   Thu, 22 Jul 2021 16:11:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 4.4.262: infinite loop in futex_unlock_pi (EAGAIN loop)
Message-ID: <YPl8nfZBjgmSnE7N@kroah.com>
References: <20210719162418.GA28003@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719162418.GA28003@zipoli.concurrent-rt.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:24:18PM -0400, Joe Korty wrote:
> [BUG] 4.4.262: infinite loop in futex_unlock_pi (EAGAIN loop)
> 
>    [ replicator, attached ]
>    [ workaround patch that crudely clears the loop, attached ]
>    [ 4.4.256 does _not_ have this problem, 4.4.262 is known to have it ]
> 
> When a certain, secure-site application is run on 4.4.262, it locks up and
> is unkillable.  Crash(8) and sysrq backtraces show that the application
> is looping in the kernel in futex_unlock_pi.
> 
> Between 4.4.256 and .257, 4.4 got this 4.12 patch backported into it:
> 
>    73d786b ("[PATCH] futex: Rework inconsistent rt_mutex/futex_q state")
> 
> This patch has the following comment:
> 
>    The only problem is that this breaks RT timeliness guarantees. That
>    is, consider the following scenario:
> 
>       T1 and T2 are both pinned to CPU0. prio(T2) > prio(T1)
> 
>         CPU0
> 
>         T1
>           lock_pi()
>           queue_me()  <- Waiter is visible
>    
>         preemption
> 
>         T2
>           unlock_pi()
>             loops with -EAGAIN forever
> 
>     Which is undesirable for PI primitives. Future patches will rectify
>     this.
> 
> This describes the situation exactly.  To prove, we developed a little
> kernel patch that, on loop detection, puts a message into the kernel log for
> just the first occurrence, keeps a count of the number of occurrences seen
> since boot, and tries to break out of the loop via usleep_range(1000,1000).
> Note that the patch is not really needed for replication.  It merely shows,
> by 'fixing' the problem, that it really is the EAGAIN loop that triggers
> the lockup.
> 
> Along with this patch, we submit a replicator.  Running this replicator
> with this patch, it can be seen that 4.4.256 does not have the problem.
> 4.4.267 and the latest 4.4, 4.4.275, do.  In addition, 4.9.274 (tested
> w/o the patch) does not have the problem.
> 
> >From this pattern there may be some futex fixup patch that was ported
> back into 4.9 but failed to make it to 4.4.

Odd, I can't seem to find anything that we missed.  Can you dig to see
if there is something that we need to do here so we can resolve this?

thanks,

greg k-h
