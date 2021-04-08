Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31057358BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhDHRsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:48:22 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:60983 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232552AbhDHRsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:48:19 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 5FEF8BAA42
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 18:48:06 +0100 (IST)
Received: (qmail 27078 invoked from network); 8 Apr 2021 17:48:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Apr 2021 17:48:06 -0000
Date:   Thu, 8 Apr 2021 18:48:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 0/11 v2] Use local_lock for pcp protection and reduce
 stat overhead
Message-ID: <20210408174804.GH3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <YG7hQeOthUbPBU86@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YG7hQeOthUbPBU86@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 12:56:01PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 09:24:12PM +0100, Mel Gorman wrote:
> > Why local_lock? PREEMPT_RT considers the following sequence to be unsafe
> > as documented in Documentation/locking/locktypes.rst
> > 
> >    local_irq_disable();
> >    raw_spin_lock(&lock);
> 
> Almost, the above is actually OK on RT. The problematic one is:
> 
> 	local_irq_disable();
> 	spin_lock(&lock);
> 
> That doesn't work on RT since spin_lock() turns into a PI-mutex which
> then obviously explodes if it tries to block with IRQs disabled.
> 
> And it so happens, that's exactly the one at hand.

Ok, I completely messed up the leader because it was local_irq_disable()
+ spin_lock() that I was worried about. Once the series is complete,
it is replated with

  local_lock_irq(&lock_lock)
  spin_lock(&lock);

According to Documentation/locking/locktypes.rst, that should be safe.
I'll rephrase the justification.

-- 
Mel Gorman
SUSE Labs
