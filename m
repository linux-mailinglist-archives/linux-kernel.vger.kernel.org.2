Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8EE432B23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhJSATE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJSATD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:19:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7F8D61212;
        Tue, 19 Oct 2021 00:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602611;
        bh=Xy0xAnuVNmz1guGX9ZAWmcVqdq0Okw/zlPTayCGIx98=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WCqTxsgwJEIKZVOLO7k3acj9b55H8f/cBwK/pllx7HvCJ59AQc+rjGqwu+IhqfVn0
         l9lxIwGxHEW/lddayN3bxzxUYyVrcErfGTyZteOKlcgSrtLai3SMaYQr5qS4ZS/XiH
         0mwBj1GYrOFOUXaHCVBFI+dips1HbHzinhBCjMYEUCZZyc4UunkMXtGXuoSX1wF69n
         JdqxyCsExxUCdlDncu8QLvBFeC8z9WLr1TcM5kheuR+8HQsl1ILlGLfaTiF2nNi8Du
         aVnW20Y1ssjOLZLO10AJvaBKaxyg55ZzvFAC6Vl3eL/nTOLmTBM//TwM/iSODgQ0N2
         ch6vhw+8XlvJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 67D835C1044; Mon, 18 Oct 2021 17:16:51 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:16:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 00/10] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB
 + a few other fixes v3
Message-ID: <20211019001651.GA880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211019000816.455375-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000816.455375-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:08:06AM +0200, Frederic Weisbecker wrote:
> Changes since v2:
> 
> _ Drop first patch (got applied by Paul)
> 
> _ Fix unwanted rcu_core() hanging around after setting a CPU as nocb
>   on boot. This resulted in terrible rcu_barrier() misordering.
>   I simply forgot to clear SEGCBLIST_RCU_CORE on nocb CPUs on boot.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/rt-v3
> 
> HEAD: 7610a2ba5eaca8caf977ed45bad251ac693feefa

Queued for further review and testing!

							Thanx, Paul

> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (9):
>       rcu/nocb: Prepare state machine for a new step
>       rcu/nocb: Invoke rcu_core() at the start of deoffloading
>       rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
>       rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
>       rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
>       rcu/nocb: Limit number of softirq callbacks only on softirq
>       rcu: Fix callbacks processing time limit retaining cond_resched()
>       rcu: Apply callbacks processing time limit only on softirq
>       rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread
> 
> Thomas Gleixner (1):
>       rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe
> 
> 
>  include/linux/rcu_segcblist.h | 51 ++++++++++++++++++-------
>  kernel/rcu/rcu_segcblist.c    | 10 ++---
>  kernel/rcu/rcu_segcblist.h    | 12 +++---
>  kernel/rcu/tree.c             | 87 +++++++++++++++++++++++++++++--------------
>  kernel/rcu/tree_nocb.h        | 33 ++++++++++++----
>  5 files changed, 133 insertions(+), 60 deletions(-)
