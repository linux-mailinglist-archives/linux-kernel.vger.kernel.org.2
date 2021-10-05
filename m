Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50986422341
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhJEKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:25:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85395C06161C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BKjJk7N2hs82NV5F7Wrm+Pt63yNzmZzO318tZ6LN/jA=; b=rUKdf2Phy3Y/8Um4rDrV7TE//X
        XPoKK/UFY06IS8efYdRq2VExEwisaTri7C+zYwAcwfbMykkoPjxJmi2tIOunX37jh3RnPV+vyASLf
        mzlgrzTCfW7vy/o7nHmkpwcBOHVFNxie0vr++ivd7uUBrfuR6r0pg83OnMyEBjqw2fkVptay6yuhI
        qbM7zGEFGrJxZY+qvRNFsiE7nW26rSiYRmX13rQET8TLXPIqTKRsLtPFXyB+xGGzKrFII27Ih6J0h
        SEzX8p4YLz/tW2+6nYFTkd3VfUmGJdfYaLV61hA+Qk9O8DD6iEhcFSVuyVk7ThgtfpUwvTXWntPWa
        NnwBbXyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXhbw-0081sD-8E; Tue, 05 Oct 2021 10:23:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F371B30019C;
        Tue,  5 Oct 2021 12:23:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF4D1202A012E; Tue,  5 Oct 2021 12:23:46 +0200 (CEST)
Date:   Tue, 5 Oct 2021 12:23:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <YVwnsrZWrnWHaoqN@hirez.programming.kicks-ass.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922173853.GB3959@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 06:38:53PM +0100, Mel Gorman wrote:

> 
> I'm not seeing an alternative suggestion that could be turned into
> an implementation. The current value for sched_wakeup_granularity
> was set 12 years ago was exposed for tuning which is no longer

(it has always been SCHED_DEBUG)

> the case. The intent was to allow some dynamic adjustment between
> sysctl_sched_wakeup_granularity and sysctl_sched_latency to reduce
> over-scheduling in the worst case without disabling preemption entirely
> (which the first version did).
> 
> Should we just ignore this problem and hope it goes away or just let
> people keep poking silly values into debugfs via tuned?

People are going to do stupid no matter what (and tuned is very much
included there -- poking random numbers in debug interfaces without
doing analysis on what the workload does and needs it just wasting
everybodies time. RHT really should know better than that).

I'm also thinking that adding more heuristics isn't going to improve the
situation lots.

For the past # of years people have been talking about extendng the task
model for SCHED_NORMAL, latency_nice was one such proposal.

If we really want to fix this proper, and not make a bigger mess of
things, we should look at all these various workloads and identify
*what* specifically they want and *why*.

Once we have this enumerated, we can look at what exactly we can provide
and how to structure the interface.

The extention must be hint only, we should be free to completely ignore
it.

The things I can think of off the top of my head are:

- tail latency; prepared to waste time to increase the odds of running
  sooner. Possible effect: have this task always do a full
  select_idle_sibling() scan.

  (there's also the anti case, which I'm not sure how to enumerate,
  basically they don't want select_idle_sibling(), just place the task
  wherever)

- non-interactive; doesn't much care about wakeup latency; can suffer
  packing?

- background; (implies non-interactive?) doesn't much care about
  completion time either, just cares about efficiency

- interactive; cares much about wakeup-latency; cares less about
  throughput.

- (energy) efficient; cares more about energy usage than performance


Now, we already have SCHED_BATCH that completely kills wakeup preemption
and SCHED_IDLE lets everything preempt. I know SCHED_IDLE is in active
use (because we see patches for that), I don't think people use
SCHED_BATCH much, should they?


Now, I think a number of contraints are going to be mutually exclusive,
and if we get such tasks combined there's just nothing much we can do
about it (and since it's all hints, we good).

We should also not make the load-balance condition too complicated, we
don't want it to try and (badly) solve a large set of constraints.
Again, if possible respect the hints, otherwise tough luck.
