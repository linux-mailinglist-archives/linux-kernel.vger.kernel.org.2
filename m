Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7138BABC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 02:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhEUARQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 20:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234612AbhEUARN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 20:17:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D794F6109F;
        Fri, 21 May 2021 00:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621556151;
        bh=KN/xo1lyoIiciG9V+VqlWx19KUfp8J5f+WyREaqusoU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e6JBFVBMjMOtGuOw3ilgjfYaLUsfqnviBEew5unIppvInUsZXyizRTMSrQSWvYHuA
         kkfJktbLa2XxBrODrZqhxlrG66hNiDXSWcoK/krfiry6dPQb7t121a5YirPmzeJc2E
         s9qv2ejQWrwtmnPTvyeDV6eMta/yfZgNRvkJBPw/KBtlCe9W9o+FjbovdfnZdk3e0n
         uY9l2hRjQTvbKvrnhcN9OieseLRnBSJByVwTT88p6RRizfqwvhJ6XfoP7WE0fZ3E9J
         nx3b37oSJdq51xp/fOly1Opm6vCbxnVEj2OC21F5xFj/wP0xUYMZNbuVIS+DsNkeGu
         EE783aWZleRCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A05D15C023D; Thu, 20 May 2021 17:15:51 -0700 (PDT)
Date:   Thu, 20 May 2021 17:15:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <20210521001551.GS4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
 <YKX4ueNIabfd1DAD@google.com>
 <20210520145708.GK4441@paulmck-ThinkPad-P17-Gen-1>
 <YKbkAXELPxXJcsHA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKbkAXELPxXJcsHA@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 07:34:41AM +0900, Sergey Senozhatsky wrote:
> On (21/05/20 07:57), Paul E. McKenney wrote:
> > > 
> > > Sounds good. I can cook a patch and run some tests.
> > > Or do you want to send a patch?
> > 
> > Given that you have the test setup, things might go faster if you do
> > the patch, especially taking timezones into consideration.  Of course,
> > if you run into difficulties, you know where to find me.
> 
> OK. Sounds good to me.
> 
> > > While VCPU-2 has PVCLOCK_GUEST_STOPPED set (resuming) and is in
> > > check_cpu_stall(), the VCPU-3 is executing:
> > > 
> > > 	apic_timer_interrupt()
> > > 	 tick_irq_enter()
> > > 	  tick_do_update_jiffies64()
> > > 	   do_timer()
> > 
> > OK, but the normal grace period time is way less than one second, and
> > the stall timeout in mainline is 21 seconds, so that would be a -lot-
> > of jiffies of skew.  Or does the restarting really take that long a time?
> 
> That's a good question. I see huge jiffies spike in the logs.
> I suspect that resuming a VM can take some time, especially on a "not
> powerful at all" overcommitted host (more virtual CPUs than physical
> ones).

I really am just asking the question.  ;-)

After all, if restarting a VM can take that long, then it can take
that long.

							Thanx, Paul
