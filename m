Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2112D3AB6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhFQPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233058AbhFQPEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:04:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7D7C613FB;
        Thu, 17 Jun 2021 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623942134;
        bh=EYhlWS7OTYyNZbRfd1Ohd426NpjeeKUY8OwIo+YZT4E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=inZYgQ5bi8uw6oOAX8EPOOtfKFDme0eliRQCBHGcYtTPCdQgFm7kSehT40IZDhwmM
         j9yFA4byMAK2cOqkoLtSNQe0bdInutyaeuvRd4VFac83IAkwZhZxn5NYR3JTcX/YXf
         zSGdF2Y8sk1RriYT/0Jv5jCCMshQ6luu5baJQ2aVGKRrQfgA+inSSeYDJBSY2IWoqc
         72ANYFGU4rSMcDqQ8wLB37eYsBI7EHUNfn/tfDO3CJrybo3ksV4DYA3141QjilF6RK
         BFN7jxPyAtrpYqIRUl+psX5ig39XJdBidkQpgmd1XamdAwax5ASMW4TgUXv/S4TROI
         zxeePoHFBwLmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8B6AF5C02A9; Thu, 17 Jun 2021 08:02:14 -0700 (PDT)
Date:   Thu, 17 Jun 2021 08:02:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
Message-ID: <20210617150214.GX4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:32:15PM -0700, Andy Lutomirski wrote:
> On Wed, Jun 16, 2021, at 7:57 PM, Andy Lutomirski wrote:
> > On Wed, Jun 16, 2021, at 6:37 PM, Nicholas Piggin wrote:
> > > Excerpts from Andy Lutomirski's message of June 17, 2021 4:41 am:
> > > > On 6/16/21 12:35 AM, Peter Zijlstra wrote:
> > > >> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
> > > >>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> > > >>>> membarrier() needs a barrier after any CPU changes mm.  There is currently
> > > >>>> a comment explaining why this barrier probably exists in all cases.  This
> > > >>>> is very fragile -- any change to the relevant parts of the scheduler
> > > >>>> might get rid of these barriers, and it's not really clear to me that
> > > >>>> the barrier actually exists in all necessary cases.
> > > >>>
> > > >>> The comments and barriers in the mmdrop() hunks? I don't see what is 
> > > >>> fragile or maybe-buggy about this. The barrier definitely exists.
> > > >>>
> > > >>> And any change can change anything, that doesn't make it fragile. My
> > > >>> lazy tlb refcounting change avoids the mmdrop in some cases, but it
> > > >>> replaces it with smp_mb for example.
> > > >> 
> > > >> I'm with Nick again, on this. You're adding extra barriers for no
> > > >> discernible reason, that's not generally encouraged, seeing how extra
> > > >> barriers is extra slow.
> > > >> 
> > > >> Both mmdrop() itself, as well as the callsite have comments saying how
> > > >> membarrier relies on the implied barrier, what's fragile about that?
> > > >> 
> > > > 
> > > > My real motivation is that mmgrab() and mmdrop() don't actually need to
> > > > be full barriers.  The current implementation has them being full
> > > > barriers, and the current implementation is quite slow.  So let's try
> > > > that commit message again:
> > > > 
> > > > membarrier() needs a barrier after any CPU changes mm.  There is currently
> > > > a comment explaining why this barrier probably exists in all cases. The
> > > > logic is based on ensuring that the barrier exists on every control flow
> > > > path through the scheduler.  It also relies on mmgrab() and mmdrop() being
> > > > full barriers.
> > > > 
> > > > mmgrab() and mmdrop() would be better if they were not full barriers.  As a
> > > > trivial optimization, mmgrab() could use a relaxed atomic and mmdrop()
> > > > could use a release on architectures that have these operations.
> > > 
> > > I'm not against the idea, I've looked at something similar before (not
> > > for mmdrop but a different primitive). Also my lazy tlb shootdown series 
> > > could possibly take advantage of this, I might cherry pick it and test 
> > > performance :)
> > > 
> > > I don't think it belongs in this series though. Should go together with
> > > something that takes advantage of it.
> > 
> > I’m going to see if I can get hazard pointers into shape quickly.

One textbook C implementation is in perfbook CodeSamples/defer/hazptr.[hc]
git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git

A production-tested C++ implementation is in the folly library:

https://github.com/facebook/folly/blob/master/folly/synchronization/Hazptr.h

However, the hazard-pointers get-a-reference operation requires a full
barrier.  There are ways to optimize this away in some special cases,
one of which is used in the folly-library hash-map code.

> Here it is.  Not even boot tested!
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=sched/lazymm&id=ecc3992c36cb88087df9c537e2326efb51c95e31
> 
> Nick, I think you can accomplish much the same thing as your patch by:
> 
> #define for_each_possible_lazymm_cpu while (false)
> 
> although a more clever definition might be even more performant.
> 
> I would appreciate everyone's thoughts as to whether this scheme is sane.
> 
> Paul, I'm adding you for two reasons.  First, you seem to enjoy bizarre locking schemes.  Secondly, because maybe RCU could actually work here.  The basic idea is that we want to keep an mm_struct from being freed at an inopportune time.  The problem with naively using RCU is that each CPU can use one single mm_struct while in an idle extended quiescent state (but not a user extended quiescent state).  So rcu_read_lock() is right out.  If RCU could understand this concept, then maybe it could help us, but this seems a bit out of scope for RCU.

OK, I should look at your patch, but that will be after morning meetings.

On RCU and idle, much of the idle code now allows rcu_read_lock() to be
directly, thanks to Peter's recent work.  Any sort of interrupt or NMI
from idle can also use rcu_read_lock(), including the IPIs that are now
done directly from idle.  RCU_NONIDLE() makes RCU pay attention to the
code supplied as its sole argument.

Or is your patch really having the CPU expect a mm_struct to stick around
across the full idle sojourn, and without the assistance of mmgrab()
and mmdrop()?

Anyway, off to meetings...  Hope this helps in the meantime.

							Thanx, Paul
