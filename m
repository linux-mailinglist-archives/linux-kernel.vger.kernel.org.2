Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A4A44DAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhKKRCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:02:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhKKRCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:02:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5514D611AD;
        Thu, 11 Nov 2021 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636650000;
        bh=SOJgNCQs2VmeLfMcIiAUa/P9miurRiJIhPfSbrNuO5s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e1m9I0MkJ+GowGBam1O2FfZk9ylK6AE5nTOn8BMBaaO4NEWM6QlAGXefRbX7+2gIl
         c1+9QKjHHoyOjlGFBgMGHPJGTvOSD0iWFtb6CEhsCfYugmUfqVSNO6O1+Np8rYH5Us
         4dU/RoowXTfoUc+TL2gen7ma0Bb6a47J/JQRwdpS+Rz2sh5eSZny1rk8XivEmucFJD
         hFwDFzH9kgbf5KIUHlN9Kpmb1Cd1LbxVSVx4KX+Xh/LUj6FsYdOY89p3eqiqo7OH//
         hnz6d24yDDLxgQEx93aN/g6MnFQhpz3Dqhy3v4r+IVLJ+7aOamcDPOm00YBFTCvAZ4
         /wREBbEo+Tmvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1F29B5C0527; Thu, 11 Nov 2021 09:00:00 -0800 (PST)
Date:   Thu, 11 Nov 2021 09:00:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     =?utf-8?B?67CV7JiB7KSA?= <her0gyu@naver.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Some question for synchronize_rcu_tasks
Message-ID: <20211111170000.GP641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <f34411bb1ea682892971ac2eb38762@cweb007.nm.nfra.io>
 <20211111154733.GN641268@paulmck-ThinkPad-P17-Gen-1>
 <547737bb65e9db75df674d097aa8129@cweb005.nm.nfra.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <547737bb65e9db75df674d097aa8129@cweb005.nm.nfra.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 01:21:16AM +0900, 박영준 wrote:
> Thank you for fast reply. 
> I missed the point kernel compile option dependency. 

Been there, done that!  I should have CCed LKML initially, so I did so
this time.  Others might have similar questions, after all.  Or better
answers, for that matter.

> I have more questions.  
> So, to what extent synchronize_sched guarantees if I apply OPTPROBE forcefully? what kind of problem happens?(on PREEMPT=y kernel that synchronize_rcu_tasks is not applied)
> (In my opinion it can not catchup preempted task switch on trampoline handler or preempt twice on trampoline handler)

Yes, doing that would be a bad idea and it could break as you say.

> And some not associated with RCU question..
> If I have to replace synchronize_sched not using synchronize_rcu_tasks,
> I think the possible way is to use live kernel patch style seeing task task switch + task eip address checking (is it on the trampoline?)is possible way. 
> (with proper locking, task stack seeing guarantees trampoline is not referenced, and task eip address checking guarantee possible stack trace fasle positive.)
> Do you think it is possible or impossible?

For one thing, in recent kernels, there is no synchronize_sched().
You instead use synchronize_rcu(), which handles preemption in kernels
built with PREEMPT=y.  But use of synchronize_rcu() to protect trampolines
in PREEMPT=y kernels require that the rcu_read_lock() be executed before
transfering to the trampoline and that the rcu_read_unlock() be executed
after returning from the trampoline.  This is not always convenient.

On your approach of checking the EIP, Mike Ask claimed that Apple did
something like this in their Objective-C runtime:
https://www.mikeash.com/pyblog/friday-qa-2015-05-29-concurrent-memory-deallocation-in-the-objective-c-runtime.html

But Linux systems can have tens of thousands of trampolines, at which point
that might not be a good approach.  Especially given that some trampolines
call functions, which means that you would need to trace the stack as well
as check the EIP.  Plus you would need to send IPIs to safely and reliably
check each CPU's state.

So why not avoid all these problems and just use synchronize_rcu_tasks()?

							Thanx, Paul

> Sincerely yours
> -----Original Message-----
> From: "Paul E. McKenney"<paulmck@kernel.org>
> To: "박영준"<her0gyu@naver.com>;
> Cc:
> Sent: 2021-11-12 (금) 00:47:33 (GMT+09:00)
> Subject: Re: Some question for synchronize_rcu_tasks
>  
> On Fri, Nov 12, 2021 at 12:08:31AM +0900, 박영준 wrote:
> > Dear paulmck
> > Hi I am the security developer of South Korea
> > recently I search the code patch area and I have some question of synchronize_rcu_tasks.
> > On the commit 'a30b85df7d599f626973e9cd3056fe755bd778e0'(kprobe/core.c) synchronize_sched is changed to synchronize_rcu_tasks.
> > As I understand, there is a problem for removal of trampoline handler.
> > In my opinion, on PREEMPT=y kernel, there is a chance to be preempted twice on trampoline handler which synchronize_sched does not wait or
> > synchronize_sched just guarantee pre-exiting interrupt is done therefore if the task on trampoline is switched to another task, it is totally problem.
> > (because it is switched to trampoline after some time later)
> > These are just my opinion so I am not sure of it. And As I think, maybe I don't know what I don't know.
> > If you give me some explanation or opinion, it will be very very helpful.
> > Thank you for reading my email.
> 
> If you are saying that synchronize_sched() would not be sufficient in
> a PREEMPT=y kernel, you are quite correct.  And this is why OPTPROBES
> depended on !PREEMPT before this patch was applied.
> 
> But in a PREEMPT=n kernel, there can be no preemption, and so in that
> case synchronize_sched() would work just fine.
> 
> Thus, the overall effect of this patch was to make OPTPROBES available
> in PREEMPT=y kernels as well as in PREEMPT=n kernels.
> 
> Or are you asking some other question?
> 
> Thanx, Paul
