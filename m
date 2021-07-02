Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B8D3B9DB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGBIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:52:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58904 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhGBIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:52:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6A22C222DB;
        Fri,  2 Jul 2021 08:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625215796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bLF2bHNnyc+k984H/cHDYV6zU+WZyPtOL4del4q64/s=;
        b=kzpltD+gQto4NyvLRZK1Zgz/6g+Vz9dILEeSpLGVSnsJVRnsX5Amowym8PGTGwhv9hBZm5
        iUOLM/NjgxJxha0yp+BeWX04lLsXckQ7mPkPEWm0c3qFyK25apA9cIPmZWuVqqQCP37WtR
        1B8WtmU9/xakodI3c20xCAK+s+UweyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625215796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bLF2bHNnyc+k984H/cHDYV6zU+WZyPtOL4del4q64/s=;
        b=nZcBW0iesf7QjdGFgpU6WI9xk60DZJos5P0/4toupiHng4+Ma28s5phli88AAu101q+3wm
        S09HLe4VzU+JjfBw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6FB01A3B83;
        Fri,  2 Jul 2021 08:49:55 +0000 (UTC)
Date:   Fri, 2 Jul 2021 09:49:53 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] nohz: nohz idle balancing per node
Message-ID: <20210702084953.GE3772@suse.de>
References: <20210701055323.2199175-1-npiggin@gmail.com>
 <YN2Wav1CSVq+6cS+@hirez.programming.kicks-ass.net>
 <20210701131139.GD3772@suse.de>
 <1625181736.w1x011tuds.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1625181736.w1x011tuds.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 09:33:45AM +1000, Nicholas Piggin wrote:
> Excerpts from Mel Gorman's message of July 1, 2021 11:11 pm:
> > On Thu, Jul 01, 2021 at 12:18:18PM +0200, Peter Zijlstra wrote:
> >> On Thu, Jul 01, 2021 at 03:53:23PM +1000, Nicholas Piggin wrote:
> >> > Currently a single nohz idle CPU is designated to perform balancing on
> >> > behalf of all other nohz idle CPUs in the system. Implement a per node
> >> > nohz balancer to minimize cross-node memory accesses and runqueue lock
> >> > acquisitions.
> >> > 
> >> > On a 4 node system, this improves performance by 9.3% on a 'pgbench -N'
> >> > with 32 clients/jobs (which is about where throughput maxes out due to
> >> > IO and contention in postgres).
> >> 
> >> Hmm, Suresh tried something like this around 2010 and then we ran into
> >> trouble that when once node went completely idle and another node was
> >> fully busy, the completely idle node would not run ILB and the node
> >> would forever stay idle.
> >> 
> > 
> > An effect like that *might* be visible at
> > https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-nohznuma-v1r1/html/network-tbench/hardy2/
> > at the CPU usage heatmaps ordered by topology at the very bottom of
> > the page.
> > 
> > The heatmap covers all client counts so there are "blocks" of activity for
> > each client count tested. The third block is for 8 thread counts so a node
> > is not fully busy yet.
> 
> I'm not sure what I'm looking at. Where are these blocks? Along the x 
> axis?
> 

The X axis is time. Each row is a CPU with a vertical line colored based on
the utilisation (white for idle, green for low utilisation, red for higher
utilisation). Along the Y axis, for a 2-socket machine, the top half 1
one node, the bottom half is the second node. Each "pair" of rows, where
pairs are indicated on the left with the CPU number, are SMT siblings.

The "blocks" along the xaxis represent 3 minutes running the benchmark
for a given client which is why the pattern changes as it starts at 1
client and increases the client count over time.

> > However, with the vanilla kernel, there is some
> > load on each node but with the patch all the load is on one node. This
> > did not happen on the two other test machines so the observation is not
> > reliable and could be a total coincidence.
> 
> tbench is pretty finicky so it could be.
> 

It's even likely. It's also not triggering the situation Peter described --
"once node went completely idle and another node was fully busy", tbench
doesn't do this except by accident.

> > 
> > That said, there were some gains but large losses depending on the client
> > count across the 3 machines for tbench which is a concern. Other results,
> > like pgbench mentioned in the changelog, will not complete until tomorrow
> > to see if it is a general pattern or tbench-specific.
> > 
> > https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-nohznuma-v1r1/html/network-tbench/bing2/
> > https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-nohznuma-v1r1/html/network-tbench/hardy2/
> > https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-nohznuma-v1r1/html/network-tbench/marvin2/
> 
> All 2-node.

Yes, I only use a limited set of machines initially. It's only when
2-node passes that a series may get evaluated on large machines, zen*
generations etc.

> How many runs does it do at each clinet count? There's a big 
> regression at one clinet with one of them, but the other two have small 
> gains.
> 

tbench can be finicky so I treat it with caution even though I generally
use it a sniff test. Only one iteration is run per thread count. What is
graphed is the reported throughput over time which is a dangerous metric
because each datapoint is average throughput since the test started. A more
robust metric would be to run the benchmark multiple times taking the final
throughput for each iteration. There are a few reasons why I didn't do that

  If the reported throughput is highly variable over time, that is an
  interesting result in itself as it can imply that steady progress is
  not being made.

  Looking at how the workload behaves during an iteration is useful

  It takes an unreasonable amount of time to run it multiple times and
  the full mix of scheduler tests I ran takes almost a day per tested
  kernel. For example, these tests are not even complete yet and
  probably won't be until late tonight.

I'm well aware of the limitations of testing tbench like this. dbench for
example is a similiarly designed workload except dbench gets patched to
report the time taken to process the loadfile once and uses that as a
primary metric instead of estimated throughput.

-- 
Mel Gorman
SUSE Labs
