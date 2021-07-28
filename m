Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700C23D9856
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 00:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhG1WXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 18:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232022AbhG1WXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:23:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2482861019;
        Wed, 28 Jul 2021 22:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627511015;
        bh=7leYzEKTO72ulBPDz/mgh+DcPVqVRolcwyFWqDqo9IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArOyjbf5QGrNOWYvt/INH53Y9I4ux9FxbaP6tx589HA/38DQLCDVV946md4fAlv2O
         JhZWuphwPUJt6ZblFwXVs9Pv6jvsky0TnK9EPqad3hGo8vI0jwjnL3/uFjbYFE/T9p
         saVO98tXbh9rOHbu7QRVZPscxR6beRqdSC9EUBj65RkqkFabD3xySla35OWbs2Da9U
         E/rmNdtyE2ZMqVxQEiHti0iRImWs+LoOdW06NjIS1WFAlX5HqefRyjQUPYPyXmYjad
         dNPtnTEMFN8+l6mPye3AgMErOW17V2Z7scL3Ri2e6YJtsMD3KiktWi4JMEuu4r6IHQ
         KOfjiIHcnDRbQ==
Date:   Thu, 29 Jul 2021 00:23:33 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, tglx@linutronix.de,
        peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210728222333.GE293265@lothringen>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <YQG//899pPl2JIWw@localhost>
 <20210728204720.GN4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728204720.GN4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:47:20PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 28, 2021 at 01:37:19PM -0700, Josh Triplett wrote:
> > On Wed, Jul 28, 2021 at 10:37:15AM -0700, Paul E. McKenney wrote:
> > > This change makes the memory ordering requirements
> > > more evident, and it might well also speed up the to-idle and from-idle
> > > fastpaths on some architectures.
> > 
> > Cleaning up the memory ordering requirements certainly seems worthwhile.
> > But is there any straightforward benchmark that might quantify the
> > "might well also speed up" here? How much does weakening the memory
> > ordering buy us, in practice?
> 
> None that I know of!

I know two:

1) The whole debate makes us review again (and again) the memory ordering
   requirements in RCU VS dynticks-idle, which can only be good to enforce
   correctness.

2) The more we weaken the ordering, the better we grasp and understand the
   underlying ordering requirements. Unnecessary full memory barriers tend to
   obfuscate our ordering expectations, making the code less self-explanatory.

3) I have terrible ideas to remove a full barrier in the dynticks idle path
   that should work in practice but not in theory and therefore I'm never going
   to talk about it unless everyone in the room is drunk.

