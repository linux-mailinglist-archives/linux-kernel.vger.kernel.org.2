Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C788D43ADDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhJZIUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:20:44 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:52363 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233575AbhJZIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:20:43 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 8CD76BEE82
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:18:19 +0100 (IST)
Received: (qmail 10978 invoked from network); 26 Oct 2021 08:18:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Oct 2021 08:18:19 -0000
Date:   Tue, 26 Oct 2021 09:18:17 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
Message-ID: <20211026081817.GM3959@techsingularity.net>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
 <20211021145603.5313-2-mgorman@techsingularity.net>
 <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
 <20211022110534.GJ3959@techsingularity.net>
 <496d495b290ac69fed75d02ab5915a7871243321.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <496d495b290ac69fed75d02ab5915a7871243321.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:35:52AM +0200, Mike Galbraith wrote:
> On Fri, 2021-10-22 at 12:05 +0100, Mel Gorman wrote:
> > On Fri, Oct 22, 2021 at 12:26:08PM +0200, Mike Galbraith wrote:
> >
> > >
> > > Patchlet helped hackbench?  That's.. unexpected (at least by me).
> > >
> >
> > I didn't analyse in depth and other machines do not show as dramatic
> > a difference but it's likely due to timings of tasks getting wakeup
> > preempted.
> 
> Wakeup tracing made those hackbench numbers less surprising. There's
> tons of wake-many going on. At a glance, it appears to already be bi-
> directional though, so patchlet helping seemingly means that there's
> just not quite enough to tickle the heuristic without a little help.

Another possible explanation is that hackbench overloads a machine to
such an extent that the ratio of bi-directional wakeups is not
sufficient to trigger the wake-wide logic.

> Question is, is the potential reward of strengthening that heuristic
> yet again, keeping in mind that "heuristic" tends to not play well with
> "deterministic", worth the risk?
> 
> My desktop trace session said distribution improved a bit, but there
> was no meaningful latency or throughput improvement, making for a
> pretty clear "nope" to the above question. 

Another interpretation is that it's simply neutral and does no harm.

> It benefiting NUMA box
> hackbench is a valid indicator, but one that is IMO too disconnected
> from the real world to carry much weight.
> 

I think if it's not shown to be harmful to a realistic workload but helps
an overloaded example then it should be ok. While excessive overload is
rare in a realistic workload, it does happen. There are a few workloads
I've seen bugs for that were triggered when an excessive number of worker
threads get spawned and compete for CPU access which in turns leads more
worker threads get spawned. There are application workarounds for this
corner case but it still triggers bugs.

-- 
Mel Gorman
SUSE Labs
