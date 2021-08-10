Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0004C3E0300
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhHDOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:23:41 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:56447 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238696AbhHDOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:23:22 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 9CAB7BAC12
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 15:23:07 +0100 (IST)
Received: (qmail 31886 invoked from network); 4 Aug 2021 14:23:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Aug 2021 14:23:07 -0000
Date:   Wed, 4 Aug 2021 15:23:06 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-ID: <20210804142306.GE6464@techsingularity.net>
References: <20210723100034.13353-1-mgorman@techsingularity.net>
 <20210723100034.13353-3-mgorman@techsingularity.net>
 <87czqu2iew.ffs@tglx>
 <20210804095425.GA6464@techsingularity.net>
 <91b2f893-eb6a-d91d-3769-baba8601b0f6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <91b2f893-eb6a-d91d-3769-baba8601b0f6@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 03:42:25PM +0200, Vlastimil Babka wrote:
> > Each counter
> > would need to be audited and two question are asked
> > 
> >  o If this counter is inaccurate, does anything break?
> >  o If this counter is inaccurate, does it both increment and decrement
> >    allowing the possibility it goes negative?
> > 
> > The decision on that is looking at the counter and seeing if any
> > functional decision is made based on its value. So two examples;
> > 
> > 	NR_VMSCAN_IMMEDIATE is a node-based counter that only every
> > 	increments and is reported to userspace. No kernel code makes
> > 	any decision based on its value. Therefore it's likely safe to
> > 	move to numa_stat_item instead.
> > 
> > 	Action: move it
> > 
> > 	WORKINGSET_ACTIVATE_FILE is a node-based counter that is used to
> > 	determine if a mem cgroup is potentially congested by looking at
> > 	the ratio of cgroup to node refault rates as well as deciding if
> > 	LRU file pages should be deactivate.  If that value drifts, the
> > 	ratios are miscalculated and could lead to functional oddities
> > 	and therefore must be accurate.
> > 
> > 	Action: leave it alone
> > 
> > I guess it could be further split into state that must be accurate from
> > IRQ and non-IRQ contexts but that probably would be very fragile and
> > offer limited value.
> > 
> >> Brilliant stuff which prevents you to do any validation on this. Over
> >> the years there have been several issues where callers had to be fixed
> >> by analysing bug reports instead of having a proper instrumentation in
> >> that code which would have told the developer that he got it wrong.
> >> 
> > 
> > I'm not sure it could be validated at build-time but I'm just back from
> > holiday and may be lacking imagination.
> 
> The idea was not build-time, but runtime (hidden behind lockdep, VM_DEBUG or
> whatnot), i.e.:
> 
> <sched_expert> what that code needs is switch(item) { case foo1: case foo2:
> lockdep_assert_irqs_disabled(); break; case bar1: case bar2:
> lockdep_assert_preempt_disabled(); lockdep_assert_no_in_irq(); break; } or
> something along those lines
> 

Ok, that would potentially work. It may not even need to split the stats
into different enums. Simply document which stats need protection from
IRQ or preemption and use PROVE_LOCKING to check if preemption or IRQs
are disabled depending on the kernel config. I don't think it gets rid
of preempt_disable_rt unless the API was completely reworked with entry
points that describe the locking requirements. That would be tricky
because the requirements differ between kernel configurations.

This would be independent of moving stats that do not need to be 100%
accurate to the inaccurate-but-fast API.

-- 
Mel Gorman
SUSE Labs
