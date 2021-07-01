Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0FB3B920F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhGANOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:14:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56528 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhGANON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:14:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CD0D82286E;
        Thu,  1 Jul 2021 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625145101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnSVStU4rTgW/IZmz3L5eNtkU/6r5KQl2nbmVYIvWhU=;
        b=yDLwGR3KgV0H1WbDoO3IatbvlovT2Qf4Gtt9l6gOeKNBdexmZckYkuMZxuAUyyyZ7PAzWb
        kEpApGfnxjnhknvhPTOS/tcAqx8RVcOf1pCcW7CZD3klkKG/UO105C6l5uPSmWFZFbhX68
        Lnfnd9hWivcsHhhepqNnhCEwXKlztMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625145101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnSVStU4rTgW/IZmz3L5eNtkU/6r5KQl2nbmVYIvWhU=;
        b=ypFjY/t6nzqT9Af2mDToScKAibg1vflp0gb0u29h9XYEIbC7bWCdqUmrF2i8yBB+Xq2A67
        PC5KfCORTq4BY0Dw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E3134A3B83;
        Thu,  1 Jul 2021 13:11:40 +0000 (UTC)
Date:   Thu, 1 Jul 2021 14:11:39 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] nohz: nohz idle balancing per node
Message-ID: <20210701131139.GD3772@suse.de>
References: <20210701055323.2199175-1-npiggin@gmail.com>
 <YN2Wav1CSVq+6cS+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YN2Wav1CSVq+6cS+@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 12:18:18PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 01, 2021 at 03:53:23PM +1000, Nicholas Piggin wrote:
> > Currently a single nohz idle CPU is designated to perform balancing on
> > behalf of all other nohz idle CPUs in the system. Implement a per node
> > nohz balancer to minimize cross-node memory accesses and runqueue lock
> > acquisitions.
> > 
> > On a 4 node system, this improves performance by 9.3% on a 'pgbench -N'
> > with 32 clients/jobs (which is about where throughput maxes out due to
> > IO and contention in postgres).
> 
> Hmm, Suresh tried something like this around 2010 and then we ran into
> trouble that when once node went completely idle and another node was
> fully busy, the completely idle node would not run ILB and the node
> would forever stay idle.
> 

An effect like that *might* be visible at
https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-nohznuma-v1r1/html/network-tbench/hardy2/
at the CPU usage heatmaps ordered by topology at the very bottom of
the page.

The heatmap covers all client counts so there are "blocks" of activity for
each client count tested. The third block is for 8 thread counts so a node
is not fully busy yet. However, with the vanilla kernel, there is some
load on each node but with the patch all the load is on one node. This
did not happen on the two other test machines so the observation is not
reliable and could be a total coincidence.

That said, there were some gains but large losses depending on the client
count across the 3 machines for tbench which is a concern. Other results,
like pgbench mentioned in the changelog, will not complete until tomorrow
to see if it is a general pattern or tbench-specific.

https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-nohznuma-v1r1/html/network-tbench/bing2/
https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-nohznuma-v1r1/html/network-tbench/hardy2/
https://beta.suse.com/private/mgorman/melt/v5.13/3-perf-test/sched/sched-nohznuma-v1r1/html/network-tbench/marvin2/

-- 
Mel Gorman
SUSE Labs
