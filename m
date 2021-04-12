Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835D335C454
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbhDLKsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:48:43 -0400
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:60657 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238968AbhDLKsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:48:39 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 07025FB837
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 11:48:21 +0100 (IST)
Received: (qmail 29985 invoked from network); 12 Apr 2021 10:48:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Apr 2021 10:48:20 -0000
Date:   Mon, 12 Apr 2021 11:48:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Parth Shah <parth@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC/PATCH] powerpc/smp: Add SD_SHARE_PKG_RESOURCES flag to MC
 sched-domain
Message-ID: <20210412104819.GT3697@techsingularity.net>
References: <1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210412062436.GB2633526@linux.vnet.ibm.com>
 <20210412093722.GS3697@techsingularity.net>
 <871rbfom04.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <871rbfom04.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:06:19AM +0100, Valentin Schneider wrote:
> On 12/04/21 10:37, Mel Gorman wrote:
> > On Mon, Apr 12, 2021 at 11:54:36AM +0530, Srikar Dronamraju wrote:
> >> * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2021-04-02 11:07:54]:
> >>
> >> >
> >> > To remedy this, this patch proposes that the LLC be moved to the MC
> >> > level which is a group of cores in one half of the chip.
> >> >
> >> >       SMT (SMT4) --> MC (Hemisphere)[LLC] --> DIE
> >> >
> >>
> >> I think marking Hemisphere as a LLC in a P10 scenario is a good idea.
> >>
> >> > While there is no cache being shared at this level, this is still the
> >> > level where some amount of cache-snooping takes place and it is
> >> > relatively faster to access the data from the caches of the cores
> >> > within this domain. With this change, we no longer see regressions on
> >> > P10 for applications which require single threaded performance.
> >>
> >> Peter, Valentin, Vincent, Mel, etal
> >>
> >> On architectures where we have multiple levels of cache access latencies
> >> within a DIE, (For example: one within the current LLC or SMT core and the
> >> other at MC or Hemisphere, and finally across hemispheres), do you have any
> >> suggestions on how we could handle the same in the core scheduler?
> >>
> >
> > Minimally I think it would be worth detecting when there are multiple
> > LLCs per node and detecting that in generic code as a static branch. In
> > select_idle_cpu, consider taking two passes -- first on the LLC domain
> > and if no idle CPU is found then taking a second pass if the search depth
> > allows within the node with the LLC CPUs masked out.
> 
> I think that's actually a decent approach. Tying SD_SHARE_PKG_RESOURCES to
> something other than pure cache topology in a generic manner is tough (as
> it relies on murky, ill-defined hardware fabric properties).
> 

Agreed. The LLC->node scan idea has been on my TODO list to try for
a while.

> Last I tried thinking about that, I stopped at having a core-to-core
> latency matrix, building domains off of that, and having some knob
> specifying the highest distance value below which we'd set
> SD_SHARE_PKG_RESOURCES. There's a few things I 'hate' about that; for one
> it makes cpus_share_cache() somewhat questionable.
> 

And I thought about something like this too but worried it might get
complex, particularly on chiplets where we do not necessarily have
hardware info on latency depending on how it's wired up. It also might
lead to excessive cpumask manipulation in a fast path if we have to
traverse multiple distances with search cost exceeding gains from latency
reduction. Hence -- keeping it simple with two level only, LLC then node
within the allowed search depth and see what that gets us. It might be
"good enough" in most cases and would be a basis for comparison against
complex approaches.

At minimum, I expect IBM can evaluate the POWER10 aspect and I can run
an evaluation on Zen generations.

-- 
Mel Gorman
SUSE Labs
