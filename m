Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0513A957A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhFPJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:05:23 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:53473 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbhFPJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:05:22 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id DDD17F836B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:03:15 +0100 (IST)
Received: (qmail 17435 invoked from network); 16 Jun 2021 09:03:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jun 2021 09:03:15 -0000
Date:   Wed, 16 Jun 2021 10:03:14 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
Message-ID: <20210616090314.GJ30378@techsingularity.net>
References: <20210615111611.GH30378@techsingularity.net>
 <20210615204228.GB4272@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210615204228.GB4272@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 10:42:28PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 15, 2021 at 12:16:11PM +0100, Mel Gorman wrote:
> > From: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > This is a partial forward-port of Peter Ziljstra's work first posted
> > at https://lore.kernel.org/lkml/20180530142236.667774973@infradead.org/.
> 
> It's patches 2 and 3 together, right?
> 

Patches 2, 3, 9 and 10. I saw limited value to preserving the feature
flag. Some of the series has since been obsoleted. The main patch of
interest that was dropped was patch 1 because the results were somewhat
inconclusive but leaning towards being an overall loss.

> > His Signed-off has been removed because it is modified but will be restored
> > if he says it's still ok.
> 
> I suppose the SoB will auto-magically re-appear if I apply it :-)
> 

Yep, it would and it would indicate that you didn't object to the copying
at least :P

> > The patch potentially matters when a socket was multiple LLCs as the
> > maximum search depth is lower. However, some of the test results were
> > suspiciously good (e.g. specjbb2005 gaining 50% on a Zen1 machine) and
> > other results were not dramatically different to other mcahines.
> > 
> > Given the nature of the patch, Peter's full series is not being forward
> > ported as each part should stand on its own. Preferably they would be
> > merged at different times to reduce the risk of false bisections.
> 
> I'm tempted to give it a go.. anyone object?

Thanks, so far no serious objection :)

The latest results as I see them have been copied to
https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/dashboard.html
They will move from here if the patch is accepted to 5-assembly replacing
3-perf-test. This naming is part of my workflow for evaluating topic
branches separetly and then putting them together for another round
of testing.

NAS shows small differences but NAS would see limited impact from the
patch. Specjbb shows small losses and some minor gains which is unfortunate
but the workload tends to see small gains and losses all the time.
redis is a mixed bag but has some wins. hackbench is the main benefit
because it's wakeup intensive and tends to overload machines where deep
searches hurt.

There are other results in there if you feel like digging around
such as sched-core tested with no processes getting tagged with prctl
https://beta.suse.com/private/mgorman/melt/v5.13-rc5/5-assembly/sched/sched-schedcore-v1r2/html/dashboard.html


-- 
Mel Gorman
SUSE Labs
